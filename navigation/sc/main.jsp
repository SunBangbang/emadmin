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
			<td  class='x_import_kh_right'>&nbsp;
				
			</td>
			<!-- 标题区结束 --> 
 	</tr>
</table>
<!-- 内容区 -->
<table  width="100%" height="450"   border="0" cellpadding="0" cellspacing="0" bordercolorlight="#B3C3D0" bordercolordark="#ffffff">
  <tr  align="center" >
    <td align="center" height="450" >
      <img src="images/sc.jpg" width="773" height="407" border="0" usemap="#Map" /></td>
  </tr>
</table>
<!-- 内容区 --><!-- 内容区 -->

<map name="Map">
<% if (Serve.getModulUrlStr(request,"xs_xsdd_listModul").length()>0) {%>
<area shape="rect" coords="5,45,156,106" href="<%=Serve.getModulUrlStr(request,"xs_xsdd_listModul")%>">
  <%}%>
<% if (Serve.getModulUrlStr(request,"cg_qgd_listModul").length()>0) {%>
<%}%>
<% if (Serve.getModulUrlStr(request,"scan_wlqd_listModul").length()>0) {%>
<area shape="rect" coords="147,159,233,231" href="<%=Serve.getModulUrlStr(request,"scan_wlqd_listModul")%>">
  <%}%>
<% if (Serve.getModulUrlStr(request,"scan_sccpdj_listModul").length()>0) {%>
<area shape="rect" coords="278,158,368,224" href="<%=Serve.getModulUrlStr(request,"scan_sccpdj_listModul")%>">
  <%}%>
<% if (Serve.getModulUrlStr(request,"cg_qgd_listModul").length()>0) {%>
<area shape="rect" coords="390,37,529,111" href="<%=Serve.getModulUrlStr(request,"cg_qgd_listModul")%>">
  <%}%>
<% if (Serve.getModulUrlStr(request,"view_scan_wlmain_listModul").length()>0) {%>
<area shape="rect" coords="391,145,503,224" href="<%=Serve.getModulUrlStr(request,"view_scan_wlmain_listModul")%>">
  <%}%>
<% if (Serve.getModulUrlStr(request,"scan_lld_listModul").length()>0) {%>
<area shape="rect" coords="555,143,621,218" href="<%=Serve.getModulUrlStr(request,"scan_lld_listModul")%>">
  <%}%>
<% if (Serve.getModulUrlStr(request,"scan_bld_listModul").length()>0) {%>
<area shape="rect" coords="614,70,699,129" href="<%=Serve.getModulUrlStr(request,"scan_bld_listModul")%>">
  <%}%>
<% if (Serve.getModulUrlStr(request,"scan_cpwgdj_listModul").length()>0) {%>
<area shape="rect" coords="700,151,766,219" href="<%=Serve.getModulUrlStr(request,"scan_cpwgdj_listModul")%>">
  <%}%>
<% if (Serve.getModulUrlStr(request,"scan_tld_listModul").length()>0) {%>
<area shape="rect" coords="613,241,704,319" href="<%=Serve.getModulUrlStr(request,"scan_tld_listModul")%>">
  <%}%>
<% if (Serve.getModulUrlStr(request,"scan_scjld_listModul").length()>0) {%>
<area shape="rect" coords="374,280,472,357" href="<%=Serve.getModulUrlStr(request,"scan_scjld_listModul")%>">
  <%}%>
<% if (Serve.getModulUrlStr(request,"scan_scjh_listModul").length()>0) {%>
<area shape="rect" coords="178,278,273,355" href="<%=Serve.getModulUrlStr(request,"scan_scjh_listModul")%>">
  <%}%>
  <% if (Serve.getModulUrlStr(request,"view_scan_scxqb_listModul").length()>0) {%>
  <area shape="rect" coords="8,159,109,238" href="<%=Serve.getModulUrlStr(request,"view_scan_scxqb_listModul")%>"></map>
  <%}%>
</body>
</html>