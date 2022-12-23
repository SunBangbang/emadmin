<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*"%>
<%@ include file="/emadmin/shared/checkPermission1.jsp"%>
<html>
<head>
<title>crm</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/main.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style2 {
	font-size: 16px;
	font-weight: bold;
}
.style5 {color: #FF0000}
.style6 {font-size: 16px}
-->
</style></head>

		<%
				String userid=(String)session.getAttribute("userId");
				String id=(String)request.getParameter("id");
				String name=(String)request.getParameter("name");
				String color=(String)request.getParameter("color");
				String message="";
				if (message.equals("")) {
					try {						
						OaService.insert_group(userid,id, name,color);
						response.sendRedirect("notebookeditgroup.jsp");
					} catch (Exception e) {
						message="在访问数据库的时候发现错误，请稍后再试!";
					}
				}

%>           
<body>
<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0" borderColor="#cccccc" borderColorDark="#ffffff">
  <tr> 
    
    <td  align="center" valign="top"><table width="100%" border="0" cellspacing="5" cellpadding="0">
      <tr>
        <td valign="top"><font class="textNormal">
            <table class="newsListbody" cellSpacing="10" cellPadding="0" width="100%" border="0">
              <tr>
                <td align="left" valign="top"><a href="notebook.jsp" class="link_rc">网络记事本</a></td>
              </tr>
              <tr>
                <td align="left" valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="5">
<% if (message.equals("") ){ %>
  <tr> 
    <td  align="center" valign="top">您的信息已经成功保存!<br>
	  <input type="button" name="Submit" value="确定" class="anniu" onClick="javascript:location.href='notebookeditgroup.jsp'">
	</td>
  </tr>
  <%} else {%>
  <tr> 
    <td  align="center" valign="top"><%=message%><br>
	<input type="button" name="Submit" value="确定" class="anniu" onClick="javascript:history.back(-1);"></td>
  </tr>
  <%} %>
                </table></td>
              </tr>
            </table>
        </font></td>
      </tr>
    </table></td>
  </tr>
  <tr> 
    <td height="25" colspan="2" align="center" valign="top">
</td>
  </tr>
</table>
</body>
</html>
