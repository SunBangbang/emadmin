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
    <td align="center" height="450"><img src="images/jxcs_main.jpg" width="699" height="300" border="0" usemap="#Map"/>    
    <map name="Map">
    <% if (Serve.getModulUrlStr(request,"cg_cgd_listModul").length()>0) {%>
    	<area shape="rect" coords="12,8,102,95" href="<%=Serve.getModulUrlStr(request,"cg_cgd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"kc_rkd_listModul").length()>0) {%>
   		 <area shape="rect" coords="232,7,321,95" href="<%=Serve.getModulUrlStr(request,"kc_rkd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"cg_fkd_listModul").length()>0) {%>
    	<area shape="rect" coords="123,79,203,163" href="<%=Serve.getModulUrlStr(request,"cg_fkd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"kc_ckd_listModul").length()>0) {%>
        <area shape="rect" coords="393,3,484,101" href="<%=Serve.getModulUrlStr(request,"kc_ckd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
    	<area shape="rect" coords="513,81,597,167" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"kc_dbd_listModul").length()>0) {%>
    	<area shape="rect" coords="195,203,285,297" href="<%=Serve.getModulUrlStr(request,"kc_dbd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"kc_pdd_listModul").length()>0) {%>
    	<area shape="rect" coords="391,218,487,296" href="<%=Serve.getModulUrlStr(request,"kc_pdd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"xs_xsd_listModul").length()>0) {%>
    	<area shape="rect" coords="617,11,695,97" href="<%=Serve.getModulUrlStr(request,"xs_xsd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"kc_kcspz_listModul").length()>0) {%>
    	<area shape="rect" coords="299,111,391,189" href="<%=Serve.getModulUrlStr(request,"kc_kcspz_listModul")%>">
    <%}%>
    </map>
    </td>
  </tr>
</table>

<!-- 内容区 -->

</body>
</html>