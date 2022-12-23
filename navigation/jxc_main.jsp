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
						进销存管理
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
      <img src="images/jxc_main.jpg" width="710" height="474" border="0" usemap="#Map" /></td>
  </tr>
</table>

<!-- 内容区 -->

<map name="Map" id="Map">
<% if (Serve.getModulUrlStr(request,"cg_qgd_listModul").length()>0) {%>
	<area shape="rect" coords="2,62,90,143" href="<%=Serve.getModulUrlStr(request,"cg_qgd_listModul")%>" />
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
	<area shape="rect" coords="277,388,358,466" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_cgdd_listModul").length()>0) {%>
  <area shape="rect" coords="109,59,196,150" href="<%=Serve.getModulUrlStr(request,"cg_cgdd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_rkd_listModul").length()>0) {%>
	<area shape="rect" coords="444,53,528,145" href="<%=Serve.getModulUrlStr(request,"kc_rkd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_fkd_listModul").length()>0) {%>
	<area shape="rect" coords="269,146,365,230" href="<%=Serve.getModulUrlStr(request,"cg_fkd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_xsd_xs_xsd_m").length()>0) {%>
	<area shape="rect" coords="311,249,409,337" href="<%=Serve.getModulUrlStr(request,"xs_xsd_xs_xsd_m")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_xsdd_listModul").length()>0) {%>
	<area shape="rect" coords="88,320,182,409" href="<%=Serve.getModulUrlStr(request,"xs_xsdd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_ckd_listModul").length()>0) {%>
	<area shape="rect" coords="448,317,534,398" href="<%=Serve.getModulUrlStr(request,"kc_ckd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_cgd_cg_cgd_m").length()>0) {%>
	<area shape="rect" coords="311,6,389,89" href="<%=Serve.getModulUrlStr(request,"cg_cgd_cg_cgd_m")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_dbd_listModul").length()>0) {%>
	<area shape="rect" coords="625,100,705,182" href="<%=Serve.getModulUrlStr(request,"kc_dbd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_kcspz_listModul").length()>0) {%>
	<area shape="rect" coords="505,191,609,273" href="<%=Serve.getModulUrlStr(request,"kc_kcspz_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"jc_YueJie_Modul").length()>0) {%>
	<area shape="rect" coords="632,190,704,264" href="<%=Serve.getModulUrlStr(request,"jc_YueJie_Modul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_xsd_listModul").length()>0) {%>
	<area shape="rect" coords="212,321,277,408" href="<%=Serve.getModulUrlStr(request,"xs_xsd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_fp_listModul").length()>0) {%>
	<area shape="rect" coords="375,396,449,473" href="<%=Serve.getModulUrlStr(request,"xs_fp_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_pdd_listModul").length()>0) {%>
	<area shape="rect" coords="629,281,710,367" href="<%=Serve.getModulUrlStr(request,"kc_pdd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_fp_listModul").length()>0) {%>
	<area shape="rect" coords="371,149,458,229" href="<%=Serve.getModulUrlStr(request,"cg_fp_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_cgd_listModul").length()>0) {%>
  <area shape="rect" coords="213,58,279,144" href="<%=Serve.getModulUrlStr(request,"cg_cgd_listModul")%>">
<%}%>

</map>
<!-- 内容区 -->
</body>
</html>