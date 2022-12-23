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
     
    //if (!wb.getSheetName(sheet).eqauls("客户档案"))
        //throw new LFException("工作表的名称不是[客户档案]!");
    
    //3）标题列对不对

    String title="";
    String [] sheetTitle=new String [25];
    sheetTitle[0]="公司名称*";
    sheetTitle[1]="公司电话*";
	sheetTitle[2]="联系人*";
	sheetTitle[3]="性别";
	sheetTitle[4]="移动电话";
	sheetTitle[5]="MSN/(QQ)";

	sheetTitle[6]="公司传真";
	sheetTitle[7]="公司网址";
    sheetTitle[8]="公司邮箱";
    sheetTitle[9]="地区";
    sheetTitle[10]="地址";
    sheetTitle[11]="邮编";
    sheetTitle[12]="客户来源"; //下拉
    sheetTitle[13]="公司性质";
    sheetTitle[14]="行业";
    sheetTitle[15]="主营业务";
    sheetTitle[16]="公司规模";
    sheetTitle[17]="开业年份";
    sheetTitle[18]="注册资金";
	sheetTitle[19]="公司法人";
    sheetTitle[20]="开户银行";
    sheetTitle[21]="银行账号";
    sheetTitle[22]="税号";
    sheetTitle[23]="客户建立日期";
    sheetTitle[24]="备注";
    
   
    for (int i=0;i<sheetTitle.length;i++) {
        title=ExcelService.getCellValue(sheet, 0, i,"0").trim();    //row,col
        if (title==null || !title.equals(sheetTitle[i].trim()) ) 
            throw new LFException("工作表的第 "+String.valueOf(i+1)+" 列应为：["+sheetTitle[i].trim()+"]!");
    }
   
 

		///2、检查Excel文件数据自身的合法性        
         //1）名称、类型有没有没录的 
         String errorMessage="";   //错误信息
         int  error_num=0;  //错误数
         String gsmc="";        //公司名称
         String gsdh="";          //公司电话
		 String lxr="";			//联系人
		 String yddh="";		//移动电话
		 String email="";		//公司邮箱
		 SLfHashMap  allGsmc= new SLfHashMap ();	//所有的公司名称	
		 SLfHashMap  allLxr= new SLfHashMap ();	//所有的联系人
		 SLfHashMap  allyddh=new SLfHashMap ();//所移动电话
		 SLfHashMap  allemail=new SLfHashMap ();//所公司邮箱
         int realTotalRows=0;   //实际的行数
         int totalRows = sheet.getLastRowNum()+2;   //Excel返回总行数
       
         for (int i=1;i<totalRows;i++)  {    //开始扫描  从地2行开始
                gsmc=ExcelService.getCellValue(sheet, i,0,"0").trim();  
                gsdh=ExcelService.getCellValue(sheet, i,1,"0").trim();  
				lxr=ExcelService.getCellValue(sheet, i,2,"0").trim(); 
				yddh=ExcelService.getCellValue(sheet, i,4,"0").trim();
				email=ExcelService.getCellValue(sheet, i,8,"0").trim();

                if (gsmc.length()==0&&gsdh.length()== 0&&lxr.length()==0) { //公司名称,公司电话都为空，同时后边没有了，就到底了
                        boolean find=false;
                        for (int j=i+1;j<totalRows;j++) {
                            if (ExcelService.getCellValue(sheet, j,0,"0").trim().length()>0||ExcelService.getCellValue(sheet, j,1,"0").trim().length()>0) {
                                find=true;
                                break;   //不用继续找了
                            }
                        }
                        if (!find) {    //到底了
                            realTotalRows=i-1;
                            break;
                        }
                }
                if (gsmc.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [公司名称] 不能为空！";
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
				
				 //判断日期格式---开业年份
                 String tmptmp=ExcelService.getCellValue(sheet, i,17,"0").trim();  
                 if (!Util.checkDateFormat(tmptmp) ){
                 		errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 开业年份 日期格式不正确";
                    error_num++;
                    continue;
                 
                 }

                 //判断日期格式---建立日期
                 tmptmp=ExcelService.getCellValue(sheet, i,23,"0").trim();  
                 if (!Util.checkDateFormat(tmptmp) ){
                 		errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 客户建立日期 格式不正确";
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
                if (allGsmc.containsKey(gsmc+lxr))  {
                        errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [客户名称]为["+gsmc+"],[联系人]为["+lxr+"] 与 第[ "+allGsmc.get(gsmc+lxr)+" ]行重复！ ";
                        error_num++;
                } else {
                        if (!Util.isBlankString(gsmc)) allGsmc.put(gsmc+lxr,String.valueOf(i+1));
                        realTotalRows++;
                }

				//3)移动电话是否重复
				  if (allyddh.containsKey(yddh))  {
                        errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [移动电话] 与 第[ "+allyddh.get(yddh)+" ]行重复！ ";
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
        String allGsmcString="";  // 取得所有的名称，用于删除的时候和数据库比较

        String failDeleteMessage=""; //不能成功删除的记录
        String sqlTemp="";
        String temp="";
        String sql="  declare @djh varchar(200)  declare @djh2 varchar(200) declare @djh3 varchar(255)   ";
	    sql+="  declare @drpc varchar(200)   set @drpc=replace(replace(replace(convert(varchar,getdate(),120),'-',''),':',''),' ','') ";
		//replace(replace(replace(convert(varchar,getdate(),120),'-',''),':',''),' ','')
        String r[]=null;
        String valueGsmc="";
		String valueLxr="";
		String valueYddh="";
		String valueXb="";
        boolean  is_update=false;  //对于修改方式,标志是否是执行update,如果为否,则执行insert
        boolean  is_update_lxr=false;  //对于修改方式,标志是否是执行update,如果为否,则执行insert

        String valueLx="";
        String valueDq="";
        
        String sqlTemp2="";
        String temp2="";
        String r2[]=null;

        String sqlTemp3="";
        String temp3="";
		String r3[]=null;

		String valueKhly="";// 客户来源
		String valueGsxz="";//公司性质
		String valueHy="";//行业
		String valueGsgm="";//公司规格
		String drpc="";//导入批次
		String valueXzr_id="";
		String valueXzr="";//协助人
		String valueXzbm="";
		String valueXzbm_id="";
        
        for (int i=1;i<=realTotalRows;i++)  {    //开始扫描   从第2行开始
                //公司名称
                temp=ExcelService.getCellValue(sheet, i,0,"0").trim();  
                allGsmcString+=","+temp+",";
                sqlTemp="select count(*) from kh_khc where gsmc='"+temp+"'";
                r=Api.sb(sqlTemp);
                if (importType.equals("insert")) {     //如果是插入方式, 数据库里有该名称,则报错
                        if (r==null || r.length==0 || !r[0].equals("0"))  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [公司名称] 中的 ["+temp+"] 与数据库中的数据重复！";
                            error_num++;
                            continue;
                        }
                       is_update=false;
                       valueGsmc=temp;
                } else {  //如果是更新方式, 数据库里有该名称,则说明需要做update
                       if (r==null || r.length==0 || !r[0].equals("0"))  {
                            is_update=true;
                       } else {
                            is_update=false;
                       }
                        valueGsmc=temp;
                }
               
			    //联系人
                temp2=ExcelService.getCellValue(sheet, i,2,"0").trim();  
                sqlTemp2="select count(*) from kh_khc_lxr where xm='"+temp2+"' and gsmc='"+ExcelService.getCellValue(sheet, i,0,"0").trim()+"'";
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

				//性别（单层码检查）
				temp=ExcelService.getCellValue(sheet, i,3,"0").trim();  
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

                //移动电话是否与数据库中重复
				temp3=ExcelService.getCellValue(sheet, i,4,"0");  
				sqlTemp3="select count(*)  from kh_khc_lxr where yddh='"+temp3+"'" ;
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
                

				//客户来源
				temp=ExcelService.getCellValue(sheet, i,12,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                        sqlTemp="select dm from dm_khly where mc='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  客户来源 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在系统中未定义！";
                            error_num++;
                            continue;
                        }else{
                        	valueKhly=r[0];
                        	
                        }  
                } 
                //地区    (层次码)(非必录)
                temp=ExcelService.getCellValue(sheet, i,9,"0").trim();  
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
				
				
				//公司性质
				temp=ExcelService.getCellValue(sheet, i,13,"0").trim();  
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
                temp=ExcelService.getCellValue(sheet, i,14,"0").trim();  
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
                temp=ExcelService.getCellValue(sheet, i,16,"0").trim();  
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

				
                if (importType.equals("insert") )  { // 如果是插入模式
                        sql+="  exec getDJH  'xtkhbh', @djh output  ";   //取一个单据号
                        sql+="  insert into kh_khc (id,gsbh,gsmc,gsdh,gscz,gswz,gsyx,dq,dz,yb,khly,gsxz,hy,zyyw,gsgm,kynf,zczj,fddbr,khyh,yhzh,sh,khjlrq,bz,zt,drpc,lrr,lrrq,lrbm,enabled,autokeyword) values( ";
                        sql+=" @djh,";                                          // id 就用单据号
                        sql+=" @djh,";                                        // khbh 就用单据号
                        sql+="'"+valueGsmc+"',";                         // 公司名称 
                        sql+="'"+ExcelService.getCellValue(sheet, i,1,"0").trim()+"',";                         // 公司电话 
                        sql+="'"+ExcelService.getCellValue(sheet, i,6,"0").trim()+"',";                         // 公司传真 
                        sql+="'"+ExcelService.getCellValue(sheet, i,7,"0").trim()+"',";                         // 公司网址
                        sql+="'"+ExcelService.getCellValue(sheet, i,8,"0").trim()+"',";                         // 公司邮箱
                        sql+="'"+valueDq+"',";                         // 地区
                        
                        sql+="'"+ExcelService.getCellValue(sheet, i,10,"0").trim()+"',";                         // 地址
                        sql+="'"+ExcelService.getCellValue(sheet, i,11,"0").trim()+"',";                         // 邮编
                        sql+="'"+valueKhly+"',";                         //客户来源
						sql+="'"+valueGsxz+"',";						//公司性质

                        sql+="'"+valueHy+"',";                         // 行业
                        sql+="'"+ExcelService.getCellValue(sheet, i,15,"0").trim()+"',";                         //主营业务
                        sql+="'"+valueGsgm+"',";                         //公司规模
                        sql+="'"+ExcelService.getCellValue(sheet, i,17,"0").trim()+"',";                         // 开业年份
						sql+="'"+ExcelService.getCellValue(sheet, i,18,"0").trim()+"',";                         // 注册资金
                        sql+="'"+ExcelService.getCellValue(sheet, i,19,"0").trim()+"',"; 						//公司法人
                        sql+="'"+ExcelService.getCellValue(sheet, i,20,"0").trim()+"',"; 						//开户银行
                        sql+="'"+ExcelService.getCellValue(sheet, i,21,"0").trim()+"',"; 						//银行账号
                        sql+="'"+ExcelService.getCellValue(sheet, i,22,"0").trim()+"',";                         //税号
                        sql+="'"+ExcelService.getCellValue(sheet, i,23,"0").trim()+"',";                         //建立日期
					

						sql+="'"+ExcelService.getCellValue(sheet, i,24,"0").trim()+"',";							//备注
						sql+="'001',";                          //状态
						sql+=" @drpc ,";                          //导入批次默认为年月日时分秒
                        sql+="'"+((String[])session.getAttribute("userInfo"))[0].trim()+"',";                        // lrr 销售代表
                        sql+="'"+Util.getDate()+"',";                                                               // lrrq
                        sql+="'"+((String[])session.getAttribute("userInfo"))[3].trim()+"',";                         // lrbm
                        sql+="'1','')";   // enabled


						//插联系人
                        sql+="  exec getDJH  'xtkhbh', @djh2 output  ";   //取一个单据号
                        sql+="  insert into kh_khc_lxr (id,gsmc,kh_khc_id,gsbh,xm,xb,yddh,msn,enabled) values (";
                        sql+=" @djh2,";                                          // id 就用单据号
                      	sql+="'"+valueGsmc+"',";                         // khjc 
                      	sql+=" @djh,"; 
                      	sql+=" @djh,"; 
                        sql+="'"+valueLxr+"',";                         // 联系人 
                        sql+="'"+valueXb+"',";                         // 性别 
                        sql+="'"+ExcelService.getCellValue(sheet, i,4,"0").trim()+"',";                         // 移动电话
                        sql+="'"+ExcelService.getCellValue(sheet, i,5,"0").trim()+"',";                         // MSN
                        sql+="'1')  ";                                                                                                              // enabled
                } 

        }  //for

        //报出检查的问题
        
        
        	
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");

		/* 4、如果是更新方式，删除数据库中多余的记录，（没有被使用的）（加个删除选项，默认不删除）  
         if (importType.equals("update") && deleteDate.equals("delete"))   {
                //从数据库中找出所有的待删除记录
                sqlTemp="select id,gsmc from kh_khc where '"+allGsmcString+"' not like '%,'+gsmc+',%'";
                r=Api.sb(sqlTemp);
                if (r!=null && r.length>0)  {   //存在需要删除的记录
                        for (int i=0;i<r.length;i+=2) {
                            if (Api.checkIftheDataIsUsed("kh_khc",r[i])) {   //如果被使用了，则在处理完成后报出来
                                    failDeleteMessage+="<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+r[i+1]+"</div>";
                            } else {
                                     sql+=" delete from kh_khc where id='"+r[i]+"'";                     //未被使用,则删除
                            }
                        }
               }  
         }*/

		Api.ub(sql);     //实际执行
		Api.XtRefreshAutoKeyWords("kh_khc");
		Api.XtRefreshAutoKeyWords("kh_khc_lxr");
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
						客户池档案导入
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
                                        <div align="center" width="100%" style="padding-top:10px;width:100%;"><img src="/emadmin/images/c2/button/bill_ok.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:location.href="/emadmin/jsp/common/list.jsp?modul_id=kh_khc_listModul"'/> </div>
							</td>
						  </tr>
						</table>
				</form>													
						
											
			<!-- 内容区 -->

</body>
</html>

