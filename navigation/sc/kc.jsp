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
    <td align="center" height="450"><img src="images/kc.jpg" width="531" height="464" border="0" usemap="#Map"/>    
    <map name="Map">
    <% if (Serve.getModulUrlStr(request,"kc_rkd_listModul").length()>0) {%>
    	<area shape="rect" coords="110,28,200,115" href="<%=Serve.getModulUrlStr(request,"kc_rkd_listModul")%>">
    <%}%>
<% if (Serve.getModulUrlStr(request,"kc_pdd_listModul").length()>0) {%>
   		 <area shape="rect" coords="408,239,497,327" href="<%=Serve.getModulUrlStr(request,"kc_pdd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"kc_dbd_listModul").length()>0) {%>
    	<area shape="rect" coords="96,238,176,322" href="<%=Serve.getModulUrlStr(request,"kc_dbd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"jc_chda_listModul").length()>0) {%>
        <area shape="rect" coords="317,365,405,452" href="<%=Serve.getModulUrlStr(request,"jc_chda_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"kc_zzd_listModul").length()>0) {%>
    	<area shape="rect" coords="38,126,122,212" href="<%=Serve.getModulUrlStr(request,"kc_zzd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"view_kc_kcyj_listModul").length()>0) {%>
    	<area shape="rect" coords="12,368,90,454" href="<%=Serve.getModulUrlStr(request,"view_kc_kcyj_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"kc_cfd_listModul").length()>0) {%>
    	<area shape="rect" coords="435,130,527,208" href="<%=Serve.getModulUrlStr(request,"kc_cfd_listModul")%>">
    <%}%>
     <% if (Serve.getModulUrlStr(request,"view_kc_scs_listModul").length()>0) {%>
    	<area shape="rect" coords="238,96,338,184" href="<%=Serve.getModulUrlStr(request,"view_kc_scs_listModul")%>">
     <%}%>
     <% if (Serve.getModulUrlStr(request,"jc_YueJie_Modul").length()>0) {%>
    	<area shape="rect" coords="248,240,332,330" href="<%=Serve.getModulUrlStr(request,"jc_YueJie_Modul")%>">
     <%}%>
     <% if (Serve.getModulUrlStr(request,"kc_kcspz_listModul").length()>0) {%>
    	<area shape="rect" coords="160,371,257,454" href="<%=Serve.getModulUrlStr(request,"kc_kcspz_listModul")%>">
     <%}%>  
     <% if (Serve.getModulUrlStr(request,"kc_ckd_listModul").length()>0) {%>
    	<area shape="rect" coords="374,29,470,114" href="<%=Serve.getModulUrlStr(request,"kc_ckd_listModul")%>">
     <%}%>
    </map>
    </td>
  </tr>
</table>

<!-- 内容区 -->

</body>
</html>