<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/emadmin/shared/checkAdminPermission.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.io.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.* ,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

	String id = "";
	String result[] = new String [2];
	//if( !Serve.checkMkQx( request ) )	{
	//	response.sendRedirect("/emadmin/shared/gotologin.jsp");
	//	return ;
	//}
      //如果已经上传过本文件
      String message="";
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
						&nbsp;&nbsp;&nbsp;库存期初信息导入
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
		  &nbsp;<!-- 按扭区 -->
		  <!-- 内容区 -->
					<table width="90%"  border="0" cellspacing="0" cellpadding="10" align="center">
						  <form action="import_excel_chqc1.jsp" method="post" name="form1" enctype="multipart/form-data">
						  <% if (message.length()>0) {%>
							  <tr>
								<td height="30px">
										  <div align="left"  style=" line-height:30px;color:#ff0000;font-size:12px;font-weight:bold;">
											警告:<br/>
										  </div>								 </td>
							  </tr>
							  <tr height="30px">
							  		<td>
										  <div align="left"  style=" line-height:30px;font-size:12px;">
											  &nbsp;&nbsp;&nbsp;&nbsp;重新上传此文件后，依赖《库存期初信息》的如下文件需要重新上传：</br>
										  </div>								   </td>
							  </tr>
							  <tr height="30px"> 
							  		<td>
										  <div align="left"  style=" line-height:30px;font-size:12px;">
											 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=message%><br/>
							    		  </div>								   </td>
							  </tr> 
						  <%}%>
						  <tr height="30px">
						    <td bgcolor="#BCCCDF">&nbsp;</td>
						    </tr>
						  <tr height="30px"> 
								<td>
									  <div align="left"  style=" line-height:25px;font-size:12px;"><br/>
										 &nbsp;&nbsp;&nbsp;&nbsp;请指定要上传的文件 :	&nbsp;&nbsp;&nbsp;&nbsp;<input type='file' name='myfile'><br/>								  </div>							   </td>
						  </tr> 
						  <tr >
							<td align="left">
							  	<div align="left" id="_button_area" style=" line-height:25px;font-size:12px;display:block"><br/>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="Submit" value="保存" onClick="_click_button(form1)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style=" line-height:25px;font-size:12px;display:none">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;正在处理，请稍等...</div>						   </td>
						  </tr>
						  </form>
						</table>
			
			<!-- 内容区 -->

</body>
</html>
