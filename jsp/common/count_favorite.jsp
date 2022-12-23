<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*"%>
<%
	String result[]=Api.sb("select url from xt_count_favorite where id='"+request.getParameter("favoriteid")+"'");
	if (result.length>0)	{
         response.sendRedirect( Util.setUrlParameter(result[0],"countfavoriteid",request.getParameter("favoriteid")));
         return;
    }
%>
