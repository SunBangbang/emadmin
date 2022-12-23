<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/emadmin/shared/checkPermission1.jsp"%>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*,java.sql.*" %>
<%
    String message="";
	String[] category=null;
    try {
        ForumService.deleteCategory(request);
  } catch (Exception e) {
        e.printStackTrace();
        message="出现了错误，错误原因为：<br>"+e.getMessage();
    }
%>
<% if (message.length()==0) {%>
<script language="javascript">
    parent.leftFrame.location.reload();
</script>
<%}%>

<html>
<head>
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>
<body>
		<%@include file="/emadmin/shared/content_1.jsp"%>
			<!-- 标题区 --> 
				&nbsp;&nbsp;&nbsp;&nbsp;删除本级栏目&nbsp; -- &nbsp;<%=category==null||category.length==0?"":category[3]%>
			<!-- 标题区 --> 
		<%@include file="/emadmin/shared/content_2.jsp"%>
			<!-- 按扭区 --> 
					<table width="60%" border="0" cellspacing="0" cellpadding="0">
						  <tr>
							<td nowrap="nowrap"  class="category_menu0"><div align="center"><a href="category_index.jsp?cid=<%=request.getParameter("cid")%>" class="a1">设置本级栏目</a></div></td>
							<td nowrap="nowrap"  class="category_menu0"><div align="center"><a href="category_add.jsp?cid=<%=request.getParameter("cid")%>" class="a1">添加下级栏目</a></div></td>
							<td nowrap="nowrap"  class="category_menu0"><div align="center"><a href="category_delete.jsp?cid=<%=request.getParameter("cid")%>" class="a1">删除本级栏目</a></div></td>
							<td nowrap="nowrap">&nbsp;</td>
					  </tr>
				  </table>
			<!-- 按扭区 --> 
		<%@include file="/emadmin/shared/content_3.jsp"%>
			<!-- 内容区 -->
				<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
				  <tr>
					<td><table width="100%" border="0" cellspacing="0" cellpadding="5">
					  <tr>
						<td width="100%" height="24"><div align="center">
							<% if (message.length()==0) {%>
						  您已经成功删除名为<strong>[<%=request.getParameter("name")%>]</strong>的栏目！<br>
						  <%}else {%>
						  <%=message%>
						  <input name="button" type="button" onClick="javascript:history.back(-1);" value="返回上一步">
						  <%}%>
						</div></td>
					  </tr>
					</table></td>
				  </tr>
				</table>
			<!-- 内容区 -->
		<%@include file="/emadmin/shared/content_4.jsp"%>
</body>
</html>

