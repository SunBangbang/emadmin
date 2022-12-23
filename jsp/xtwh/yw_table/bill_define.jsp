<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%


    if( !Serve.checkMkQx( request ) )	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}
	String modul_id = request.getParameter("modul_id");

	String _mainCN = DefineService.getTableName(request);

   
	response.sendRedirect("/emadmin/jsp/xtwh/yw_table/template_print.jsp?modul_id="+modul_id+"&_mainCN="+_mainCN);

	%>
