<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
    response.reset();
    response.setContentType("application/vnd.ms-excel;charset=UTF-8");
    response.setHeader("Content-Disposition","attachment; filename=导出全部数据.xls");
%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
          Serve.excelDefineAllExportExcel( request,response );
%>