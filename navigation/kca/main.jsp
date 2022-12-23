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
      <img src="images/kca_main.jpg" width="531" height="464" border="0" usemap="#Map" /></td>
  </tr>
</table>
<!-- 内容区 -->
<map name="Map" id="Map">
<% if (Serve.getModulUrlStr(request,"cg_cgd_listModul").length()>0) {%>
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_fkd_listModul").length()>0) {%>
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_rkd_listModul").length()>0) {%>
<area shape="rect" coords="96,21,183,112" href="<%=Serve.getModulUrlStr(request,"kc_rkd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_zzd_listModul").length()>0) {%>
<area shape="rect" coords="47,124,133,207" href="<%=Serve.getModulUrlStr(request,"kc_zzd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_cfd_listModul").length()>0) {%>
<area shape="rect" coords="453,125,528,210" href="<%=Serve.getModulUrlStr(request,"kc_cfd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_ckd_listModul").length()>0) {%>
<area shape="rect" coords="380,21,464,113" href="<%=Serve.getModulUrlStr(request,"kc_ckd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"view_kc_scs_listModul").length()>0) {%>
<area shape="rect" coords="232,91,340,191" href="<%=Serve.getModulUrlStr(request,"view_kc_scs_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"jc_YueJie_Modul").length()>0) {%>
<area shape="rect" coords="239,244,337,332" href="<%=Serve.getModulUrlStr(request,"jc_YueJie_Modul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_dbd_listModul").length()>0) {%>
<area shape="rect" coords="92,236,191,333" href="<%=Serve.getModulUrlStr(request,"kc_dbd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_pdd_listModul").length()>0) {%>
<area shape="rect" coords="411,232,502,327" href="<%=Serve.getModulUrlStr(request,"kc_pdd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"view_kc_kcyj_listModul").length()>0) {%>
<area shape="rect" coords="9,369,106,450" href="<%=Serve.getModulUrlStr(request,"view_kc_kcyj_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"view_kc_slhz_listModul").length()>0) {%>
<area shape="rect" coords="168,376,258,454" href="<%=Serve.getModulUrlStr(request,"view_kc_slhz_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"jc_chda_listModul").length()>0) {%>
<area shape="rect" coords="328,369,416,447" href="<%=Serve.getModulUrlStr(request,"jc_chda_listModul")%>">
<%}%>
</map>
<!-- 内容区 -->
</body>
</html>