<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
    response.reset();
    response.setContentType("application/vnd.ms-excel;charset=UTF-8");
    String  title=request.getParameter("table");
    if (title.equals("jc_chda")) 
            title="货品档案";
    else if (title.equals("kh_da")) 
            title="客户档案";
    else if (title.equals("gys_da")) 
            title="供应商档案";
    response.setHeader("Content-Disposition","attachment; filename="+title+".xls");
%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
          ExcelService.export(request.getParameter("table"), request,response );
%>