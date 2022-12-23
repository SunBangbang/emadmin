<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.lfbase.service.*,java.net.*"%>
<%
	String ids = request.getParameter( "ids" );
	Api.ub("delete kh_khc_lxr from kh_khc a,kh_khc_lxr b where a.id=b.kh_khc_id and '"+ids+"' like '%,'+ a.drpc +',%' and a.zt='001'   delete kh_khc_lxr from kh_khc a,kh_khc_lxr b where a.id=b.kh_khc_id and '"+ids+"' like '%,'+ a.drpc +',%' and a.zt='001' "+"delete from kh_khc  where '"+ids+"' like '%,'+ drpc +',%' and zt='001' " );
	response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("恭喜您,操作已成功 ！","UTF-8"));
%>
