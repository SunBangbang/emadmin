<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*"%>
<html>
<head>
<title>预设/发送消息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/emadmin/css/c1/style_new.css">
<%@include file="/emadmin/js/functions.jsp"%>
<%@ include file="/emadmin/shared/checkPermission1.jsp"%>
<script language=javascript src="/emadmin/js/do_check.js"></script>
<script language=javascript src="/emadmin/js/pop_selections.js"></script>
<script language=javascript src="/emadmin/js/pop_upload.js"></script>
</head>
<% 
	String[] result_dm=null; 
	String[] result_dep=Server.getOptionList("000",request); 
	String[] result_user=Server.getOptionList("have_qx_yh",request);
	String[] result_qxz=Server.getOptionList("101",request);
	String alert_time1="";
	String alert_time2="";
%>
<body>
	<table width="100%" border ="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				&nbsp;
			</td>
		</tr>
	</table>
</body>

</html>