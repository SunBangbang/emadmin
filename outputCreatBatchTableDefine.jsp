<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
	//批量表的导出的脚本：　输入　取表名称的sql　结果在:　特殊创建脚本 名称为：表批量导出依据批量sql
    Serve.getBatchTableDefineScriptOuputBySql("select table_name from xt_tables where table_name in ('view_cw_kjkm_with_hl','view_fx_fysy','view_fx_xsjhzx','view_oa_cl_tj_fybb','view_qd_ltjt','view_qd_lxsgj','view_ywzd')");
%>


