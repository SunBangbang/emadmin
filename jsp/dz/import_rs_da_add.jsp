<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.io.*,com.lf.util.*,java.text.SimpleDateFormat,com.lf.lfbase.service.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,javax.servlet.http.HttpServletRequest,java.net.*,java.text.*"%>
<%

        /*
        1、首先检查上传的Excel文件的合法性
            1）是不是Excel文件
            2）工作表的数量是不是1个，工作表的名称对不对“员工档案”
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


    
    //2）工作表的数量是不是1个，工作表的名称对不对“员工档案”
    if (wb.getNumberOfSheets()!= 1)
        throw new LFException("模板的工作表数量应该是1个,请检查是否使用了正确的模板!");
	
    HSSFSheet sheet = wb.getSheetAt(0); 
     
    //if (!wb.getSheetName(sheet).eqauls("员工档案"))
        //throw new LFException("工作表的名称不是[员工档案]!");
    
    //3）标题列对不对

    String title="";
    String [] sheetTitle=new String [40];
    sheetTitle[0]="员工编号*";
    sheetTitle[1]="姓名*";
    sheetTitle[2]="性别*";
    sheetTitle[3]="出生日期*";
    sheetTitle[4]="婚否";
    sheetTitle[5]="民族";
    sheetTitle[6]="政治面貌";
    sheetTitle[7]="籍贯";
    sheetTitle[8]="部门*";
    sheetTitle[9]="职务";
    sheetTitle[10]="来源时间";
    sheetTitle[11]="入职日期";
    sheetTitle[12]="员工来源";
    sheetTitle[13]="离职时间";
    sheetTitle[14]="员工状态";
    sheetTitle[15]="状态时间";
    sheetTitle[16]="专业";
    sheetTitle[17]="毕业院校";
    sheetTitle[18]="毕业时间";
    sheetTitle[19]="学历*";
    sheetTitle[20]="身份证号*";
    sheetTitle[21]="户口类型";
    sheetTitle[22]="养老保险序号";
    sheetTitle[23]="养老保险起始日";
    sheetTitle[24]="失业保险起始日";
    sheetTitle[25]="劳动合同起始日";
    sheetTitle[26]="劳动合同到期日";
    sheetTitle[27]="常住地址";
	sheetTitle[28]="常住地电话";
    sheetTitle[29]="移动电话";
    sheetTitle[30]="现住址";
    sheetTitle[31]="家庭电话";
    sheetTitle[32]="办公电话";
    sheetTitle[33]="电子邮件";
    sheetTitle[34]="QQ(MSN)";
    sheetTitle[35]="工作经历";
    sheetTitle[36]="教育培训";
	sheetTitle[37]="奖惩情况";
    sheetTitle[38]="家庭成员";
    sheetTitle[39]="备注";
    
    for (int i=0;i<sheetTitle.length;i++) {
        title=ExcelService.getCellValue(sheet, 0, i,"0");    //row,col
        if (title==null || !title.equals(sheetTitle[i].trim()) ) 
            throw new LFException("工作表的第 "+String.valueOf(i+1)+" 列应为：["+sheetTitle[i].trim()+"]!");
   }
   
 

///2、检查Excel文件数据自身的合法性        
         //1）名称、类型有没有没录的 
         String errorMessage="";   //错误信息
         int  error_num=0;  //错误数
         String ygbh="";        //员工编号
         String xm="";          //姓名
         String xb="";          //性别
		 String csrq="";          //出生日期
		 String bm="";          //部门
		 String xl="";          //学历
		 String sfzh="";          //身份证号
		 String yddh="";          //移动电话
		 HashMap  allMc= new HashMap ();	//所有员工编号	
		 HashMap  allSfzh= new HashMap ();	//身份证号
		 HashMap  allYddh= new HashMap ();	//移动电话
		 
         int realTotalRows=0;   //实际的行数
         int totalRows = sheet.getLastRowNum()+2;   //Excel返回总行数
       
         for (int i=1;i<totalRows;i++)  {    //开始扫描  从地2行开始
                ygbh=ExcelService.getCellValue(sheet, i,0,"0").trim();  
                xm=ExcelService.getCellValue(sheet, i,1,"0").trim(); 
				xb=ExcelService.getCellValue(sheet, i,2,"0").trim(); 
				csrq=ExcelService.getCellValue(sheet, i,3,"0").trim(); 
				bm=ExcelService.getCellValue(sheet, i,8,"0").trim(); 
				xl=ExcelService.getCellValue(sheet, i,19,"0").trim(); 
				sfzh=ExcelService.getCellValue(sheet, i,20,"0").trim(); 
                yddh=ExcelService.getCellValue(sheet, i,29,"0").trim(); 
                if (ygbh.length()==0 && xm.length()==0) { //员工编号和姓名都为空，同时后边没有了，就到底了
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
                if (ygbh.length()==0 && xm.length()>0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [员工编号] 不能为空！";
                    error_num++;
                    continue;
                }
                if (ygbh.length()>0 && xm.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [姓名] 不能为空！";
                    error_num++;
                    continue;
                }
                 if (xb.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [性别] 不能为空！";
                    error_num++;
                    continue;
                }
				if (csrq.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [出生日期] 不能为空！";
                    error_num++;
                    continue;
                }
				if (bm.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [部门] 不能为空！";
                    error_num++;
                    continue;
                }
				if (xl.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [学历] 不能为空！";
                    error_num++;
                    continue;
                }
				if (sfzh.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [身份证号] 不能为空！";
                    error_num++;
                    continue;
                }
                 //判断日期格式
                 String tmptmp=ExcelService.getCellValue(sheet, i,3,"0").trim();  
                 if (!Util.checkDateFormat(tmptmp) ){
                 		errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 日期格式不正确";
                    error_num++;
                    continue;
                 
                 }
				  tmptmp=ExcelService.getCellValue(sheet, i,10,"0").trim();  
                 if (!Util.checkDateFormat(tmptmp) ){
                 		errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 日期格式不正确";
                    error_num++;
                    continue;
                 
                 }
				  tmptmp=ExcelService.getCellValue(sheet, i,11,"0").trim();  
                 if (!Util.checkDateFormat(tmptmp) ){
                 		errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 日期格式不正确";
                    error_num++;
                    continue;
                 
                 }
				   tmptmp=ExcelService.getCellValue(sheet, i,13,"0").trim();  
                 if (!Util.checkDateFormat(tmptmp) ){
                 		errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 日期格式不正确";
                    error_num++;
                    continue;
                 
                 }
				    tmptmp=ExcelService.getCellValue(sheet, i,18,"0").trim();  
                 if (!Util.checkDateFormat(tmptmp) ){
                 		errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 日期格式不正确";
                    error_num++;
                    continue;
                 
                 }
				     tmptmp=ExcelService.getCellValue(sheet, i,23,"0").trim();  
                 if (!Util.checkDateFormat(tmptmp) ){
                 		errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 日期格式不正确";
                    error_num++;
                    continue;
                 
                 }
				     tmptmp=ExcelService.getCellValue(sheet, i,24,"0").trim();  
                 if (!Util.checkDateFormat(tmptmp) ){
                 		errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 日期格式不正确";
                    error_num++;
                    continue;
                 
                 }
				     tmptmp=ExcelService.getCellValue(sheet, i,25,"0").trim();  
                 if (!Util.checkDateFormat(tmptmp) ){
                 		errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 日期格式不正确";
                    error_num++;
                    continue;
                 
                 }
				     tmptmp=ExcelService.getCellValue(sheet, i,26,"0").trim();  
                 if (!Util.checkDateFormat(tmptmp) ){
                 		errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 日期格式不正确";
                    error_num++;
                    continue;
                 
                 }
                 //2）员工编号有没有重复
                if (allMc.containsKey(ygbh))  {
                        errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [员工编号] 与 第[ "+allMc.get(ygbh)+" ]行重复！ ";
                        error_num++;
                } else {
                        if (!Util.isBlankString(ygbh)) allMc.put(ygbh,String.valueOf(i+1));
                        realTotalRows++;
                      
                }
				//身份证号
				 if (allSfzh.containsKey(sfzh))  {
                        errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [身份证号] 与 第[ "+allSfzh.get(ygbh)+" ]行重复！ ";
                        error_num++;
                } else{
				
				  if (!Util.isBlankString(sfzh)) allSfzh.put(sfzh,String.valueOf(i+1));
				}
                //3)联系电话有没有重复
                 if (allYddh.containsKey(yddh))  {
                        errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [移动电话] 与 第[ "+allYddh.get(yddh)+" ]行重复！ ";
                        error_num++;
                } else {
                        if (!Util.isBlankString(yddh)) allYddh.put(yddh,String.valueOf(i+1));
                       
                }
         } //for

         //先报出自身检查的问题
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<br/><div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");


//3、Excel文件数据与数据库中的已有数据的关联性检查   
        
        errorMessage="";
        error_num=0;
        String allYgbhString="";  // 取得所有的名称，用于删除的时候和数据库比较
		String allSfzhString="";  // 取得所有的身份证号，用于删除的时候和数据库比较
		String allYddhString="";  // 取得所有的移动电话，用于删除的时候和数据库比较
        String failDeleteMessage=""; //不能成功删除的记录
        String sqlTemp="";
        String temp="";
        String sql="  declare @djh varchar(200)   ";
        String r[]=null;
        String valueYgbh="";
        boolean  is_update=false;  //对于修改方式,标志是否是执行update,如果为否,则执行insert
       
       
       
      
      
        
         String sqlTemp2="";
        String temp2="";
      //  String sql="  declare @djh2 varchar(200) declare @djh3 varchar(255) ";
        String r2[]=null;
      
        
        String valueXb="";//性别
		String valueHf="";//婚否
		String valueMz="";//民族
		String valueZzmm="";//政治面貌
		String valueJg="";//籍贯
		String valueBm="";//部门
		String valueBm_mc="";
		String valueYgzt="";//员工状态
		String valueXl="";//学历
		String valueHklx="";//户口类型
		String valueYgzz="";//户口类型
					     
        
        
        for (int i=1;i<=realTotalRows;i++)  {    //开始扫描   从第2行开始
                //名称
                temp=ExcelService.getCellValue(sheet, i,0,"0").trim();  
              
                allYgbhString+=","+temp+",";
                sqlTemp="select count(*) from rs_da where a01='"+temp+"'";
                r=Api.sb(sqlTemp);
                if (importType.equals("insert")) {     //如果是插入方式, 数据库里有该名称,则报错
                        if (r==null || r.length==0 || !r[0].equals("0"))  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [员工编号] 中的 ["+temp+"] 与数据库中的数据重复！";
                            error_num++;
                            continue;
                        }
                       is_update=false;
                       valueYgbh=temp;
                } else {  //如果是更新方式, 数据库里有该名称,则说明需要做update
                       if (r==null || r.length==0 || !r[0].equals("0"))  {
                            is_update=true;
                       } else {
                            is_update=false;
                       }
                        valueYgbh=temp;
                }
                //身份证号
                temp2=ExcelService.getCellValue(sheet, i,20,"0").trim();  
                allSfzhString+=","+temp2+",";
                sqlTemp2="select count(*) from rs_da where a20='"+temp2+"' ";
                r2=Api.sb(sqlTemp2);
                if (importType.equals("insert")) {     //如果是插入方式, 数据库里有该名称,则报错
                        if (r2==null || r2.length==0 || !r2[0].equals("0"))  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [身份证号] 中的 ["+temp2+"] 与数据库中的数据重复！";
                            error_num++;
                            continue;
                        }
                  
                       
                } 
                
                
                //类型(单层代码)(必录)
                temp=ExcelService.getCellValue(sheet, i,2,"0").trim();    
                sqlTemp="select code_value from xt_option_code where group_name like '%性别%' and code_title='"+temp+"'";
                r=Api.sb(sqlTemp);
                System.out.println("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
                if (r==null || r.length==0)  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [性别] 中的 ["+temp+"]  不规范！";
                    error_num++;
                    continue;
                } 
                valueXb=r[0];
					//婚否（单层码检查）
				temp=ExcelService.getCellValue(sheet, i,4,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        
                        sqlTemp="select code_value from xt_inneroption_code where group_name like '%是否' and  code_title='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  婚否 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 不规范！";
                            error_num++;
                            continue;
                        }else{
                        	valueHf=r[0];
                        	
                        }  
                         
                       
                } 


                //部门    (层次码)(必录)
                temp=ExcelService.getCellValue(sheet, i,8,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码,层次码同时查找出是否是末级节点
                        sqlTemp="select a.id,(select count(*) from xt_bm b where b.id<>a.id and b.id like a.id+'%') from xt_bm a  where a.name='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [部门] 中的 ["+temp+"] 在部门设置中未定义,请先添加该部门！";
                            error_num++;
                            continue;
                        }  
                        if (!r[1].equals("0"))  {   //不是末级节点
                            errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [部门] 中的 ["+temp+"] 不是最末级部门,请更该为末级部门！";
                            error_num++;
                            continue;
                        }  
                        valueBm=r[0];
                } 
                
							
				//民族
				temp=ExcelService.getCellValue(sheet, i,5,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        
                        sqlTemp="select  code_value from xt_option_code where group_name like '%民族%' and code_title='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  民族 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在系统中未定义！";
                            error_num++;
                            continue;
                        }else{
                        	valueMz=r[0];
                        	
                        }  
                         
                       
                } 
				//政治面貌
				temp=ExcelService.getCellValue(sheet, i,6,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                       
                        sqlTemp="select  code_value from xt_option_code where group_name like '%政治面貌%' and code_title='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  政治面貌 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在系统中未定义！";
                            error_num++;
                            continue;
                        }else{
                        	valueZzmm=r[0];
                        	
                        }  
                         
                       
                } 
								
				//籍贯
				temp=ExcelService.getCellValue(sheet, i,7,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                       
                        sqlTemp="select dm from dm_jg where mc='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  籍贯 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在系统中未定义！";
                            error_num++;
                            continue;
                        }else{
                        	valueJg=r[0];
                        	
                        }  
                         
                       
                } 
               //员工状态
				temp=ExcelService.getCellValue(sheet, i,14,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                       
                        sqlTemp="select  code_value from xt_option_code where group_name like '%员工状态%' and code_title='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  员工状态 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在系统中未定义！";
                            error_num++;
                            continue;
                        }else{
                        	valueYgzz=r[0];
                        	
                        }  
                         
                       
                } 
                //学历
				temp=ExcelService.getCellValue(sheet, i,19,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                       
                        sqlTemp="select  code_value from xt_option_code where group_name like '%学历%' and code_title='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  学历 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在系统中未定义！";
                            error_num++;
                            continue;
                        }else{
                        	valueXl=r[0];
                        	
                        }  
                         
                       
                } 
               //户口类型
				temp=ExcelService.getCellValue(sheet, i,21,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                       
                        sqlTemp="select dm from dm_hklx where mc='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  户口类型 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在系统中未定义！";
                            error_num++;
                            continue;
                        }else{
                        	valueHklx=r[0];
                        	
                        }  
                         
                       
                } 
                //对该行的列都检查完了,可以预生成sql语句了

                if (!is_update )  { // 如果是插入模式

                        sql+="  exec getDJH  'xtkhbh', @djh output  ";   //取一个单据号
                        sql+=" insert into rs_da(id,a01,a02,a03,a04,hf,a05,a06,a07,a08,a09,a13,a11,a12,a10,a14,a15,a16,a17,a18,a19,a20,hklb,ylbxxh,ylbxqsr,sybxqsr,ldhtqsr,ldhtdqr,a21,a22,a23,a24,a25,a26,a27,qq,a28,a29,a30,a31,a32,enabled)values(";
                        sql+=" @djh,";                                          // id 就用单据号
                        sql+="'"+ExcelService.getCellValue(sheet, i,0,"0").trim()+"',";   //员工编号
                        sql+="'"+ExcelService.getCellValue(sheet, i,1,"0").trim()+"',";   //姓名
                        sql+="'"+valueXb+"',";                         // 性别
                        
                        sql+="'"+ExcelService.getCellValue(sheet, i,3,"0").trim()+"',"; //出生日期
                        sql+="'"+valueHf+"',";                         //婚否
                        sql+="'"+valueMz+"',";                         //民族
                        
                        sql+="'"+valueZzmm+"',";                         // 政治面貌
                        sql+="'"+valueJg+"',";                         // 籍贯
                        sql+="'"+valueBm+"',";                         // 部门
                        sql+="'"+ExcelService.getCellValue(sheet, i,9,"0").trim()+"',"; // 职务
                        sql+="'"+ExcelService.getCellValue(sheet, i,10,"0").trim()+"',"; //来源时间
                        sql+="'"+ExcelService.getCellValue(sheet, i,11,"0").trim()+"',";  //入职日期
                        sql+="'"+ExcelService.getCellValue(sheet, i,12,"0").trim()+"',";// 员工来源
                        sql+="'"+ExcelService.getCellValue(sheet, i,13,"0").trim()+"',";// 离职时间																										
                        sql+="'"+valueYgzz+"',"; //员工状态
                        sql+="'"+ExcelService.getCellValue(sheet, i,15,"0").trim()+"',";// 状态时间																	
                        sql+="'"+ExcelService.getCellValue(sheet, i,16,"0").trim()+"',";// 专业
                        sql+="'"+ExcelService.getCellValue(sheet, i,17,"0").trim()+"',";   // 毕业院校
                        sql+="'"+ExcelService.getCellValue(sheet, i,18,"0").trim()+"',";   // 毕业时间   
						sql+="'"+valueXl+"',"; //学历
						sql+="'"+ExcelService.getCellValue(sheet, i,20,"0").trim()+"',";   // 身份证号 
						sql+="'"+valueHklx+"',"; //户口类型
						sql+="'"+ExcelService.getCellValue(sheet, i,22,"0").trim()+"',";   // 养老保险序号
						sql+="'"+ExcelService.getCellValue(sheet, i,23,"0").trim()+"',";   // 养老保险起始日
						sql+="'"+ExcelService.getCellValue(sheet, i,24,"0").trim()+"',";   // 失业保险起始日
						sql+="'"+ExcelService.getCellValue(sheet, i,25,"0").trim()+"',";   // 劳动合同起始日
						sql+="'"+ExcelService.getCellValue(sheet, i,26,"0").trim()+"',";   // 劳动合同到期日
						sql+="'"+ExcelService.getCellValue(sheet, i,27,"0").trim()+"',";   // 常住地址
						sql+="'"+ExcelService.getCellValue(sheet, i,28,"0").trim()+"',";   // 常住地电话
						sql+="'"+ExcelService.getCellValue(sheet, i,29,"0").trim()+"',";   // 移动电话
						sql+="'"+ExcelService.getCellValue(sheet, i,30,"0").trim()+"',";   // 现住址
						sql+="'"+ExcelService.getCellValue(sheet, i,31,"0").trim()+"',";   // 家庭电话
						sql+="'"+ExcelService.getCellValue(sheet, i,32,"0").trim()+"',";   // 办公电话
						sql+="'"+ExcelService.getCellValue(sheet, i,33,"0").trim()+"',";   // 电子邮件
						sql+="'"+ExcelService.getCellValue(sheet, i,34,"0").trim()+"',";   // QQ(MSN)
						sql+="'"+ExcelService.getCellValue(sheet, i,35,"0").trim()+"',";   // 工作经历
						sql+="'"+ExcelService.getCellValue(sheet, i,36,"0").trim()+"',";   // 教育培训
						sql+="'"+ExcelService.getCellValue(sheet, i,37,"0").trim()+"',";   // 奖惩情况
						sql+="'"+ExcelService.getCellValue(sheet, i,38,"0").trim()+"',";   // 家庭成员
						sql+="'"+ExcelService.getCellValue(sheet, i,39,"0").trim()+"',";   // 备注
						
                        sql+="'1')";   
                        
                     
                } else {
                	
                        sql+=" update rs_da  set ";
                        sql+="a02='"+ExcelService.getCellValue(sheet, i,1,"0").trim()+"',";   //姓名
                        sql+="a03='"+valueXb+"',";                         // 性别
                        
                        sql+="a04='"+ExcelService.getCellValue(sheet, i,3,"0").trim()+"',"; //出生日期
                        sql+="hf='"+valueHf+"',";                         //婚否
                        sql+="a05='"+valueMz+"',";                         //民族
                        
                        sql+="a06='"+valueZzmm+"',";                         // 政治面貌
                        sql+="a07='"+valueJg+"',";                         // 籍贯
                        sql+="a08='"+valueBm+"',";                         // 部门
                        sql+="a09='"+ExcelService.getCellValue(sheet, i,9,"0").trim()+"',"; // 职务
                        sql+="a13='"+ExcelService.getCellValue(sheet, i,10,"0").trim()+"',"; //来源时间
                        sql+="a11='"+ExcelService.getCellValue(sheet, i,11,"0").trim()+"',";  //入职日期
                        sql+="a12='"+ExcelService.getCellValue(sheet, i,12,"0").trim()+"',";// 员工来源
                        sql+="a10='"+ExcelService.getCellValue(sheet, i,13,"0").trim()+"',";// 离职时间																										
                        sql+="a14='"+valueYgzz+"',"; //员工状态
                        sql+="a15='"+ExcelService.getCellValue(sheet, i,15,"0").trim()+"',";// 状态时间																	
                        sql+="a16='"+ExcelService.getCellValue(sheet, i,16,"0").trim()+"',";// 专业
                        sql+="a17='"+ExcelService.getCellValue(sheet, i,17,"0").trim()+"',";   // 毕业院校
                        sql+="a18='"+ExcelService.getCellValue(sheet, i,18,"0").trim()+"',";   // 毕业时间   
						sql+="a19='"+valueXl+"',"; //学历
						sql+="a20='"+ExcelService.getCellValue(sheet, i,20,"0").trim()+"',";   // 身份证号 
						sql+="hklb='"+valueHklx+"',"; //户口类型
						sql+="ylbxxh='"+ExcelService.getCellValue(sheet, i,22,"0").trim()+"',";   // 养老保险序号
						sql+="ylbxqsr='"+ExcelService.getCellValue(sheet, i,23,"0").trim()+"',";   // 养老保险起始日
						sql+="sybxqsr='"+ExcelService.getCellValue(sheet, i,24,"0").trim()+"',";   // 失业保险起始日
						sql+="ldhtqsr='"+ExcelService.getCellValue(sheet, i,25,"0").trim()+"',";   // 劳动合同起始日
						sql+="ldhtdqr='"+ExcelService.getCellValue(sheet, i,26,"0").trim()+"',";   // 劳动合同到期日
						sql+="a21='"+ExcelService.getCellValue(sheet, i,27,"0").trim()+"',";   // 常住地址
						sql+="a22='"+ExcelService.getCellValue(sheet, i,28,"0").trim()+"',";   // 常住地电话
						sql+="a23='"+ExcelService.getCellValue(sheet, i,29,"0").trim()+"',";   // 移动电话
						sql+="a24='"+ExcelService.getCellValue(sheet, i,30,"0").trim()+"',";   // 现住址
						sql+="a25='"+ExcelService.getCellValue(sheet, i,31,"0").trim()+"',";   // 家庭电话
						sql+="a26='"+ExcelService.getCellValue(sheet, i,32,"0").trim()+"',";   // 办公电话
						sql+="a27='"+ExcelService.getCellValue(sheet, i,33,"0").trim()+"',";   // 电子邮件
						sql+="qq='"+ExcelService.getCellValue(sheet, i,34,"0").trim()+"',";   // QQ(MSN)
						sql+="a28='"+ExcelService.getCellValue(sheet, i,35,"0").trim()+"',";   // 工作经历
						sql+="a29='"+ExcelService.getCellValue(sheet, i,36,"0").trim()+"',";   // 教育培训
						sql+="a30='"+ExcelService.getCellValue(sheet, i,37,"0").trim()+"',";   // 奖惩情况
						sql+="a31='"+ExcelService.getCellValue(sheet, i,38,"0").trim()+"',";   // 家庭成员
						sql+="a32='"+ExcelService.getCellValue(sheet, i,39,"0").trim()+"'";   // 备注																											
                        
                        sql+=" where a01='"+ExcelService.getCellValue(sheet, i,0,"0").trim()+"'";   
                                                                     //条件
                }

        }  //for

        //报出检查的问题
        
        
        	
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");

     // 4、如果是更新方式，删除数据库中多余的记录，（没有被使用的）（加个删除选项，默认不删除）  
         if (importType.equals("update") && deleteDate.equals("delete"))   {
                //从数据库中找出所有的待删除记录
                sqlTemp="select id,a01 from rs_da where '"+allYgbhString+"' not like '%,'+a01+ ',%'";
                r=Api.sb(sqlTemp);
                if (r!=null && r.length>0)  {   //存在需要删除的记录
                        for (int i=0;i<r.length;i+=2) {
                            if (Api.checkIftheDataIsUsed("rs_da",r[i])) {   //如果被使用了，则在处理完成后报出来
                                    failDeleteMessage+="<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+r[i+1]+"</div>";
                            } else {
                                     sql+=" delete from rs_da where id='"+r[i]+"'";                     //未被使用,则删除
                            }
                        }
               }  
               

         }
	
      
		Api.ub(sql);     //实际执行
		Api.XtRefreshAutoKeyWords("rs_da");
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
						员工档案导入
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
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
                                        但有如下员工由于已经被某张单据使用,不能删除:
                                        <%=failDeleteMessage%>
                                     <%}%>
                                        <div align="center" width="100%" style="padding-top:10px;width:100%;"><img src="/emadmin/images/c2/button/bill_ok.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:location.href="/emadmin/jsp/common/list.jsp?modul_id=rs_da_listModul"'/> </div>
							</td>
						  </tr>
						</table>
				</form>													
						
											
			<!-- 内容区 -->

</body>
</html>

