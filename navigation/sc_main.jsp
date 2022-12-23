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
						生产管理
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
 	</tr>
</table>
<!-- 内容区 -->
<table  width="100%" height="450"   border="0" cellpadding="0" cellspacing="0" bordercolorlight="#B3C3D0" bordercolordark="#ffffff">
  <tr  align="center" >
    <td align="center" height="450" >
      <img src="images/sc.jpg" width="647" height="311" border="0" usemap="#Map" /></td>
  </tr>
</table>
<!-- 内容区 -->
<map name="Map" id="Map">

<% if (Serve.getModulUrlStr(request,"view_kc_scs_listModul").length()>0) {%>
<area shape="rect" coords="450,124,522,195" href="<%=Serve.getModulUrlStr(request,"kc_ckd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_xsd_listModul").length()>0) {%>
<area shape="rect" coords="207,83,285,152" href="<%=Serve.getModulUrlStr(request,"scan_lld_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_ckd_listModul").length()>0) {%>
<area shape="rect" coords="378,4,458,72" href="<%=Serve.getModulUrlStr(request,"scan_bld_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
<area shape="rect" coords="265,1,346,71" href="<%=Serve.getModulUrlStr(request,"scan_tld_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_yskd_listModul").length()>0) {%>
<area shape="rect" coords="101,83,174,153" href="<%=Serve.getModulUrlStr(request,"scan_sccpdj_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_fp_listModul").length()>0) {%>
<area shape="rect" coords="576,184,644,279" href="<%=Serve.getModulUrlStr(request,"kc_kcspz_listModul")%>">
<%}%>

<% if (Serve.getModulUrlStr(request,"xs_xsd_xs_xsd_m").length()>0) {%>
<area shape="rect" coords="5,8,70,86" href="<%=Serve.getModulUrlStr(request,"scan_wlqd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_xsdd_listModul").length()>0) {%>
<area shape="rect" coords="6,137,85,205" href="<%=Serve.getModulUrlStr(request,"scan_scjh_listModul")%>">
<%}%>

<% if (Serve.getModulUrlStr(request,"xs_fp_listModul").length()>0) {%>
<area shape="rect" coords="450,236,527,306" href="<%=Serve.getModulUrlStr(request,"kc_rkd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_xsdd_listModul").length()>0) {%>
<area shape="rect" coords="270,237,378,304" href="<%=Serve.getModulUrlStr(request,"scan_cpwgdj_listModul")%>">
<%}%>
</map>
<!-- 内容区 -->
</body>
</html>