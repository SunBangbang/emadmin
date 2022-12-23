<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
    String result[] = new String [2];
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}
		else
			result = Serve.getBillDetailResult( request );

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
<body>
			<!-- 按扭区 --> 
					<div class="x_bill_detail_button_div"><%=result[0]%></div>
			<!-- 按扭区 --> 
			<!-- 内容区 -->
					<table class="x_bill_outer_table" cellspacing="0" align="center">
					  <tr>
						<td align="left"><%=result[1]%></td>
					  </tr>
					</table>
			<!-- 内容区 -->
</body>
</html>
