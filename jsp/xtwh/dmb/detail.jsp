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
			result = Serve.getBillDetailTemplate( request );


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
<body onload="javascript:document.getElementById('bill_main_table').width=document.body.clientWidth*0.8;">
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区 --> 
			<td height="" align="left" valign="middle" id="center_head_bg">
					<span class="center_title" style="width:100%;">
						&nbsp;&nbsp;&nbsp;<%=Serve.getModulName( request )%>
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
			<!-- 按扭区 --> 
							<div align="left" style='padding-top:5px;padding-bottom:5px;padding-left:27px;padding-right:5px;'><%=result[0]%></div>
			<!-- 按扭区 --> 
			<!-- 内容区 -->
            <div align="left" style='padding-top:5px;padding-bottom:5px;padding-left:25px;padding-right:5px;'>
					<table width="100%"  border="0" cellspacing="0" cellpadding="0" align="left">
					  <tr>
						<td align="left"><%=result[1]%></td>
					  </tr>
					</table>
            </div>																
			<!-- 内容区 -->
</body>
</html>
