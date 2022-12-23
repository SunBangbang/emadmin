<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*"%>
<%@ include file="/emadmin/shared/checkPermission1.jsp"%>
<html>
<head>
<title>crm</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/main.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style2 {
	font-size: 16px;
	font-weight: bold;
}
.style5 {color: #FF0000}
.style6 {font-size: 16px}
-->
</style></head>

		<%
				String userid=(String)session.getAttribute("userId");
				String rid=request.getParameter("rid");
				if (rid!=null) {
					OaService.delete_group(rid,userid);
				}
				String[] group=OaService.getList_group(userid);

%>         
<body>
<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0" borderColor="#cccccc" borderColorDark="#ffffff">
  <tr> 
    <td align="center" valign="top"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="5">
      <tr>
        <td height="235" valign="top"><font class="textNormal">
            <table class="newsListbody" cellSpacing="10" cellPadding="0" width="100%" border="0">
              <tr>
                <td height="180" align="left" valign="top"><table width="100%" height="180"  border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
                  <tr class="tabletitle"><td><font class="textNormal"> </a>&nbsp;&nbsp;  <a href="notebook.jsp" class="link_rc">记事本</a> &gt; 设置标签 </font></td></tr>
				  <tr>
                    <td height="125" valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                      <tr class="qiangdiaotd1">
                        <td><div align="center">标签编号</div></td>
                        <td><div align="center">标签名称</div></td>
                        <td><div align="center">颜色设置</div></td>
                        <td><div align="center">操作</div></td>
                      </tr>
					  <% for (int i=0;i<group.length;i+=3) {%>
                      <tr>
                        <td align="center"><%=group[i]%></td>
                        <td align="center"><%=group[i+1]%></td>
                        <td align="center" bgcolor="#<%=group[i+2]%>"></td>
                        <td align="center"><a href="notebookgroupdelete.jsp?id=<%=group[i]%>&name=<%=group[i+1]%>" class="linkline">删除</a>&nbsp;&nbsp;<a href="notebookgroupchange.jsp?id=<%=group[i]%>&name=<%=group[i+1]%>&color=<%=group[i+2]%>" class="linkline">修改</a></td>
                      </tr>
					  <% }%>
                      <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                    </table></td>
                  </tr>
			<% if (group.length/3<18) { %>
                  <tr class="qiangdiaotd">
                    <td height="26" valign="middle"><div align="center">填加新标签</div></td>
                  </tr>
                  <tr>
                    <td height="29" valign="top"><form name="form1" method="post" action="notebookgroupadd.jsp">
                      <div align="center">标签编号
                            <input name="id" type="text" size="4" maxlength="2">
								标签名称
							<input name="name" type="text" size="20" maxlength="20"> 
								 颜色设置
								<select name="color">
									 <option value="D2691E">红色</option>
									<option value="6B8E23">绿色</option>
									<option value="483D8B">暗灰蓝色</option>
									<option value="9ACD32">黄绿色</option>
									 <option value="DEB887">实木色</option>
									<option value="D8BFD8">紫色</option>
									<option value="FFB6C1">亮粉红色</option>
									<option value="F4A460">沙褐色</option>
								</select> 
							<input type="submit" name="Submit"  class="anniu" value="添加标签">                   
                      </div>
                    </form></td>
                  </tr>
			<% } %>
                </table></td>
              </tr>
            </table>
        </font></td>
      </tr>
    </table></td>
  </tr>
  <tr> 
    <td height="25" colspan="2" align="center" valign="top"></td>
  </tr>
</table>
<SCRIPT language=JavaScript>
<!-- 

function docheck()
{ 
} 

//--> 
</SCRIPT>
</body>
</html>
