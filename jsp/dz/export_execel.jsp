<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
    response.reset();
    response.setContentType("application/vnd.ms-excel;charset=UTF-8");
    String  title=request.getParameter("table");
    if (title.equals("jc_chda")) 
            title="��Ʒ����";
    else if (title.equals("kh_da")) 
            title="�ͻ�����";
    else if (title.equals("gys_da")) 
            title="��Ӧ�̵���";
    response.setHeader("Content-Disposition","attachment; filename="+title+".xls");
%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
          ExcelService.export(request.getParameter("table"), request,response );
%>