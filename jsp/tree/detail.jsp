<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
	String id = request.getParameter("id");
    String result[] = new String [2];
	String bmQxResult = "";

	if( !Serve.checkMkQx( request ) )
	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}
	else
	{
		result = Serve.getBillDetailResult( request );
	}




%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
<script>
function printData()
{
     var  title = "标题";
     print_this(print_table, title);
}
</script>
</head>
<body onload="javascript:document.getElementById('bill_main_table').width=document.body.clientWidth*0.8;">

		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
			<!-- 按扭区 --> 
							<div align="left"><%=result[0]%></div>&nbsp;
			<!-- 按扭区 --> 
			<!-- 内容区 -->

					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
					  <tr>
						<td align="left"><%=result[1]%></td>
					  </tr>
					  <tr>
						<td align="left">

				    </td>
				 </tr>



					</table>
																
			<!-- 内容区 -->
</body>
</html>
<%if( request.getParameter("rf") != null){%>
<SCRIPT language=JavaScript>
    parent.left.location=parent.left.location+"&nid=<%=id%>" ;
</SCRIPT>
<%}%>
