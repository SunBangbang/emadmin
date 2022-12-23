<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%@include file="/emadmin/shared/checkPermission1.jsp"%>
<%			 String modulId =Serve.getNextModule(request); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
</head>

<frameset rows="*" cols="169,*" framespacing="1" frameborder="NO" border="0">
  <frame src="left.jsp?<%=request.getQueryString()%>" id="left" name="left" scrolling="auto" >
  <frame src="/emadmin/jsp/tree/list.jsp?modul_id=<%=modulId%>" name="work">
</frameset>
<noframes><body>
</body></noframes>
</html>
