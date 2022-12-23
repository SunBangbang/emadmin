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
						采购管理
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
    <td align="center" height="450">
      <img src="images/cg_cw.jpg" width="484" height="245" border="0" usemap="#Map" /></td>
  </tr>
</table>
<!-- 内容区 -->
<map name="Map" id="Map">
<% if (Serve.getModulUrlStr(request,"view_kh_da_ysk_listModul").length()>0) {%>
<%}%>
<% if (Serve.getModulUrlStr(request,"view_cg_cgd_lrfx_qk_listModul").length()>0) {%>
	<area shape="rect" coords="350,168,470,244" href="<%=Serve.getModulUrlStr(request,"view_cg_cgd_lrfx_qk_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"view_xs_xsd_lrfx_qk_listModul").length()>0) {%>
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_yfkd_listModul").length()>0) {%>
<%}%>
<% if (Serve.getModulUrlStr(request,"cw_zhxx_listModul").length()>0) {%>
<area shape="rect" coords="56,24,140,116" href="<%=Serve.getModulUrlStr(request,"cw_zhxx_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_fkd_listModul").length()>0) {%>
<area shape="rect" coords="368,23,454,106" href="<%=Serve.getModulUrlStr(request,"cg_fkd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cw_zjzz_listModul").length()>0) {%>
<area shape="rect" coords="117,145,200,224" href="<%=Serve.getModulUrlStr(request,"cw_zjzz_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cw_szjl_addModul").length()>0) {%>
<area shape="rect" coords="7,143,90,222" href="<%=Serve.getModulUrlStr(request,"cw_szjl_addModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"view_gys_da_yfk_listModul").length()>0) {%>
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_yskd_listModul").length()>0) {%>
<%}%>
<% if (Serve.getModulUrlStr(request,"cw_fyd_listModul").length()>0) {%>
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
<%}%>
</map>
<!-- 内容区 -->
</body>
</html>