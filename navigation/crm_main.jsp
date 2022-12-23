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
						客户关系管理
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
      <img src="images/crm.jpg" width="621" height="327" border="0" usemap="#Map" /></td>
  </tr>
</table>
<!-- 内容区 -->
<map name="Map" id="Map">

<% if (Serve.getModulUrlStr(request,"xs_xsd_listModul").length()>0) {%>
<area shape="rect" coords="521,7,612,96" href="<%=Serve.getModulUrlStr(request,"xs_xsd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kh_da_lxjl_listModul").length()>0) {%>
<area shape="rect" coords="9,118,180,207" href="<%=Serve.getModulUrlStr(request,"kh_da_lxjl_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kh_zskh_lxjl_listModul").length()>0) {%>
<area shape="rect" coords="246,108,427,200" href="<%=Serve.getModulUrlStr(request,"kh_zskh_lxjl_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"fw_shfw_listModul").length()>0) {%>
<area shape="rect" coords="274,230,386,324" href="<%=Serve.getModulUrlStr(request,"fw_shfw_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kh_all_wlx_listModul").length()>0) {%>
<area shape="rect" coords="73,228,216,325" href="<%=Serve.getModulUrlStr(request,"kh_all_wlx_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
<area shape="rect" coords="526,112,617,205" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
<%}%>

<% if (Serve.getModulUrlStr(request,"kh_da_listModul").length()>0) {%>
<area shape="rect" coords="251,7,428,94" href="<%=Serve.getModulUrlStr(request,"kh_da_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kh_yxkh_listModul").length()>0) {%>
<area shape="rect" coords="14,7,187,95" href="<%=Serve.getModulUrlStr(request,"kh_yxkh_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"oa_rw_listModul").length()>0) {%>
<area shape="rect" coords="465,230,578,322" href="<%=Serve.getModulUrlStr(request,"oa_rw_listModul")%>">
<%}%>

</map>
<!-- 内容区 -->
</body>
</html>