<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.io.*,com.lf.util.*,java.text.SimpleDateFormat,com.lf.lfbase.service.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,javax.servlet.http.HttpServletRequest,java.net.*,java.text.*"%>
<%



        /*
        1、首先检查上传的Excel文件的合法性
            1) 是不是Excel文件
            2) 工作表的数量是不是1个，工作表的名称对不对“货品档案”
            3) 标题列对不对
        2、检查Excel文件数据自身的合法性
             1) 名称、类型有没有没录的 
             2) 名称有没有重复 
        3、Excel文件数据与数据库中的已有数据的关联性检查
            1) 类型有没有
            2) 已录入销售代表有没有，空白不报错
            3) 已录入的地区有没有，空白不报错
            4) 分别处理新增和更新
                新增
                  检查名称是不是重复了名称是不是重了(数据库里已经有了) 
                   生成流水号，插入数据
                更新
                 如果名称数据里有了，则update,0则，分配一个编号，insert
      4、删除数据库中多余的记录，(没有被使用的) (加个删除选项，默认不删除) 
         原则：所有操作必须包含在一个sql串中提交，有问题可以回滚。
    */    
//1、首先检查上传的Excel文件的合法性


                    
    // 1) 是不是Excel文件
	Map req=ExcelService.initUpload(request);
	    FileItem fItem=(FileItem)req.get("import_type");
        String importType="";   // 导入方式 insert    update
        if (fItem==null ) {
            importType="insert";   //默认insert
        } else {
            importType=fItem.getString();   //默认insert
        }

        String deleteDate="";   //  删除Excel文件中部包含的数据库记录  delete    nodelete
	    fItem=(FileItem)req.get("delete");
        if (fItem==null ) {
            deleteDate="nodelete";   //默认nodelete
        } else {
            deleteDate=fItem.getString();   //
        }


	FileItem myfile = (FileItem)req.get("myfile");
    if (myfile.getName().indexOf("xls")<0)
		throw new LFException("上传的文件不是EXCEL文件!");

	if( myfile.getSize() <= 0 ) 
        throw new LFException("上传的文件内容为空!");

    
    InputStream uploadedStream = myfile.getInputStream(); 
    POIFSFileSystem fs  =  new POIFSFileSystem(uploadedStream);	
    HSSFWorkbook wb = new HSSFWorkbook(fs);


    
    //2) 工作表的数量是不是1个，工作表的名称对不对“”
    if (wb.getNumberOfSheets()!= 2)
        throw new LFException("模板的工作表数量应该是2个,请检查是0使用了正确的模板!");
	
    HSSFSheet sheet = wb.getSheetAt(0); 
    HSSFSheet sheet1 = wb.getSheetAt(1);  
    //if (!wb.getSheetName(sheet).eqauls("货品档案"))
        //throw new LFException("工作表的名称不是[货品档案]!");
    
    //3) 标题列对不对
//单位类型编码	单位类型名称	单位编码	单位名称	日期	业务员	单据号	物品类型编码	物品类型名称	
//物品编码	物品名称	规格型号	计量单位	数量	目录价	 实收金额 	扣率	生产批号	订货人	别名	
//备注	产品促销信息	发票号	原币收款金额	预付款余额	备用1	备用2

    String title="";
    String [] sheetTitle=new String [2];
		sheetTitle[0]="英文名称";
    sheetTitle[1]="中文名称";
    for (int i=0;i<sheetTitle.length;i++) {
        title=ExcelService.getCellValue(sheet, 0, i,"0");    //row,col
        if (title==null || !title.equals(sheetTitle[i].trim()) ) 
            throw new LFException("工作表的第 "+String.valueOf(i+1)+" 列应为：["+sheetTitle[i]+"]!");
   }

///2、检查Excel文件数据自身的合法性        
         //1) 名称、类型有没有没录的 
         String errorMessage="";   //错误信息
         int  error_num=0;  //错误数
         String table_name="";        //表名
         String colume_name="";          //列英文名
         String display_name="";          //列中文名
         String tempMc="";          //临时存放
		 SLfHashMap  allMc= new SLfHashMap ();	//所有的表名称

         int realTotalRows=0;   //实际的行数
         int totalRows = sheet1.getLastRowNum()+1;   //Excel返回总行数
         for (int i=1;i<totalRows;i++)  {    //开始扫描  从第2行开始
                colume_name=ExcelService.getCellValue(sheet1, i,0,"0");
                display_name=ExcelService.getCellValue(sheet1, i,1,"0");
                if (colume_name.length()==0 && display_name.length()==0) { //表名和列名都为空，同时后边没有了，就到底了
                        boolean find=false;
                        for (int j=i+1;j<totalRows;j++) {
                            if (ExcelService.getCellValue(sheet1, j,0,"0").length()>0  
                                || ExcelService.getCellValue(sheet1, j,1,"0").length()>0) {
                                find=true;
                                break;   //不用继续找了
                            }
                        }
                        if (!find) {    //到底了
                            realTotalRows=i-1;
                            break;
                        }
                }
								
                if (colume_name.length()>0 && colume_name.length()==0)  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [列英文名] 不能为空！";
                    error_num++;
                    continue;
                }
                if (display_name.length()>0 && display_name.length()==0)  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [列中文名] 不能为空！";
                    error_num++;
                    continue;
                }
                //检查其他必录项
					
                 //2) 编号有没有重复
                if (allMc.containsKey(colume_name))  {
                        errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [列英文名] 与 第[ "+allMc.get(colume_name)+" ]行重复！ ";
                        error_num++;
                } else {
                        if (!Util.isBlankString(colume_name)) allMc.put(colume_name,String.valueOf(i+1));
                        realTotalRows++;
                }
                if (allMc.containsKey(display_name))  {
                        errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [列中文名] 与 第[ "+allMc.get(display_name)+" ]行重复！ ";
                        error_num++;
                } else {
                        if (!Util.isBlankString(display_name)) allMc.put(display_name,String.valueOf(i+1));
                        realTotalRows++;
                }
         } //for

         //先报出自身检查的问题
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<br/><div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");


//3、Excel文件数据与数据库中的已有数据的关联性检查   
        
        errorMessage="";
        error_num=0;
         String allMcString="";  // 取得所有的名称，用于删除的时候和数据库比较
         String failDeleteMessage=""; //不能成功删除的记录
       //1) 类型有没有
        String sqlTemp="";
        String temp="";
        String sql="  declare @djh varchar(200)  ";
        String r[]=null;
        boolean  is_update=false;  //对于修改方式,标志是0是执行update,如果为0,则执行insert
        String value_table_name="";
        String value_hplx="";
        String value_jjfs="";
        String ywybz="0";
				String autokeyword="0";
				String jlbz="0";
				String shbz="0";
				String hzbz="0";
				String gbbz="0";
				String zdbz="0";
				String czbz="0";
				String cpfzhs="0";
				String hongzibz="0";
				String enabled_control="0";
				if("是".equals(ExcelService.getCellValue(sheet, 1,5,"0"))){
					ywybz="1";
				}
				if("是".equals(ExcelService.getCellValue(sheet, 1,8,"0"))){
					autokeyword="1";
				}
				if("是".equals(ExcelService.getCellValue(sheet, 1,9,"0"))){
					jlbz="1";
				}
				if("是".equals(ExcelService.getCellValue(sheet, 1,10,"0"))){
					shbz="1";
				}
				if("是".equals(ExcelService.getCellValue(sheet, 1,11,"0"))){
					hzbz="1";
				}
				if("是".equals(ExcelService.getCellValue(sheet, 1,12,"0"))){
					gbbz="1";
				}
				if("是".equals(ExcelService.getCellValue(sheet, 1,13,"0"))){
					zdbz="1";
				}
				if("是".equals(ExcelService.getCellValue(sheet, 1,14,"0"))){
					czbz="1";
				}
				if("是".equals(ExcelService.getCellValue(sheet, 1,15,"0"))){
					cpfzhs="1";
				}
				if("是".equals(ExcelService.getCellValue(sheet, 1,16,"0"))){
					hongzibz="1";
				}
				if("是".equals(ExcelService.getCellValue(sheet, 1,17,"0"))){
					enabled_control="1";
				}
				sql+="  exec getDJH  'xtkhbh', @djh output  ";   //取一个单据号
        sql+="  insert into xt_tables (id,table_name,display_name,name_col,date_col,zycols,ywybz,ywy_col_title,ywbm_col_title,autokeyword,jlbz,shbz,gbbz,czbz,cpfzhs,hongzibz,enabled_control,log_cols,workflow_titles,workflow_filters,description) values (";
        sql+="'"+ExcelService.getCellValue(sheet, 1,0,"0")+"',"; 													// id 就用单据号 
        sql+="'"+ExcelService.getCellValue(sheet, 1,0,"0")+"',";                         // table_name     
        sql+="'"+ExcelService.getCellValue(sheet, 1,1,"0")+"',";                         // display_name   
        sql+="'"+ExcelService.getCellValue(sheet, 1,2,"0")+"',";                         // name_col       
        sql+="'"+ExcelService.getCellValue(sheet, 1,3,"0")+"',";                         // date_col       
        sql+="'"+ExcelService.getCellValue(sheet, 1,4,"0")+"',";                         // zycols         
        sql+="'"+ywybz+"',";                         																		// ywybz          
        sql+="'"+ExcelService.getCellValue(sheet, 1,6,"0")+"',";                         // ywy_col_title  
        sql+="'"+ExcelService.getCellValue(sheet, 1,7,"0")+"',";                         // ywbm_col_title 
        sql+="'"+autokeyword+"',";                     															    // autokeyword    
        sql+="'"+jlbz+"',";              																			           // jlbz           
        sql+="'"+shbz+"',";              																			          // shbz                    
        sql+="'"+gbbz+"',";              																			          // gbbz                     
        sql+="'"+czbz    +"',";          																			  				// czbz           
        sql+="'"+cpfzhs  +"',";          																			  				// cpfzhs         
        sql+="'"+hongzibz+"',";          																			  				// hongzibz       
        sql+="'"+enabled_control+"',";                        													// enabled_control 
        sql+="'"+ExcelService.getCellValue(sheet, 1,16,"0")+"',";                         // log_cols 
        sql+="'"+ExcelService.getCellValue(sheet, 1,17,"0")+"',";                         // workflow_titles
        sql+="'"+ExcelService.getCellValue(sheet, 1,18,"0")+"',";                         // workflow_filters 
        sql+="'"+ExcelService.getCellValue(sheet, 1,19,"0")+"')";                        // description 
        
				String colume_type1[]; 					  //列数据类型
				String bdxmlx1[];     					//表单项目类型
				String is_unique1[];							//唯一性类型
				String autocomplete_type1[];			//自动完成类型
				String xtdefaultdefine1[];				//系统默认定义
				String item_no_source_id1[];				//单据号来源              

        for (int i=1;i<totalRows;i++)  {    //开始扫描   从第2行开始
        System.out.println(ExcelService.getCellValue(sheet1, i,3,"0"));
        System.out.println("--------------------");
				String colume_type="1"; 					  //列数据类型
				String bdxmlx="020";     					//表单项目类型
				String is_unique="0";							//唯一性类型
				String autocomplete_type="";			//自动完成类型
				String xtdefaultdefine="";				//系统默认定义
				String item_no_source_id="";				//单据号来源 		
        String is_required="0";	         //是否必须输入	7
				String is_readonly="0";         //是否只读	9
				String is_hidden="0";	       //是否隐藏	10
				String is_qx_bm="0"; 	       //是否系统部门权限控制字段	14
				String is_qx_ry="0"; 	       //是否系统个人权限控制字段	15
				String is_add="1"; 		       //是否可新增	16
				String is_update1="1";        //是否可修改	17
				String is_detail="1";	       //是否可详情	18
				String is_print="1";         //是否可打印	19
				String is_list="0";          //是否默认列表项目	20
				String is_list_keyword_item="0"; //是否为模糊搜索项	21
				String is_list_filter="1";    //是否用户可自定义维护	22
				String is_default_filter="0";   //是否默认高级搜索项目	23
				String is_default_count="1";   //是否默认统计项目	24
				String is_list_order="0";	        //是否为列表排序关键字	25
				String is_required_sum="0";	       ///    是否需要合计	30
				String is_pyzj="0";	                ///    是否拼音助记   31
				String is_total_line="0";	          /// 是否整行	35
				String sf_tjssfz="0";	               ///  是否统计实时分组  37  
				 
        	if("是".equals(ExcelService.getCellValue(sheet1, i,6,"0")))  is_required="1";
					if("是".equals(ExcelService.getCellValue(sheet1, i,8,"0")))  is_readonly="1";
					if("是".equals(ExcelService.getCellValue(sheet1, i,31,"0")))  is_hidden="1";
					if("是".equals(ExcelService.getCellValue(sheet1, i,35,"0")))  is_qx_bm="1";
					if("是".equals(ExcelService.getCellValue(sheet1, i,36,"0")))  is_qx_ry="1";
					if("否".equals(ExcelService.getCellValue(sheet1, i,9,"0")))  is_add="0";
					if("否".equals(ExcelService.getCellValue(sheet1, i,10,"0")))  is_update1="0";
					if("否".equals(ExcelService.getCellValue(sheet1, i,11,"0")))  is_detail="0";
					if("否".equals(ExcelService.getCellValue(sheet1, i,12,"0")))  is_print="0";
					if("是".equals(ExcelService.getCellValue(sheet1, i,13,"0")))  is_list="1";
					if("是".equals(ExcelService.getCellValue(sheet1, i,14,"0")))  is_list_keyword_item="1";
					if("否".equals(ExcelService.getCellValue(sheet1, i,15,"0")))  is_list_filter="0";
					if("是".equals(ExcelService.getCellValue(sheet1, i,16,"0")))  is_default_filter="1";
					if("否".equals(ExcelService.getCellValue(sheet1, i,17,"0")))  is_default_count="0";
					if("是".equals(ExcelService.getCellValue(sheet1, i,18,"0")))  is_list_order="1";
					if("是".equals(ExcelService.getCellValue(sheet1, i,23,"0")))  is_required_sum="1";
					if("是".equals(ExcelService.getCellValue(sheet1, i,24,"0")))  is_pyzj="1";
					if("是".equals(ExcelService.getCellValue(sheet1, i,28,"0")))  is_total_line="1";
					if("是".equals(ExcelService.getCellValue(sheet1, i,30,"0")))  sf_tjssfz="1";
					temp=ExcelService.getCellValue(sheet1, i,32,"0");
					if(temp.length()>0) {
					item_no_source_id1 = Api.sb( "select id  from xt_bill_no where bh_name='" + ExcelService.getCellValue(sheet1, i,32,"0") + "'" );
						item_no_source_id=item_no_source_id1[0];
					}
					temp=ExcelService.getCellValue(sheet1, i,3,"0").trim();
					
					if(temp.length()>0) {
					colume_type1 = Api.sb( "select code_value  from xt_inneroption_code where group_name='列数据类型' and code_title='" + ExcelService.getCellValue(sheet1, i,3,"0") + "'" );
						colume_type=colume_type1[0];
					}
					if(ExcelService.getCellValue(sheet1, i,5,"0").length()>0) {
					bdxmlx1 = Api.sb( "select code_value  from xt_option_code where group_name='表单项目类型' and code_title='" + ExcelService.getCellValue(sheet1, i,5,"0") + "'" );
						bdxmlx=bdxmlx1[0];
					}
					if(ExcelService.getCellValue(sheet1, i,7,"0").length()>0) {
					is_unique1 = Api.sb( "select code_value  from xt_inneroption_code where group_name='唯一性类型' and code_title='" + ExcelService.getCellValue(sheet1, i,7,"0") + "'" );
						is_unique=is_unique1[0];
					}
					temp=ExcelService.getCellValue(sheet1, i,19,"0").trim();
					if(temp.length()>0) {
					autocomplete_type1 = Api.sb( "select code_value  from xt_inneroption_code where group_name='自动完成类型' and code_title='" + ExcelService.getCellValue(sheet1, i,19,"0") + "'" );
						autocomplete_type=autocomplete_type1[0];
					}
					if(ExcelService.getCellValue(sheet1, i,20,"0").length()>0) {
					xtdefaultdefine1 = Api.sb( "select code_value  from xt_inneroption_code where group_name='系统默认值' and code_title='" + ExcelService.getCellValue(sheet1, i,20,"0") + "'" );
						xtdefaultdefine=xtdefaultdefine1[0];
					}
					

                //对该行的列都检查完了,可以预生成sql语句了

                        sql+="  exec getDJH  'xtkhbh', @djh output  ";   //取一个单据号
                        sql+="  insert into xt_tables_define (id,table_name,colume_name,display_name,row_index,colume_type,decimal_num,bdxmlx,is_required,is_unique,is_readonly,is_add,is_update,is_detail,is_print,is_list,is_list_keyword_item,is_list_filter,is_default_filter,is_default_count,is_list_order,autocomplete_type,xtdefaultdefine,finaldefine,default_value,is_required_sum,is_pyzj,upload_main_col_name,upload_main_col_title,upload_main_col_type,is_total_line,col_line,sf_tjssfz,is_hidden,item_no_source_id,item_option_source_id,item_option_source_name,is_qx_bm,is_qx_ry,is_index,is_primary,datedemo) values (";
                        sql+=" @djh,";                                          													// id 就用单据号 
                        sql+="'"+ExcelService.getCellValue(sheet, 1,0,"0")+"',";                          // table_name	表名称	0                         
                        sql+="'"+ExcelService.getCellValue(sheet1, i,0,"0")+"',";                         //  colume_name	列英文名	2                           
                        sql+="'"+ExcelService.getCellValue(sheet1, i,1,"0")+"',";                         //  display_name	列中文名	3                     
                        sql+="'"+ExcelService.getCellValue(sheet1, i,2,"0")+"',";                         //  row_index	序号	1                    
                        sql+="'"+colume_type+"',";                         																// colume_type	列数据类型	4                       
                        sql+=""+ExcelService.getCellValueForNumber(sheet1, i,4,"0.00")+",";                // decimal_num	小数的位数	5                       
                        sql+="'"+bdxmlx+"',";                         																		// bdxmlx	表单项目类型	6                         
                        sql+="'"+is_required+"',";                         																// is_required	是否必须输入	7                     
                        sql+="'"+is_unique+"',";                         																	// is_unique	唯一性类型	7                         
                        sql+="'"+is_readonly+"',";                         																// is_readonly	是否只读	8                       
              
                        sql+="'"+is_add+"',";            																									// is_add	是否可新增	16                          
                        sql+="'"+is_update1+"',";                       																  // is_update	是否可修改	17                        
                        sql+="'"+is_detail+"',";                        																	// is_detail	是否可详情	18                        
                        sql+="'"+is_print+"',";                         																		// is_print	是否可打印	19                        
                        sql+="'"+is_list+"',";                        																		// is_list	是否默认列表项目	20                      
                        sql+="'"+is_list_keyword_item+"',";                        												// is_list_keyword_item	是否为模糊搜索项	21        
                        sql+="'"+is_list_filter+"',";                        															// is_list_filter	是否用户可自定义维护	22            
                        sql+="'"+is_default_filter+"',";                        													// is_default_filter	是否默认高级搜索项目	23          
                        sql+="'"+is_default_count+"',";                        														// is_default_count	是否默认统计项目	24            
                        sql+="'"+is_list_order+"',";                        															// is_list_order	是否为列表排序关键字	25              
                        sql+="'"+autocomplete_type+"',";                        													// autocomplete_type	自动完成类型	26              
                        sql+="'"+xtdefaultdefine+"',";                        														// xtdefaultdefine	系统默认定义	20               
                        sql+="'"+ExcelService.getCellValue(sheet1, i,21,"0")+"',";                        // finaldefine	常量默认定义	28                    
                        sql+="'"+ExcelService.getCellValue(sheet1, i,22,"0")+"',";                        // default_value	默认值	29                      
                        sql+="'"+is_required_sum+"',";                        														// is_required_sum	是否需要合计	30                
                        sql+="'"+is_pyzj+"',";                        																		// is_pyzj	是否拼音助记	31                        
                        sql+="'"+ExcelService.getCellValue(sheet1, i,25,"0")+"',";                        // upload_main_col_name	上传主表名称	32          
                        sql+="'"+ExcelService.getCellValue(sheet1, i,26,"0")+"',";            						// upload_main_col_title	上传主表标题	33          
                        sql+="'"+ExcelService.getCellValue(sheet1, i,27,"0")+"',";            						// upload_main_col_type	上传主表方式	34          
                        sql+="'"+is_total_line+"',";            																					// is_total_line	是否整行	28                    
                        sql+=""+ExcelService.getCellValueForNumber(sheet1, i,29,"0.00")+",";            // col_line	列的长度	36                        
                        sql+="'"+sf_tjssfz+"',";                        																	// sf_tjssfz	是否统计实时分组	37
                        sql+="'"+is_hidden+"',";                        																	// is_hidden	是否隐藏	10                        
                        sql+="'"+item_no_source_id+"',";                        // item_no_source_id	单据号的来源	11              
                        sql+="'"+ExcelService.getCellValue(sheet1, i,33,"0")+"',";                        // item_option_source_id	选择项目id	12          
                        sql+="'"+ExcelService.getCellValue(sheet1, i,34,"0")+"',";            						// item_option_source_name	选择项目	13          
                        sql+="'"+is_qx_bm+"',";            																								// is_qx_bm	是否系统部门权限控制字段	14                
                        sql+="'"+is_qx_ry+"',";            																								// is_qx_ry	是否系统个人权限控制字段	15 
                        sql+="'0',"; 
                        sql+="'0',";                     
                        sql+="'"+ExcelService.getCellValue(sheet1, i,37,"0")+"')";                        // datedemo	模拟数据	38                        
                        
                        
                     

        }  //for

        //报出检查的问题
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");

     // 4、如果是更新方式，删除数据库中多余的记录，(没有被使用的) (加个删除选项，默认不删除)   
        
	    sql+="delete xt_tables_define where table_name='"+ExcelService.getCellValue(sheet, 1,0,"0")+"' and colume_name=''"; 
        System.out.println(sql);
        System.out.println(sheet1.getLastRowNum());
        System.out.println(realTotalRows);
		Api.ub(sql);     //实际执行
		//Api.XtRefreshAutoKeyWords("xt_tables");
        Serve.reloadAll();

 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>
<body>
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区 --> 
			<td height=""  valign="middle" class='x_center_head_bg'>
					<span class="x_center_title" >
						表定义导入
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
			<!-- 内容区 -->
			<!-- 内容区 -->

				<form name="form2" action="kc_aqsz.jsp" method="post">
          			<table class="x_message_table" cellspacing="0" align="center">
						  <tr>
							<td align="center" width="100"  class="x_message_title_td">&nbsp;</td>
							<td align="center"  class="x_message_title_td">&nbsp;</td>
						  </tr>
						  <tr>
							<td align="center"  width="100"   class="x_message_message_td"><img src="/emadmin/images/c2/icon/message.jpg" align="center"/> </td>
							<td  class="x_message_message_td">
                                      保存成功！<br>
                                     <% if (failDeleteMessage.length()>0) {%>
                                        但有如下货品由于已经被某张单据使用,不能删除:
                                        <%=failDeleteMessage%>
                                     <%}%>
                                        <div align="center" width="100%" style="padding-top:10px;width:100%;"><img src="/emadmin/images/c2/button/bill_ok.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:location.href="/emadmin/jsp/common/list.jsp?modul_id=tg_xsjl_listModul"'/> </div>
							</td>
						  </tr>
						</table>
				</form>													
							 
											
			<!-- 内容区 -->

</body>
</html>

