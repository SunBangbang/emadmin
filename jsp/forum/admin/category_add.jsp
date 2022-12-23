<%@ page contentType="text/html;charset=UTF-8" %>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@ include file="/emadmin/shared/checkPermission1.jsp"%>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*,java.sql.*" %>
<%
    String message="";
	String[] category=null;
    try {
        category=ForumService.getCategoryNode(request);
    } catch (Exception e) {
        e.printStackTrace();
        message="出现了错误，错误原因为：<br>"+e.getMessage();
    }
	if (message.length()>0) {
		out.println(message);
		return;
	}
%>
<SCRIPT language=JavaScript>
<!-- 
function check()
{ 
    if (form1.name.value.length<1) {
		alert("[栏目名称] 为必录项，请录入内容！");
		form1.name.focus();
		return false;	
	}
}
--> 
</SCRIPT>
<html>
<head>
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>
<body>
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区 --> 
			<td  align="left" valign="middle" id="center_head_bg">
					<span class="center_title" style="width:100%;">
							&nbsp;&nbsp;&nbsp;&nbsp;添加下级栏目&nbsp; -- &nbsp;<%=category==null||category.length==0?"":category[3]%>
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
			<!-- 按扭区 --> 
					<table height="25" width="60%" border="0" cellspacing="0" cellpadding="0">
						  <tr>
							<td nowrap="nowrap"  class="category_menu0"><div align="center"><a href="category_index.jsp?cid=<%=request.getParameter("cid")%>" class="a1">设置本级栏目</a></div></td>
							<td nowrap="nowrap"  class="category_menu0"><div align="center"><a href="category_add.jsp?cid=<%=request.getParameter("cid")%>" class="a1">添加下级栏目</a></div></td>
							<td nowrap="nowrap"  class="category_menu0"><div align="center"><a href="category_delete.jsp?cid=<%=request.getParameter("cid")%>" class="a1">删除本级栏目</a></div></td>
							<td nowrap="nowrap">&nbsp;</td>
					  </tr>
				  </table>
			<!-- 按扭区 --> 
		  <!-- 内容区 -->
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
						  <tr>
							<td align="left">
									<form name="form1" method="post" action="category_add1.jsp">
										  <table width="95%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9C9A9C">
											<tr>
											  <td width="46%" height="32" bgcolor="#F7FBFF"><div align="right">输入栏目名称：</div></td>
											  <td width="54%" height="32" bgcolor="#F7FBFF"><input name="name" type="text" size="30"></td>
											</tr>
											<tr>
											  <td height="23" bgcolor="#F7FBFF"><input name="cid" type="hidden" value=<%=request.getParameter("cid")%>></td>
											  <td height="23" bgcolor="#F7FBFF"><input type="image" name="Submit" src="../images/next_step.jpg" onClick="return check();"></td>
											</tr>
										  </table>
										</form>
						   </td>
						  </tr>
						</table>
			
			<!-- 内容区 -->
</body>
</html>
