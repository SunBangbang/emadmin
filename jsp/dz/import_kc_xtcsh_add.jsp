<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.io.*,com.lf.util.*,java.text.SimpleDateFormat,com.lf.lfbase.service.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,javax.servlet.http.HttpServletRequest,java.net.*,java.text.*,java.lang.*"%>
<%

        /*
        1、首先检查上传的Excel文件的合法性
            1）是不是Excel文件
            2）工作表的数量是不是1个，工作表的名称对不对“客户档案”
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

// 特殊处理
//  如果系统未启用批次，则模板中不含批次，如果系统启用了批次，则模板中含有批次，首先要进行这样的校验
// 在后续的处理中也要进行动态处理
                    
		// 1）是不是Excel文件
		System.out.println("开始导入。。。。。 了");
		Map req=ExcelService.initUpload(request);

	    FileItem fItem=(FileItem)req.get("is_pc");    //是否有批次管理
        String is_pc="";   // 导入方式 insert    update
        if (fItem==null ) {
            throw new LFException("传入参数不正确!");
        } else {
            is_pc=fItem.getString();   
        }

        if  (!is_pc.equals(Api.getXtPreferenceValueByName("is_pc"))) {
            throw new LFException("传入参数与系统参数中设置的不一致!");
        }


	FileItem myfile = (FileItem)req.get("myfile");
    if (myfile.getName().indexOf("xls")<0)
		throw new LFException("上传的文件不是EXCEL文件!");

	if( myfile.getSize() <= 0 ) 
        throw new LFException("上传的文件内容为空!");

    
    InputStream uploadedStream = myfile.getInputStream(); 
    POIFSFileSystem fs  =  new POIFSFileSystem(uploadedStream);	
    HSSFWorkbook wb = new HSSFWorkbook(fs);


    
    //2）工作表的数量是不是1个，工作表的名称对不对“库存期初”
    if (wb.getNumberOfSheets()!= 1)
        throw new LFException("模板的工作表数量应该是1个,请检查是否使用了正确的模板!");
	
    HSSFSheet sheet = wb.getSheetAt(0); 
     
    //if (!wb.getSheetName(sheet).eqauls("库存期初"))
        //throw new LFException("工作表的名称不是[库存期初]!");
    
    //3）标题列对不对

    String title="";
    String [] sheetTitle;
    if (is_pc.equals("1")) {
        sheetTitle=new String [27];
        sheetTitle[0]="仓库名称*";
		sheetTitle[1]="库管*";
        sheetTitle[2]="货品编码*";
        sheetTitle[3]="货品名称*";
		sheetTitle[4]="货品分类*";
        sheetTitle[5]="规格型号*";
        sheetTitle[6]="计价单位*";
		sheetTitle[7]="计价方式 ";
		sheetTitle[8]="原编号 ";
		sheetTitle[9]="大包装单位";
		sheetTitle[10]="包装换算率";
		sheetTitle[11]="税率";
		sheetTitle[12]="参考成本价";
		sheetTitle[13]="参考销售价";
		sheetTitle[14]="产地";
		sheetTitle[15]="品牌";
		sheetTitle[16]="生产商";
		sheetTitle[17]="货位";
		sheetTitle[18]="货品备注";
        sheetTitle[19]="期初数量";
        sheetTitle[20]="期初单价";
        sheetTitle[21]="期初金额";
		sheetTitle[22]="是否批次管理";
		sheetTitle[23]="是否有效期管理";
        sheetTitle[24]="批次";
        sheetTitle[25]="生产日期";
        sheetTitle[26]="失效日期";
    } else {
        sheetTitle=new String [22];
        sheetTitle[0]="仓库名称*";
		sheetTitle[1]="库管*";
        sheetTitle[2]="货品编码*";
        sheetTitle[3]="货品名称*";
		sheetTitle[4]="货品分类*";
        sheetTitle[5]="规格型号*";
        sheetTitle[6]="计价单位*";
		sheetTitle[7]="计价方式 ";
		sheetTitle[8]="原编号 ";
		sheetTitle[9]="大包装单位";
		sheetTitle[10]="包装换算率";
		sheetTitle[11]="税率";
		sheetTitle[12]="参考成本价";
		sheetTitle[13]="参考销售价";
		sheetTitle[14]="产地";
		sheetTitle[15]="品牌";
		sheetTitle[16]="生产商";
		sheetTitle[17]="货位";
		sheetTitle[18]="货品备注";
        sheetTitle[19]="期初数量";
        sheetTitle[20]="期初单价";
        sheetTitle[21]="期初金额";
    }

		//判断标题对不对
		for (int i=0;i<sheetTitle.length;i++) {
			title=ExcelService.getCellValue(sheet, 0, i,"0").trim();    //row,col
			if (title==null || !title.equals(sheetTitle[i].trim()) ) 
				throw new LFException("工作表的第 "+String.valueOf(i+1)+" 列应为：["+sheetTitle[i].trim()+"]!");
		}
   
		//判断上传文件和is_pc是否一致
		if (!is_pc.equals("1")) {   //未启用批次，但上传文件含有批次列
			   title=ExcelService.getCellValue(sheet, 0,22,"0").trim();
			   if (title!=null && title.equals("批次")) 
				 throw new LFException("此模板含有批次列，但目前系统未启用批次，请重新下载模版！");
		}

		 ///2、检查Excel文件数据自身的合法性        
         //1）仓库、编码有没有没录的，即必录项检查
         String errorMessage="";   //错误信息
         int  error_num=0;  //错误数

         String ck="";        //仓库名称
		 String kg="";			//库管
         String chbm="";          //货品编码
         String chmc="";          //货品名称
		 String chfl="";			//货品分类
         String ggxh="";          //规格型号
         String jjdw="";          //计价单位
		 String hw="";				//货位
         double qcsl;          //期初数量
         String pc="";						//批次
         String scrq="";						//生产日期
         String sxq="";						//失效日期
	     String tempMc="";          //临时存放
		 String tempMc2="";			//临时存放
		 HashMap  allUnion= new HashMap ();	//仓库名称+货品编码+批次	
		 HashMap  allCk= new HashMap(); 	    //仓库
		 HashMap  allChbm=new HashMap();		//存货编码
		 HashMap  allHw= new HashMap(); 	    //货位
		 HashMap  allJcda=new HashMap(); 	    //货品基础档案
		 HashMap  allJcda2=new HashMap(); 	    //货品基础档案2
		 HashMap  allck_id=	new HashMap(); //所有仓库id
		 HashMap  allch_id=new HashMap(); //所有存货id
		 HashMap  allchmc=new HashMap(); //所有存货名称,通过id查找名称
         //解决假行的问题
        int realTotalRows=0;   //实际的行数
        int totalRows = sheet.getLastRowNum()+2;   //Excel返回总行数
        boolean is_continue_next=false;    //如果有一个问题出现了，则去处理一条。
         for (int i=1;i<totalRows;i++)  {    //开始扫描  从第2行开始

                ck=ExcelService.getCellValue(sheet, i,0,"0").trim();  
				kg=ExcelService.getCellValue(sheet, i,1,"0").trim(); 
                chbm=ExcelService.getCellValue(sheet, i,2,"0").trim(); 
                chmc=ExcelService.getCellValue(sheet, i,3,"0").trim(); 
				chfl=ExcelService.getCellValue(sheet, i,4,"0").trim(); 
                ggxh=ExcelService.getCellValue(sheet, i,5,"0").trim();
				hw=ExcelService.getCellValue(sheet, i,17,"0").trim();
                jjdw=ExcelService.getCellValue(sheet, i,6,"0").trim();  
                qcsl=Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,19,"0.00").trim());  
                pc=ExcelService.getCellValue(sheet, i,24,"0").trim(); 
                scrq=ExcelService.getCellValue(sheet, i,25,"0").trim(); 
				//仓库与货品编码都为空，同时后边行的这两列没有了，就到底了
                if (ck.length()==0 &&kg.length()==0&& chbm.length()==0&&chmc.length()==0&&chfl.length()==0&&ggxh.length()==0) { 
                        boolean find=false;
                        for (int j=i+1;j<totalRows;j++) {
                            if(ck.length()>0||kg.length()>0||chbm.length()>0||chmc.length()>0||chfl.length()>0||ggxh.length()>0) {
                                find=true;
                                break;   //不用继续找了
                            }
                        }
                        if (!find) {    //到底了
                            realTotalRows=i;
                            break;
                        }
                }

               

                if (ck.length()==0 && chbm.length()>0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [仓库名称] 不能为空！";
                    error_num++;
                    is_continue_next=true;
                }
				
                if (ck.length()>0 && chbm.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [货品编码] 不能为空！";
                    error_num++;
                    is_continue_next=true;
                }
				if ( kg.length()==0)  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [库管] 不能为空！";
                    error_num++;
                    is_continue_next=true;
                }
                if (chmc.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [货品名称] 不能为空！";
                    error_num++;
                    is_continue_next=true;
                }
				if (chfl.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [货品分类] 不能为空！";
                    error_num++;
                    is_continue_next=true;
                }
                if (ggxh.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [规格型号] 不能为空！";
                    error_num++;
                    is_continue_next=true;
                }
				if (jjdw.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [计价单位] 不能为空！";
                    error_num++;
                    is_continue_next=true;
                }

				//是否有效期管理 
				 tempMc=ExcelService.getCellValue(sheet, i,23,"0").trim(); 
				 //如果系统未启用批次管理，却选择批次管理，则报错
				 if (tempMc.equals("是") && !Api.getXtPreferenceValueByName("is_pc").equals("1"))  {
					errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [是否有效期管理] 不能为“是”，因为系统未启用批次及有效期管理，请选择“否”，或到首选参数中启用批次及有效期！";
					error_num++;
					 is_continue_next=true;
				 } 

                 //是否批次管理 
                 tempMc=ExcelService.getCellValue(sheet, i,22,"0").trim(); 
                 //如果系统未启用批次管理，却选择批次管理，则报错
                 if (tempMc.equals("是") && !Api.getXtPreferenceValueByName("is_pc").equals("1"))  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [是否批次管理] 不能为“是”，因为系统未启用批次及有效期管理，请选择“否”，或到首选参数中启用批次及有效期！";
                    error_num++;
                    is_continue_next=true;
                 } 

			

                //如果是批次管理，做关于批次的相关判断
                if (is_pc.equals("1")) {   //
                         String tmptmp=ExcelService.getCellValue(sheet, i,25,"0").trim();  
                        //判断日期格式
                         if (!Util.checkDateFormat(tmptmp) ){
                                errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [生产日期]格式不正确,日期格式样例：2009-05-18。";
                            error_num++;
                            is_continue_next=true;
                         
                         }
                         //如果输入了日期，没有批次，则提示
                         if (Util.isBlankString(pc) && !Util.isBlankString(tmptmp) ){
                                errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 输入了生产日期，则必需录入批次，如果您不确定批次，可以直接把生产日期作为批次。";
                                error_num++;
                                is_continue_next=true;
                         
                         }
                         String tmptmp1=ExcelService.getCellValue(sheet, i,26,"0").trim();  
                         if (!Util.checkDateFormat(tmptmp1) ){
                                errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行  [失效日期]日期格式不正确";
                                error_num++;
                                is_continue_next=true;
                         }
                                                  //如果输入了日期，没有批次，则提示
                         if (Util.isBlankString(tmptmp) && !Util.isBlankString(tmptmp1) ){
                                errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 输入了失效日期，则必需录入生产日期。";
                                error_num++;
                                is_continue_next=true;
                         
                         }

                }
				 //4、如果启用批次管理，是不是应该导入成功后，计价方式应该是【批次计价法】
				 tempMc=ExcelService.getCellValue(sheet, i,22,"0").trim();	//是否批次管理
				 tempMc2=ExcelService.getCellValue(sheet, i,7,"0").trim(); //计价方式
				// if("是".equals(tempMc)&&(!tempMc2.equals("批次计价法")))
				 if(tempMc2.equals("批次计价法")&&(!"是".equals(tempMc)))
				 {
					    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 计价方式选择了[批次计价法],批次管理必须选择[是]！";
						error_num++;
						is_continue_next=true;
				 }

				//2) 同一个货品货位要相同的判断
				if (allChbm.containsKey(chbm))  {
						String oldhw=(String)allHw.get(chbm);

						
						if(null!=oldhw && (!oldhw.equals(hw)))
						{
							  
							  errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 货品编码:["+chbm+"],货品名称:["+chmc+"],货位:["+hw+"]与第[ "+allChbm.get(chbm)+" ]行的货位为["+oldhw+"]不一致,同一个货品必需是同一个货位,请核对！ ";
							   error_num++;
							   is_continue_next=true;
						}

				} else {
						if (!Util.isBlankString(chbm)) allChbm.put(chbm,String.valueOf(i+1));
						if (!Util.isBlankString(hw)) allHw.put(chbm,hw);	
				}


					//2）名称有没有重复
					if (allUnion.containsKey(ck+chbm+pc))  {
						if(is_pc.equals("1")){
							errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [仓库名称]为["+ck+"] ,[货品编码]为["+chbm+"],[批次]为["+pc+"]与 第[ "+allUnion.get(ck+chbm+pc)+" ]行重复！ ";
						} else {
							errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [仓库名称]为["+ck+"] ,[货品编码]为["+chbm+"]与 第[ "+allUnion.get(ck+chbm+pc)+" ]行重复！ ";
						}
							error_num++;
							is_continue_next=true;
					} else {
							if (!Util.isBlankString(ck+chbm+pc)) allUnion.put(ck+chbm+pc,String.valueOf(i+1));
					}


                if(is_continue_next) continue;    //如果上边有问题，则不查重，处理下一条
         } //for

         //先报出自身检查的问题
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<br/><div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");

        //校验并获取当前会计日历
        String r_dqkjq[]=Api.sb("select qsrq from jc_kjrl where zt='002'");
        if (r_dqkjq==null || r_dqkjq.length==0) {
             throw new LFException("系统没有当前会计期信息,请执行【系统启用】,重新建立会计日历!");
        }


		//3、Excel文件数据与数据库中的已有数据的关联性检查   


		/*   1)检查仓库是否合法   2）货品几项是否合法 3）批次有效期是否合法    */
        
        errorMessage="";
        error_num=0;
         
        String sqlTemp="";
        String temp="";
		String sql=" declare @djh varchar(200) ";
			   sql+="alter table jc_chda disable trigger tr_insert_jc_chda_chdz ";
			   sql+="alter table jc_chda disable trigger tr_update_jc_chda_chdz ";
			   sql+="alter table jc_chda disable trigger tr_delete_jc_chda_chdz ";
			   sql+="alter table jc_cksz disable trigger tr_insert_jc_cksz_chdz ";
			   sql+="alter table jc_cksz disable trigger tr_update_jc_cksz_chdz ";
			   sql+="alter table jc_cksz disable trigger tr_delete_jc_cksz_chdz ";
			   sql+="alter table jc_ckchdz disable trigger tr_insert_jc_ckchdz ";
        String r[]=null;
        
        
        String xt_cpfz_sfpcgl="";
        String xt_cpfz_sfbzqgl="";
        String ck_id=""; //最近的存货id
        String ch_id=""; //仓库id
        String ckmc="";
		String jldw="";
		String value_hplx="";
		String value_jjfs="";
        GB2Alpha gb2alpha = new GB2Alpha();//关键字搜索
		String valueXsdb="";
        String valueXsdb_mc="";
        String valueBm="";
        String valueBm_mc="";

        for (int i=1;i<realTotalRows;i++)  {    //开始扫描   从第2行开始
				
                 is_continue_next=false;
				 //仓库名称
				ckmc=ExcelService.getCellValue(sheet, i,0,"0").trim();  
				kg=ExcelService.getCellValue(sheet, i,1,"0").trim(); 
                chbm=ExcelService.getCellValue(sheet, i,2,"0").trim(); 
                chmc=ExcelService.getCellValue(sheet, i,3,"0").trim(); 
				chfl=ExcelService.getCellValue(sheet, i,4,"0").trim(); 
                ggxh=ExcelService.getCellValue(sheet, i,5,"0").trim();
                jjdw=ExcelService.getCellValue(sheet, i,6,"0").trim();   
				pc=ExcelService.getCellValue(sheet, i,24,"0").trim(); 

				//类型(多层代码)(必录)
                temp=ExcelService.getCellValue(sheet, i,4,"0").trim();    
                //查找出代码,层次码同时查找出是否是末级节点
                sqlTemp="select a.dm,(select count(*) from jc_hpfl b where b.dm<>a.dm and b.dm like a.dm+'%') from jc_hpfl a  where a.mc='"+temp+"'";

                r=Api.sb(sqlTemp);
                if (r==null || r.length==0)  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [货品类型] 中的 ["+temp+"] 在货品分类中未定义,请先添加该货品类型！";
                    error_num++;
                    is_continue_next=true;
                }  
				else if (!r[1].equals("0"))  {   //不是末级节点
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [货品类型] 中的 ["+temp+"] 不是最末级分类,请更该为末级分类！";
                    error_num++;
                    is_continue_next=true;
                }  
                else {value_hplx=r[0];}


			    //计价方式    (单层码)(非必录)
                temp=ExcelService.getCellValue(sheet, i,7,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                        sqlTemp="select code_value from xt_option_code where code_title='"+temp+"' and group_name='计价方式'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  计价方式 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在系统中未定义，请输入[“移动平均法”,“先进先出法”,“全月平均法”,“个别计价法”]中的一种！";
                            error_num++;
                           is_continue_next=true;
                        } 
						else{
							value_jjfs=r[0];
						}
                } else {  //默认值
                        value_jjfs="002";  //先进先出法
                }

				 //赋值
				temp=ExcelService.getCellValue(sheet,i,2,"0").trim();   
                temp+=ExcelService.getCellValue(sheet,i,3,"0").trim();	
				sqlTemp="select xt_cpfz_sfpcgl,xt_cpfz_sfbzqgl,id  from jc_chda where  chbm+chmc='"+temp+"' ";
                r=Api.sb(sqlTemp);
                if (r!=null && r.length>0)  {
						xt_cpfz_sfpcgl=r[0];
                        xt_cpfz_sfbzqgl=r[1];
                } 
               // 关于批次的检查
               if (is_pc.equals("1"))  {
                    pc=ExcelService.getCellValue(sheet, i,24,"0").trim(); 
                    scrq=ExcelService.getCellValue(sheet, i,25,"0").trim(); 
                    sxq=ExcelService.getCellValue(sheet, i,26,"0").trim(); 
                    //如果是批次管理，必须录入批次
                    if (xt_cpfz_sfpcgl.equals("1") && Util.isBlankString(pc)) {
                        errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [货品编码]为["+chbm+"],[货品名称]为["+chmc+"],[规格型号]为["+ggxh+"]  的货品，在【货品档案】中定义了采用“批次管理”，这里没有录入批次，请录入！";
                        error_num++;
                        is_continue_next=true;
                    }
                    //如果是效期管理，必须录入生产日期
                    if (xt_cpfz_sfbzqgl.equals("1") && Util.isBlankString(scrq)) {
                        errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [货品编码]为["+chbm+"],[货品名称]为["+chmc+"],[规格型号]为["+ggxh+"]  的货品，在【货品档案】中定义了采用“有效期管理”，这里没有录入生产日期，请录入！";
                        error_num++;
                        is_continue_next=true;
                    }
               }


			    // 判断库管是合法   (单层码)(非必录)
                temp=ExcelService.getCellValue(sheet, i,1,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                        sqlTemp="select a.id,a.name,a.bm_id,b.name from xt_yh a,xt_bm b  where a.bm_id=b.id and  (a.name='"+temp+"' or  a.zhanghao='"+temp+"' )";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  库管 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在用户帐号中未定义,请先添加该帐号！";
                            error_num++;
                           is_continue_next=true;
                        }  
                        else if (r.length>4)  {   //如果通过姓名找出的帐号多余一个
                            errorMessage+="\r\n  库管 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在用户帐号有重名的记录,请通过帐号而不是姓名指定！";
                            error_num++;
                            is_continue_next=true;
                        } else{
							valueXsdb=r[0];
							valueXsdb_mc=r[1];
							valueBm=r[2];
							valueBm_mc=r[3];
						}
                       
                } else {
                        valueXsdb=((String[])session.getAttribute("userInfo"))[0];    //取当前yh_id
                        valueXsdb_mc=((String[])session.getAttribute("userInfo"))[2];  //取当前登录人姓名
                        valueBm=((String[])session.getAttribute("userInfo"))[3];    //
                        valueBm_mc=Api.getValueName("000", valueBm);
                }
				
				//判断货品期初的货品以前是否发生了交易
				sqlTemp="select count(*) from kc_kcspz where chbm='"+chbm+"' and xt_cpfz_pc='"+pc+"' and djlx<>'期初'" ;
				r=Api.sb(sqlTemp);
				if (r!=null && (!r[0].equals("0")))  {
					errorMessage+="\r\n  第 [ "+String.valueOf(i+1)+" ] 行中 [货品编码]为["+chbm+"],[货品名称]为["+chmc+"],[批次]为["+pc+"]的货品，已经发生过出入库交易,不允许再期初导入了,请核对！";
					error_num++;
				   is_continue_next=true;
				} 
				

             if(is_continue_next) continue;    //如果上边有问题，则不查重，处理下一条
            

		
			//对该行的列都检查完了,可以预生成sql语句了

			String id=Util.getSequence();
			//3）用HashMap将仓库唯一存储起来
			//插入之前先判断数据库中是否存在
			sqlTemp="select id,ckbm,ckmc from jc_cksz where ckmc='"+ckmc+"'";
			r=Api.sb(sqlTemp);
			//如果数据库中不存在则生成插入的SQL语句
			if (r==null || r.length==0) 
			{
				if (!allCk.containsKey(ckmc))  {
					if (!Util.isBlankString(ckmc)){ allCk.put(ckmc,String.valueOf(i+1));
						allck_id.put(ckmc,id); 
						ck_id=id;
						 //仓库设置导入
						sql+="  exec getDJH  'xtckbh', @djh output  ";   //取一个单据号
						sql+="insert into jc_cksz (id,ckbm,ckmc,ssbm,kg,ckchfl,zt,row_index,enabled,autokeyword) values(" ;
						sql+=" '"+id+"',"; 
						sql+=" @djh,"; 				//仓库编码
						sql+="'"+ckmc+"',";	 //仓库名称
						sql+="'"+valueBm+"',";
						sql+="',"+valueXsdb+",',";
						sql+="'',";	 //存货分类
						sql+="'1',";	 //状态
						sql+="'10',";	 //row_index
						sql+="'1','') ";  
					}
				} else{
					ck_id=(String)allck_id.get(ckmc);	
				}
			}else{
					ck_id=r[0];
			}


		     //插入之前先判断数据库中是否存在

			 sqlTemp="select id,chbm,chmc from jc_chda where chbm='"+chbm+"' or( chmc='"+chmc+"' and chlx='"+value_hplx+"' and ggxh='"+ggxh+"') ";
			 r=Api.sb(sqlTemp);
			//如果数据库中不存在则生成插入的SQL语句
			 if (r==null || r.length==0) {
				//3）用HashMap将货品基础档案 唯一存储起来
						if (!(allJcda.containsKey(chbm)||allJcda2.containsKey(chbm+chmc+chfl+ggxh)))  {

						if (!(Util.isBlankString(chbm)||Util.isBlankString(chbm+chmc+chfl+ggxh))) 
						{
						 allJcda.put(chbm,String.valueOf(i+1));
						 allJcda2.put(chbm+chmc+chfl+ggxh,String.valueOf(i+1));
						 allch_id.put(chbm,id);
						 allchmc.put(chbm,chmc);
						 ch_id=id;
						//先插入货品档案
						sql+="  insert into jc_chda (id,chbm,chmc,chlx,ggxh,jldw,jjfs,ybm,bzdw,hsl,sl,ckcbj,cklsj,cd,chpp,scs,hw,bz,xt_cpfz_sfpcgl,xt_cpfz_sfbzqgl,lrr,lrrq,lrbm,enabled,autokeyword) values (";
						sql+=" '"+id+"',";                                          // id 就用单据号
						sql+="'"+ExcelService.getCellValue(sheet, i,2,"0").trim()+"',";                         // 货品编码
						sql+="'"+ExcelService.getCellValue(sheet, i,3,"0").trim()+"',";                         // chmc 
						sql+="'"+value_hplx+"',";                         // chlx 
						sql+="'"+ExcelService.getCellValue(sheet, i,5,"0").trim()+"',";                         // ggxh
						sql+="'"+ExcelService.getCellValue(sheet, i,6,"0").trim()+"',";                         //jjdw
						sql+="'"+value_jjfs+"',";                         // jjfs
						sql+="'"+ExcelService.getCellValue(sheet, i,8,"0").trim()+"',";                         //ybh
						sql+="'"+ExcelService.getCellValue(sheet, i,9,"0").trim()+"',";                         //bzdw

						temp=ExcelService.getCellValueForNumber(sheet, i,10,"0.00").trim();		
						sql+="'"+(Util.isBlankString(ExcelService.getCellValue(sheet, i,10,"0").trim())?"1":temp)+"',";                         //hsl 换算率
						temp=ExcelService.getCellValueForNumber(sheet, i,11,"0.00").trim();
						sql+="'"+(Util.isBlankString(ExcelService.getCellValue(sheet, i,11,"0").trim())?"0.17":temp)+"',";   //sl
						sql+="'"+ExcelService.getCellValueForNumber(sheet, i,12,"0.00").trim()+"',";                   //ckcbj
						sql+="'"+ExcelService.getCellValueForNumber(sheet, i,13,"0.00").trim()+"',";             //cklsj
						sql+="'"+ExcelService.getCellValue(sheet, i,14,"0").trim()+"',";                         // cd
						sql+="'"+ExcelService.getCellValue(sheet, i,15,"0").trim()+"',";                         //chpp品牌
						sql+="'"+ExcelService.getCellValue(sheet, i,16,"0").trim()+"',";                         //scs	生产商
						sql+="'"+ExcelService.getCellValue(sheet, i,17,"0").trim()+"',";                         //hw	货位

						sql+="'"+ExcelService.getCellValue(sheet, i,18,"0").trim()+"',";                         //bz	货品备注
						temp=ExcelService.getCellValue(sheet, i,22,"0").trim();
						sql+="'"+(temp.equals("是")?"1":"0")+"',";                         //xt_cpfz_sfpcgl

						temp=ExcelService.getCellValue(sheet, i,23,"0").trim();
						sql+="'"+(temp.equals("是")?"1":"0")+"',";    //xt_cpfz_sfbzqgl

						sql+="'"+((String[])session.getAttribute("userInfo"))[0]+"',";                        // lrr 销售代表
						sql+="'"+Util.getDate()+"',";                                                         // lrrq
						sql+="'"+((String[])session.getAttribute("userInfo"))[3]+"',";                         // lrbm
						sql+="'1','') ";  
					  }
					}else{
						//这个货品已经添加过了检查货位信息
						ch_id=(String)allch_id.get(chbm);
						chmc=(String)allchmc.get(chbm);
					}
			}else{
				ch_id=r[0];
			} 
			
				//再插入库存期初导入
             
                String rls ="";			//日流水
                String xgsx="";		   //相关属性
                rls = r_dqkjq[0] + id;       
                xgsx="";
                if (!Util.isBlankString(pc)&&ExcelService.getCellValue(sheet, i,22,"0").trim().equals("是")) {
                    xgsx+="批次："+pc;
                }
                if (!Util.isBlankString(ExcelService.getCellValue(sheet, i,25,"0").trim())) {  //scrp
                    xgsx+=" 生产日期："+ExcelService.getCellValue(sheet, i,25,"0").trim();
                }
                if (!Util.isBlankString(ExcelService.getCellValue(sheet, i,26,"0").trim())) {  //scrp
                    xgsx+=" 失效日期："+ExcelService.getCellValue(sheet, i,26,"0").trim();
                }
                
			   sqlTemp="select id,ckmc,ck_id,chbm,ch_id,xt_cpfz_pc,jcdj from kc_kcspz where ckmc='"+ckmc+"' and chbm='"+chbm+"' and xt_cpfz_pc='"+pc+"' ";	
				r=Api.sb(sqlTemp);
				//ck_id=r[2];
				//ch_id=r[4];
				//chbm =r[3];
			    if (r==null || r.length==0) {
					   sql+="  insert into kc_kcspz (id,djbh,djrq,ywlx,djlx,ckmc,ck_id,chbm,chmc,ggxh,dw,rksl,rkdj,rkje,cksl,ckdj,ckje,jcsl,jcdj,jcje,ch_id,rls,autokeyword,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl) values (";
						sql+="'yj"+id+"',";       // id 
						sql+="'',";               // djbh 
						sql+="'"+ r_dqkjq[0]+"',";                                      // 单据日期
						sql+=" '405',";                         // 业务类型
						sql+=" '期初',";                         // 单据类型
						sql+="'"+ckmc+"',";                         // 仓库名称
						sql+="'"+ck_id+"',";  		 //仓库ID
						sql+="'"+chbm+"',";      //存货编码    
						sql+="'"+chmc+"',";  	 //存货名称
						sql+="'"+ggxh+"',";  	   //规格型号
						sql+="'"+jjdw+"',";    //	 计价单位
						sql+="0,";     //rksl
						sql+="0,";    //rkdj
						sql+="0,";    //rkje
						sql+="0,";    //cksl
						sql+="0,";    //ckdj
						sql+="0,";    //ckje
					 
						sql+=""+Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,19,"0.00000000").trim())+",";                         // 结存数量
						sql+=""+Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,20,"0.00000000").trim())+",";                         // 结存单价
						sql+=""+Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,19,"0.00000000").trim())*Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,20,"0.00000000").trim())+",";                         // 结存金额
						sql+="'"+ch_id+"',";  		  											//存货id
						sql+="'"+rls+"',";  											//日流水
						sql+="'"+gb2alpha.String2Alpha(ckmc+" "+chmc +" "+pc)+"', ";   	//系统关键字
						sql+="'"+pc+"',";                         // 批次
						sql+="'"+scrq+"',";                         // 生产日期
						sql+="'"+sxq+"',";                         // 失效日期
						sql+="'"+xgsx+"',";  		
						 sql+="'"+xt_cpfz_sfpcgl+"',";  		
						sql+="'"+xt_cpfz_sfbzqgl+"')  ";  		
				}else{
					String ck_id2 =r[2];
					String ch_id2=r[4];
					String pc2=r[5];
					double jcdj=+Double.parseDouble(r[6]);
					//修改，只修改数量
					sql+="  update kc_kcspz set jcsl=jcsl+"+Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,19,"0.00000000").trim())+",jcje=jcje+"+Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,19,"0.00000000").trim())*jcdj+" where ck_id='"+ck_id2+"' and ch_id='"+ch_id2+"'  and xt_cpfz_pc='"+pc2+"'  ";
				}
				

		  
        }  //for

        //报出检查的问题
           if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");
                
        	
      
               //sql=" truncate table kc_kcspz  truncate table jc_cksz  truncate table jc_chda "+sql;   //删除库存商品帐
               //更新当前库存
               sql+=" truncate table  kc_kcspz_dqkc ";
			   sql+=" insert kc_kcspz_dqkc select distinct ck_id+ch_id+xt_cpfz_pc,ck_id,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,jcsl from kc_kcspz where djrq+rls in(select max(djrq+rls) from kc_kcspz group by ck_id,ch_id,xt_cpfz_pc) and jcsl >0  ";

			  
				sql+=" truncate table  jc_ckchdz ";
                //更新仓库存货对照
				sql+=" insert into jc_ckchdz (id,ck,chbm,chmc,ggxh,ch_id) select distinct ch_id+ck_id+chbm,ck_id,chbm,chmc,ggxh,ch_id  from kc_kcspz  where ck_id+chbm+chmc+ggxh+ch_id  not in (select ck+chbm+chmc+ggxh+ch_id from jc_ckchdz) "; 

				 
				//更新仓库货品分类,要设置大类 和我设置的货品类型有关
				//更新仓库货品分类
				sql+=" update jc_cksz set ckchfl=ckchfl+','+substring(b.chlx,1,3)+',' from  jc_ckchdz a,jc_chda b where a.ch_id=b.id and jc_cksz.id=a.ck and jc_cksz.ckchfl not like '%,'+substring(b.chlx,1,3)+',%'	";

				//更新仓库存货对照第二次刷新	  ,先删除后刷
				sql+=" truncate table  jc_ckchdz   insert into jc_ckchdz (id,ck,chbm,chmc,ggxh,ch_id) select distinct ch_id+ck_id+chbm,ck_id,chbm,chmc,ggxh,ch_id  from kc_kcspz  where ck_id+chbm+chmc+ggxh+ch_id  not in (select ck+chbm+chmc+ggxh+ch_id from jc_ckchdz) "; 

			   sql+="alter table jc_chda enable trigger tr_insert_jc_chda_chdz ";
			   sql+="alter table jc_chda enable trigger tr_update_jc_chda_chdz ";
			   sql+="alter table jc_chda enable trigger tr_delete_jc_chda_chdz ";
			   sql+="alter table jc_cksz enable trigger tr_insert_jc_cksz_chdz ";
			   sql+="alter table jc_cksz enable trigger tr_update_jc_cksz_chdz ";
			   sql+="alter table jc_cksz enable trigger tr_delete_jc_cksz_chdz ";
			   sql+="alter table jc_ckchdz enable trigger tr_insert_jc_ckchdz ";
			   Api.ub(sql);     //实际执行	


				Api.XtRefreshAutoKeyWords("jc_cksz");
				Api.XtRefreshAutoKeyWords("jc_chda");
				Api.XtRefreshAutoKeyWords("kc_kcspz");
				Api.XtRefreshAutoKeyWords("jc_ckchdz");
				Api.ub("update xt_xszn set state=1 where modul_id='kc_kcqc_import_Modul'");
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
						库存期初导入
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
                                    
                                        <div align="center" width="100%" style="padding-top:10px;width:100%;"><img src="/emadmin/images/c2/button/bill_ok.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:location.href="/emadmin/jsp/common/list.jsp?modul_id=kc_kcspz_listModul"'/> </div>
							</td>
						  </tr>
						</table>
				</form>													
						
											
			<!-- 内容区 -->

</body>
</html>

