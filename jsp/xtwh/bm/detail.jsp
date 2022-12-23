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
		bmQxResult = Serve.getBmQxResult(request);
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
<body>
			<!-- 按扭区 --> 
							<div align="left"><%=result[0]%></div>&nbsp;
			<!-- 按扭区 --> 
			<!-- 内容区 -->

					<table class="x_bill_outer_table" cellspacing="0" align="center">
					  <tr>
						<td align="left"><%=result[1]%></td>
					  </tr>
					  <tr>
						<td align="left">

<%if(Api.getXtPreferenceValueByName("sf_cydjqxms").equals("1")){%>

	<table  class='list_result_table' border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
		  <tr>
			<td class='list_result_title' align='center' colspan='4' nowrap><span class='list_result_title_main'>部门岗位</span>
			</td>
		  </tr>

		  <tr class='list_result_title_tr'>
			  <td  align='center' nowrap width="10%"> 序号  </td>
			  <td  align='center' nowrap width="10%"> 岗位 </td>
			  <td  align='center' nowrap width="10%"> 序号 </td>
			  <td  align='center' nowrap  width="10%"> 岗位 </td>
		  </tr>

			<%=bmQxResult%>
	</table>
<%}%>

					</td>
				 </tr>



					</table>
																
			<!-- 内容区 -->
</body>
</html>
<%if( request.getParameter("rf") != null){%>
<SCRIPT language=JavaScript>
    parent.left.location="left.jsp?nid=<%=id%>" ;
</SCRIPT>
<%}%>
