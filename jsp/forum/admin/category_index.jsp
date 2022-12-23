<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/emadmin/shared/checkPermission1.jsp"%>
<%@page import="com.lf.lfbase.service.*,com.lf.lfbase.service.*" %>
<%
    String message="";
	String category[]=null;
	String allDepartment[]=null;
	String allUsers[]=null;
    try {
		category=ForumService.getCategoryNode(request);
	    allDepartment=Server.getOptionList("000",request);
	    allUsers=Server.getOptionList("001",request);
    } catch (Exception e) {
        e.printStackTrace();
        message="出现了错误，错误原因为：<br>"+e.getMessage();
    }
%>
<%! public String getSelected(String x1,String x2) {
			if (x1==null || x2==null) return "";
			if (x1.equals(x2)) {
				return "selected"; 
			} else {
				return "";
			}
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
				&nbsp;&nbsp;&nbsp;&nbsp;设置本级栏目&nbsp; -- &nbsp;<%=category==null||category.length==0?"":category[3]%>
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
			<!-- 按扭区 --> 
					<table  height="25" width="60%" border="0" cellspacing="0" cellpadding="0">
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

						<form action="category_index1.jsp" method="post" name="form1">
						  <table width="95%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9C9A9C">
							<tr bgcolor="#F7FBFF">
							  <td height="25"  colspan="2" align="center"   class="content_font_td">请对栏目进行详细设置：</td>
							</tr>
							<tr >
							  <td width="34%" height="23" nowrap bgcolor="#F7FBFF"><div align="right">栏目名称：</div></td>
							  <td width="66%" height="23" bgcolor="#F7FBFF"><input name="name" type="text" value="<%=category[3]%>" size="40" ></td>
							</tr>
							<tr >
							  <td width="34%" height="23" nowrap bgcolor="#F7FBFF"><div align="right">链接地址：</div></td>
							  <td width="66%" height="23" bgcolor="#F7FBFF"><input name="link" type="text" value="<%=category[4]%>" size="40" ></td>
							</tr>
							<tr >
							  <td width="34%" height="23" nowrap bgcolor="#F7FBFF"><div align="right">顺序号：</div></td>
							  <td width="66%" height="23" bgcolor="#F7FBFF"><input name="item_order" type="text" value="<%=category[6]%>" size="40" ></td>
							</tr>
							<tr >
							  <td width="34%" height="23" nowrap bgcolor="#F7FBFF"><div align="right">栏目状态：</div></td>
							  <td width="66%" height="23" bgcolor="#F7FBFF"><select name="state">
																										<option value="1" <%=getSelected(category[8],"1")%>>有效</option>
																										<option value="0" <%=getSelected(category[8],"0")%>>无效</option>
																								</select>
							  </td>
							</tr>
							<tr >
							  <td width="34%" height="23" nowrap bgcolor="#F7FBFF"><div align="right">主版主：</div></td>
							  <td width="66%" height="23" bgcolor="#F7FBFF"><input name="admin" type="text" value="<%=category[9]%>" size="40" ></td>
							</tr>
							<tr >
							  <td width="34%" height="23" nowrap bgcolor="#F7FBFF"><div align="right">副版主：</div></td>
							  <td width="66%" height="23" bgcolor="#F7FBFF"><input name="admin1" type="text" value="<%=category[10]%>" size="40" ></td>
							</tr>
							<tr >
							  <td width="34%" height="23" nowrap bgcolor="#F7FBFF"><div align="right">是否允许发新文章：</div></td>
							  <td width="66%" height="23" bgcolor="#F7FBFF"><select name="is_create">
																										<option value="1" <%=getSelected(category[11],"1")%>>是</option>
																										<option value="0" <%=getSelected(category[11],"0")%>>否</option>
																								</select>
							  </td>
							</tr>
							<tr >
							  <td width="34%" height="23" nowrap bgcolor="#F7FBFF"><div align="right">是否允许回复文章：</div></td>
							  <td width="66%" height="23" bgcolor="#F7FBFF"><select name="is_reply">
																										<option value="1" <%=getSelected(category[12],"1")%>>是</option>
																										<option value="0" <%=getSelected(category[12],"0")%>>否</option>
																								</select>
							  </td>
							</tr>
							<tr >
							  <td width="34%" height="23" nowrap bgcolor="#F7FBFF"><div align="right">是否图文混排模式：</div></td>
							  <td width="66%" height="23" bgcolor="#F7FBFF"><select name="is_html">
																										<option value="1" <%=getSelected(category[13],"1")%>>是</option>
																										<option value="0" <%=getSelected(category[13],"0")%>>否</option>
																								</select>
							  </td>
							</tr>
							<tr >
							  <td width="34%" height="23" nowrap bgcolor="#F7FBFF"><div align="right">是否进行权限控制：</div></td>
							  <td width="66%" height="23" bgcolor="#F7FBFF"><select name="is_qx">
																										<option value="1" <%=getSelected(category[14],"1")%>>是</option>
																										<option value="0" <%=getSelected(category[14],"0")%>>否</option>
																								</select>
							  </td>
							</tr>
							<tr class="qiangdiaotd1">
								<td nowrap  bgcolor="#F7FBFF"><div align="right">允许访问的部门</div></td>
								<td  bgcolor="#F7FBFF"><select name="departments" multiple>
											<% for (int i=0;i<allDepartment.length;i+=2) { %>
												<option value="<%=allDepartment[i]%>" <%=(category[15]).indexOf(","+allDepartment[i]+",")<0?"":"selected"%>><%=allDepartment[i+1]%></option>
											 <% } %>
									</select></td>
							</tr>
							<tr>
								<td nowrap  bgcolor="#F7FBFF"><div align="right">允许访问的人员</div></td>
								<td  bgcolor="#F7FBFF"><select name="users" multiple>
											<% for (int i=0;i<allUsers.length;i+=2) { %>
												<option value="<%=allUsers[i]%>"  <%=(category[16]).indexOf(","+allUsers[i]+",")<0?"":"selected"%>><%=allUsers[i+1]%></option>
											   <% } %>
										</select></td>  
							</tr>
							<tr>
							  <td height="23" nowrap bgcolor="#F7FBFF"><input name="cid" type="hidden" value="<%=category[1]%>">
								&nbsp;</td>
							  <td height="23" bgcolor="#F7FBFF"><input name="submit" type="submit" value="保存"></td>
							</tr>
						  </table>
						</form>
						</td>
						  </tr>
						</table>
			
</body>
</html>

