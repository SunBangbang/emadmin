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
						采购管理
					</span>
			</td>
			<td  class='x_import_kh_right'>&nbsp;
				
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
<table  width="101%" height="450"   border="0" cellpadding="0" cellspacing="0" bordercolorlight="#B3C3D0" bordercolordark="#ffffff">
  <tr  align="center" >
    <td align="center" height="450">
      <img src="images/cg_main.jpg" width="606" height="373" border="0" usemap="#Map" /></td>
  </tr>
</table>
<!-- 内容区 -->
<map name="Map" id="Map">


<% if (Serve.getModulUrlStr(request,"kc_rkd_listModul").length()>0) {%>
<area shape="rect" coords="359,59,451,136" href="<%=Serve.getModulUrlStr(request,"kc_rkd_listModul")%>">
<%}%>

<% if (Serve.getModulUrlStr(request,"cg_cgdd_listModul").length()>0) {%>
<area shape="rect" coords="104,1,197,87" href="<%=Serve.getModulUrlStr(request,"cg_cgdd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_fkd_listModul").length()>0) {%>
<area shape="rect" coords="152,156,239,231" href="<%=Serve.getModulUrlStr(request,"cg_fkd_listModul")%>">
<%}%>

<% if (Serve.getModulUrlStr(request,"cg_qgd_listModul").length()>0) {%>
<area shape="rect" coords="4,7,95,84" href="<%=Serve.getModulUrlStr(request,"cg_qgd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_dbd_listModul").length()>0) {%>
	<area shape="rect" coords="324,265,409,346" href="<%=Serve.getModulUrlStr(request,"kc_dbd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"jc_YueJie_Modul").length()>0) {%>
<area shape="rect" coords="419,283,504,367" href="<%=Serve.getModulUrlStr(request,"jc_YueJie_Modul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_pdd_listModul").length()>0) {%>
<area shape="rect" coords="520,264,602,349" href="<%=Serve.getModulUrlStr(request,"kc_pdd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_cgd_listModul").length()>0) {%>
<area shape="rect" coords="212,2,297,88" href="<%=Serve.getModulUrlStr(request,"cg_cgd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"kc_kcspz_listModul").length()>0) {%>
<area shape="rect" coords="421,156,510,232" href="<%=Serve.getModulUrlStr(request,"kc_kcspz_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cg_fp_listModul").length()>0) {%>
<area shape="rect" coords="267,152,342,228" href="<%=Serve.getModulUrlStr(request,"cg_fp_listModul")%>">
<%}%>
</map>
<!-- 内容区 -->
</body>
</html>