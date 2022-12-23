<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
	String result;
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}
		else 
			result = Serve.allListPrint( request );

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>

<style>

td {font-size:13px}
.main1 {  font-size: 14px}
.main2 {  font-size: 12px}
.top{	FONT-SIZE: 4px}
.aa{ font-size:18px;font-family:宋体;}
.bb{ font-size:22px;font-family:宋体;font-weight:bold}
td.rptitle1 {
 	BORDER-BOTTOM:none;
 	BORDER-LEFT:none;
 	border-top:#000000 solid 1px ;
 	BORDER-RIGHT:#000000 solid 1px;
}
TABLE.rpbody {
	border-top:none; BORDER-RIGHT:none;
	BORDER-LEFT:#000000 solid 1px;BORDER-BOTTOM:#000000 solid 1px;
	ALIGN:MIDDLE;
}
</style>

</head>
<body>
<table width="100%"  border="0" cellspacing="0" cellpadding="5">
<form name="form1" action="list.jsp" method="get">
  <tr>
    <td>
	<%=result%>
	</td>
  </tr>
</form>  
</table>

</body>
</html>
