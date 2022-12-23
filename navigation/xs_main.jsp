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
      <img src="images/xs_main.jpg" width="635" height="378" border="0" usemap="#Map" /></td>
  </tr>
</table>
<!-- 内容区 -->
<map name="Map" id="Map">

<% if (Serve.getModulUrlStr(request,"view_kc_scs_listModul").length()>0) {%>
<area shape="rect" coords="455,157,543,242" href="<%=Serve.getModulUrlStr(request,"view_kc_scs_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_xsd_listModul").length()>0) {%>
<area shape="rect" coords="105,70,178,145" href="<%=Serve.getModulUrlStr(request,"xs_xsd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_ckd_listModul").length()>0) {%>
<area shape="rect" coords="394,73,481,158" href="<%=Serve.getModulUrlStr(request,"kc_ckd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
<area shape="rect" coords="190,138,275,221" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_xsd_xs_xsd_m").length()>0) {%>
<area shape="rect" coords="206,2,294,88" href="<%=Serve.getModulUrlStr(request,"xs_xsd_xs_xsd_m")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_fp_listModul").length()>0) {%>
<area shape="rect" coords="303,2,394,89" href="<%=Serve.getModulUrlStr(request,"xs_fp_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"xs_xsdd_listModul").length()>0) {%>
<area shape="rect" coords="6,69,88,149" href="<%=Serve.getModulUrlStr(request,"xs_xsdd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_dbd_listModul").length()>0) {%>
<area shape="rect" coords="358,280,436,365" href="<%=Serve.getModulUrlStr(request,"kc_dbd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"jc_YueJie_Modul").length()>0) {%>
<area shape="rect" coords="462,281,538,362" href="<%=Serve.getModulUrlStr(request,"jc_YueJie_Modul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_pdd_listModul").length()>0) {%>
<area shape="rect" coords="563,279,641,361" href="<%=Serve.getModulUrlStr(request,"kc_pdd_listModul")%>">
<%}%>

</map>
<!-- 内容区 -->
</body>
</html>