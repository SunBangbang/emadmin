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
    <td align="center" height="450"><img src="images/cw.jpg" width="625" height="384" border="0" usemap="#Map"/>    
    <map name="Map">
    <% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
    	<area shape="rect" coords="58,9,148,96" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
    <%}%>
<% if (Serve.getModulUrlStr(request,"cw_fyd_listModul").length()>0) {%>
   		 <area shape="rect" coords="458,9,547,97" href="<%=Serve.getModulUrlStr(request,"cw_fyd_listModul")%>">
    <%}%>
  
    <% if (Serve.getModulUrlStr(request,"view_xs_xsd_lrfx_qk_listModul").length()>0) {%>
        <area shape="rect" coords="368,261,474,357" href="<%=Serve.getModulUrlStr(request,"view_xs_xsd_lrfx_qk_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
    	<area shape="rect" coords="141,388,225,474" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"cw_ysd_listModul").length()>0) {%>
    	<area shape="rect" coords="67,152,145,238" href="<%=Serve.getModulUrlStr(request,"cw_ysd_listModul")%>">
    <%}%>
     <% if (Serve.getModulUrlStr(request,"cg_fkd_listModul").length()>0) {%>
    	<area shape="rect" coords="267,14,367,102" href="<%=Serve.getModulUrlStr(request,"cg_fkd_listModul")%>">
     <%}%>
     <% if (Serve.getModulUrlStr(request,"cw_yfd_listModul").length()>0) {%>
    	<area shape="rect" coords="271,142,355,232" href="<%=Serve.getModulUrlStr(request,"cw_yfd_listModul")%>">
     <%}%>
     <% if (Serve.getModulUrlStr(request,"view_cg_cgd_lrfx_qk_listModul").length()>0) {%>
    	<area shape="rect" coords="149,261,251,350" href="<%=Serve.getModulUrlStr(request,"view_cg_cgd_lrfx_qk_listModul")%>">
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