<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*"%>
<%@include file="/emadmin/open_start_window.jsp"%>
<%
				response.setHeader("Pragma","No-cache"); 
                response.setHeader("Cache-Control","no-cache"); 
                response.setDateHeader("Expires", 0); 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<link rel="stylesheet" href="/emadmin/css/c1/style_new.css">
<style type="text/css">
<!--
body {padding:0px;margin:0px;}
-->
</style>

</head>
<body>
<table width="100%"  border="0" cellpadding="0" cellspacing="0">
	<tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						库存管理
					</span>
			</td>
			<td  class='x_import_kh_right'>&nbsp;
				
			</td>
			<!-- 标题区结束 --> 
 	</tr>
</table>
<!-- 内容区 -->
<table  width="100%" height="450"   border="0" cellpadding="0" cellspacing="0" bordercolorlight="#B3C3D0" bordercolordark="#ffffff">
  <tr  align="center" >
    <td align="center" height="450">
      <img src="images/kcs_main.jpg" width="434" height="209" border="0" usemap="#Map" /></td>
  </tr>
</table>
<!-- 内容区 -->
<map name="Map" id="Map">

<% if (Serve.getModulUrlStr(request,"kc_rkd_listModul").length()>0) {%>
<area shape="rect" coords="17,27,104,118" href="<%=Serve.getModulUrlStr(request,"kc_rkd_listModul")%>">
<%}%>

<% if (Serve.getModulUrlStr(request,"kc_ckd_listModul").length()>0) {%>
<area shape="rect" coords="350,33,450,120" href="<%=Serve.getModulUrlStr(request,"kc_ckd_listModul")%>">
<%}%>

<% if (Serve.getModulUrlStr(request,"kc_kcspz_listModul").length()>0) {%>
<area shape="rect" coords="174,133,282,233" href="<%=Serve.getModulUrlStr(request,"kc_kcspz_listModul")%>">
<%}%>

</map>
<!-- 内容区 -->
</body>
</html>