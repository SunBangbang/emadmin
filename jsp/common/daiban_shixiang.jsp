<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%


   String modulId = request.getParameter("modul_id");
   String tableName = request.getParameter("id");
   String result;

		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}


		 result=Serve.getDaiBanShiXiangResult( request );


%>
<html>
<head>
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>
<body>
	
			<!-- 标题区 --> 
		
			<!-- 标题区 --> 
		<%@include file="/emadmin/shared/content_2.jsp"%>
			<!-- 按扭区 --> 
							&nbsp;
			<!-- 按扭区 --> 
		<%@include file="/emadmin/shared/content_3.jsp"%>
			<!-- 内容区 -->

						<table width="100%"  height='100%' border="0"  style='table-layout: fixed;'>
						  <tr>
							<td>	
								<div align="center"><%=result%></div>
						   </td>
						  </tr>
						</table>
			<!-- 内容区 -->
		<%@include file="/emadmin/shared/content_4.jsp"%>
</body>
</html>

