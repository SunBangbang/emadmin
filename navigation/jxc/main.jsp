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
    <td align="center" height="450"><img src="images/jxc_main.jpg" width="606" height="543" border="0" usemap="#Map" />
      <map name="Map" id="Map">
        <% if (Serve.getModulUrlStr(request,"cg_qgd_listModul").length()>0) {%>
        <area shape="rect" coords="26,1,98,68" href="<%=Serve.getModulUrlStr(request,"cg_qgd_listModul")%>" />
        <%}%>
        <% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
        <area shape="rect" coords="382,373,463,451" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cg_cgdd_listModul").length()>0) {%>
        <area shape="rect" coords="22,84,111,153" href="<%=Serve.getModulUrlStr(request,"cg_cgdd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"kc_rkd_listModul").length()>0) {%>
        <area shape="rect" coords="260,114,344,206" href="<%=Serve.getModulUrlStr(request,"kc_rkd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cg_fkd_listModul").length()>0) {%>
        <area shape="rect" coords="376,244,472,328" href="<%=Serve.getModulUrlStr(request,"cg_fkd_listModul")%>">
        <%}%>
        
        <% if (Serve.getModulUrlStr(request,"xs_xsdd_listModul").length()>0) {%>
        <area shape="rect" coords="9,333,103,409" href="<%=Serve.getModulUrlStr(request,"xs_xsdd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"kc_ckd_listModul").length()>0) {%>
        <area shape="rect" coords="263,463,349,544" href="<%=Serve.getModulUrlStr(request,"kc_ckd_listModul")%>">
        <%}%>
       
        <% if (Serve.getModulUrlStr(request,"kc_dbd_listModul").length()>0) {%>
        <area shape="rect" coords="625,100,705,182" href="<%=Serve.getModulUrlStr(request,"kc_dbd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"kc_kcspz_listModul").length()>0) {%>
        <area shape="rect" coords="489,301,593,383" href="<%=Serve.getModulUrlStr(request,"kc_kcspz_listModul")%>">
        <%}%>
		 <% if (Serve.getModulUrlStr(request,"cw_yfd_listModul").length()>0) {%>
			 <area shape="rect" coords="254,241,344,317" href="<%=Serve.getModulUrlStr(request,"cw_yfd_listModul")%>">
		 <%}%>
        <% if (Serve.getModulUrlStr(request,"jc_YueJie_Modul").length()>0) {%>
        <area shape="rect" coords="632,190,704,264" href="<%=Serve.getModulUrlStr(request,"jc_YueJie_Modul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"xs_xsd_listModul").length()>0) {%>
        <area shape="rect" coords="3,422,91,505" href="<%=Serve.getModulUrlStr(request,"xs_xsd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cw_ysd_listModul").length()>0) {%>
        <area shape="rect" coords="264,377,338,454" href="<%=Serve.getModulUrlStr(request,"cw_ysd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"kc_pdd_listModul").length()>0) {%>
        <area shape="rect" coords="629,281,710,367" href="<%=Serve.getModulUrlStr(request,"kc_pdd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cg_cgd_listModul").length()>0) {%>
        <area shape="rect" coords="9,184,99,268" href="<%=Serve.getModulUrlStr(request,"cg_cgd_listModul")%>">
        <%}%>
    </map></td>
  </tr>
</table>

<!-- 内容区 -->

<map name="Map" id="Map">
<% if (Serve.getModulUrlStr(request,"cg_qgd_listModul").length()>0) {%>
	<area shape="rect" coords="15,-6,103,75" href="<%=Serve.getModulUrlStr(request,"cg_qgd_listModul")%>" />
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
	<area shape="rect" coords="372,374,453,452" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_cgdd_listModul").length()>0) {%>
  <area shape="rect" coords="16,79,103,170" href="<%=Serve.getModulUrlStr(request,"cg_cgdd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_rkd_listModul").length()>0) {%>
	<area shape="rect" coords="260,114,344,206" href="<%=Serve.getModulUrlStr(request,"kc_rkd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_fkd_listModul").length()>0) {%>
	<area shape="rect" coords="373,245,469,329" href="<%=Serve.getModulUrlStr(request,"cg_fkd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_xsd_xs_xsd_m").length()>0) {%>
	<area shape="rect" coords="173,292,271,380" href="<%=Serve.getModulUrlStr(request,"xs_xsd_xs_xsd_m")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_xsdd_listModul").length()>0) {%>
	<area shape="rect" coords="10,319,104,408" href="<%=Serve.getModulUrlStr(request,"xs_xsdd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_ckd_listModul").length()>0) {%>
	<area shape="rect" coords="254,463,340,544" href="<%=Serve.getModulUrlStr(request,"kc_ckd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_cgd_cg_cgd_m").length()>0) {%>
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
	<area shape="rect" coords="4,417,91,503" href="<%=Serve.getModulUrlStr(request,"xs_xsd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_fp_listModul").length()>0) {%>
	<area shape="rect" coords="265,377,339,454" href="<%=Serve.getModulUrlStr(request,"xs_fp_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_pdd_listModul").length()>0) {%>
<area shape="rect" coords="629,281,710,367" href="<%=Serve.getModulUrlStr(request,"kc_pdd_listModul")%>">
<%}%>

<% if (Serve.getModulUrlStr(request,"cg_cgd_listModul").length()>0) {%>
  <area shape="rect" coords="9,184,94,272" href="<%=Serve.getModulUrlStr(request,"cg_cgd_listModul")%>">
<%}%>

</map>
<!-- 内容区 -->
</body>
</html>