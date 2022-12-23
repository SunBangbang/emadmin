<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.io.*,com.lf.util.*,java.text.SimpleDateFormat,com.lf.lfbase.service.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,javax.servlet.http.HttpServletRequest,java.net.*,java.text.*"%>
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
         //判断日期格式 
         if (!Util.checkDateFormat(tmp) )
					errMessage += " 采购应付款信息的第 "+Integer.toString(i+1)+" 行的单据日期格式不正确,格式为 2008-01-01 "+ ";<br> \r\n";

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


    
    //2）工作表的数量是不是1个，工作表的名称对不对“客户档案”
    if (wb.getNumberOfSheets()!= 1)
        throw new LFException("模板的工作表数量应该是1个,请检查是否使用了正确的模板!");
	
    HSSFSheet sheet = wb.getSheetAt(0); 
    
    //3）标题列对不对
    String title="";
    String [] sheetTitle=new String [36];
    sheetTitle[0]="客户名称*";
    sheetTitle[1]="客户类型";
	sheetTitle[2]="客户级别*";
    sheetTitle[3]="客户需求";
    sheetTitle[4]="答复内容"; 
    sheetTitle[5]="最新报价";
    sheetTitle[6]="公司电话*";
    sheetTitle[7]="联系人*";
    sheetTitle[8]="性别";
    sheetTitle[9]="移动电话";
    sheetTitle[10]="MSN/(QQ)";
    sheetTitle[11]="公司传真";
	sheetTitle[12]="公司网址";
	sheetTitle[13]="公司邮箱";
    sheetTitle[14]="地区";
	sheetTitle[15]="地址";
    sheetTitle[16]="邮编";
	sheetTitle[17]="客户来源";
	sheetTitle[18]="公司性质";
	sheetTitle[19]="行业";
	sheetTitle[20]="主营业务";
	sheetTitle[21]="公司规模";
	sheetTitle[22]="开业年份";
	sheetTitle[23]="注册资金";
	sheetTitle[24]="公司法人";
	sheetTitle[25]="信用等级";
	sheetTitle[26]="开户银行";
	sheetTitle[27]="银行账号";
	sheetTitle[28]="税号";
    sheetTitle[29]="是否重点跟踪";
    sheetTitle[30]="跟踪状态";
	sheetTitle[31]="下次联系日期";
	sheetTitle[32]="客户建立日期";
    sheetTitle[33]="销售代表";
	sheetTitle[34]="协助人";
    sheetTitle[35]="备注";
   
    for (int i=0;i<sheetTitle.length;i++) {
        title=ExcelService.getCellValue(sheet, 0, i,"0").trim();    //row,col
        if (title==null || !title.equals(sheetTitle[i].trim()) ) 
            throw new LFException("工作表的第 "+String.valueOf(i+1)+" 列应为：["+sheetTitle[i].trim()+"]!");
    }
   
 

		 ///2、检查Excel文件数据自身的合法性        
         //1）名称、类型有没有没录的 
         String errorMessage="";   //错误信息
         int  error_num=0;  //错误数
         String mc="";        //名称
		 String gsdh="";		//公司电话
         String lx="";          //类型
         String lxr="";          //类型
		 String yddh="";        //移动电话
		 String khjb="";		//客户级别
		 String email="";		//公司邮箱
		 HashMap  allMc= new HashMap ();	//所有的公司名称	
		 HashMap  allLxr= new HashMap ();	//所有的联系人
		 HashMap  allyddh=new HashMap ();//所移动电话
		 HashMap  allemail=new HashMap ();//所公司邮箱	
				 
         int realTotalRows=0;   //实际的行数
         int totalRows = sheet.getLastRowNum()+2;   //Excel返回总行数
	
         for (int i=1;i<totalRows;i++)  {    //开始扫描  从地2行开始
                mc=ExcelService.getCellValue(sheet, i,0,"0").trim();  
				khjb=ExcelService.getCellValue(sheet, i,2,"0").trim(); 
				gsdh=ExcelService.getCellValue(sheet, i,6,"0").trim(); 
                lxr=ExcelService.getCellValue(sheet, i,7,"0").trim(); 
				yddh=ExcelService.getCellValue(sheet, i,9,"0").trim(); 
				email=ExcelService.getCellValue(sheet, i,13,"0").trim();
			    //名称,级别,公司电话和联系人都为空，同时后边没有了，就到底了
                if (mc.length()==0 && khjb.length()==0  && gsdh.length()==0&& lxr.length()==0) { 
                        boolean find=false;
                        for (int j=i+1;j<totalRows;j++) {
                            if (ExcelService.getCellValue(sheet, j,0,"0").trim().length()>0  || ExcelService.getCellValue(sheet, j,2,"0").trim().length()>0 ||ExcelService.getCellValue(sheet, j,6,"0").trim().length()>0||ExcelService.getCellValue(sheet, j,7,"0").trim().length()>0) {
                                find=true;
                                break;   //不用继续找了
                            }
                        }
                        if (!find) {    //到底了
                            realTotalRows=i-1;
                            break;
                        }
                }

                if (mc.length()==0)  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [客户名称] 不能为空！";
                    error_num++;
                    continue;
                }
               
			    if (khjb.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [客户级别] 不能为空！";
                    error_num++;
                    continue;
                }

				if (gsdh.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [公司电话] 不能为空！";
                    error_num++;
                    continue;
                }
				
                if (lxr.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [联系人] 不能为空！";
                    error_num++;
                    continue;
                }

				 //判断开业年份日期格式
                 String tmptmp=ExcelService.getCellValue(sheet, i,22,"0").trim();  
                 if (!Util.checkDateFormat(tmptmp) ){
                 		errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 建立日期格式不正确";
                    error_num++;
                    continue;
                 }

                 //判断下次联系日期格式
                  //判断下次联系日期格式
                 tmptmp=ExcelService.getCellValue(sheet, i,31,"0").trim();
				 if(null!=tmptmp&&tmptmp.length()>=10)
					tmptmp=tmptmp.substring(0,10);
				    System.out.println(tmptmp);
                 if (!Util.checkDateFormat(tmptmp) ){
                 		errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 下次联系日期格式不正确";
                    error_num++;
                    continue;
                 }
				 //判断客户建立日期格式
                 tmptmp=ExcelService.getCellValue(sheet, i,32,"0").trim();  
                 if (!Util.checkDateFormat(tmptmp) ){
                 		errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 建立日期格式不正确";
                    error_num++;
                    continue;
                 }

				 //判断公司邮箱不能为重复，如果不能为空的话
				
                 if (!Util.isBlankString(email) ){
                 	  if (allemail.containsKey(email))  {
                        errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [公司邮箱]为["+email+"] 与 第[ "+allemail.get(email)+" ]行重复！ ";
                        error_num++;
					} else {
							if (!Util.isBlankString(email)) allemail.put(email,String.valueOf(i+1));
							realTotalRows++;
					}
                 }
                //2）名称有没有重复
                if (allMc.containsKey(mc+lxr))  {
                        errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [客户名称]为["+mc+"],[联系人]为["+lxr+"] 与 第[ "+allMc.get(mc+lxr)+" ]行重复！ ";
                        error_num++;
                } else {
                        if (!Util.isBlankString(mc)) allMc.put(mc+lxr,String.valueOf(i+1));
                        realTotalRows++;
                }
				//3)移动电话是否重复
				if (allyddh.containsKey(yddh))  {
                        errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [移动电话]为["+yddh+"] 与 第[ "+allyddh.get(yddh)+" ]行重复！ ";
                        error_num++;
                } else {
                        if (!Util.isBlankString(yddh)) allyddh.put(yddh,String.valueOf(i+1));
                }
      
         } //for

         //先报出自身检查的问题
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<br/><div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");
				

		//3、Excel文件数据与数据库中的已有数据的关联性检查   
        
        errorMessage="";
        error_num=0;
        String allMcString="";  // 取得所有的名称，用于删除的时候和数据库比较
        String allLxrString="";  // 取得所有的名称，用于删除的时候和数据库比较
        String failDeleteMessage=""; //不能成功删除的记录
        String sqlTemp="";
        String temp="";
        String sql="  declare @djh varchar(200) declare @djh2 varchar(200) declare @djh3 varchar(255) ";
        String r[]=null;
        boolean  is_update=false;  //对于修改方式,标志是否是执行update,如果为否,则执行insert
		boolean  is_update_lxr=false;
        String valueLx="";
		String valueMc="";
		String valueKhjb="";
        String valueDq="";

        String valueXsdb="";
        String valueXsdb_mc="";
        String valueBm="";
        String valueBm_mc="";
		String valueXzr="";
		String valueXzbm="";
		String valueXzr_id="";
		String valueXzbm_id="";
        
        String sqlTemp2="";
        String temp2="";
        String r2[]=null;
        String valueLxr="";

		String sqlTemp3="";
        String temp3="";
		String r3[]=null;
		String valueYddh="";
        
        String valueXb="";
		String valueZdgz="";
		String valueLy="";
		String valueGsxz="";
		String valueHy="";
		String valueGsgm="";
		String valueXydj="";
		String valueGzzt="";
        for (int i=1;i<=realTotalRows;i++)  {    //开始扫描   从第2行开始
                //客户名称
                temp=ExcelService.getCellValue(sheet, i,0,"0").trim(); 
                allMcString+=","+temp+",";
                sqlTemp="select count(*) from kh_yxkh where khjc='"+temp+"'";
                r=Api.sb(sqlTemp);
                if (importType.equals("insert")) {     //如果是插入方式, 数据库里有该名称,则报错
                        if (r==null || r.length==0 || !r[0].equals("0"))  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [客户名称] 中的 ["+temp+"] 与数据库中的数据重复！";
                            error_num++;
                            continue;
                        }
                       is_update=false;
                       valueMc=temp;
                } else {  //如果是更新方式, 数据库里有该名称,则说明需要做update
                       if (r==null || r.length==0 || !r[0].equals("0"))  {
                            is_update=true;
                       } else {
                            is_update=false;
                       }
                        valueMc=temp;
                }
                //联系人
                temp2=ExcelService.getCellValue(sheet, i,7,"0").trim();  
                allLxrString+=","+temp2+",";
                sqlTemp2="select count(*) from kh_yxkh_lxr where xm='"+temp2+"' and khmc='"+temp+"'";
                r2=Api.sb(sqlTemp2);
                if (importType.equals("insert")) {     //如果是插入方式, 数据库里有该名称,则报错
                        if (r2==null || r2.length==0 || !r2[0].equals("0"))  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [联系人] 中的 ["+temp2+"] 与数据库中的数据重复！";
                            error_num++;
                            continue;
                        }
                       is_update=false;
                       valueLxr=temp2;
                } else {  //如果是更新方式, 数据库里有该名称,则说明需要做update
                       if (r2==null || r2.length==0 || !r2[0].equals("0"))  {
                            is_update=true;
                       } else {
                            is_update=false;
                       }
                        valueLxr=temp2;
                }

				 //公司邮箱是否与数据库中重复
				temp3=ExcelService.getCellValue(sheet, i,13,"0");  
				sqlTemp3="select count(*)  from kh_yxkh where email='"+temp3+"'" ;
				r3=Api.sb(sqlTemp3);
				if(importType.equals("insert")){ //如果是插入方式, 数据库里有该移动电话,则报错
					 if ((r3==null || r3.length==0 || !r3[0].equals("0"))&&temp3.length()!=0)  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [公司邮箱] 中的 ["+temp3+"] 与数据库中的数据重复！";
                            error_num++;
                            continue;
                        }
                       is_update=false;
				}else {  //如果是更新方式, 数据库里有该名称,则说明需要做update
                       if (r3==null || r3.length==0 || !r3[0].equals("0"))  {
                            is_update=true;
                       } else {
                            is_update=false;
                       }
                }
                
                
                //移动电话是否与数据库中重复
				temp3=ExcelService.getCellValue(sheet, i,9,"0");  
				sqlTemp3="select count(*)  from kh_yxkh_lxr where yddh='"+temp3+"'" ;
				r3=Api.sb(sqlTemp3);
				if(importType.equals("insert")){ //如果是插入方式, 数据库里有该移动电话,则报错
					 if ((r3==null || r3.length==0 || !r3[0].equals("0"))&&temp3.length()!=0)  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [移动电话] 中的 ["+temp3+"] 与数据库中的数据重复！";
                            error_num++;
                            continue;
                        }
                       is_update_lxr=false;
                       valueYddh=temp3;
				}else {  //如果是更新方式, 数据库里有该名称,则说明需要做update
                       if (r3==null || r3.length==0 || !r3[0].equals("0"))  {
                            is_update_lxr=true;
                       } else {
                            is_update_lxr=false;
                       }
                        valueYddh=temp3;
                }
                
                
                //客户类型(单层代码)
                 temp=ExcelService.getCellValue(sheet, i,1,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                       sqlTemp="select dm from jc_khfl where mc='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                             errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [客户类型] 中的 ["+temp+"] 在客户类型设置中未定义,请先添加该分类！";
                    error_num++;
                    continue;
                        }else{
                        	 valueLx=r[0];	
                        }    
                } 

                  
                //客户级别(单层代码)
                temp=ExcelService.getCellValue(sheet, i,2,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                       sqlTemp="select dm from dm_khjb where mc='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                             errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [客户级别] 中的 ["+temp+"] 在客户类型设置中未定义,请先添加该分类！";
							error_num++;
							continue;
                        }else{
                        	 valueKhjb=r[0];
                        }    
                }


                //性别（单层码检查）
				temp=ExcelService.getCellValue(sheet, i,8,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                        sqlTemp="select code_value from xt_option_code where group_name like '%性别%' and code_title='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  性别 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 不规范！";
                            error_num++;
                            continue;
                        }else{
                        	valueXb=r[0];
                        	
                        }  
                } 
               
                //地区    (层次码)(非必录)
                temp=ExcelService.getCellValue(sheet, i,14,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码,层次码同时查找出是否是末级节点
                        sqlTemp="select a.dm,(select count(*) from dm_dq b where b.dm<>a.dm and b.dm like a.dm+'%') from dm_dq a  where a.mc='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [地区] 中的 ["+temp+"] 在地区设置中未定义,请先添加该地区！";
                            error_num++;
                            continue;
                        }  
                        if (!r[1].equals("0"))  {   //不是末级节点
                            errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [地区] 中的 ["+temp+"] 不是最末级地区,请更该为末级地区！";
                            error_num++;
                            continue;
                        }  
                        valueDq=r[0];
                } else {
                        valueDq="";    //未录入,默认为空
                }

              
				//客户来源
				temp=ExcelService.getCellValue(sheet, i,17,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                        sqlTemp="select dm from dm_khly where mc='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  客户来源 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在系统中未定义！";
                            error_num++;
                            continue;
                        }else{
                        	valueLy=r[0];
                        	
                        }  
                } 
                //是否重点跟踪（单层码检查）
				temp=ExcelService.getCellValue(sheet, i,29,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                        sqlTemp="select code_value from xt_inneroption_code where group_name like '%是否%' and code_title='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  是否重点跟踪 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 不规范！";
                            error_num++;
                            continue;
                        }else{
                        	valueZdgz=r[0];
                        	
                        }   
                } 
				//跟踪状态
				temp=ExcelService.getCellValue(sheet, i,30,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                        sqlTemp="select dm from dm_gzzt where mc='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  跟踪状态 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在系统中未定义！";
                            error_num++;
                            continue;
                        }else{
                        	valueGzzt=r[0];
                        	
                        }  
                } 
				
				//公司性质
				temp=ExcelService.getCellValue(sheet, i,18,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                        sqlTemp="select dm from dm_gsxz where mc='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  公司性质 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在系统中未定义！";
                            error_num++;
                            continue;
                        }else{
                        	valueGsxz=r[0];	
                        }  
                } 
                //行业
                temp=ExcelService.getCellValue(sheet, i,19,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                        sqlTemp="select dm from dm_hy where mc='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  公司行业 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在系统中未定义！";
                            error_num++;
                            continue;
                        }else{
                        	valueHy=r[0];
                        	
                        }  
                } 
                //公司规模
                temp=ExcelService.getCellValue(sheet, i,21,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                        sqlTemp="select dm from dm_gsgm where mc='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  公司规模 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在系统中未定义！";
                            error_num++;
                            continue;
                        }else{
                        	valueGsgm=r[0];
                        	
                        }      
                       
                } 
                //信用等级
                temp=ExcelService.getCellValue(sheet, i,25,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                        sqlTemp="select dm from dm_xydj where mc='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  信用等级 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在系统中未定义！";
                            error_num++;
                            continue;
                        }else{
                        	valueXydj=r[0];
                        	
                        }  
                         
                       
                } 

				//销售代表    (单层码)(非必录)
                temp=ExcelService.getCellValue(sheet, i,33,"0").trim();  
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
                        valueXsdb=((String[])session.getAttribute("userInfo"))[0];     //取当前yh_id
                        valueXsdb_mc=((String[])session.getAttribute("userInfo"))[2];  //取当前登录人姓名
                        valueBm=((String[])session.getAttribute("userInfo"))[3];       //部门id
                        valueBm_mc=Api.getValueName("000", valueBm);
                }

				//协助人(单层码)(非必录)
                temp=ExcelService.getCellValue(sheet, i,34,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                        sqlTemp="select a.id,a.name,a.bm_id,b.name from xt_yh a,xt_bm b  where a.bm_id=b.id and  (a.name='"+temp+"' or  a.zhanghao='"+temp+"' )";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  /协助人 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在用户帐号中未定义,请先添加该帐号！";
                            error_num++;
                            continue;
                        }  
                        if (r.length>4)  {   //如果通过姓名找出的帐号多余一个
                            errorMessage+="\r\n  /协助人 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在用户帐号有重名的记录,请通过帐号而不是姓名指定！";
                            error_num++;
                            continue;
                        }  
                        valueXzr_id=r[0];
                        valueXzr=r[1];
                        valueXzbm_id=r[2];
                        valueXzbm=r[3];
                } 

                //对该行的列都检查完了,可以预生成sql语句了
                if (importType.equals("insert"))  { // 如果是插入模式
				
                        sql+="  exec getDJH  'xtkhbh', @djh output  ";   //取一个单据号
                        sql+="  insert into kh_yxkh (id,khbh,khjc,khlx,khjb,khxq,dfnr,zxbj,lxdh,gscz,gswz,email,dq,gsdz,yb,khly,gsxz,hy,zyyw,gsgm,kynf,zczj,fddbr,xydj,khh,gszh,sh,sfzdgz,gzzt,xclxrq,jlrq,ywy_id,ywy_mc,ywbm_id,ywbm_mc,xzr,xzbm,lrr,lrrq,lrbm,bz,enabled,autokeyword) values (";
                        sql+=" @djh,";                                          // id 就用单据号
                        sql+=" @djh,";                                        // khbh 就用单据号
                        sql+="'"+valueMc+"',";                         // khjc 
                        sql+="'"+valueLx+"',";                         // khlx 
						sql+="'"+valueKhjb+"',";                         // 客户级别
                        sql+="'"+ExcelService.getCellValue(sheet, i,3,"0").trim()+"',";                         // 客户需求
                        sql+="'"+ExcelService.getCellValue(sheet, i,4,"0").trim()+"',";                         // 答复内容
                        sql+="'"+ExcelService.getCellValueForNumber(sheet, i,5,"0.00").trim()+"',";                         // 最新报价  
						sql+="'"+ExcelService.getCellValue(sheet, i,6,"0").trim()+"',";                         // 公司电话
						sql+="'"+ExcelService.getCellValue(sheet, i,11,"0").trim()+"',";                         // 公司传真
						sql+="'"+ExcelService.getCellValue(sheet, i,12,"0").trim()+"',";                         // 公司网址
						sql+="'"+ExcelService.getCellValue(sheet, i,13,"0").trim()+"',";                         // 公司邮箱
                        sql+="'"+valueDq+"',";                         // dq 地区
						sql+="'"+ExcelService.getCellValue(sheet, i,15,"0").trim()+"',";                         //地址
                        sql+="'"+ExcelService.getCellValue(sheet, i,16,"0").trim()+"',";                         // 邮编
                        sql+="'"+valueLy+"',"; 																    //客户来源
						sql+="'"+valueGsxz+"',"; 																//公司性质
						sql+="'"+valueHy+"',"; 						//行业
						sql+="'"+ExcelService.getCellValue(sheet, i,20,"0").trim()+"',"; 						//主营业务
						sql+="'"+valueGsgm+"',"; 																//公司规模
						sql+="'"+ExcelService.getCellValue(sheet, i,22,"0").trim()+"',"; 						//开业年份
						sql+="'"+ExcelService.getCellValue(sheet, i,23,"0").trim()+"',"; 						//注册资金
						sql+="'"+ExcelService.getCellValue(sheet, i,24,"0").trim()+"',"; 						//公司法人
						sql+="'"+valueXydj+"',"; 																//信用等级
						sql+="'"+ExcelService.getCellValue(sheet, i,26,"0").trim()+"',"; 						//开户银行
						sql+="'"+ExcelService.getCellValue(sheet, i,27,"0").trim()+"',"; 						//银行账号
						sql+="'"+ExcelService.getCellValue(sheet, i,28,"0").trim()+"',"; 						//税号
						sql+="'"+valueZdgz+"',"; 																//是否重点跟踪
                        sql+="'"+valueGzzt+"',"; 																//跟踪状态
                        sql+="'"+ExcelService.getCellValue(sheet, i,31,"0").trim()+"',";                         // 下次联系日期
                       
						
						
						
                        sql+="'"+ExcelService.getCellValue(sheet, i,32,"0").trim()+"',"; 						//客户建立日期
                        sql+="'"+valueXsdb+"',";                                                                //ywy_id销售代表
                        sql+="'"+valueXsdb_mc+"',";                                                             // ywy_mc 销售代表
                        sql+="'"+valueBm+"',";                                                                 // ywbm_id销售代表
                        sql+="'"+valueBm_mc+"',";                                                               // ywbm_mc销售代表
						sql+="'"+valueXzr_id+"',";                                                               // 协助人
						sql+="'"+valueXzbm_id+"',";                                                               // 协助部门

                        sql+="'"+((String[])session.getAttribute("userInfo"))[0]+"',";                        // lrr 销售代表
                        sql+="'"+Util.getDate()+"',";                                                           // lrrq
                        sql+="'"+((String[])session.getAttribute("userInfo"))[3]+"',";                         // lrbm
                        sql+="'"+ExcelService.getCellValue(sheet, i,35,"0").trim()+"',";						//备注
                        sql+="'1','' )";   
                        
                        //插联系人
                        sql+="  exec getDJH  'xtkhbh', @djh2 output  ";   //取一个单据号
                        sql+="  insert into kh_yxkh_lxr (id,khmc,kh_yxkh_id,khbh,xm,xb,yddh,msn,lrr,lrrq,lrbm,enabled) values (";
                        sql+=" @djh2,";                                          // id 就用单据号
                      	sql+="'"+valueMc+"',";                         // khjc 
                      	sql+=" @djh,"; 
                      	sql+=" @djh,"; 
                        sql+="'"+valueLxr+"',";                         // 联系人 
                        sql+="'"+valueXb+"',";                         // 性别 
                        
                        sql+="'"+ExcelService.getCellValue(sheet, i,9,"0").trim()+"',";                         // 移动电话
                        sql+="'"+ExcelService.getCellValue(sheet, i,10,"0").trim()+"',";                         // MSN
						sql+="'"+valueXsdb+"',";                                                                  
						sql+="'"+Util.getDate()+"',"; 
						sql+="'"+valueBm+"',";  
                        sql+="'1')  ";                                                                                                               // enabled
                }  else {

                		System.out.println("bbbbbbbbbbbbbbbbbmmmmmmmmmmmbbbbbbbbbbbbb");
                        sql+=" update kh_yxkh  set ";
						sql+="khjb='"+valueKhjb+"',";                         // 客户级别
                        sql+="khxq='"+ExcelService.getCellValue(sheet, i,3,"0").trim()+"',";                         // 客户需求
                        sql+="dfnr='"+ExcelService.getCellValue(sheet, i,4,"0").trim()+"',";                         // 答复内容
                        sql+="zxbj='"+ExcelService.getCellValueForNumber(sheet, i,5,"0.00").trim()+"',";                         // 最新报价  
						sql+="lxdh='"+ExcelService.getCellValue(sheet, i,6,"0").trim()+"',";                         // 公司电话
						sql+="gscz='"+ExcelService.getCellValue(sheet, i,11,"0").trim()+"',";                         // 公司传真
						sql+="gswz='"+ExcelService.getCellValue(sheet, i,12,"0").trim()+"',";                         // 公司网址
						sql+="email='"+ExcelService.getCellValue(sheet, i,13,"0").trim()+"',";                         // 公司邮箱
                        sql+="dq='"+valueDq+"',";                         // dq 地区
						sql+="gsdz='"+ExcelService.getCellValue(sheet, i,15,"0").trim()+"',";                         //地址
                        sql+="yb='"+ExcelService.getCellValue(sheet, i,16,"0").trim()+"',";                         // 邮编
                        sql+="khly='"+valueLy+"',"; 																    //客户来源
						sql+="gsxz='"+valueGsxz+"',"; 																//公司性质
						sql+="hy='"+valueHy+"',"; 						//行业
						sql+="zyyw='"+ExcelService.getCellValue(sheet, i,20,"0").trim()+"',"; 						//主营业务
						sql+="gsgm='"+valueGsgm+"',"; 																//公司规模
						sql+="kynf='"+ExcelService.getCellValue(sheet, i,22,"0").trim()+"',"; 						//开业年份
						sql+="zczj='"+ExcelService.getCellValue(sheet, i,23,"0").trim()+"',"; 						//注册资金
						sql+="fddbr='"+ExcelService.getCellValue(sheet, i,24,"0").trim()+"',"; 						//公司法人
						sql+="xydj='"+valueXydj+"',"; 																//信用等级
						sql+="khh='"+ExcelService.getCellValue(sheet, i,26,"0").trim()+"',"; 						//开户银行
						sql+="gszh='"+ExcelService.getCellValue(sheet, i,27,"0").trim()+"',"; 						//银行账号
						sql+="sh='"+ExcelService.getCellValue(sheet, i,28,"0").trim()+"',"; 						//税号
						sql+="sfzdgz='"+valueZdgz+"',"; 																//是否重点跟踪
                        sql+="gzzt='"+valueGzzt+"',"; 																//跟踪状态
                        sql+="xclxrq='"+ExcelService.getCellValue(sheet, i,31,"0").trim()+"',";                         // 下次联系日期
                        sql+="jlrq='"+ExcelService.getCellValue(sheet, i,32,"0").trim()+"',"; 						//客户建立日期
                        sql+="ywy_id='"+valueXsdb+"',";                                                                //ywy_id销售代表
                        sql+="ywy_mc='"+valueXsdb_mc+"',";                                                             // ywy_mc 销售代表
                        sql+="ywbm_id='"+valueBm+"',";                                                                 // ywbm_id销售代表
                        sql+="ywbm_mc='"+valueBm_mc+"',";                                                               // ywbm_mc销售代表
						sql+="xzr='"+valueXzr_id+"',";                                                               // 协助人
						sql+="xzbm='"+valueXzbm_id+"',";                                                               // 协助部门
						sql+="bz='"+ExcelService.getCellValue(sheet, i,35,"0").trim()+"' ";						//备注
                        sql+=" where khjc='"+valueMc+"'";   



						//联系人
						sql+="          if(select count(*) from kh_yxkh_lxr a, kh_yxkh b where a.kh_id=b.id and b.khjc='"+valueMc+"' and a.xm='"+valueLxr+"') >0  begin ";
										                        
							                      
						sql+=" update kh_yxkh_lxr set ";  
						sql+="xb='"+valueXb+"',";                         // 性别   
						sql+="yddh='"+ExcelService.getCellValue(sheet, i,9,"0").trim()+"',";                         // 移动电话
						sql+="msn='"+ExcelService.getCellValue(sheet, i,10,"0").trim()+"' ";  
						sql+=" from kh_yxkh where kh_yxkh.khjc='"+valueMc+"' and xm='"+valueLxr+"' and kh_yxkh_lxr.kh_id=kh_yxkh.id end else begin ";  
						

						

				        sql+=" exec getDJH  'xtkhbh', @djh3 output  ";   //取一个单据号
			
						sql+="  insert into kh_yxkh_lxr (id,khmc,kh_yxkh_id,khbh,xm,xb,yddh,msn,lrr,lrrq,lrbm,enabled) select ";
						sql+=" @djh3,";                                          // id 就用单据号
						sql+="'"+valueMc+"',";                         // khjc 
						sql+=" id,"; 
						sql+=" khbh,"; 
						sql+="'"+valueLxr+"',";                         // 联系人 
						sql+="'"+valueXb+"',";                         // 性别 
						sql+="'"+ExcelService.getCellValue(sheet, i,9,"0").trim()+"',";                         // 移动电话
						sql+="'"+ExcelService.getCellValue(sheet, i,10,"0").trim()+"',";                         // MSN
						sql+="'"+valueXsdb+"',";                                                                  
						sql+="'"+Util.getDate()+"',"; 
						sql+="'"+valueBm+"',";  
						sql+="'1' from kh_yxkh where kh_yxkh.khjc='"+valueMc+"'   end ";							//条件
                }

        }  //for

        //报出检查的问题
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");

		  // 4、如果是更新方式，删除数据库中多余的记录，（没有被使用的）（加个删除选项，默认不删除）  
         if (importType.equals("update") && deleteDate.equals("delete"))   {
                //从数据库中找出所有的待删除记录
                sqlTemp="select id,khjc from kh_yxkh where '"+allMcString+"' not like '%,'+khjc+ ',%'";
                r=Api.sb(sqlTemp);
                if (r!=null && r.length>0)  {   //存在需要删除的记录
                        for (int i=0;i<r.length;i+=2) {
                            if (Api.checkIftheDataIsUsed("kh_yxkh",r[i])) {   //如果被使用了，则在处理完成后报出来
                                    failDeleteMessage+="<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+r[i+1]+"</div>";
                            } else {
                                     sql+="  delete from kh_yxkh where id='"+r[i]+"'";                     //未被使用,则删除
                            }
                        }
               }  
               //找删除联系人
                sqlTemp="select id,xm from kh_yxkh_lxr where '"+allLxrString+"' not like '%,'+xm+',%'";
                r2=Api.sb(sqlTemp);
                if (r2!=null && r2.length>0)  {   //存在需要删除的记录
                        for (int i=0;i<r2.length;i+=2) {
                            if (Api.checkIftheDataIsUsed("kh_yxkh_lxr",r2[i])) {   //如果被使用了，则在处理完成后报出来
                                    failDeleteMessage+="<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+r2[i+1]+"</div>";
                            } else {
                                     sql+=" delete from kh_yxkh_lxr where id='"+r2[i]+"'";                     //未被使用,则删除
                            }
                        }
               }  

         }
	 
		Api.ub(sql);     //实际执行
		Api.XtRefreshAutoKeyWords("kh_yxkh");
		Api.XtRefreshAutoKeyWords("kh_yxkh_lxr");
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
						意向客户档案导入
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
                                     <% if (failDeleteMessage.length()>0) {%>
                                        但有如下客户由于已经被某张单据使用,不能删除:
                                        <%=failDeleteMessage%>
                                     <%}%>
                                        <div align="center" width="100%" style="padding-top:10px;width:100%;"><img src="/emadmin/images/c2/button/bill_ok.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:location.href="/emadmin/jsp/common/list.jsp?modul_id=kh_yxkh_listModul"'/> </div>
							</td>
						  </tr>
						</table>
				</form>													
							 
											
			<!-- 内容区 -->


</body>
</html>

