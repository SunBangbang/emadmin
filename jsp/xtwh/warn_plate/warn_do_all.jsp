<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/emadmin/shared/checkAdminPermission.jsp"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%
	//执行全部

	Serve.doAllDsWarn();
	response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功 ！","UTF-8"));

		 
%>
