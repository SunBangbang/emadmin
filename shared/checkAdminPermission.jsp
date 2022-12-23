<%@page contentType="text/html;charset=UTF-8"%>
<%  if(session.getAttribute("userId")==null || !((String)session.getAttribute("userId")).equalsIgnoreCase("admin"))  { %>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
    alert("不具有该功能的操作权限或登录信息已经失效，请以系统管理员身份登录！");
	history.back(-1);
	//-->
	</SCRIPT>
 <% 
		return;
 }%>

