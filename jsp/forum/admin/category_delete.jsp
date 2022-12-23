<%@ page contentType="text/html;charset=UTF-8" %>
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
			<td height="" align="left" valign="middle" id="center_head_bg">
					<span class="center_title" style="width:100%;">
						&nbsp;&nbsp;&nbsp;&nbsp;删除本级栏目&nbsp; -- &nbsp;<%=category==null||category.length==0?"":category[3]%>
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
					<table height="25"  width="60%" border="0" cellspacing="0" cellpadding="0">
						  <tr>
							<td nowrap="nowrap"  class="category_menu0"><div align="center"><a href="category_index.jsp?cid=<%=request.getParameter("cid")%>" class="a1">设置本级栏目</a></div></td>
							<td nowrap="nowrap"  class="category_menu0"><div align="center"><a href="category_add.jsp?cid=<%=request.getParameter("cid")%>" class="a1">添加下级栏目</a></div></td>
							<td nowrap="nowrap"  class="category_menu0"><div align="center"><a href="category_delete.jsp?cid=<%=request.getParameter("cid")%>" class="a1">删除本级栏目</a></div></td>
							<td nowrap="nowrap">&nbsp;</td>
					  </tr>
				  </table>
		  <!-- 内容区 -->
					<table width="90%"  border="0" cellspacing="0" cellpadding="5" align="center">
						  <tr>
							<td align="left">	
						<form name="form1" method="post" action="category_delete1.jsp">
						  <table width="95%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9C9A9C">
							<tr bgcolor="#F7FBFF">
							  <td width="21%" height="24" ><div align="right">删除栏目:</div></td>
							  <td width="79%" ><%=category[3]%></td>
							</tr>
							<tr>
							  <td height="80" bgcolor="#F7FBFF"><div align="right"><font size="+1" color="red">警告：</font></div></td>
							  <td bgcolor="#F7FBFF">1、删除这个栏目的同时，该栏目的所有下级栏目及内容也同时被删除。<br>
								2、栏目删除后，将无法恢复。<br>
								3、推荐使用使用设置状态功能暂时关闭此栏目。</td>
							</tr>
							<tr>
							  <td height="23" bgcolor="#F7FBFF"><input name="cid" type="hidden" value=<%=category[1]%>>
								  <input name="name" type="hidden" value=<%=category[3]%>>
								&nbsp;</td>
							  <td height="23" bgcolor="#F7FBFF"><input type="button" name="Submit2" value="取消删除 返回" onClick="javascript:history.back(-1);">
								&nbsp;
								<input type="submit" name="Submit" value="确定删除 继续下一步" ></td>
							</tr>
						  </table>
						</form>
						   </td>
						  </tr>
						</table>
			
</body>
</html>
