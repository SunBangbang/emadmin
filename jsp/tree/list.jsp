<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
	String result[];
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
			//throw new Exception ("结果未查询到！");
		}
		else 
			result = Serve.getListResult( request );


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
<style type="text/css">
    <!--
        body {padding:0px;margin:0px;}
    -->
</style>
</head>



<body>
			<!-- 内容区 -->

							<form name="form1" action="list.jsp" method="get">
								<%=result[0]%>
							  
							  
							</form>  
							 <%=result[1]%>	
											
			<!-- 内容区 -->

</body>
</html>
