<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.io.*,com.lf.util.*,java.text.SimpleDateFormat,com.lf.lfbase.service.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,javax.servlet.http.HttpServletRequest,java.net.*,java.text.*"%>
<%

        /*
        1、首先检查上传的Excel文件的合法性
            1）是不是Excel文件
            2）工作表的数量是不是1个，工作表的名称对不对“入库单”
            3）标题列对不对
        2、检查Excel文件数据自身的合法性
             1）名称、类型有没有没录的 
             2）名称有没有重复 
        3、Excel文件数据与数据库中的已有数据的关联性检查
            1）类型有没有
            2）已录入销售代表有没有，空白不报错
            3）已录入的地区有没有，空白不报错
            4）分别处理新增和更新
                新增
                  检查名称是不是重复了名称是不是重了（数据库里已经有了）
                   生成流水号，插入数据
                更新
                 如果名称数据里有了，则update,否则，分配一个编号，insert
      4、删除数据库中多余的记录，（没有被使用的）（加个删除选项，默认不删除）
         原则：所有操作必须包含在一个sql串中提交，有问题可以回滚。
    */    
//1、首先检查上传的Excel文件的合法性


                    
    // 1）是不是Excel文件
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


    
    //2）工作表的数量是不是1个，工作表的名称对不对“入库单”
    if (wb.getNumberOfSheets()!= 1)
        throw new LFException("模板的工作表数量应该是1个,请检查是否使用了正确的模板!");
	
    HSSFSheet sheet = wb.getSheetAt(0); 
     
    //if (!wb.getSheetName(sheet).eqauls("入库单"))
        //throw new LFException("工作表的名称不是[入库单]!");
    
    //3）标题列对不对

    String title="";
    String [] sheetTitle=new String [18];
    sheetTitle[0]="入库日期*";
    sheetTitle[1]="业务类型*";
    sheetTitle[2]="仓库*";
    sheetTitle[3]="供应商";
    sheetTitle[4]="项目编码";
    sheetTitle[5]="项目名称";
    sheetTitle[6]="货品编码*";
    sheetTitle[7]="货品名称";
    sheetTitle[8]="规格型号";
    sheetTitle[9]="单位";
    sheetTitle[10]="数量*";
    sheetTitle[11]="单价*";
    sheetTitle[12]="金额*";
    sheetTitle[13]="批次";
    sheetTitle[14]="生产日期";
    sheetTitle[15]="失效日期";
    sheetTitle[16]="业务员";
	sheetTitle[17]="备注";
   
   
    for (int i=0;i<sheetTitle.length;i++) {
        title=ExcelService.getCellValue(sheet, 0, i,"0");    //row,col
        if (title==null || !title.equals(sheetTitle[i].trim()) ) 
            throw new LFException("工作表的第 "+String.valueOf(i+1)+" 列应为：["+sheetTitle[i]+"]!");
   }
   
 

///2、检查Excel文件数据自身的合法性        
         //1）名称、类型有没有没录的 
         String errorMessage="";   //错误信息
         int  error_num=0;  //错误数
		 String rkrq="";//入库日期
		 String rkrq_next="";//下一条入库日期
		 String ywlx="";//业务类型
		 String ywlx_next="";//下一个业务类型
		 String ywlx_mc="";//业务类型

		 String ck="";//仓库
		 String ck_next="";//仓库
		 String chbm="";//货品编码
		 String sl="";//数量
		 String dj="";//单价
		 String je="";//金额

         int realTotalRows=0;   //实际的行数
         int totalRows = sheet.getLastRowNum()+1;   //Excel返回总行数
       
         for (int i=1;i<totalRows;i++)  {    //开始扫描  从地2行开始
                rkrq=ExcelService.getCellValue(sheet, i,0,"0").trim();  
                ywlx=ExcelService.getCellValue(sheet, i,1,"0").trim(); 
                ck=ExcelService.getCellValue(sheet, i,2,"0").trim(); 
				chbm=ExcelService.getCellValue(sheet, i,6,"0").trim(); 
				sl=ExcelService.getCellValue(sheet, i,10,"0.00").trim(); 
				dj=ExcelService.getCellValue(sheet, i,11,"0.00").trim(); 
				je=ExcelService.getCellValue(sheet, i,12,"0.00").trim(); 

                if (rkrq.length()==0 && ywlx.length()==0) { //入库日期和业务类型都为空，同时后边没有了，就到底了
                        boolean find=false;
                        for (int j=i+1;j<totalRows;j++) {
                            if (ExcelService.getCellValue(sheet, j,0,"0").trim().length()>0  
                                || ExcelService.getCellValue(sheet, j,1,"0").trim().length()>0) {
                                find=true;
                                break;   //不用继续找了
                            }
                           
                        }
                        if (!find) {    //到底了
                            realTotalRows=i-1;
                            break;
                        }
                }
                if (rkrq.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [入库日期] 不能为空！";
                    error_num++;
                    continue;
                }
                if (ywlx.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [业务类型] 不能为空！";
                    error_num++;
                    continue;
                }
                if (ck.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [仓库] 不能为空！";
                    error_num++;
                    continue;
                }
				if (chbm.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [货品编码] 不能为空！";
                    error_num++;
                    continue;
                }
				if (sl.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [数量] 不能为空！";
                    error_num++;
                    continue;
                }
				if (dj.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [单价] 不能为空！";
                    error_num++;
                    continue;
                }
				if (je.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [金额] 不能为空！";
                    error_num++;
                    continue;
                }
                 //判断日期格式
                String tmptmp=ExcelService.getCellValue(sheet, i,0,"0").trim();  
                if (!Util.checkDateFormat(tmptmp) ){
                 	errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 入库日期格式不正确";
                    error_num++;
                    continue;
                 
                }
				tmptmp=ExcelService.getCellValue(sheet, i,14,"0").trim();  
                if (!Util.checkDateFormat(tmptmp) ){
                 	errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 生产日期格式不正确";
                    error_num++;
                    continue;
                 
                }
				tmptmp=ExcelService.getCellValue(sheet, i,15,"0").trim();  
                if (!Util.checkDateFormat(tmptmp) ){
                 	errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 失效日期格式不正确";
                    error_num++;
                    continue;
                 
                }
                
               
         } //for

         //先报出自身检查的问题
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<br/><div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");


//3、Excel文件数据与数据库中的已有数据的关联性检查   
     
        errorMessage="";
        error_num=0;
		String gys="";
		String gys_next="";//下一条供应商
		String gys_id="";
		String gysbh="";
		String ck_id="";
		String ch_id="";
		String hsl="";
		String bzdw="";
		String bzsl="";
		String ggxh="";
		String xt_cpfz_pc="";
		String xt_cpfz_scrq="";
		String xt_cpfz_sxrq="";
		String xt_cpfz_yxq="";
		String xt_cpfz_xgsx="";
		String  xt_cpfz_sfpcgl="";
		String  xt_cpfz_sfbzqgl="";
        String sqlTemp="";
        String temp="";
        String sql="  declare @djh varchar(200)  declare @djh2 varchar(200) declare @djh_del varchar(255)  ";
        String r[]=null;
        boolean  is_update=false;  //对于修改方式,标志是否是执行update,如果为否,则执行insert
        String valueXsdb="";
        String valueXsdb_mc="";
        String valueBm="";
        String valueBm_mc="";
		String lrr="";
		String lrrq="";
		String lrbm="";
		String chmc="";
		String xmbm="";
		String xmbm_next="";
		String xmmc="";
		String xmmc_next="";
		String id="";
		String fid="";
		
        
        
        
        for (int i=1;i<=realTotalRows;i++)  {    //开始扫描   从第2行开始
			

				rkrq=ExcelService.getCellValue(sheet, i,0,"0").trim();  
				rkrq_next=ExcelService.getCellValue(sheet, i+1,0,"0").trim();  
                ywlx_mc=ExcelService.getCellValue(sheet, i,1,"0").trim(); 
				ywlx_next=ExcelService.getCellValue(sheet, i+1,1,"0").trim();
				
                ck=ExcelService.getCellValue(sheet, i,2,"0").trim(); 
				ck_next=ExcelService.getCellValue(sheet, i+1,2,"0").trim(); 

				gys=ExcelService.getCellValue(sheet, i,3,"0").trim(); 
				gys_next=ExcelService.getCellValue(sheet, i+1,3,"0").trim(); 

				xmbm=ExcelService.getCellValue(sheet, i,4,"0").trim(); 
				xmbm_next=ExcelService.getCellValue(sheet, i+1,4,"0").trim(); 

				xmmc=ExcelService.getCellValue(sheet, i,5,"0").trim(); 
				xmmc_next=ExcelService.getCellValue(sheet, i+1,5,"0").trim();
                //业务类型 
              temp=ExcelService.getCellValue(sheet, i,1,"0").trim();  
              if (!Util.isBlankString(temp)) {    
                        sqlTemp="select code_value from xt_option_code where code_title='"+temp+"' and id like '916%'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  业务类型 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在系统中未定义！";
                            error_num++;
                            continue;
                        }else{
                        	ywlx=r[0];
                        	
                        }  
                         
                       
                } 
				  //仓库
              temp=ExcelService.getCellValue(sheet, i,2,"0").trim();  
              if (!Util.isBlankString(temp)) {    
                 
                        sqlTemp="select id from jc_cksz where ckmc='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  仓库 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在仓库设置中未定义，请定义该仓库！";
                            error_num++;
                            continue;
                        }else{
                        	ck_id=r[0];
                        	
                        }  
                         
                       
                } 
			  //供应商
			  temp=ExcelService.getCellValue(sheet, i,3,"0").trim();  
              if (!Util.isBlankString(temp)) {    
                 
                        sqlTemp="select id,gysbh from gys_da where gysjc='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  供应商 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在供应商档案中未定义，请添加该供应商！";
                            error_num++;
                            continue;
                        }else{
							gys_id=r[0];
							gysbh=r[1];
						
						}
                         
                       
                } 
			//项目编号
			  temp=ExcelService.getCellValue(sheet, i,4,"0").trim();  
              if (!Util.isBlankString(temp)) {    
                 
                        sqlTemp="select id from xm_xmgl where xmbh='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  项目编号 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在项目档案中未定义，请添加该项目！";
                            error_num++;
                            continue;
                        }
                         
                       
                }
				
				//项目名称
			  temp=ExcelService.getCellValue(sheet, i,5,"0").trim();  
              if (!Util.isBlankString(temp)) {    
                 
                        sqlTemp="select id from xm_xmgl where xmbh='"+ExcelService.getCellValue(sheet, i,4,"0").trim()+"' and xmmc='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  项目名称 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 与项目编号不匹配，请到项目档案中核实！";
                            error_num++;
                            continue;
                        }
                         
                       
                } 
			
              
                //取出存货id
               temp=ExcelService.getCellValue(sheet,i,6,"0").trim();  
               sqlTemp="select id,hsl,bzdw,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl from jc_chda where  chbm='"+temp+"' "; 
               r=Api.sb(sqlTemp);
               if (importType.equals("insert")) {     //如果是插入方式, 数据库里没有该名称,则报错
                        if (r==null || r[0].equals("0"))  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 没有存货！";
                            error_num++;
                            continue;
                        }else
                        	{
                        	ch_id=r[0];
							hsl=r[1];
							bzdw=r[2];
							xt_cpfz_sfbzqgl=r[3];
							xt_cpfz_sfpcgl=r[4];
                        	}
                  
                } 


				 //货品编码 名称 规格型号
                temp=ck_id+ch_id;
                
               
				ck=ExcelService.getCellValue(sheet,i,2,"0").trim();  //货品编码
				chbm=ExcelService.getCellValue(sheet,i,6,"0").trim();  //货品编码
				chmc=ExcelService.getCellValue(sheet,i,7,"0").trim(); //货品名称
				ggxh=ExcelService.getCellValue(sheet,i,8,"0").trim();//规格型号
                sqlTemp="select count(*) from jc_ckchdz where  ck+ch_id='"+temp+"' ";
				
				//System.out.println(sqlTemp);
                r=Api.sb(sqlTemp);
                if (importType.equals("insert")) {     //如果是插入方式, 数据库里没有该名称,则报错
                        if (r==null || r[0].equals("0"))  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [仓库名称]为["+ck+"],[货品编码]为["+chbm+"],[货品名称]为["+chmc+"],[规格型号]为["+ggxh+"] 在仓库存货对照不存在，请到【仓库货品勾选】中添加！";
                            error_num++;
                            continue;
                        }
                  
                } 
				xt_cpfz_pc=ExcelService.getCellValue(sheet, i,13,"0").trim();//批次
				xt_cpfz_scrq=ExcelService.getCellValue(sheet, i,14,"0").trim();//生产日期
				xt_cpfz_sxrq=ExcelService.getCellValue(sheet, i,15,"0").trim();//失效日期
				if (!Util.isBlankString(xt_cpfz_pc)) {
					xt_cpfz_xgsx="批次："+xt_cpfz_pc;
				}
				if (!Util.isBlankString(ExcelService.getCellValue(sheet, i,14,"0"))) {  //scrp
					xt_cpfz_xgsx+=" 生产日期："+ExcelService.getCellValue(sheet, i,14,"0");
				}
				if (!Util.isBlankString(ExcelService.getCellValue(sheet, i,15,"0"))) {  //scrp
					xt_cpfz_xgsx+=" 失效日期："+ExcelService.getCellValue(sheet, i,15,"0");
				}
				


                //销售代表    (单层码)(非必录)
                temp=ExcelService.getCellValue(sheet, i,16,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                        sqlTemp="select a.id,a.name,a.bm_id,b.name from xt_yh a,xt_bm b  where a.bm_id=b.id and  (a.name='"+temp+"' or  a.zhanghao='"+temp+"' )";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  销售代表 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在用户帐号中未定义,请先添加该帐号！";
                            error_num++;
                            continue;
                        }  
                        if (r.length>4)  {   //如果通过姓名找出的帐号多余一个
                            errorMessage+="\r\n  销售代表 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在用户帐号有重名的记录,请通过帐号而不是姓名指定！";
                            error_num++;
                            continue;
                        }  
                        valueXsdb=r[0];
                        valueXsdb_mc=r[1];
                        valueBm=r[2];
                        valueBm_mc=r[3];
                } else {
                        valueXsdb=((String[])session.getAttribute("userInfo"))[0];    //取当前yh_id
                        valueXsdb_mc=((String[])session.getAttribute("userInfo"))[2];  //取当前登录人姓名
                        valueBm=((String[])session.getAttribute("userInfo"))[3];    //
                        valueBm_mc=Api.getValueName("000", valueBm);
                }
								
				lrr=((String[])session.getAttribute("userInfo"))[0];
				lrbm=((String[])session.getAttribute("userInfo"))[3];
				lrrq=Util.getDate();
                
               
                //对该行的列都检查完了,可以预生成sql语句了
				
                if (!is_update )  { // 如果是插入模式
						id=Util.getSequence();

						sql+=" update kc_rkd_sub set fid='"+id+"' where fid='888888' ";
                        sql+="  exec getDJH  '11689555671970113', @djh output  ";   //取一个单据号
                        sql+=" insert into kc_rkd (id,rkdh,rkrq,ywlx,ck,gys,gysbh,gys_id,ywy_id,ywy_mc,ywbm_id,ywbm_mc,lrr,lrrq,lrbm,shr,shrq,shzt) values (  ";
                        sql+="'"+id+"',";                                          // id 
                        sql+=" @djh,";                                        // 入库单号
                        sql+="'"+ExcelService.getCellValue(sheet, i,0,"0").trim()+"',";//入库日期
						sql+="'"+ywlx+"',";//业务类型
						sql+="'"+ck_id+"',";//仓库
						sql+="'"+ExcelService.getCellValue(sheet, i,3,"0").trim()+"',";//供应商
						sql+="'"+gysbh+"',";//供应商编号
						sql+="'"+gys_id+"',";//供应商id
                        sql+="'"+valueXsdb+"',";                                                                                                // ywy_id销售代表
                        sql+="'"+valueXsdb_mc+"',";                                                                                                // ywy_mc 销售代表
                        sql+="'"+valueBm+"',";                                                                                                // ywbm_id销售代表
                        sql+="'"+valueBm_mc+"',";                                                                                                // ywbm_mc销售代表
                        sql+="'"+((String[])session.getAttribute("userInfo"))[0]+"',";                        // lrr 销售代表
                        sql+="'"+Util.getDate()+"',";                                                                                     // lrrq
                        sql+="'"+((String[])session.getAttribute("userInfo"))[3]+"',";                         // lrbm
                        sql+="'','','0'";    
                        sql+=")";   
                        
                        //插入库单子表
                      	
		                sql+=" insert into kc_rkd_sub (id,fid,chbm,chmc,ggxh,bzdw, bzsl,dw,sl, dj,je,bz,ch_id,hsl,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl)  values (";
		                sql+=" '"+id+"',";                                          // id 
		                sql+=" '"+id+"',"; 
		                sql+=" '"+ExcelService.getCellValue(sheet,i,6,"0").trim()+"',"; //货品编码
						sql+=" '"+ExcelService.getCellValue(sheet,i,7,"0").trim()+"',"; //货品名称
						sql+=" '"+ExcelService.getCellValue(sheet,i,8,"0").trim()+"',"; //规格型号
						sql+="'"+bzdw+"',";//包装单位		
						sql+="'"+Double.parseDouble(ExcelService.getCellValue(sheet, i,10,"0.00").trim())/Double.parseDouble(hsl)+"',";
						//包装数量
						sql+=" '"+ExcelService.getCellValue(sheet,i,9,"0").trim()+"',";//单位
						sql+="'"+ExcelService.getCellValue(sheet, i,10,"0.00").trim()+"',";//数量
						sql+="'"+ExcelService.getCellValue(sheet, i,11,"0.00").trim()+"',";//单价
						sql+="'"+Double.parseDouble(ExcelService.getCellValue(sheet, i,10,"0.00").trim())*Double.parseDouble(ExcelService.getCellValue(sheet, i,11,"0.00").trim())+"',";//金额
						sql+=" '"+ExcelService.getCellValue(sheet,i,17,"0").trim()+"',";//备注
						sql+="'"+ch_id+"',";//存货id
						sql+="'"+Double.parseDouble(hsl)+"',";//换算率
						sql+="'"+xt_cpfz_pc+"',";//批次
						sql+="'"+xt_cpfz_scrq+"',";//生产日期
						sql+="'"+xt_cpfz_sxrq+"',";//失效日期
						sql+="'0',";//有效期
						sql+="'"+xt_cpfz_xgsx+"',";//相关属性
						sql+="'"+xt_cpfz_sfbzqgl+"',";//相关属性
						sql+="'"+xt_cpfz_sfpcgl+"'";//相关属性
						
						sql+=")  ";  

						System.out.println("============================");
						System.out.println(rkrq+"vvvv"+rkrq_next);
						System.out.println(ywlx_mc+"vvvv"+ywlx_next);
						System.out.println(ck+"vvvv"+ck_next);
						if( (rkrq.equals(rkrq_next) ) && (ywlx_mc.equals(ywlx_next)) && (ck.equals(ck_next)) && (gys.equals(gys_next)) && (xmbm.equals(xmbm_next))  && (xmmc.equals(xmmc_next)) ){
								
						   sql+=" delete kc_rkd where id='"+id+"'  update kc_rkd_sub set fid='888888' where fid='"+id+"' ";
						  
					
						}
						
						


						

						
		                       
                                                                                                                         // enabled
                } 

        }  //for

        //报出检查的问题
        
        
        	
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");
	
		Api.ub(sql);     //实际执行
		Api.XtRefreshAutoKeyWords("kc_rkd");
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
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						入库单导入
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
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
							<td align="center"  width="100"   class="x_message_message_td"><img src="/emadmin/images/c2/icon/message.gif" align="center"/> </td>
							<td  class="x_message_message_td">
                                      保存成功！<br>
                                  
                                        <div align="center" width="100%" style="padding-top:10px;width:100%;"><img src="/emadmin/images/c2/button/bill_ok.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:location.href="/emadmin/jsp/common/list.jsp?modul_id=kc_rkd_listModul"'/> </div>
							</td>
						  </tr>
						</table>
				</form>													
						
											
			<!-- 内容区 -->

</body>
</html>

