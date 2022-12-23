<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="com.lf.lfbase.service.*"%>
<%
	if (request.getMethod().equalsIgnoreCase("post")) {
		if (request.getParameter("s")!=null & request.getParameter("s").length()>0 ) out.println(Server.s(request));
		if (request.getParameter("s1")!=null && request.getParameter("s1").length()>0 ) Server.u(request);
	}
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
</head>
<body>
<form name="form1" method="post" action="" onSubmit="">
<table width="800"  border="0">
  <tr>
    <td>	部门 </td>
    <td>	<input type=text name=p value=<%=request.getParameter("p")%>>  </td>
 </tr>
  <tr>
    <td>	内容 </td>
    <td>	<textarea type=text name=s><%=request.getParameter("s")%></textarea> </td>
 </tr>
  <tr>
    <td>	备注 </td>
    <td>	<textarea type=text name=s1><%=request.getParameter("s1")%></textarea> </td>
 </tr>
</table>
<table width="100%"  border="0" cellspacing="10" cellpadding="0" align="center">
  <tr>
    <td align="center"><input type="submit" name="Submit" value="保存"></td>
  </tr>
</table>
</form>
</body>
</html>
