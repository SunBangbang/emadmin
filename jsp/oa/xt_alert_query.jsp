<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page language="java" import="com.lf.util.Util" %>
<% String moduleId="103440";%>
<html>
<head>
<title>crm</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/emadmin/css/c1/style_new.css">
</head>
<%@ include file="/emadmin/shared/checkPermission.jsp"%>
<%@ include file="/js/popSelections.js"%>
<%@ include file="/js/functions.jsp"%>
<jsp:useBean id="p" class="com.lf.crm.PageBean" scope="page"/>
<jsp:useBean id="alert" class="com.lf.crm.Alert" scope="page"/>
<jsp:useBean id="dm" class="com.lf.crm.DmBean" scope="page"/>
		<%
				String message="";
				String rid=request.getParameter("rid");
				try {	
						if (rid!=null) alert.deleteAlert(rid,session);	
						p=alert.getAlertList(request,session);	
					} catch (Exception e) {
						message="在访问数据库的时候发现错误，错误信息如下：<br>"+e.getMessage();
					}

		%>           
<body>
<table width="100%" height="203"  border="0">
  <tr>
    <td height="20" valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td height="104" valign="top">
<% if (message.equals("")) {%>
	<form name="form1" method="post" action="">
      <table width="100%"  border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
        <tr class="tabletitle">
          <td colspan="6" nowrap><div align="center">提醒列表</div></td>
          </tr>
        <tr>
          <td width="10%" height="22" nowrap><div align="center">提醒类型</div></td>
          <td width="8%" nowrap><div align="center">提醒时间</div></td>
          <td width="44%" nowrap><div align="center">提醒内容</div></td>
          <td width="9%" nowrap><div align="center">发送人</div></td>
          <td width="9%" nowrap><div align="center">发送时间</div></td>
          <td width="8%" nowrap><div align="center">操作</div></td>
          </tr>
	  <% for (int i=0;i<p.result.length;i+=p.resultCols) { %>
      <tr>
        <td nowrap><div align="center"><%=dm.getByName("dm_alert_type",p.result[i+1])%>&nbsp;</div></td>
        <td nowrap><div align="center"><%=p.result[i+3]%>&nbsp;</div></td>
        <td><a href="#" class="linkline" onclick="window.open('/jsp/xt_alert_message.jsp?id=<%=p.result[i]%>','','left=250,top=100,height=450,width=600,resizable=no,scrollbars=yes,status=no,toolbar=no,menubar=no,location=no')"><%=p.result[i+4]%></a>&nbsp;</td>
        <td nowrap><div align="center"><%=dm.getNameByUserId(p.result[i+8])%>&nbsp;</div></td>
        <td nowrap><div align="center"><%=p.result[i+9]%>&nbsp;</div></td>
        <td nowrap><div align="center"><a href="xt_alert_query.jsp?rid=<%=p.result[i]%>" class="linkline">永久删除</a></div></td>
      </tr>
	  <%}%></table>
		<%=p.getBar(request)%>
    </form>
<% } else { %>
	<div align="center"><%=message%></div>
<%}%>
	</td>
  </tr>
  <tr>
    <td height="31" valign="top">&nbsp;</td>
  </tr>
</table>
</body>
</html>