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
						销售管理
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
      <img src="images/xs_main.gif" width="606" height="371" border="0" usemap="#Map" /></td>
  </tr>
</table>
<!-- 内容区 -->
<map name="Map" id="Map">


<% if (Serve.getModulUrlStr(request,"xs_xsd_listModul").length()>0) {%>
<area shape="rect" coords="46,205,129,281" href="<%=Serve.getModulUrlStr(request,"xs_xsd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_ckd_listModul").length()>0) {%>
<area shape="rect" coords="414,147,501,232" href="<%=Serve.getModulUrlStr(request,"kc_ckd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
<area shape="rect" coords="519,276,604,359" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_xsd_xs_xsd_m").length()>0) {%>
<area shape="rect" coords="254,16,342,102" href="<%=Serve.getModulUrlStr(request,"xs_xsd_xs_xsd_m")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_fp_listModul").length()>0) {%>
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_xsdd_listModul").length()>0) {%>
<area shape="rect" coords="38,80,120,160" href="<%=Serve.getModulUrlStr(request,"xs_xsdd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cw_ysd_listModul").length()>0) {%>
<area shape="rect" coords="396,272,490,358" href="<%=Serve.getModulUrlStr(request,"cw_ysd_listModul")%>">
<%}%>
</map>
<!-- 内容区 -->
</body>
</html>