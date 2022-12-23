<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*"%>
<html>
<head>
<title>crm</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/emadmin/css/c1/style_new.css">
</head>
<%@ include file="/emadmin/js/functions.jsp"%>
<%@ include file="/emadmin/shared/checkPermission1.jsp"%>

		<%
				String message="";
				try {	
							OaService.insertAlert(request);	
					} catch (Exception e) {
						e.printStackTrace();
						message="在访问数据库的时候发现错误，错误信息如下：<br>"+e.getMessage();
					}

		%>           
<body>
<table width="100%"  border="0">
<% if (message.equals("") ){ %>
  <tr>
    <td height="282" valign="middle"><div align="center">
      <p>提醒信息发送成功了!<br>
      </p>
<SCRIPT language=JavaScript>
<!-- 
	window.close();
--> 
</SCRIPT>
      <p>&nbsp;      </p>
    </div></td>
  </tr>
  <%} else {%>
  <tr> 
    <td  align="center" valign="top"><%=message%><br>
	<input type="button" name="Submit2" value="确定" class="anniu" onClick="javascript:history.back(-1);"></td>
  </tr>
  <%} %>
</table>
</body> 
</html>
