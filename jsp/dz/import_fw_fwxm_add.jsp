<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.io.*,com.lf.util.*,java.text.SimpleDateFormat,com.lf.lfbase.service.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,javax.servlet.http.HttpServletRequest,java.net.*,java.text.*"%>
<%

        /*
        1、首先检查上传的Excel文件的合法性
            1）是不是Excel文件
            2）工作表的数量是不是1个，工作表的名称对不对“服务项目档案”
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


    
    //2）工作表的数量是不是1个，工作表的名称对不对“服务项目档案”
    if (wb.getNumberOfSheets()!= 1)
        throw new LFException("模板的工作表数量应该是1个,请检查是否使用了正确的模板!");
	
    HSSFSheet sheet = wb.getSheetAt(0); 
     
    //if (!wb.getSheetName(sheet).eqauls("服务项目档案"))
        //throw new LFException("工作表的名称不是[服务项目档案]!");
    
    //3）标题列对不对

    String title="";
    String [] sheetTitle=new String [6];
    sheetTitle[0]="服务项目编号*";
    sheetTitle[1]="服务项目名称*";
    sheetTitle[2]="服务项目类型";
    sheetTitle[3]="服务内容";
    sheetTitle[4]="价格";
    sheetTitle[5]="备注";
    
    for (int i=0;i<sheetTitle.length;i++) {
        title=ExcelService.getCellValue(sheet, 0, i,"0");    //row,col
        if (title==null || !title.equals(sheetTitle[i].trim()) ) 
            throw new LFException("工作表的第 "+String.valueOf(i+1)+" 列应为：["+sheetTitle[i]+"]!");
   }
   
 

///2、检查Excel文件数据自身的合法性        
         //1）名称、类型有没有没录的 
         String errorMessage="";   //错误信息
         int  error_num=0;  //错误数
         String fwxmbh="";        //服务项目编号
         String fwxmmc="";          //服务项目名称
		 String fwxmlx="";          //服务项目类型
		
       
		 HashMap  allMc= new HashMap ();	//所有服务项目名称
		 HashMap  allFwxmbh= new HashMap ();	//服务项目编号
		
		 
         int realTotalRows=0;   //实际的行数
         int totalRows = sheet.getLastRowNum()+1;   //Excel返回总行数
       
         for (int i=1;i<totalRows;i++)  {    //开始扫描  从地2行开始
                fwxmbh=ExcelService.getCellValue(sheet, i,0,"0");  
                fwxmmc=ExcelService.getCellValue(sheet, i,1,"0"); 
				fwxmlx=ExcelService.getCellValue(sheet, i,2,"0"); 
			
                if (fwxmbh.length()==0 && fwxmmc.length()==0) { //服务项目编号和名称都为空，同时后边没有了，就到底了
                        boolean find=false;
                        for (int j=i+1;j<totalRows;j++) {
                            if (ExcelService.getCellValue(sheet, j,0,"0").length()>0  
                                || ExcelService.getCellValue(sheet, j,1,"0").length()>0) {
                                find=true;
                                break;   //不用继续找了
                            }
                           
                        }
                        if (!find) {    //到底了
                            realTotalRows=i-1;
                            break;
                        }
                }
                if (fwxmbh.length()==0 && fwxmmc.length()>0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [服务项目编号] 不能为空！";
                    error_num++;
                    continue;
                }
                if (fwxmbh.length()>0 && fwxmmc.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [服务项目名称] 不能为空！";
                    error_num++;
                    continue;
                }
                
				
               
                 //2）服务项目编号有没有重复
                if (allMc.containsKey(fwxmbh))  {
                        errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [服务项目编号] 与 第[ "+allMc.get(fwxmbh)+" ]行重复！ ";
                        error_num++;
                } else {
                        if (!Util.isBlankString(fwxmbh)) allMc.put(fwxmbh,String.valueOf(i+1));
                        realTotalRows++;
                      
                }
				//服务项目名称
				 if (allFwxmbh.containsKey(fwxmmc))  {
                      errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [服务项目名称] 与 第[ "+allFwxmbh.get(fwxmmc)+" ]行重复！ ";
                        error_num++;
                } else{
				
				  if (!Util.isBlankString(fwxmmc)) allFwxmbh.put(fwxmmc,String.valueOf(i+1));
				}
               
         } //for

         //先报出自身检查的问题
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<br/><div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");


//3、Excel文件数据与数据库中的已有数据的关联性检查   
        
        errorMessage="";
        error_num=0;
        String allfwxmbhString="";  // 取得所有的编号，用于删除的时候和数据库比较
		String allfwxmmcString="";  // 取得所有的名称，用于删除的时候和数据库比较
		
        String failDeleteMessage=""; //不能成功删除的记录
        String sqlTemp="";
        String temp="";
        String sql="  declare @djh varchar(200)   ";
        String r[]=null;
        String valuefwxmbh="";
        boolean  is_update=false;  //对于修改方式,标志是否是执行update,如果为否,则执行insert
        String sqlTemp2="";
        String temp2="";
        String r2[]=null;
		String valueLx="";//服务项目类型
	
					     
        
        
        for (int i=1;i<=realTotalRows;i++)  {    //开始扫描   从第2行开始
                //名称
                temp=ExcelService.getCellValue(sheet, i,0,"0");  
              
                allfwxmbhString+=","+temp+",";
                sqlTemp="select count(*) from fw_fwxm where fwxmbh='"+temp+"'";
                r=Api.sb(sqlTemp);
                if (importType.equals("insert")) {     //如果是插入方式, 数据库里有该名称,则报错
                        if (r==null || r.length==0 || !r[0].equals("0"))  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [服务项目编号] 中的 ["+temp+"] 与数据库中的数据重复！";
                            error_num++;
                            continue;
                        }
                       is_update=false;
                       valuefwxmbh=temp;
                } else {  //如果是更新方式, 数据库里有该名称,则说明需要做update
                       if (r==null || r.length==0 || !r[0].equals("0"))  {
                            is_update=true;
                       } else {
                            is_update=false;
                       }
                        valuefwxmbh=temp;
                }
                //身份证号
                temp2=ExcelService.getCellValue(sheet, i,1,"0");  
                allfwxmmcString+=","+temp2+",";
                sqlTemp2="select count(*) from fw_fwxm where fwxmmc='"+temp2+"' ";
                r2=Api.sb(sqlTemp2);
                if (importType.equals("insert")) {     //如果是插入方式, 数据库里有该名称,则报错
                        if (r2==null || r2.length==0 || !r2[0].equals("0"))  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [服务项目名称] 中的 ["+temp2+"] 与数据库中的数据重复！";
                            error_num++;
                            continue;
                        }
                  
                       
                } 
                
                
              


                //服务项目类型    (层次码)
                temp=ExcelService.getCellValue(sheet, i,2,"0");  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码,层次码同时查找出是否是末级节点
                        sqlTemp="select a.dm,(select count(*) from fw_fwxmfl b where b.dm<>a.dm and b.dm like a.dm+'%') from fw_fwxmfl a  where a.mc='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [服务项目类型] 中的 ["+temp+"] 在服务项目分类中未定义,请先添加该部门！";
                            error_num++;
                            continue;
                        }  
                        if (!r[1].equals("0"))  {   //不是末级节点
                            errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [服务项目类型] 中的 ["+temp+"] 不是最末级服务项目类型,请更该为末级服务项目类型！";
                            error_num++;
                            continue;
                        }  
                        valueLx=r[0];
                } 
                
							
			
                //对该行的列都检查完了,可以预生成sql语句了

                if (!is_update )  { // 如果是插入模式

                        sql+="  exec getDJH  '11701433974070311', @djh output  ";   //取一个单据号
                        sql+=" insert into fw_fwxm(id,fwxmbh,fwxmmc,fwxmlx,fwnr,jg,bz,enabled)values(";
                        sql+=" @djh,";                                          // id 就用单据号
                        sql+="'"+ExcelService.getCellValue(sheet, i,0,"0")+"',";   //服务项目编号
                        sql+="'"+ExcelService.getCellValue(sheet, i,1,"0")+"',";   //服务项目名称
                        sql+="'"+valueLx+"',";                         // 服务项目类型
						sql+="'"+ExcelService.getCellValue(sheet, i,3,"0")+"',";   //服务内容
                     	sql+="'"+ExcelService.getCellValueForNumber(sheet, i,4,"0.00")+"',"; //	价格
						sql+="'"+ExcelService.getCellValue(sheet, i,5,"0")+"',";   //服务内容
						
                        sql+="'1')";   
                        
                     
                } else {
                	
                        sql+=" update fw_fwxm  set ";
                        sql+="fwxmbh='"+ExcelService.getCellValue(sheet, i,0,"0")+"',";   //服务项目编号
                        sql+="fwxmmc='"+ExcelService.getCellValue(sheet, i,1,"0")+"',";   //服务项目名称
                        sql+="fwxmlx='"+valueLx+"',";                         // 服务项目类型
						sql+="fwnr='"+ExcelService.getCellValue(sheet, i,3,"0")+"',";   //服务内容
                     	sql+="jg='"+ExcelService.getCellValueForNumber(sheet, i,4,"0.00")+"',"; //	价格
						sql+="bz='"+ExcelService.getCellValue(sheet, i,5,"0")+"'";   //服务内容							
                        
                        sql+=" where fwxmbh='"+ExcelService.getCellValue(sheet, i,0,"0")+"'";   
                                                                     //条件
                }

        }  //for

        //报出检查的问题
        
        
        	
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");

     // 4、如果是更新方式，删除数据库中多余的记录，（没有被使用的）（加个删除选项，默认不删除）  
         if (importType.equals("update") && deleteDate.equals("delete"))   {
                //从数据库中找出所有的待删除记录
                sqlTemp="select id,fwxmbh from fw_fwxm where '"+allfwxmbhString+"' not like '%,'+fwxmbh+ ',%'";
                r=Api.sb(sqlTemp);
                if (r!=null && r.length>0)  {   //存在需要删除的记录
                        for (int i=0;i<r.length;i+=2) {
                            if (Api.checkIftheDataIsUsed("fw_fwxm",r[i])) {   //如果被使用了，则在处理完成后报出来
                                    failDeleteMessage+="<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+r[i+1]+"</div>";
                            } else {
                                     sql+=" delete from fw_fwxm where id='"+r[i]+"'";                     //未被使用,则删除
                            }
                        }
               }  
               

         }
	
      
		Api.ub(sql);     //实际执行
		Api.XtRefreshAutoKeyWords("fw_fwxm");
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
						服务项目档案导入
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
                                        <div align="center" width="100%" style="padding-top:10px;width:100%;"><img src="/emadmin/images/c2/button/bill_ok.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:location.href="/emadmin/jsp/common/list.jsp?modul_id=fw_fwxm_listModul"'/> </div>
							</td>
						  </tr>
						</table>
				</form>													
						
											
			<!-- 内容区 -->

</body>
</html>

