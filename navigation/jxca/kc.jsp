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
						库存管理
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
    	<area shape="rect" coords="104,27,194,114" href="<%=Serve.getModulUrlStr(request,"kc_rkd_listModul")%>">
    <%}%>
<% if (Serve.getModulUrlStr(request,"kc_pdd_listModul").length()>0) {%>
   		 <area shape="rect" coords="405,235,494,323" href="<%=Serve.getModulUrlStr(request,"kc_pdd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"kc_dbd_listModul").length()>0) {%>
    	<area shape="rect" coords="94,241,174,325" href="<%=Serve.getModulUrlStr(request,"kc_dbd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"jc_chda_listModul").length()>0) {%>
        <area shape="rect" coords="316,368,404,455" href="<%=Serve.getModulUrlStr(request,"jc_chda_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"kc_zzd_listModul").length()>0) {%>
    	<area shape="rect" coords="42,118,126,204" href="<%=Serve.getModulUrlStr(request,"kc_zzd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"view_kc_kcyj_listModul").length()>0) {%>
    	<area shape="rect" coords="8,367,86,453" href="<%=Serve.getModulUrlStr(request,"view_kc_kcyj_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"kc_cfd_listModul").length()>0) {%>
    	<area shape="rect" coords="437,125,529,203" href="<%=Serve.getModulUrlStr(request,"kc_cfd_listModul")%>">
    <%}%>
     <% if (Serve.getModulUrlStr(request,"view_kc_scs_listModul").length()>0) {%>
    	<area shape="rect" coords="237,102,337,190" href="<%=Serve.getModulUrlStr(request,"view_kc_scs_listModul")%>">
     <%}%>
     <% if (Serve.getModulUrlStr(request,"jc_YueJie_Modul").length()>0) {%>
    	<area shape="rect" coords="246,252,330,342" href="<%=Serve.getModulUrlStr(request,"jc_YueJie_Modul")%>">
     <%}%>
     <% if (Serve.getModulUrlStr(request,"kc_kcspz_listModul").length()>0) {%>
    	<area shape="rect" coords="157,373,254,456" href="<%=Serve.getModulUrlStr(request,"kc_kcspz_listModul")%>">
     <%}%>  
     <% if (Serve.getModulUrlStr(request,"kc_ckd_listModul").length()>0) {%>
    	<area shape="rect" coords="373,27,469,112" href="<%=Serve.getModulUrlStr(request,"kc_ckd_listModul")%>">
     <%}%>
    </map>
    </td>
  </tr>
</table>

<!-- 内容区 -->

</body>
</html>