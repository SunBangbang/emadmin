<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/emadmin/shared/checkPermission1.jsp"%>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*"%>
<html>
<head>
<title></title>
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
				String content=(String)request.getParameter("content");
				String group_id=(String)request.getParameter("group_id");
				String title=(String)request.getParameter("title");
				String message="";
				if (message.equals("")) {
					try {						
						OaService.insert(userid,content, request.getRemoteAddr(),group_id,title);
						response.sendRedirect("notebook.jsp?group_id="+group_id);
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
                <td height="50" align="left" valign="middle"><font class="textNormal">   <a href="notebook.jsp" class="link_rc">网络记事本</a></font></td>
              </tr>
              <tr>
                <td align="left" valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="5">
<% if (message.equals("") ){ %>
  <tr> 
    <td  align="center" valign="top">您的信息已经成功保存!<br>
	  <input type="button" name="Submit1" value="确定" class="anniu" onClick="javascript:location.href='notebook.jsp?group_id=<%=group_id%>'">
	</td>
  </tr>
  <%} else {%>
  <tr> 
    <td  align="center" valign="top"><%=message%><br>
	<input type="button" name="Submit2" value="确定" class="anniu" onClick="javascript:history.back(-1);"></td>
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
