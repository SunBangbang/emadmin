<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.lfbase.common.*,com.lf.lfbase.product.*,java.sql.*,com.lf.lfbase.service.*,java.io.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.* "%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

	String id = "";
	String result[] = new String [2];
	//if( !Serve.checkMkQx( request ) )	{
	//	response.sendRedirect("/emadmin/shared/gotologin.jsp");
	//	return ;
	//}
	 if( request.getMethod().equalsIgnoreCase("post") )   {
			InitImportExcel_Ch.doImport(request);
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
 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
   //-->
</SCRIPT>

<body >
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区 --> 
			<td height="" align="left" valign="middle" id="center_head_bg">
					<span class="center_title" style="width:100%;">
						&nbsp;&nbsp;&nbsp;
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
		  <%=result[0]%>&nbsp;<!-- 按扭区 -->
		  <!-- 内容区 -->
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
						  <form action="import_excel_zz.jsp" method="post" name="form1" enctype="multipart/form-data">
						  <tr>
							<td align="left">	
								  <input type='file' name='myfile'>							
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="保存" onclick="_click_button(form1)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
						   </td>
						  </tr>
						  </form>
						</table>
			
			<!-- 内容区 -->

</body>
</html>
