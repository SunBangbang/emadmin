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
<!-- 内容区 -->
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						采购管理
					</span>
			</td>
			<td  class='x_import_kh_right'>&nbsp;
				
			</td>
			<!-- 标题区结束 --> 
		  </tr>
</table>
<table  width="101%" height="450"   border="0" cellpadding="0" cellspacing="0" bordercolorlight="#B3C3D0" bordercolordark="#ffffff">
  <tr  align="center" >
    <td align="center" height="450">
      <img src="images/cg_main.jpg" width="606" height="373" border="0" usemap="#Map" /></td>
  </tr>
</table>
<!-- 内容区 -->
<map name="Map" id="Map">


<% if (Serve.getModulUrlStr(request,"kc_rkd_listModul").length()>0) {%>
<area shape="rect" coords="338,163,430,240" href="<%=Serve.getModulUrlStr(request,"kc_rkd_listModul")%>">
<%}%>

<% if (Serve.getModulUrlStr(request,"cg_cgdd_listModul").length()>0) {%>
<area shape="rect" coords="11,113,104,199" href="<%=Serve.getModulUrlStr(request,"cg_cgdd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_fkd_listModul").length()>0) {%>
<area shape="rect" coords="469,283,556,358" href="<%=Serve.getModulUrlStr(request,"cg_fkd_listModul")%>">
<%}%>

<% if (Serve.getModulUrlStr(request,"cg_qgd_listModul").length()>0) {%>
<area shape="rect" coords="4,7,95,84" href="<%=Serve.getModulUrlStr(request,"cg_qgd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_dbd_listModul").length()>0) {%>
<%}%>
<% if (Serve.getModulUrlStr(request,"jc_YueJie_Modul").length()>0) {%>
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_pdd_listModul").length()>0) {%>
<%}%>
<% if (Serve.getModulUrlStr(request,"cw_yfd_listModul").length()>0) {%>
<area shape="rect" coords="342,276,416,355" href="<%=Serve.getModulUrlStr(request,"cw_yfd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_cgd_cg_cgd_m").length()>0) {%>
<area shape="rect" coords="217,57,289,125" href="<%=Serve.getModulUrlStr(request,"cg_cgd_cg_cgd_m")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_cgd_listModul").length()>0) {%>
<area shape="rect" coords="8,223,93,309" href="<%=Serve.getModulUrlStr(request,"cg_cgd_listModul")%>">
<%}%>
</map>
<!-- 内容区 -->
</body>
</html>