<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*"%>
<%@ include file="/emadmin/shared/checkPermission1.jsp"%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="css/main.css">
<style>
   BODY {margin: 0px;padding: 0px;}
   TD {font-size: 12px; LINE-HEIGHT: 25px;
       font-family: verdana,helvetica; 
	   text-decoration: none;
	   white-space:nowrap;}
   A  {text-decoration: none;
       color: black}
</style>
</head>

		<%
			    String cid = (String)request.getParameter("cid");
				String message="";
				String category[]=null;
				try {						
						category=ForumService.getCategoryNode(request);
					} catch (Exception e) {
						message="在访问数据库的时候发现错误，错误信息如下：<br>"+e.getMessage();
					}

		%>           

<body style="margin: 0px;padding: 0px;">

<table width="100%"  border="0"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="26" align="center" valign="middle">
	<table borderColorDark="#ffffff" borderColorLight="#66FFFF" width="100%" height="245" border="0" cellpadding="0" cellspacing="0">
      

<tr>
    <td valign="middle"><div align="right" style="background-image:url('/emadmin/images/c3/jsb.gif');height:26px;padding-top:7px;"><a href="lt_titlelist.jsp?cid=<%=cid%>" class="link_rc"><img src="\emadmin\images\c2\button\bill_back.gif" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></td>
  </tr>
  <tr>
    <td valign="top"><form name="form1" method="post" action="lt_newpaste1.jsp">
	<table width="100%"  border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
      <tr class="tabletitle">
        <td colspan="2" nowrap><div align="center">新建主题</div></td>
        </tr>
      <tr>
        <td width="13%" height="30"  nowrap><div align="center">主题</div></td>
        <td>
            <input type="text" name="title" size="122" maxlength="200">
        </td>
        </tr>
	<% if (category[13].equals("0")) {%>

      <tr>
        <td width="13%" height="30"><div align="center">正文</div></td>
        <td><input type=hidden name=ishtml value="">
          <textarea name="content" cols="80" rows="8">&nbsp;</textarea>
       </td>
      </tr>
	<% } else {%>
      <tr>
        <td width="13%" height="30"><div align="center">正文</div></td>
        <td>
		  <div style=" display:none "><input type=hidden name=ishtml value="1"><textarea name="content"></textarea></div>
<IFRAME ID="eWebEditor2" src="/emadmin/shared/webeditor/ewebeditor.htm?id=content&style=full" frameborder="0" scrolling="no" width="100%" height="530"></IFRAME>
       </td>
      </tr>
		
	<% } %>
      <tr>
        <td height="42" colspan="2" >
          <div align="center">
            <input type="hidden" name="cid" value="<%=cid%>">            
            <input type="image" src="\emadmin\images\c2\button\bill_save.gif" />
</div>
        </td>
      </tr>
    </table>
    </form></td>
  </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
