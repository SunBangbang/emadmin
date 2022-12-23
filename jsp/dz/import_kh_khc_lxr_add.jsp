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
    String [] sheetTitle=new String [16];
    sheetTitle[0]="公司名称*";
    sheetTitle[1]="姓名*";
    sheetTitle[2]="性别";
    sheetTitle[3]="所在部门";
    sheetTitle[4]="职务";
    sheetTitle[5]="负责业务";
    sheetTitle[6]="工作电话";
    sheetTitle[7]="移动电话";
    sheetTitle[8]="家庭电话";
    sheetTitle[9]="家庭住址";
    sheetTitle[10]="传真";
    sheetTitle[11]="邮箱";
    sheetTitle[12]="MSN/(QQ)";
    sheetTitle[13]="生日";
    sheetTitle[14]="爱好";
    sheetTitle[15]="备注";

     for (int i=0;i<sheetTitle.length;i++) {
        title=ExcelService.getCellValue(sheet, 0, i,"0").trim();    //row,col
        if (title==null || !title.equals(sheetTitle[i].trim()) ) 
            throw new LFException("工作表的第 "+String.valueOf(i+1)+" 列应为：["+sheetTitle[i].trim()+"]!");
   }
   
 
		 //2、检查Excel文件数据自身的合法性        
         //1）名称、类型有没有没录的 
         String errorMessage="";   //错误信息
         int  error_num=0;  //错误数
         String gsmc="";        //名称
         String xm="";          //类型
		 String yddh="";		//移动电话
		 HashMap  allyddh=new HashMap ();//所移动电话

         int realTotalRows=0;   //实际的行数
         int totalRows = sheet.getLastRowNum()+3;   //Excel返回总行数

         for (int i=1;i<totalRows;i++)  {    //开始扫描  从地2行开始
                gsmc=ExcelService.getCellValue(sheet, i,0,"0").trim();  
                xm=ExcelService.getCellValue(sheet, i,1,"0").trim(); 
				yddh=ExcelService.getCellValue(sheet, i,7,"0").trim();
				  
				 if (gsmc.length()==0 && xm.length()==0) { //名称类型和联系人都为空，同时后边没有了，就到底了
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


                if (gsmc.length()==0 && xm.length()>0)  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [公司名称] 不能为空！";
                    error_num++;
                    continue;
                }
                if (gsmc.length()>0 && xm.length()==0)  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [联系人] 不能为空！";
                    error_num++;
                    continue;
                }

				 //判断生日日期格式
                 String tmptmp=ExcelService.getCellValue(sheet, i,13,"0").trim();  
                 if (!Util.checkDateFormat(tmptmp) ){
                 		errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 生日日期格式不正确";
                    error_num++;
                    continue;
                 
                 }

				//1)移动电话是否重复
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
        String allGsmcString="";  //取得所有的名称，用于删除的时候和数据库比较
		String allXmString="";	 //取得的有姓名
        String failDeleteMessage=""; //不能成功删除的记录
        //1）类型有没有
        String sqlTemp="";
        String temp="";
        String sql="  declare @djh varchar(200)  ";
        String r[]=null;
        String valuegsmc="";
        String valueXb="";			   //性别
		String valueYddh="";			//移动电话
		String gs_id="";
		String gsbh="";
		boolean  is_update=false;  //对于修改方式,标志是否是执行update,如果为否,则执行insert
        for (int i=1;i<realTotalRows+1;i++)  {    //开始扫描   从第2行开始
                //公司名称是否存在
                temp=ExcelService.getCellValue(sheet, i,0,"0").trim();  
                allGsmcString+=","+temp+",";
			    allXmString+=","+ExcelService.getCellValue(sheet, i,0,"0").trim()+",";	 //取得的有姓名
                sqlTemp="select id,gsbh from kh_khc where gsmc='"+temp+"'";
                r=Api.sb(sqlTemp);
				System.out.println("aaaaaaaVVVVVVVVVVVVVVVVVV"+r);
				
                if (importType.equals("insert")) {     //如果是插入方式, 数据库里没有该名称,则报错
                        if (r==null || r.length==0 )  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [公司名称] 中的 ["+temp+"] 在客户池档案中未定义，请添加该客户！";
                            error_num++;
                            continue;
                        }
                       valuegsmc=temp;
					   gs_id=r[0];
					   gsbh =r[1];
                } else {  //如果是更新方式, 数据库里有该名称,则说明需要做update
                       if (r==null || r.length==0 )  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [公司名称] 中的 ["+temp+"] 在客户池档案中未定义，请添加该客户！";
                            error_num++;
                            continue;
                       }
                       valuegsmc=temp;
					   gs_id=r[0];
					   gsbh =r[1];
                }

				//性别（单层码检查）
				temp=ExcelService.getCellValue(sheet, i,2,"0").trim();  
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
				temp=ExcelService.getCellValue(sheet, i,7,"0");  
				sqlTemp="select count(*)  from kh_khc_lxr where yddh='"+temp+"'" ;
				r=Api.sb(sqlTemp);
				if(importType.equals("insert")){ //如果是插入方式, 数据库里有该移动电话,则报错
					 if ((r==null || r.length==0 || !r[0].equals("0"))&&temp.length()!=0)  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [移动电话] 中的 ["+temp+"] 与数据库中的数据重复！";
                            error_num++;
                            continue;
                        }
                       valueYddh=temp;
				}else { 
						//如果是更新方式, 数据库里有该名称,则说明需要做update
                       if ((r==null || r.length==0 || !r[0].equals("0")))  {
                             is_update=true;
                       } else {
                            is_update=false;
                       }
                        valueYddh=temp;
                }

                //对该行的列都检查完了,可以预生成sql语句了

                if (importType.equals("insert"))  { // 如果是插入模式

                        sql+="  exec getDJH  'xtlxrbh', @djh output  ";   //取一个单据号
                        sql+="  insert into kh_khc_lxr (id,gsmc,xm,xb,szbm,zw,fzyw,gzdh,yddh,jtdh,jtzz,cz,yx,msn,sr,ah,bz,gsbh,kh_khc_id,lrr,lrrq,lrbm,enabled,autokeyword) values( " ;
                        sql+=" @djh,";                                          // id 
                        sql+="'"+valuegsmc+"',";                                        //公司名称
                        sql+="'"+ExcelService.getCellValue(sheet, i,1,"0").trim()+"',";                         // 联系人
                        sql+="'"+valueXb+"',";																	// 性别            
                        sql+="'"+ExcelService.getCellValue(sheet, i,3,"0").trim()+"',";                          // 所在部门         
                        sql+="'"+ExcelService.getCellValue(sheet, i,4,"0").trim()+"',";                         /// 职务             
                        sql+="'"+ExcelService.getCellValue(sheet, i,5,"0").trim()+"',";                         /// 负责业务           
                        sql+="'"+ExcelService.getCellValue(sheet, i,6,"0").trim()+"',";                         /// 工作电话    
                        sql+="'"+ExcelService.getCellValue(sheet, i,7,"0").trim()+"',";                         ///移动电话               
                        sql+="'"+ExcelService.getCellValue(sheet, i,8,"0").trim()+"',";                         /// 家庭电话	       
                        sql+="'"+ExcelService.getCellValue(sheet, i,9,"0").trim()+"',";                          //家庭住址
                        sql+="'"+ExcelService.getCellValue(sheet, i,10,"0").trim()+"',";                          // 传真
                        sql+="'"+ExcelService.getCellValue(sheet, i,11,"0").trim()+"',";                          //邮编 
                        sql+="'"+ExcelService.getCellValue(sheet, i,12,"0").trim()+"',";                          //MSN/(QQ) 
                        sql+="'"+ExcelService.getCellValue(sheet, i,13,"0").trim()+"',";                          //生日      
						sql+="'"+ExcelService.getCellValue(sheet, i,14,"0").trim()+"',";                          //爱号        
                        sql+="'"+ExcelService.getCellValue(sheet, i,15,"0").trim()+"',";                           //bz 备注    
						sql+="'"+gsbh+"',";																	//gsbh   
						sql+="'"+gs_id+"',";															//gs_id
                        sql+="'"+((String[])session.getAttribute("userInfo"))[0]+"',";                         // lrr 
                        sql+="'"+Util.getDate()+"',";                                                          // lrrq
                        sql+="'"+((String[])session.getAttribute("userInfo"))[3]+"',";                         // lrbm
                        sql+="'1',',"+valueXb+","+gsbh+"') ";                                                    // enabled
                } 
				else if (importType.equals("update"))  {
                        sql+=" update kh_khc_lxr  set ";
                        sql+="xb='"+valueXb+"',";																	 // 性别 
                        sql+="szbm='"+ExcelService.getCellValue(sheet, i,3,"0").trim()+"',";                         // 所在部门
                        sql+="zw='"+ExcelService.getCellValue(sheet, i,4,"0").trim()+"',";                         // 职务
                        sql+="fzyw='"+ExcelService.getCellValue(sheet, i,5,"0").trim()+"',";                         // 负责业务
                        sql+="gzdh='"+ExcelService.getCellValue(sheet, i,6,"0").trim()+"',";                         // 工作电话
                        sql+="yddh='"+ExcelService.getCellValue(sheet, i,7,"0").trim()+"',";                         // 移动电话
                        sql+="jtdh='"+ExcelService.getCellValue(sheet, i,8,"0").trim()+"',";                         //家庭电话 
                        sql+="jtzz='"+ExcelService.getCellValue(sheet, i,9,"0").trim()+"',";                         // 家庭住址	
                        sql+="cz='"+ExcelService.getCellValue(sheet, i,10,"0").trim()+"',";                         //传真
                        sql+="yx='"+ExcelService.getCellValue(sheet, i,11,"0").trim()+"',";                         //邮编
                        sql+="msn='"+ExcelService.getCellValue(sheet, i,12,"0").trim()+"',";                         // MSN/(QQ) 
                        sql+="sr='"+ExcelService.getCellValue(sheet, i,13,"0").trim()+"',";                         // 生日
                        sql+="ah='"+ExcelService.getCellValue(sheet, i,14,"0").trim()+"',";                         //爱号
                        sql+="bz='"+ExcelService.getCellValue(sheet, i,15,"0").trim()+"' ";                          //bz 备注
						sql+=" where gsmc='"+valuegsmc+"' and xm='"+ExcelService.getCellValue(sheet, i,1,"0").trim()+"' ";      //条件   
                }

        }  //for

        //报出检查的问题
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");
		
     // 4、如果是更新方式，删除数据库中多余的记录，（没有被使用的）（加个删除选项，默认不删除）  
         if (importType.equals("update") && deleteDate.equals("delete"))   {
                //从数据库中找出所有的待删除记录

                sqlTemp="select id,xm from kh_khc_lxr where '"+allGsmcString+"' not like '%,'+gsmc+',%' and '"+allXmString+"' not like '%,'+xm+ ',%'";
				System.out.println(sqlTemp);
                r=Api.sb(sqlTemp);
                if (r!=null && r.length>0)  {   //存在需要删除的记录
                        for (int i=0;i<r.length;i+=2) {
                            if (Api.checkIftheDataIsUsed("kh_khc_lxr",r[i])) {   //如果被使用了，则在处理完成后报出来
                                    failDeleteMessage+="<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+r[i+1]+"</div>";
                            } else {
                                     sql+=" delete from kh_khc_lxr where id='"+r[i]+"'";                     //未被使用,则删除
                            }
                        }
               }  

         }
	
        //System.out.println(sql);
		Api.ub(sql);     //实际执行
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
						客户池联系人档案导入
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
                                        但有如客户池联系人由于已经被某张单据使用,不能删除:
                                        <%=failDeleteMessage%>
                                     <%}%>
                                       <div align="center" width="100%" style="padding-top:10px;width:100%;"><img src="/emadmin/images/c2/button/bill_ok.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:location.href="/emadmin/jsp/common/list.jsp?modul_id=kh_khc_lxr_listModul"'/> </div>
							</td>
						  </tr>
						</table>
				</form>													
							 
											
			<!-- 内容区 -->

</body>
</html>

