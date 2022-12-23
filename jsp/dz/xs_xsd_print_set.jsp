<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}
      

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
<body >
	
 			
			<!-- 内容区 -->

				<form name="form1" action="xs_xsd_print.jsp" method="post" target="_blank">
					<table width="90%"  border="0" cellspacing="5" cellpadding="5" align="center">
					  <tr>
						<td align="left"><br/>
							
							<input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
							  <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
							  <div align="center">宽度控制参数：<input type="text" name="xiaopiao" value="205"></div>
							  	

						</td>
						
					  </tr>
					  <tr><td colspan=2><div align="center" id="_button_area" style="display:block"><input type="Submit" name="Submit" value="确定"> <input type="button" name="quxiao" value="重置"  onclick="javascript:document.getElementsByName('xiaopiao')[0].value='';"></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div></td></tr>
					</table>
				</form>													
							 
											
			<!-- 内容区 -->

</body>
</html>
<iframe  width="0" height="0"></iframe>
