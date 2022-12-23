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
						采购管理
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
    <td align="center" height="450"><img src="images/cg.jpg" width="531" height="222" border="0" usemap="#Map"/>
      <map name="Map">
        <% if (Serve.getModulUrlStr(request,"cg_cgd_listModul").length()>0) {%>
        <area shape="rect" coords="195,61,285,148" href="<%=Serve.getModulUrlStr(request,"cg_cgd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cg_fkd_listModul").length()>0) {%>
        <area shape="rect" coords="275,147,365,217" href="<%=Serve.getModulUrlStr(request,"cg_fkd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cg_cgd_cg_cgd_m").length()>0) {%>
        <area shape="rect" coords="299,3,410,88" href="<%=Serve.getModulUrlStr(request,"cg_cgd_cg_cgd_m")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"kc_rkd_listModul").length()>0) {%>
        <area shape="rect" coords="442,59,528,155" href="<%=Serve.getModulUrlStr(request,"kc_rkd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cg_qgd_listModul").length()>0) {%>
        <area shape="rect" coords="2,72,74,164" href="<%=Serve.getModulUrlStr(request,"cg_qgd_listModul")%>">
        <%}%>  
        <% if (Serve.getModulUrlStr(request,"cg_cgdd_listModul").length()>0) {%>
      		<area shape="rect" coords="111,75,181,162" href="<%=Serve.getModulUrlStr(request,"cg_cgdd_listModul")%>">
        <%}%>
<% if (Serve.getModulUrlStr(request,"cg_fp_listModul").length()>0) {%>
        	<area shape="rect" coords="373,144,439,217" href="<%=Serve.getModulUrlStr(request,"cg_fp_listModul")%>">
        <%}%>  
      </map>
 
   </td>
  </tr>
</table>

<!-- 内容区 -->

</body>
</html>