<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%

		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}

		Serve.Billqiyong(request);
	   
		String url =Serve.getNextUrl( request );
			 
%> 
        <script language="javascript">
            if (parent!=null && parent.left!=null && parent.left.name=="left") {
                 parent.left.location.reload();
            }
            window.location="<%=url%>";
        </script>
