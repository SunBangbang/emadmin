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
						客户关系管理
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
 	</tr>
</table>
<table  width="100%" height="450"   border="0" cellpadding="0" cellspacing="0" bordercolorlight="#B3C3D0" bordercolordark="#ffffff">
  <tr  align="center" >
    <td align="center" height="450" > 
      <img src="images/crmf.jpg" width="621" height="327" border="0" usemap="#Map" /></td>
  </tr>
</table>
<!-- 内容区 -->
<map name="Map" id="Map">

<% if (Serve.getModulUrlStr(request,"fw_ht_listModul").length()>0) {%>
<area shape="rect" coords="527,7,618,96" href="<%=Serve.getModulUrlStr(request,"fw_ht_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kh_da_lxjl_listModul").length()>0) {%>
<area shape="rect" coords="5,111,176,200" href="<%=Serve.getModulUrlStr(request,"kh_da_lxjl_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kh_zskh_lxjl_listModul").length()>0) {%>
<area shape="rect" coords="235,114,416,206" href="<%=Serve.getModulUrlStr(request,"kh_zskh_lxjl_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"fw_shfw_listModul").length()>0) {%>
<area shape="rect" coords="271,229,383,323" href="<%=Serve.getModulUrlStr(request,"fw_shfw_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kh_all_wlx_listModul").length()>0) {%>
<area shape="rect" coords="72,231,215,328" href="<%=Serve.getModulUrlStr(request,"kh_all_wlx_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"fw_ht_gzjl_listModul").length()>0) {%>
<area shape="rect" coords="528,109,619,202" href="<%=Serve.getModulUrlStr(request,"fw_ht_gzjl_listModul")%>">
<%}%>

<% if (Serve.getModulUrlStr(request,"kh_da_listModul").length()>0) {%>
<area shape="rect" coords="242,7,419,94" href="<%=Serve.getModulUrlStr(request,"kh_da_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kh_yxkh_listModul").length()>0) {%>
<area shape="rect" coords="14,7,187,95" href="<%=Serve.getModulUrlStr(request,"kh_yxkh_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"oa_rw_listModul").length()>0) {%>
<area shape="rect" coords="460,227,573,319" href="<%=Serve.getModulUrlStr(request,"oa_rw_listModul")%>">
<%}%>

</map>
<!-- 内容区 -->
</body>
</html>