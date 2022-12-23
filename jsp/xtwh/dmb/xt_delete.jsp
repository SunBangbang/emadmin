<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
	String id = "";
    String father_id=request.getParameter("father_id");

		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}

		Serve.BillActionXtDelete(request);
	   
			 
	  String url =Serve.getDMBEditNextUrl( request );
	 response.sendRedirect(url);
					


%>
