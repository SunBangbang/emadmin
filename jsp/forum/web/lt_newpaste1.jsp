<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*"%>
<%@ include file="/emadmin/shared/checkPermission1.jsp"%>
<html>
<head>
<title>crm</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/main.css" rel="stylesheet" type="text/css">
</head>
		<%
				String message="";
			    String cid = (String)request.getParameter("cid");
				try {						
						ForumService.addPaste(request);		
						
					} catch (Exception e) {
						message="在访问数据库的时候发现错误，错误信息如下：<br>"+e.getMessage();
					}

		%>           
<body>
<table width="100%"  border="0">
<% if (message.equals("") ){ %>
   <tr>
    <td height="282" valign="middle"><div align="center">
      <p>主题建立成功！</p>
    </div></td>
  <tr> 
          <td height="12"><div align="center">
          <form name="form1" method="post" action="lt_titlelist.jsp">
          <input type="hidden" name="cid" value="<%=cid%>">
		  <input type="submit" name="Submit"  value="返回" class="anniu"  >
          </form></div></td>


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
