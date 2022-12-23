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
        <area shape="rect" coords="63,195,153,282" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cw_fyd_listModul").length()>0) {%>
        <area shape="rect" coords="214,4,303,92" href="<%=Serve.getModulUrlStr(request,"cw_fyd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"xs_yskd_listModul").length()>0) {%>
        <area shape="rect" coords="76,13,149,97" href="<%=Serve.getModulUrlStr(request,"xs_yskd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cw_fyd_listModul").length()>0) {%>
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cw_szjl_listModul").length()>0) {%>
        <area shape="rect" coords="268,110,373,201" href="<%=Serve.getModulUrlStr(request,"cw_szjl_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cg_yfkd_listModul").length()>0) {%>
        <area shape="rect" coords="500,16,594,103" href="<%=Serve.getModulUrlStr(request,"cg_yfkd_listModul")%>">
         <%}%>
        <% if (Serve.getModulUrlStr(request,"cw_szjl_addModul").length()>0) {%>
        <area shape="rect" coords="197,221,284,302" href="<%=Serve.getModulUrlStr(request,"cw_szjl_addModul")%>">
         <%}%>
        <% if (Serve.getModulUrlStr(request,"cw_zjzz_listModul").length()>0) {%>
        <area shape="rect" coords="342,224,438,303" href="<%=Serve.getModulUrlStr(request,"cw_zjzz_listModul")%>">
         <%}%>
        <% if (Serve.getModulUrlStr(request,"view_xs_xsd_lrfx_qk_listModul").length()>0) {%>
        <area shape="rect" coords="505,312,620,382" href="<%=Serve.getModulUrlStr(request,"view_xs_xsd_lrfx_qk_listModul")%>">
         <%}%>
       
        <% if (Serve.getModulUrlStr(request,"view_cg_cgd_lrfx_qk_listModul").length()>0) {%>
        <area shape="rect" coords="350,314,471,382" href="<%=Serve.getModulUrlStr(request,"view_cg_cgd_lrfx_qk_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
        <area shape="rect" coords="141,388,225,474" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cw_ysd_listModul").length()>0) {%>
        <area shape="rect" coords="70,104,148,190" href="<%=Serve.getModulUrlStr(request,"cw_ysd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cg_fkd_listModul").length()>0) {%>
        <area shape="rect" coords="501,201,607,276" href="<%=Serve.getModulUrlStr(request,"cg_fkd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cw_yfd_listModul").length()>0) {%>
        <area shape="rect" coords="506,108,590,198" href="<%=Serve.getModulUrlStr(request,"cw_yfd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"view_kh_da_ysk_listModul").length()>0) {%>
        <area shape="rect" coords="190,313,317,382" href="<%=Serve.getModulUrlStr(request,"view_kh_da_ysk_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"view_gys_da_yfk_listModul").length()>0) {%>
        <area shape="rect" coords="9,308,145,381" href="<%=Serve.getModulUrlStr(request,"view_gys_da_yfk_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cw_ysd_listModul").length()>0) {%>
        <area shape="rect" coords="295,393,388,473" href="<%=Serve.getModulUrlStr(request,"cw_ysd_listModul")%>">
        <%}%>
      </map>
      <map name="Map">
    <% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
    	<area shape="rect" coords="63,194,153,281" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
    <%}%>
<% if (Serve.getModulUrlStr(request,"cw_fyd_listModul").length()>0) {%>
   		 <area shape="rect" coords="214,4,303,92" href="<%=Serve.getModulUrlStr(request,"cw_fyd_listModul")%>">
    <%}%>
  
    <% if (Serve.getModulUrlStr(request,"view_xs_xsd_lrfx_qk_listModul").length()>0) {%>
        <area shape="rect" coords="365,292,471,388" href="<%=Serve.getModulUrlStr(request,"view_xs_xsd_lrfx_qk_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
    	<area shape="rect" coords="141,388,225,474" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
    <%}%>
    <% if (Serve.getModulUrlStr(request,"cw_ysd_listModul").length()>0) {%>
    	<area shape="rect" coords="70,104,148,190" href="<%=Serve.getModulUrlStr(request,"cw_ysd_listModul")%>">
    <%}%>
     <% if (Serve.getModulUrlStr(request,"cg_fkd_listModul").length()>0) {%>
    	<area shape="rect" coords="499,202,599,290" href="<%=Serve.getModulUrlStr(request,"cg_fkd_listModul")%>">
     <%}%>
     <% if (Serve.getModulUrlStr(request,"cw_yfd_listModul").length()>0) {%>
    	<area shape="rect" coords="506,108,590,198" href="<%=Serve.getModulUrlStr(request,"cw_yfd_listModul")%>">
     <%}%>
     <% if (Serve.getModulUrlStr(request,"view_cg_cgd_lrfx_qk_listModul").length()>0) {%>
    	<area shape="rect" coords="192,294,294,383" href="<%=Serve.getModulUrlStr(request,"view_cg_cgd_lrfx_qk_listModul")%>">
     <%}%>
     <% if (Serve.getModulUrlStr(request,"view_cg_cgd_lrfx_qk_listModul").length()>0) {%>
     	<area shape="rect" coords="9,308,145,381" href="<%=Serve.getModulUrlStr(request,"view_cg_cgd_lrfx_qk_listModul")%>">
     <%}%>
     <% if (Serve.getModulUrlStr(request,"cw_ysd_listModul").length()>0) {%>
    	<area shape="rect" coords="295,393,388,473" href="<%=Serve.getModulUrlStr(request,"cw_ysd_listModul")%>">
     <%}%>
    </map>    </td>
  </tr>
</table>

<!-- 内容区 -->

</body>
</html>