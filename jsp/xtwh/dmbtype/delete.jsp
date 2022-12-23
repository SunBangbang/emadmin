<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%

	try
	{
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}

		String id = request.getParameter("id");

		Serve.deleteDMLX(id);
	   
		String url =Serve.getEditNextUrl( request );
			 
		response.sendRedirect(url);
		

	 }

	 catch( SQLException sqle)
	 {
		 if (Serve.getPageSendRedirectSystem())
		 {
			// System.out.println("SQL State :" + sqle.getSQLState());
			// System.out.println("Error Code :" + sqle.getErrorCode());
			sqle.printStackTrace();
			response.sendRedirect("/emadmin/shared/usererror.jsp?id=error102");
			return ;
		 }
		 else
		 {
			response.sendRedirect("/emadmin/shared/usererror.jsp?id=error102");
			return;
		 }
	 }
	 catch( Exception e)
	 {
			response.sendRedirect("/emadmin/shared/usererror.jsp?id=error102");
			return;
	 }
%>
