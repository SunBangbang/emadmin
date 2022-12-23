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
						财务管理
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
      <img src="images/cw.jpg" width="625" height="384" border="0" usemap="#Map" /></td>
  </tr>
</table>
<!-- 内容区 -->
<map name="Map" id="Map">
<% if (Serve.getModulUrlStr(request,"view_kh_da_ysk_listModul").length()>0) {%>
	<area shape="rect" coords="182,308,321,385" href="<%=Serve.getModulUrlStr(request,"view_kh_da_ysk_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"view_cg_cgd_lrfx_qk_listModul").length()>0) {%>
	<area shape="rect" coords="351,309,471,385" href="<%=Serve.getModulUrlStr(request,"view_cg_cgd_lrfx_qk_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"view_xs_xsd_lrfx_qk_listModul").length()>0) {%>
	<area shape="rect" coords="501,307,625,389" href="<%=Serve.getModulUrlStr(request,"view_xs_xsd_lrfx_qk_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_yfkd_listModul").length()>0) {%>
<area shape="rect" coords="493,48,580,139" href="<%=Serve.getModulUrlStr(request,"cg_yfkd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cw_zhxx_listModul").length()>0) {%>
<area shape="rect" coords="274,112,358,204" href="<%=Serve.getModulUrlStr(request,"cw_zhxx_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_fkd_listModul").length()>0) {%>
<area shape="rect" coords="493,156,579,239" href="<%=Serve.getModulUrlStr(request,"cg_fkd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cw_zjzz_listModul").length()>0) {%>
<area shape="rect" coords="340,223,423,302" href="<%=Serve.getModulUrlStr(request,"cw_zjzz_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cw_szjl_addModul").length()>0) {%>
<area shape="rect" coords="193,223,276,302" href="<%=Serve.getModulUrlStr(request,"cw_szjl_addModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"view_gys_da_yfk_listModul").length()>0) {%>
<area shape="rect" coords="8,299,141,386" href="<%=Serve.getModulUrlStr(request,"view_gys_da_yfk_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_yskd_listModul").length()>0) {%>
<area shape="rect" coords="70,59,148,142" href="<%=Serve.getModulUrlStr(request,"xs_yskd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cw_fyd_listModul").length()>0) {%>
<area shape="rect" coords="271,7,351,89" href="<%=Serve.getModulUrlStr(request,"cw_fyd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
<area shape="rect" coords="69,161,148,244" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
<%}%>
</map>
<!-- 内容区 -->
</body>
</html>