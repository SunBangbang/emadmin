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
			<td  class='x_import_kh_right'>&nbsp;
				
			</td>
			<!-- 标题区结束 --> 
 	</tr>
</table>
<!-- 内容区 -->
<table  width="100%" height="450"   border="0" cellpadding="0" cellspacing="0" bordercolorlight="#B3C3D0" bordercolordark="#ffffff">
  <tr  align="center" >
    <td align="center" height="450"><img src="images/cw.jpg" width="510" height="370" border="0" usemap="#Map"/>    
    <map name="Map">
    <% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
    	<area shape="rect" coords="5,178,95,265" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
    <%}%>
	<% if (Serve.getModulUrlStr(request,"cw_ysd_listModul").length()>0) {%>
    <area shape="rect" coords="8,81,96,170" href="<%=Serve.getModulUrlStr(request,"cw_ysd_listModul")%>">
     <%}%>
    <% if (Serve.getModulUrlStr(request,"view_xs_xsd_lrfx_qk_listModul").length()>0) {%>
    <area shape="rect" coords="281,281,390,367" href="<%=Serve.getModulUrlStr(request,"view_xs_xsd_lrfx_qk_listModul")%>">
     <%}%>
     <% if (Serve.getModulUrlStr(request,"xs_yskd_listModul").length()>0) {%>
    <area shape="rect" coords="10,8,83,79" href="<%=Serve.getModulUrlStr(request,"xs_yskd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"cw_szjl_addModul").length()>0) {%>
    <area shape="rect" coords="307,188,390,274" href="<%=Serve.getModulUrlStr(request,"cw_szjl_addModul")%>">
     <%}%>
    <% if (Serve.getModulUrlStr(request,"cw_zjzz_listModul").length()>0) {%>
    <area shape="rect" coords="418,185,489,278" href="<%=Serve.getModulUrlStr(request,"cw_zjzz_listModul")%>">
     <%}%>
    <% if (Serve.getModulUrlStr(request,"xs_yskd_listModul").length()>0) {%>
    <%}%>
    <% if (Serve.getModulUrlStr(request,"view_kh_da_ysk_listModul").length()>0) {%>
    <area shape="rect" coords="145,291,267,367" href="<%=Serve.getModulUrlStr(request,"view_kh_da_ysk_listModul")%>">
     <%}%>
    </map>
    
    </td>
  </tr>
</table>

<!-- 内容区 -->

</body>
</html>