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
    <td align="center" height="450"><img src="images/jxca_main.jpg" width="606" height="543" border="0" usemap="#Map" />
      <map name="Map">
       
        <% if (Serve.getModulUrlStr(request,"cg_qgd_listModul").length()>0) {%>
        <area shape="rect" coords="105,-5,183,70" href="<%=Serve.getModulUrlStr(request,"cg_qgd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cg_cgdd_listModul").length()>0) {%>
        <area shape="rect" coords="103,86,180,159" href="<%=Serve.getModulUrlStr(request,"cg_cgdd_listModul")%>">
        <%}%>
		  <% if (Serve.getModulUrlStr(request,"view_cg_cgxqd_listModul").length()>0) {%>
		<area shape="rect" coords="7,51,95,127" href="<%=Serve.getModulUrlStr(request,"view_cg_cgxqd_listModul")%>">
		 <%}%>
        <% if (Serve.getModulUrlStr(request,"cg_cgd_listModul").length()>0) {%>
        <area shape="rect" coords="90,183,172,276" href="<%=Serve.getModulUrlStr(request,"cg_cgd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cg_fkd_listModul").length()>0) {%>
        <area shape="rect" coords="357,247,432,311" href="<%=Serve.getModulUrlStr(request,"cg_fkd_listModul")%>">
        <%}%>
       
        <% if (Serve.getModulUrlStr(request,"kc_rkd_listModul").length()>0) {%>
        <area shape="rect" coords="267,113,349,209" href="<%=Serve.getModulUrlStr(request,"kc_rkd_listModul")%>">
        <%}%>
		 <% if (Serve.getModulUrlStr(request,"kc_zzd_listModul").length()>0) {%>
		<area shape="rect" coords="536,157,602,230" href="<%=Serve.getModulUrlStr(request,"kc_zzd_listModul")%>">
		 <%}%>
		 <% if (Serve.getModulUrlStr(request,"kc_cfd_listModul").length()>0) {%>
        <area shape="rect" coords="533,244,603,305" href="<%=Serve.getModulUrlStr(request,"kc_cfd_listModul")%>">
		 <%}%>
		 <% if (Serve.getModulUrlStr(request,"kc_rkd_listModul").length()>0) {%>
        <area shape="rect" coords="569,272,570,282" href="<%=Serve.getModulUrlStr(request,"kc_rkd_listModul")%>">
		 <%}%>
		 <% if (Serve.getModulUrlStr(request,"kc_dbd_listModul").length()>0) {%>
        <area shape="rect" coords="528,318,598,386" href="<%=Serve.getModulUrlStr(request,"kc_dbd_listModul")%>">
		 <%}%>
		 <% if (Serve.getModulUrlStr(request,"jc_YueJie_Modul").length()>0) {%>
        <area shape="rect" coords="531,394,600,468" href="<%=Serve.getModulUrlStr(request,"jc_YueJie_Modul")%>">
		<%}%>
		 <% if (Serve.getModulUrlStr(request,"kc_pdd_listModul").length()>0) {%>
        <area shape="rect" coords="525,476,603,538" href="<%=Serve.getModulUrlStr(request,"kc_pdd_listModul")%>">
		 <%}%>
        <% if (Serve.getModulUrlStr(request,"kc_zzd_listModul").length()>0) {%>
        <area shape="rect" coords="629,14,709,104" href="<%=Serve.getModulUrlStr(request,"kc_zzd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"kc_cfd_listModul").length()>0) {%>
        <area shape="rect" coords="627,366,707,443" href="<%=Serve.getModulUrlStr(request,"kc_cfd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"kc_dbd_listModul").length()>0) {%>
        <area shape="rect" coords="632,106,706,182" href="<%=Serve.getModulUrlStr(request,"kc_dbd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"kc_kcspz_listModul").length()>0) {%>
        <area shape="rect" coords="427,308,513,385" href="<%=Serve.getModulUrlStr(request,"kc_kcspz_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"jc_YueJie_Modul").length()>0) {%>
        <area shape="rect" coords="629,193,708,271" href="<%=Serve.getModulUrlStr(request,"jc_YueJie_Modul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"kc_pdd_listModul").length()>0) {%>
        <area shape="rect" coords="634,280,706,353" href="<%=Serve.getModulUrlStr(request,"kc_pdd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"kc_ckd_listModul").length()>0) {%>
        <area shape="rect" coords="260,469,344,549" href="<%=Serve.getModulUrlStr(request,"kc_ckd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"xs_xsd_xs_xsd_m").length()>0) {%>
        <%}%>
        <% if (Serve.getModulUrlStr(request,"xs_xsdd_listModul").length()>0) {%>
        <area shape="rect" coords="84,327,168,416" href="<%=Serve.getModulUrlStr(request,"xs_xsdd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"xs_xsd_listModul").length()>0) {%>
        <area shape="rect" coords="77,425,171,518" href="<%=Serve.getModulUrlStr(request,"xs_xsd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
        <area shape="rect" coords="337,383,421,464" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
        <%}%>
      
        <% if (Serve.getModulUrlStr(request,"cw_yfd_listModul").length()>0) {%>
        <area shape="rect" coords="275,248,342,319" href="<%=Serve.getModulUrlStr(request,"cw_yfd_listModul")%>">
        <%}%>
        <% if (Serve.getModulUrlStr(request,"cw_ysd_listModul").length()>0) {%>
        <area shape="rect" coords="261,382,326,460" href="<%=Serve.getModulUrlStr(request,"cw_ysd_listModul")%>">
        <%}%>
      </map></td>
  </tr>
</table>
<!-- 内容区 -->
<map name="Map">
 <% if (Serve.getModulUrlStr(request,"cg_cgd_cg_cgd_m").length()>0) {%>
 <%}%>
 <% if (Serve.getModulUrlStr(request,"cg_qgd_listModul").length()>0) {%>
<area shape="rect" coords="105,-5,183,70" href="<%=Serve.getModulUrlStr(request,"cg_qgd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"cg_cgdd_listModul").length()>0) {%>
<area shape="rect" coords="103,86,180,159" href="<%=Serve.getModulUrlStr(request,"cg_cgdd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"cg_cgd_listModul").length()>0) {%>
<area shape="rect" coords="90,183,172,276" href="<%=Serve.getModulUrlStr(request,"cg_cgd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"cg_fkd_listModul").length()>0) {%>
<area shape="rect" coords="354,252,429,316" href="<%=Serve.getModulUrlStr(request,"cg_fkd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"cg_fp_listModul").length()>0) {%>
 <%}%>
 <% if (Serve.getModulUrlStr(request,"kc_rkd_listModul").length()>0) {%>
<area shape="rect" coords="267,113,349,209" href="<%=Serve.getModulUrlStr(request,"kc_rkd_listModul")%>"><area shape="rect" coords="536,157,602,230" href="#"><area shape="rect" coords="533,244,603,305" href="#"><area shape="rect" coords="569,272,570,282" href="#"><area shape="rect" coords="529,318,599,386" href="#"><area shape="rect" coords="530,397,599,471" href="#"><area shape="rect" coords="525,476,603,538" href="#">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"kc_zzd_listModul").length()>0) {%>
<area shape="rect" coords="629,14,709,104" href="<%=Serve.getModulUrlStr(request,"kc_zzd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"kc_cfd_listModul").length()>0) {%>
<area shape="rect" coords="627,366,707,443" href="<%=Serve.getModulUrlStr(request,"kc_cfd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"kc_dbd_listModul").length()>0) {%>
<area shape="rect" coords="632,106,706,182" href="<%=Serve.getModulUrlStr(request,"kc_dbd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"kc_kcspz_listModul").length()>0) {%>
<area shape="rect" coords="417,307,503,384" href="<%=Serve.getModulUrlStr(request,"kc_kcspz_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"jc_YueJie_Modul").length()>0) {%>
<area shape="rect" coords="629,193,708,271" href="<%=Serve.getModulUrlStr(request,"jc_YueJie_Modul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"kc_pdd_listModul").length()>0) {%>
<area shape="rect" coords="634,280,706,353" href="<%=Serve.getModulUrlStr(request,"kc_pdd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"kc_ckd_listModul").length()>0) {%>
<area shape="rect" coords="260,469,344,549" href="<%=Serve.getModulUrlStr(request,"kc_ckd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"xs_xsd_xs_xsd_m").length()>0) {%>
 <%}%>
 <% if (Serve.getModulUrlStr(request,"xs_xsdd_listModul").length()>0) {%>
<area shape="rect" coords="84,327,168,416" href="<%=Serve.getModulUrlStr(request,"xs_xsdd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"xs_xsd_listModul").length()>0) {%>
<area shape="rect" coords="77,425,171,518" href="<%=Serve.getModulUrlStr(request,"xs_xsd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"xs_skd_listModul").length()>0) {%>
<area shape="rect" coords="337,383,421,464" href="<%=Serve.getModulUrlStr(request,"xs_skd_listModul")%>">
  <%}%>
 <% if (Serve.getModulUrlStr(request,"xs_fp_listModul").length()>0) {%>
 <%}%>
 <% if (Serve.getModulUrlStr(request,"xs_yskd_listModul").length()>0) {%>
 <%}%>
 <% if (Serve.getModulUrlStr(request,"cg_yfkd_listModul").length()>0) {%>
 <%}%>
<% if (Serve.getModulUrlStr(request,"cw_yfd_listModul").length()>0) {%>
<area shape="rect" coords="275,248,342,319" href="<%=Serve.getModulUrlStr(request,"cw_yfd_listModul")%>">
<%}%>
<% if (Serve.getModulUrlStr(request,"cw_ysd_listModul").length()>0) {%>
<area shape="rect" coords="261,382,326,460" href="<%=Serve.getModulUrlStr(request,"cw_ysd_listModul")%>">
<%}%>
</map>

</body>
</html>