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
</head>

		<%
				String message="";
			    String cid = (String)request.getParameter("cid");
				String category[]=null;
				String result[]=null;
				String id = (String)request.getParameter("id");
				String father = (String)request.getParameter("father");
				try {						
						result=ForumService.getPasteDetail(request);					
						category=ForumService.getCategoryNode(request);
					
					} catch (Exception e) {
						message="在访问数据库的时候发现错误，错误信息如下：<br>"+e.getMessage();
					}

		%>           

<body>
<table width="100%">
  <tr>
    <td align="center" valign="middle">
    <table  borderColorLight=#B3C3D0 borderColorDark=#ffffff width="100%" border="1" cellpadding="0" cellspacing="0">
	  <tr class="tabletitle"><td><table width="100%" cellpadding="0" cellspacing="0">
      <tr>
        <td width="17%"  >&nbsp;		</td>
        <td width="66%"  ><div align="center"> 修改帖子 </div></td>
        <td width="17%"  ><div align="right"><a href="lt_pastelist.jsp?cid=<%=cid%>&id=<%=father%>" class="linkline">返回</a></div></td>
      </tr></table></td></tr>  
	  
<tr><td height="100"  align="center" valign="top">
   <form name="form1" method="post" action="lt_changepaste1.jsp">

      <table width="100%"  border="0" cellpadding="0" cellspacing="0"  borderColorLight=#B3C3D0 borderColorDark=#ffffff>
      <tr>
        <td width="13%" height="30" align="center"  class="share" nowrap>标题:
       </td>
        <td width="87%" ><input name="title" type="text"size="62" maxlength="200" value="<%=result[2]%>"></td>
	<% if (category[13].equals("0")) {%>

      <tr>
        <td width="13%" height="30" nowrap><div align="center">正文</div></td>
        <td>
          <textarea name="content" cols="80" rows="8"><%=result[3]%></textarea>
       </td>
      </tr>
	<% } else {%>
      <tr>
        <td width="13%" height="30"><div align="center">正文</div></td>
        <td>
		  <div style=" display:none "><textarea name="content"><%=result[3]%></textarea></div>
<IFRAME ID="eWebEditor2" src="/emadmin/shared/webeditor/ewebeditor.htm?id=content&style=coolblue" frameborder="0" scrolling="no" width="600" height="300"></IFRAME>
       </td>
      </tr>
		
	<% } %>
      <tr>
         <td colspan="2" align="center">
     	 <input type="hidden" name="cid" value="<%=cid%>">            
     	 <input type="hidden" name="id" value="<%=result[0]%>">            
      	 <input type="hidden" name="father" value="<%=father%>">            
         <input type="submit" name="Submit" value="保存" class="anniu">
        </td>
      </tr>

    </table>
   </form>
   </td>
   </tr>

  </table></td>
  </tr>
</table>

</body>
</html>
