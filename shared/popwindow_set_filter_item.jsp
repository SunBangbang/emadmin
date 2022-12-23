<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*" %>
<html>
<head>
<title>选择筛选项目</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
</head>


<BODY TOPMARGIN=0 LEFTMARGIN=0 BGPROPERTIES="FIXED"  LINK="#000000" VLINK="#808080" ALINK="#000000">
<table width="100%"  border="0" align="center">
  <tr>
    <td align="center" valign="middle"><iframe src="w_set_filter_item.jsp?filtertemplateid=<%=request.getParameter("filtertemplateid")%>"  height="550" width="700"></iframe></td>
  </tr>
</table>
</BODY>

</HTML>