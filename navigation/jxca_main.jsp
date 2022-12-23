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
    <td align="center" height="450"><img src="images/jxca_main.jpg" width="710" height="555" border="0" usemap="#Map" />     </td>
  </tr>
</table>
<!-- 内容区 -->
<map name="Map">
 <% if (Serve.getModulUrlStr(request,"cg_cgd_cg_cgd_m").length()>0) {%>
<area shape="rect" coords="308,0,412,76" href="<%=Serve.getModulUrlStr(request,"cg_cgd_cg_cgd_m")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"cg_qgd_listModul").length()>0) {%>
<area shape="rect" coords="4,60,81,148" href="<%=Serve.getModulUrlStr(request,"cg_qgd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"cg_cgdd_listModul").length()>0) {%>
<area shape="rect" coords="100,61,176,149" href="<%=Serve.getModulUrlStr(request,"cg_cgdd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"cg_cgd_listModul").length()>0) {%>
<area shape="rect" coords="204,63,274,154" href="<%=Serve.getModulUrlStr(request,"cg_cgd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"cg_fkd_listModul").length()>0) {%>
<area shape="rect" coords="281,131,352,217" href="<%=Serve.getModulUrlStr(request,"cg_fkd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"cg_fp_listModul").length()>0) {%>
<area shape="rect" coords="369,126,446,218" href="<%=Serve.getModulUrlStr(request,"cg_fp_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"kc_rkd_listModul").length()>0) {%>
<area shape="rect" coords="453,52,535,148" href="<%=Serve.getModulUrlStr(request,"kc_rkd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"kc_zzd_listModul").length()>0) {%>
<area shape="rect" coords="627,30,707,120" href="<%=Serve.getModulUrlStr(request,"kc_zzd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"kc_cfd_listModul").length()>0) {%>
<area shape="rect" coords="627,128,707,205" href="<%=Serve.getModulUrlStr(request,"kc_cfd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"kc_dbd_listModul").length()>0) {%>
<area shape="rect" coords="631,207,705,283" href="<%=Serve.getModulUrlStr(request,"kc_dbd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"kc_kcspz_listModul").length()>0) {%>
<area shape="rect" coords="509,187,596,278" href="<%=Serve.getModulUrlStr(request,"kc_kcspz_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"jc_YueJie_Modul").length()>0) {%>
<area shape="rect" coords="627,286,706,364" href="<%=Serve.getModulUrlStr(request,"jc_YueJie_Modul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"kc_pdd_listModul").length()>0) {%>
<area shape="rect" coords="632,367,704,440" href="<%=Serve.getModulUrlStr(request,"kc_pdd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"kc_ckd_listModul").length()>0) {%>
<area shape="rect" coords="452,309,535,401" href="<%=Serve.getModulUrlStr(request,"kc_ckd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"xs_xsd_xs_xsd_m").length()>0) {%>
<area shape="rect" coords="309,244,402,338" href="<%=Serve.getModulUrlStr(request,"xs_xsd_xs_xsd_m")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"xs_xsdd_listModul").length()>0) {%>
<area shape="rect" coords="77,316,180,408" href="<%=Serve.getModulUrlStr(request,"xs_xsdd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"xs_xsd_listModul").length()>0) {%>
<area shape="rect" coords="207,306,284,399" href="<%=Serve.getModulUrlStr(request,"xs_xsd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
<area shape="rect" coords="273,393,357,474" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"xs_fp_listModul").length()>0) {%>
<area shape="rect" coords="372,395,448,475" href="<%=Serve.getModulUrlStr(request,"xs_fp_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"view_kc_kcyj_listModul").length()>0) {%>
<area shape="rect" coords="138,466,223,551" href="<%=Serve.getModulUrlStr(request,"view_kc_kcyj_listModul")%>">
  <%}%>
 
</map>
</body>
</html>