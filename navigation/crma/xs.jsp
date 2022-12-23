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
    <td align="center" height="450"><img src="images/xs.jpg" width="452" height="207" border="0" usemap="#Map"/>    
    <map name="Map">
    <% if (Serve.getModulUrlStr(request,"xs_xsdd_listModul").length()>0) {%>
    	<area shape="rect" coords="22,44,112,131" href="<%=Serve.getModulUrlStr(request,"xs_xsdd_listModul")%>">
    <%}%>
   <% if (Serve.getModulUrlStr(request,"xs_xsd_listModul").length()>0) {%>
    <area shape="rect" coords="174,44,265,137" href="<%=Serve.getModulUrlStr(request,"xs_xsd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
    <area shape="rect" coords="343,46,421,129" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
    <%}%></map>
    
    </td>
  </tr>
</table>

<!-- 内容区 -->

</body>
</html>