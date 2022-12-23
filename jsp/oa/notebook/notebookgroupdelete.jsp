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
.style5 {color: #FF0000}
.style6 {font-size: 16px}
-->
</style></head>

		<%
				String userid=(String)session.getAttribute("userId");
				String id=(String)request.getParameter("id");
				String name=(String)request.getParameter("name");

%>           
<body>
<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0" borderColor="#cccccc" borderColorDark="#ffffff">
  <tr> 
    
    <td  align="center" valign="top"><table width="100%" border="0" cellspacing="5" cellpadding="0">
      <tr>
        <td valign="top"><font class="textNormal">
            <table class="newsListbody" cellSpacing="10" cellPadding="0" width="100%" border="0">
              <tr>
                <td height="50" align="left" valign="top"><font class="textNormal"> <a class="bclink" href="index.jsp"> </a> </font></td>
              </tr>
              <tr>
                <td align="left" valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="5">
  <tr> 
    <td  align="center" valign="top"><span class="style5"><span class="style6">警告</span></span>该标签下的所有信息将同时全部删除!<br>
      <br>你确定删除<span class="style5"><%=name%></span>标签及其信息吗？<br>
      <br>
	  <input type="button" name="Submit" value="确定删除" class="anniu" onClick="javascript:location.href='notebookeditgroup.jsp?rid=<%=id%>'">&nbsp;<input type="button" name="Submit" value="取消删除" class="anniu" onClick="javascript:history.back(-1);">
	</td>
  </tr>
                </table></td>
              </tr>
            </table>
        </font></td>
      </tr>
    </table></td>
  </tr>
  <tr> 
    <td height="25" colspan="2" align="center" valign="top">
</td>
  </tr>
</table>
</body>
</html>
