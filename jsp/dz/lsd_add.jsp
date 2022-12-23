<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

	String id = "";
	String result[] = new String [2];
    if( !Serve.checkMkQx( request ) )	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}
%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
   //设置网页打印的页眉页脚为空 

		function _after_load() {
			var height=window.screen.availHeight-10
			var width=document.body.clientWidth+10;
			showModelessDialog('/emadmin/jsp/dz/lsd_add_add.jsp?modul_id=xs_lsd_add_Modul', '',"resizable:Yes;status:no;dialogHeight:"+height+";dialogWidth:"+width+";scroll:no");}
 	
   //-->
</SCRIPT>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META name=save content=history >
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>

<body onLoad="_after_load();">
	<br><br><br><br><br><br><br><br><br><br>
	<div align="center"><font size="7px;"><strong>欢迎使用零售系统！<strong></font></div>
</body>
</html>