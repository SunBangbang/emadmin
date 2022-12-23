<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.ca1234.admin.*,com.lf.util.Util,com.lf.ca1234.*,java.util.*"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*,java.text.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>

<%
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}
		Gztj aGztj = new Gztj();
		boolean flg = aGztj.insert(request);
		//System.out.println(flg);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>无标题文档</title>
</head>

<body>
<div align="center"><input type="button" value="提交成功，返回" onclick="history.back(-1)"/></div>
</body>
</html>
