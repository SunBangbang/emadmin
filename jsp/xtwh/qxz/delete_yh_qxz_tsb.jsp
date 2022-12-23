<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%//生成工作日

		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}


		String id = "";
		id = request.getParameter("id");

		Api.ub( " exec delete_qxz_qx  '"+ id +"'" ); 
		
		response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作成功 ！","UTF-8"));

%>




