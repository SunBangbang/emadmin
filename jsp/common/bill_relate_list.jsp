<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%

	String result = Serve.getBillRelateTemplate( request );
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
<style type="text/css">
<!--
body {padding:0px;margin:0px;}
-->
</style>
<body>      
         <!-- 内容区 -->

							   <%=result%>	
                               <div align="center"><img src="/emadmin/images/c2/button/bill_back.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);'/> </div>
											
			<!-- 内容区 -->
</body>
</html>
