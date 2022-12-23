<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

	if( !Serve.checkMkQx( request ) )	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}

    String r[]= Serve.xtWarnDefineGetNextUrl( request );

	
	 String url ="/emadmin/jsp/common/list.jsp?modul_id=xt_warn_define_listModul&id="+r[0]+"&_mainCN=view_xt_list&_mainID="+r[0];
     System.out.println(url);
				 response.sendRedirect(url);
%>
