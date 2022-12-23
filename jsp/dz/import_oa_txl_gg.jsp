<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.io.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
	String id = "";
	String result[] = new String [2];
	if( !Serve.checkMkQx( request ) )	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}

%>
<html>
<head>
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
 		function _click_button(formx) { 
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				document.getElementById('_button_area_2' ).style.display="none";
				document.getElementById('_button_area_message_2' ).style.display="block";
				formx.submit();
		}
   //-->
</SCRIPT>

<body >
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
		  &nbsp;<!-- 按扭区 -->
        <table class="x_bill_outer_table" cellspacing="0" align="center">
		    <tr>
			    <td>
					    <div align="center">   
                                <table cellspacing="0" class="x_list_export_result_table"> 
   		                                <tr>
   			                                <td class="x_list_export_result_title_td">
                                            <br/>
                                                    <form name='form1' action="import_oa_txl_gg_add.jsp" method="post" enctype="multipart/form-data">
                                                            <div id='insert_title' class="x_excel_area_title_div">
                            										<input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
                                                                    <input type="hidden" name="import_type" value="insert"> 
                                                                     <input type="hidden" name="delete"  value="nodelete">
                                                                     <img src="/emadmin/images/c2/button/excel_insert.gif" onclick="javascript:insert_content.style.display='block';update_content.style.display='none';"  onMouseOver="this.style.cursor='hand'" style="vertical-align:middle"/>
                                                                   <span class="x_excel_alert_message">（提示: 通过Excel导入,批量向数据库中新增数据)</span>
                                                                    
                                                             </div>
                                                            <div id='insert_content' class="x_excel_area_content_div">
                                                                        <div class="x_excel_content_line_div" >第一步：下载右边的Excel模板。&nbsp;&nbsp;&nbsp;&nbsp; <a href="/emadmin/resource/template/公共通讯录导入模版.xls" target="_blank" class="x_list_result_title_link_excel"> 公共通讯录数据模板</a></div>
                                                                        <div  class="x_excel_content_line_div" >第二步：向Excel模板中添加数据。 <span class="x_excel_alert_message">(注意：不能改变模板中的栏目及格式) </span></div>
                                                                        <div  class="x_excel_content_line_div" >第三步：点击“浏览”，打开添加好数据的Excel文件，点击“开始导入”。</div>
                                                                        <div id="_button_area" class="x_excel_content_line_div" style="display:block">
                                                                                    <input type=file name="myfile" style="vertical-align:middle">
                                                                                    &nbsp;&nbsp;<img src="/emadmin/images/c2/button/excel_start_import.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form1)" style="vertical-align:middle"/> &nbsp;&nbsp;<img src="/emadmin/images/c2/button/excel_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);' style="vertical-align:middle"/> 
                                                                        </div>
                                                                        <div align="center" id="_button_area_message" style="display:none;">正在处理，请稍等...</div>
                                                           </div>
                                                    </form>
                                                    <form name='form2' action="import_oa_txl_gg_add.jsp" method="post" enctype="multipart/form-data">
                                                             <div id='update_title' class="x_excel_area_title_div">  
                            										<input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
                                                                    <input type="hidden" name="import_type" value="update"> 
                                                                     <input type="hidden" name="delete"  value="nodelete">
                                                             <img src="/emadmin/images/c2/button/excel_update.gif" onclick="javascript:update_content.style.display='block';insert_content.style.display='none';"  onMouseOver="this.style.cursor='hand'" style="vertical-align:middle"/>
                                                                   <span class="x_excel_alert_message">（提示:通过Excel导入,批量更新数据库中的数据)</span></div>
                                                            <div id='update_content' class="x_excel_area_content_div">
                                                                        <div class="x_excel_content_line_div" >第一步：从数据库中导出数据。&nbsp;&nbsp;&nbsp;&nbsp; <a href="export_execel.jsp?table=oa_txl_gg" target="_blank" class="x_list_result_title_link_excel"> 导出公共通讯录数据</a></div>
                                                                        <div  class="x_excel_content_line_div" >第二步：修改或删除导出的Excel中的数据。 <span class="x_excel_alert_message">(注意：不能改变模板中的栏目及格式) </span></div>
                                                                         <div  class="x_excel_content_line_div" ><input type="checkbox" name="delete" value="delete">  删除数据。 <span class="x_excel_alert_message">（注意选择此项后，如果数据库中的某条信息在Excel中不包括，则会被删除）。</span></div>
                                                                        <div  class="x_excel_content_line_div" >第三步：点击“浏览”，打开添加好数据的Excel文件，点击“开始导入”。</div>
                                                                        <div id="_button_area_2" class="x_excel_content_line_div" style="display:block">
                                                                                    <input type=file name="myfile" style="vertical-align:middle">
                                                                                    &nbsp;&nbsp;<img src="/emadmin/images/c2/button/excel_start_import.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form2)" style="vertical-align:middle"/> &nbsp;&nbsp;<img src="/emadmin/images/c2/button/excel_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);' style="vertical-align:middle"/> 
                                                                        </div>
                                                                        <div align="center" id="_button_area_message_2" style="display:none;">正在处理，请稍等...</div>
                                                            </div>
                                                    </form>
                                            </td>
                                        </tr>
   	                            </table>
                        </div>	
				</td>
			</tr>
		</table>

</body>
</html>
