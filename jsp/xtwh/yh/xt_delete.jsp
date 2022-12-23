<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*,com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%

		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}

		Serve.BillActionXtDelete(request);
	   
		response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("恭喜您，操作成功!","UTF-8"));


%>
