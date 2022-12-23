<%@page contentType="text/html;charset=UTF-8" %>

<%@page import="com.lf.lfbase.service.*,java.net.*,java.io.*,com.lf.util.*"%>
<%@include file="/emadmin/shared/checkPermission1.jsp"%>
<%@include file="/emadmin/version.jsp"%>
<style type="text/css">
<!--
* {
	margin: 0px;
	padding: 0px;
	font-size: 14px;
	}
	
body {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
    
}
#center_head_bg {
	background:url(images/content/content_head_bg.gif) repeat-x;
	height:23px;
	}
-->
</style>
<%
				response.setHeader("Pragma","No-cache"); 
                response.setHeader("Cache-Control","no-cache"); 
                response.setDateHeader("Expires", 0); 
                String _systemState="0";
%>
              <SCRIPT language=JavaScript>
              <!-- 
                function do_next() {
                    if (document.getElementById('is_zzjg').value=='ok' &&
                       document.getElementById('is_chda').value=='ok' &&
                       document.getElementById('is_ck').value=='ok' &&
                       document.getElementById('is_chqc').value=='ok' &&
                       document.getElementById('is_kh').value=='ok' &&
                       document.getElementById('is_ys').value=='ok' &&
                       document.getElementById('is_gys').value=='ok' &&
                       document.getElementById('is_yf').value=='ok' 
                       ) {
                       location.href="/emadmin/jsp/xtwh/system/system_start.jsp?modul_id=sys_start_Mod";
                    } else {
                        alert("您还没有完成初始化操作，不能继续下一步!");
                    }
                }
                --> 
              </SCRIPT>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
</head>
<body>
<table width="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <!-- 标题区 -->
    <td height="" align="left" valign="middle" id="center_head_bg"><span class="center_title" style="width:100%;"> &nbsp;&nbsp;&nbsp;系统初始化 </span> </td>
    <!-- 标题区 -->
  </tr>
</table>
<!-- 内容区 -->
<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
		    <td width="22%" rowspan="2" align="left" valign="middle" ><div align="center"><img src="images/c1/init_picture.jpg" width="127" height="100"></div></td>
            <td height="29" align="left" valign="middle" ><img src="images/c1/init_point.gif" width="15" height="18"></td>
		    <td align="left" valign="middle" > &nbsp;在正式使用系统前，需进行系统初始化，请按如下步骤将基础资料导入到软件中：</td>
		  </tr>
		  <tr>
		    <td width="1%" height="" align="left" valign="middle" ></td>
		    <td width="77%" height="" align="left" valign="middle" ><img src="images/c1/init_step.gif" width="626" height="46"></td>
		  </tr>
</table>
<table  width="100%" height="274"   border="1" cellpadding="20" cellspacing="0" bordercolorlight="#B3C3D0" bordercolordark="#ffffff">

  <tr  align="center" >
    <td width="18%" height="32"   align="center" valign="middle"><div align="right">组织机构信息 <img src="images/c1/init_arrow.gif" width="17" height="13" align="top">&nbsp;</div></td>
    <td width="30%"   align="center" valign="middle"><div align="center"><a href="resource/template/初始化模板--组织机构.xls" target="_blank">下载Excel模版文件</a></div></td>
    <td width="16%"   align="center" valign="middle"><div align="center"><a href="jsp/xtwh/init_import/import_excel_zz.jsp">上传Excel文件</a></div></td>
    <td width="18%"   align="center" valign="middle"><div align="center">
    <% if (InitImportExcelService.InitImportExcel_Organize_isFinished()){%>
        <img src="images/c1/init_ok.gif" width="34" height="30" />已完成
        <input type="hidden" id="is_zzjg" value="ok">
    <%} else {%>
        <img src="images/c1/init_no.gif" width="30" height="28" />未完成
        <input type="hidden" id="is_zzjg" value="no">
    <%}%>
    </div></td>
  </tr>

  <% if (Api.getXtPreferenceValueByName("prodcutModul").indexOf("kc")>=0) { //如果有库存管理模块%>
      <tr  align="center"  bgcolor="FBF8F3" >
        <td   align="center" valign="middle"><div align="right">仓库设置信息 <img src="images/c1/init_arrow.gif" width="17" height="13" align="top">&nbsp;</div></td>
        <td height="26"   align="center" valign="middle"><a href="resource/template/初始化模板--仓库设置.xls" target="_blank">下载Excel模版文件</a></td>
        <td height="26"   align="center" valign="middle">
                <% if (InitImportExcelService.InitImportExcel_Organize_isFinished()){%>
                    <a href="jsp/xtwh/init_import/import_excel_ck.jsp">上传Excel文件</a>
                <%} else {%>
                    &nbsp;
                <%}%>    </td>
        <td   align="center" valign="middle">
        <% if (InitImportExcelService.InitImportExcel_ck_isFinished()){%>
            <img src="images/c1/init_ok.gif" width="34" height="30" />已完成
            <input type="hidden" id="is_ck" value="ok">
        <%} else {%>
            <img src="images/c1/init_no.gif" width="30" height="28" />未完成
            <input type="hidden" id="is_ck" value="no">
        <%}%>    </td>
      </tr>
    <%} else {%>
        <input type="hidden" id="is_ck" value="ok">
    <%}%>

  <% if (Api.getXtPreferenceValueByName("prodcutModul").indexOf("kc")>=0 || Api.getXtPreferenceValueByName("prodcutModul").indexOf("crm")>=0) { //如果有库存管理模块%>
  <tr  align="center">
    <td height="29"   align="center" valign="middle"><div align="right">产品目录信息  <img src="images/c1/init_arrow1.gif" width="17" height="16" align="top">&nbsp;</div></td>
    <td height="29"   align="center" valign="middle"><div align="center"><a href="resource/template/初始化模板--产品目录.xls" target="_blank">下载Excel模版文件</a></div></td>
    <td height="29"   align="center" valign="middle">
                <% if (InitImportExcelService.InitImportExcel_ck_isFinished() || Api.getXtPreferenceValueByName("prodcutModul").indexOf("kc")<0){%>
                    <a href="jsp/xtwh/init_import/import_excel_ch.jsp">上传Excel文件</a>
                <%} else {%>
                    &nbsp;
                <%}%>    </td>
    <td   align="center" valign="middle"><div align="center">
    <% if (InitImportExcelService.InitImportExcel_Ch_isFinished()){%>
        <img src="images/c1/init_ok.gif" width="34" height="30" />已完成
        <input type="hidden" id="is_chda" value="ok">
    <%} else {%>
        <img src="images/c1/init_no.gif" width="30" height="28" />未完成
        <input type="hidden" id="is_chda" value="no">
    <%}%>
    </div></td>
  </tr>
  <%} else {%>
        <input type="hidden" id="is_chda" value="ok">
  <%}%>

  <% if (Api.getXtPreferenceValueByName("prodcutModul").indexOf("kc")>=0) { //如果有库存管理模块%>
          <tr  align="center"  bgcolor="FBF8F3" >
            <td   align="center" valign="middle"><div align="right">库存期初信息 <img src="images/c1/init_arrow1.gif" width="17" height="16" align="top">&nbsp;</div></td>
            <td height="26"   align="center" valign="middle"><div align="center"><a href="resource/template/初始化模板--库存期初.xls" target="_blank">下载Excel模版文件</a></div></td>
            <td height="26"   align="center" valign="middle">
                    <% if (InitImportExcelService.InitImportExcel_Ch_isFinished() && InitImportExcelService.InitImportExcel_ck_isFinished()){%>
                        <a href="jsp/xtwh/init_import/import_excel_chqc.jsp">上传Excel文件</a>
                    <%} else {%>
                        &nbsp;
                    <%}%>    </td>
            <td   align="center" valign="middle"><div align="center">
            <% if (InitImportExcelService.InitImportExcel_Chqc_isFinished()){%>
                <img src="images/c1/init_ok.gif" width="34" height="30" />已完成
                <input type="hidden" id="is_chqc" value="ok">
            <%} else {%>
                <img src="images/c1/init_no.gif" width="30" height="28" />未完成
                <input type="hidden" id="is_chqc" value="no">
            <%}%>
            </div></td>
          </tr>
    <%} else {%>
        <input type="hidden" id="is_chqc" value="ok">
    <%}%>

  <% if (Api.getXtPreferenceValueByName("prodcutModul").indexOf("xs")>=0 || Api.getXtPreferenceValueByName("prodcutModul").indexOf("crm")>=0) { //如果有销售或客户关系模块%>

  <tr  align="center" >
    <td   align="center" valign="middle"><div align="right">客户档案信息 <img src="images/c1/init_arrow.gif" width="17" height="13" align="top">&nbsp;</div></td>
    <td height="25"   align="center" valign="middle"><div align="center"><a href="resource/template/初始化模板--客户档案.xls" target="_blank">下载Excel模版文件</a></div></td>
    <td height="25"   align="center" valign="middle">
            <% if (InitImportExcelService.InitImportExcel_Organize_isFinished()){%>
                <a href="jsp/xtwh/init_import/import_excel_kh.jsp">上传Excel文件</a>
            <%} else {%>
                &nbsp;
            <%}%>    </td>
    <td   align="center" valign="middle"><div align="center">
    <% if (InitImportExcelService.InitImportExcel_kh_isFinished()){%>
        <img src="images/c1/init_ok.gif" width="34" height="30" />已完成
        <input type="hidden" id="is_kh" value="ok">
    <%} else {%>
        <img src="images/c1/init_no.gif" width="30" height="28" />未完成
        <input type="hidden" id="is_kh" value="no">
    <%}%>
    </div></td>
  </tr>

  <tr  align="center" bgcolor="FBF8F3" >
    <td   align="center" valign="middle"><div align="right">销售应收款信息 <img src="images/c1/init_arrow1.gif" width="17" height="16" align="top">&nbsp;</div></td>
    <td height="22"   align="center" valign="middle"><a href="resource/template/初始化模板--销售应收款.xls" target="_blank">下载Excel模版文件</a></td>
    <td height="22"   align="center" valign="middle">
            <% if (InitImportExcelService.InitImportExcel_Organize_isFinished() && InitImportExcelService.InitImportExcel_kh_isFinished()){%>
                    <a href="jsp/xtwh/init_import/import_excel_ys.jsp">上传Excel文件</a>
            <%} else {%>
                &nbsp;
            <%}%>    </td>
    <td   align="center" valign="middle">
    <% if (InitImportExcelService.InitImportExcel_sfys_isFinished()){%>
        <img src="images/c1/init_ok.gif" width="34" height="30" />已完成
        <input type="hidden" id="is_ys" value="ok">
    <%} else {%>
        <img src="images/c1/init_no.gif" width="30" height="28" />未完成
        <input type="hidden" id="is_ys" value="no">
    <%}%>    </td>
  </tr>
    <%} else {%>
       <input type="hidden" id="is_kh" value="ok"><input type="hidden" id="is_ys" value="ok">
    <%}%>

  <% if (Api.getXtPreferenceValueByName("prodcutModul").indexOf("cg")>=0) { //%>

  <tr  align="center" >
    <td   align="center" valign="middle"><div align="right">供应商档案信息 <img src="images/c1/init_arrow.gif" width="17" height="13" align="top">&nbsp;</div></td>
    <td height="22"   align="center" valign="middle"><a href="resource/template/初始化模板--供应商档案.xls" target="_blank">下载Excel模版文件</a></td>
    <td height="22"   align="center" valign="middle">
            <% if (InitImportExcelService.InitImportExcel_Organize_isFinished()){%>
                    <a href="jsp/xtwh/init_import/import_excel_gys.jsp">上传Excel文件</a>
            <%} else {%>
                &nbsp;
            <%}%>    </td>
    <td   align="center" valign="middle">
    <% if (InitImportExcelService.InitImportExcel_gys_isFinished()){%>
        <img src="images/c1/init_ok.gif" width="34" height="30" />已完成
        <input type="hidden" id="is_gys" value="ok">
    <%} else {%>
        <img src="images/c1/init_no.gif" width="30" height="28" />未完成
        <input type="hidden" id="is_gys" value="no">
    <%}%>    </td>
  </tr>
  <tr  align="center" bgcolor="FBF8F3" >
    <td   align="center" valign="middle" bgcolor="FBF8F3"><div align="right">采购应付款信息 <img src="images/c1/init_arrow1.gif" width="17" height="16" align="top">&nbsp;</div></td>
    <td height="22"   align="center" valign="middle" ><a href="resource/template/初始化模板--采购应付款.xls" target="_blank">下载Excel模版文件</a></td>
    <td height="22"   align="center" valign="middle" bgcolor="FBF8F3">
            <% if (InitImportExcelService.InitImportExcel_Organize_isFinished() && InitImportExcelService.InitImportExcel_gys_isFinished()){%>
                    <a href="jsp/xtwh/init_import/import_excel_yf.jsp">上传Excel文件</a>
            <%} else {%>
                &nbsp;
            <%}%>    </td>
    <td   align="center" valign="middle" bgcolor="FBF8F3">
    <% if (InitImportExcelService.InitImportExcel_sfyf_isFinished()){%>
        <img src="images/c1/init_ok.gif" width="34" height="30" />已完成
        <input type="hidden" id="is_yf" value="ok">
    <%} else {%>
        <img src="images/c1/init_no.gif" width="30" height="28" />未完成
        <input type="hidden" id="is_yf" value="no">
    <%}%>    </td>
  </tr>
    <%} else {%>
       <input type="hidden" id="is_gys" value="ok"><input type="hidden" id="is_yf" value="ok">
    <%}%>
</table>
<table width="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="" align="left" valign="middle" ><br/>
      <div align="center"><img src="images/c1/init_start_system.gif" width="339" height="30" border="0" onClick="do_next();" onMouseOver="this.style.cursor='hand'">
      </div>
    </td>
  </tr>
</table>
<!-- 内容区 -->
</body>
</html>
