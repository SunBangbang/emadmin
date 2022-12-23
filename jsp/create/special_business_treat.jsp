<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
	String id = "";
	String result = "";
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}


	     if( request.getMethod().equalsIgnoreCase("post") )
         {
			 //执行
			 Serve.specialBusinessTreatExec( request );

			 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功 ！","UTF-8"));
			 return; 

			
         }
		 else
			 result =Serve.getSpecialBusinessTreatTemplate( request ); 

%>





<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
<SCRIPT language=JavaScript>
<!-- 
function doSubmit( )
{
	if( doCheck( document.form1 ) )	
	     form1.submit();	
	else
	     return false;
}
-->
</SCRIPT>
</head>

<body>
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区 --> 
			<td height="" align="left" valign="middle" id="center_head_bg">
					<span class="center_title" style="width:100%;">
						&nbsp;&nbsp;&nbsp;<%=Serve.getModulName( request )%>
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
			<!-- 按扭区 --> 
							&nbsp;
			<!-- 按扭区 --> 
			<!-- 内容区 -->
			<form name="form1" method="post" action="special_business_treat.jsp"  onSubmit="return doCheck(form1)">
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
					  <tr>
						<td align="left"><%=result%>
							  	<div align="center"><input type="submit" name="Submit" value="执行"> 
								<input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'>
								
								</div>
						</td>
					  </tr>
					</table>
			</form>													
																
</body>
</html>
