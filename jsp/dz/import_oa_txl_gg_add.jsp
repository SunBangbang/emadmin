<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.io.*,com.lf.util.*,java.text.SimpleDateFormat,com.lf.lfbase.service.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,javax.servlet.http.HttpServletRequest,java.net.*,java.text.*"%>
<%

        /*
        1、首先检查上传的Excel文件的合法性
            1）是不是Excel文件
            2）工作表的数量是不是1个，工作表的名称对不对“公共通讯录”
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


    
    //2）工作表的数量是不是1个，工作表的名称对不对“公共通讯录”
    if (wb.getNumberOfSheets()!= 1)
        throw new LFException("模板的工作表数量应该是1个,请检查是否使用了正确的模板!");
	
    HSSFSheet sheet = wb.getSheetAt(0); 
     
    //if (!wb.getSheetName(sheet).eqauls("公共通讯录"))
        //throw new LFException("工作表的名称不是[公共通讯录]!");
    
    //3）标题列对不对

    String title="";
    String [] sheetTitle=new String [13];
    sheetTitle[0]="单位*";
    sheetTitle[1]="姓名*";
    sheetTitle[2]="性别";
    sheetTitle[3]="职务";
    sheetTitle[4]="部门";
    sheetTitle[5]="地址";
	sheetTitle[6]="电话";
    sheetTitle[7]="手机";
    sheetTitle[8]="传真";
	sheetTitle[9]="Email";
    sheetTitle[10]="网址";
    sheetTitle[11]="QQ(MSN)";
	sheetTitle[12]="备注";
  
    
    
    for (int i=0;i<sheetTitle.length;i++) {
        title=ExcelService.getCellValue(sheet, 0, i,"0").trim();    //row,col
        if (title==null || !title.equals(sheetTitle[i].trim()) ) 
            throw new LFException("工作表的第 "+String.valueOf(i+1)+" 列应为：["+sheetTitle[i].trim()+"]!");
   }
   
 

///2、检查Excel文件数据自身的合法性        
         //1）名称、类型有没有没录的 
         String errorMessage="";   //错误信息
         int  error_num=0;  //错误数
         String dw="";        //单位
         String xm="";          //姓名
		 String xb="";          //性别
		 String sj="";          //手机
		
       
		 SLfHashMap  allMc= new SLfHashMap ();	//所有手机
	
		
		 
         int realTotalRows=0;   //实际的行数
         int totalRows = sheet.getLastRowNum()+2;   //Excel返回总行数
       
         for (int i=1;i<totalRows;i++)  {    //开始扫描  从地2行开始
                dw=ExcelService.getCellValue(sheet, i,0,"0").trim();  
                xm=ExcelService.getCellValue(sheet, i,1,"0").trim(); 
				xb=ExcelService.getCellValue(sheet, i,2,"0").trim(); 
				sj=ExcelService.getCellValue(sheet, i,7,"0").trim(); 
			
                if (dw.length()==0 && xm.length()==0) { //单位和姓名都为空，同时后边没有了，就到底了
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
                if (dw.length()==0 && xm.length()>0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [单位] 不能为空！";
                    error_num++;
                    continue;
                }
                if (dw.length()>0 && xm.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [姓名] 不能为空！";
                    error_num++;
                    continue;
                }
                
				
               
                 //2）手机有没有重复
                if (allMc.containsKey(sj))  {
                        errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [手机] 与 第[ "+allMc.get(sj)+" ]行重复！ ";
                        error_num++;
                } else {
                        if (!Util.isBlankString(sj)) allMc.put(sj,String.valueOf(i+1));
                        realTotalRows++;
                      
                }
				
               
         } //for

         //先报出自身检查的问题
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<br/><div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");


//3、Excel文件数据与数据库中的已有数据的关联性检查   
        
        errorMessage="";
        error_num=0;
        String alldwString="";  // 取得单位，用于删除的时候和数据库比较
		String allxmString="";  // 取得姓名，用于删除的时候和数据库比较
		
        String failDeleteMessage=""; //不能成功删除的记录
        String sqlTemp="";
        String temp="";
        String sql="  declare @djh varchar(200)   ";
        String r[]=null;
        String valuedw="";
        boolean  is_update=false;  //对于修改方式,标志是否是执行update,如果为否,则执行insert
        String sqlTemp2="";
        String temp2="";
        String r2[]=null;
		String valueXb="";//性别
	
					     
        
        
        for (int i=1;i<=realTotalRows;i++)  {    //开始扫描   从第2行开始

                //手机
                temp2=ExcelService.getCellValue(sheet, i,7,"0").trim();  
                allxmString+=","+temp2+",";
                sqlTemp2="select count(*) from oa_txl_gg where sj='"+temp2+"' ";
                r2=Api.sb(sqlTemp2);
                if (importType.equals("insert")) {     //如果是插入方式, 数据库里有该名称,则报错
                        if (r2==null || r2.length==0 || !r2[0].equals("0"))  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [手机] 中的 ["+temp2+"] 与数据库中的数据重复！";
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
              


							
			
                //对该行的列都检查完了,可以预生成sql语句了

                if (!is_update )  { // 如果是插入模式

                        sql+="  exec getDJH  'txl', @djh output  ";   //取一个单据号
                        sql+=" insert into oa_txl_gg(id,dw,xm,xb,zw,bm,dz,dh,sj,cz,email,wz,qq,bz)values(";
                        sql+=" @djh,";                                          // id 就用单据号
                        sql+="'"+ExcelService.getCellValue(sheet, i,0,"0").trim()+"',";   //单位
                        sql+="'"+ExcelService.getCellValue(sheet, i,1,"0").trim()+"',";   //姓名
                        sql+="'"+valueXb+"',";                         // 性别
						sql+="'"+ExcelService.getCellValue(sheet, i,3,"0").trim()+"',";   //职务
                    


						sql+="'"+ExcelService.getCellValue(sheet, i,4,"0").trim()+"',";   //部门
                        sql+="'"+ExcelService.getCellValue(sheet, i,5,"0").trim()+"',";   //地址
                      
						sql+="'"+ExcelService.getCellValue(sheet, i,6,"0").trim()+"',";   //电话
                     
						sql+="'"+ExcelService.getCellValue(sheet, i,7,"0").trim()+"',";   //手机
						sql+="'"+ExcelService.getCellValue(sheet, i,8,"0").trim()+"',";   //传真
						sql+="'"+ExcelService.getCellValue(sheet, i,9,"0").trim()+"',";   //Email
						sql+="'"+ExcelService.getCellValue(sheet, i,10,"0").trim()+"',";   //网址
						sql+="'"+ExcelService.getCellValue(sheet, i,11,"0").trim()+"',";   //QQ(MSN)
						sql+="'"+ExcelService.getCellValue(sheet, i,12,"0").trim()+"'";   //备注
					
						
                        sql+=")";   
                        
                     
                } else {		
                	
                        sql+=" update oa_txl_gg  set ";
                       sql+="dw='"+ExcelService.getCellValue(sheet, i,0,"0").trim()+"',";   //单位
                        sql+="xm='"+ExcelService.getCellValue(sheet, i,1,"0").trim()+"',";   //姓名
                        sql+="xb='"+valueXb+"',";                         // 性别
						sql+="zw='"+ExcelService.getCellValue(sheet, i,3,"0").trim()+"',";   //职务
                    


						sql+="bm='"+ExcelService.getCellValue(sheet, i,4,"0").trim()+"',";   //部门
                        sql+="dz='"+ExcelService.getCellValue(sheet, i,5,"0").trim()+"',";   //地址
                      
						sql+="dh='"+ExcelService.getCellValue(sheet, i,6,"0").trim()+"',";   //电话
                     
						sql+="sj='"+ExcelService.getCellValue(sheet, i,7,"0").trim()+"',";   //手机
						sql+="cz='"+ExcelService.getCellValue(sheet, i,8,"0").trim()+"',";   //传真
						sql+="email='"+ExcelService.getCellValue(sheet, i,9,"0").trim()+"',";   //Email
						sql+="wz='"+ExcelService.getCellValue(sheet, i,10,"0").trim()+"',";   //网址
						sql+="qq='"+ExcelService.getCellValue(sheet, i,11,"0").trim()+"',";   //QQ(MSN)
						sql+="bz='"+ExcelService.getCellValue(sheet, i,12,"0").trim()+"'";   //备注					
                        
						sql+=" where dw='"+ExcelService.getCellValue(sheet, i,0,"0").trim()+"' ";   
                                                                     //条件
                }

        }  //for

        //报出检查的问题
        
        
        	
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");

     // 4、如果是更新方式，删除数据库中多余的记录，（没有被使用的）（加个删除选项，默认不删除）  
         if (importType.equals("update") && deleteDate.equals("delete"))   {
                //从数据库中找出所有的待删除记录
                sqlTemp="select id,dw from oa_txl_gg where '"+allxmString+"' not like '%,'+dw+ ',%'";
                r=Api.sb(sqlTemp);
                if (r!=null && r.length>0)  {   //存在需要删除的记录
                        for (int i=0;i<r.length;i+=2) {
                            if (Api.checkIftheDataIsUsed("oa_txl_gg",r[i])) {   //如果被使用了，则在处理完成后报出来
                                    failDeleteMessage+="<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+r[i+1]+"</div>";
                            } else {
                                     sql+=" delete from oa_txl_gg where id='"+r[i]+"'";                     //未被使用,则删除
                            }
                        }
               }  
               

         }
	
      
		Api.ub(sql);     //实际执行
		Api.XtRefreshAutoKeyWords("oa_txl_gg");
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
						公共通讯录导入
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
                                        但有如下服务项目由于已经被某张单据使用,不能删除:
                                        <%=failDeleteMessage%>
                                     <%}%>
                                        <div align="center" width="100%" style="padding-top:10px;width:100%;"><img src="/emadmin/images/c2/button/bill_ok.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:location.href="/emadmin/jsp/common/list.jsp?modul_id=oa_txl_gg_listModul"'/> </div>
							</td>
						  </tr>
						</table>
				</form>													
						
											
			<!-- 内容区 -->

</body>
</html>

