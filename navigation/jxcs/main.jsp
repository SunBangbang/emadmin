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
						进销存管理
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
    <td align="center" height="450"><img src="images/jxcs_main.jpg" width="684" height="476" border="0" usemap="#Map"/>    
    <map name="Map">
    <% if (Serve.getModulUrlStr(request,"cg_cgd_listModul").length()>0) {%>
    	<area shape="rect" coords="24,73,114,160" href="<%=Serve.getModulUrlStr(request,"cg_cgd_listModul")%>">
    <%}%>
<% if (Serve.getModulUrlStr(request,"kc_rkd_listModul").length()>0) {%>
   		 <area shape="rect" coords="423,78,512,166" href="<%=Serve.getModulUrlStr(request,"kc_rkd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"cg_fkd_listModul").length()>0) {%>
    	<area shape="rect" coords="177,132,257,216" href="<%=Serve.getModulUrlStr(request,"cg_fkd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"kc_ckd_listModul").length()>0) {%>
        <area shape="rect" coords="424,324,515,422" href="<%=Serve.getModulUrlStr(request,"kc_ckd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
    	<area shape="rect" coords="141,388,225,474" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"kc_dbd_listModul").length()>0) {%>
    	<area shape="rect" coords="592,110,682,204" href="<%=Serve.getModulUrlStr(request,"kc_dbd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"kc_pdd_listModul").length()>0) {%>
    	<area shape="rect" coords="586,296,682,374" href="<%=Serve.getModulUrlStr(request,"kc_pdd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"xs_xsd_listModul").length()>0) {%>
    	<area shape="rect" coords="3,317,81,403" href="<%=Serve.getModulUrlStr(request,"xs_xsd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"kc_kcspz_listModul").length()>0) {%>
    	<area shape="rect" coords="493,204,585,282" href="<%=Serve.getModulUrlStr(request,"kc_kcspz_listModul")%>">
    <%}%>
     <% if (Serve.getModulUrlStr(request,"cg_cgd_cg_cgd_m").length()>0) {%>
    	<area shape="rect" coords="219,6,319,94" href="<%=Serve.getModulUrlStr(request,"cg_cgd_cg_cgd_m")%>">
     <%}%>
     <% if (Serve.getModulUrlStr(request,"cw_yfd_listModul").length()>0) {%>
    	<area shape="rect" coords="279,129,363,219" href="<%=Serve.getModulUrlStr(request,"cw_yfd_listModul")%>">
     <%}%>
     <% if (Serve.getModulUrlStr(request,"jc_YueJie_Modul").length()>0) {%>
    	<area shape="rect" coords="610,207,682,282" href="<%=Serve.getModulUrlStr(request,"jc_YueJie_Modul")%>">
     <%}%>
     <% if (Serve.getModulUrlStr(request,"xs_xsd_xs_xsd_m").length()>0) {%>
    	<area shape="rect" coords="201,259,298,342" href="<%=Serve.getModulUrlStr(request,"xs_xsd_xs_xsd_m")%>">
     <%}%>
     <% if (Serve.getModulUrlStr(request,"cw_ysd_listModul").length()>0) {%>
    	<area shape="rect" coords="295,393,388,473" href="<%=Serve.getModulUrlStr(request,"cw_ysd_listModul")%>">
     <%}%>
    </map>
    </td>
  </tr>
</table>

<!-- 内容区 -->

</body>
</html>