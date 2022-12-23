<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.lfbase.service.*"%>
<%
String id = request.getParameter("id");

String errorMessage="";
errorMessage = Serve.getErrorMessage(id);

%>


<html>
<head>
<title></title>
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="1">
  <tr>
    <td align="center" valign="middle">
	<table width="50%"  border="0" cellspacing="0" cellpadding="0">
	  <tr>
        <td><%=errorMessage%></td>
	    </tr>
      <tr>
        <td align="center"></td>
      </tr>
    </table>
</td>
  </tr>
</table>
</body>
</html>
