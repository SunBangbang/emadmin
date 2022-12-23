<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*"%>
<%@ include file="/emadmin/shared/checkPermission1.jsp"%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="css/main.css">
<%@include file="/emadmin/shared/headres.jsp"%>
</head>

		<%
				String message="";
				String category[]=null;
			    ObjPageBean p=null; 
				Object result[]=null;
				String id = (String)request.getParameter("id");
				String rid = (String)request.getParameter("rid");
				try {						
						category=ForumService.getCategoryNode(request);
						if (rid!=null) ForumService.deletePaste(rid,request);	
						p=ForumService.getPasteList(request,"20");					
						 if(p.r == null ||p.r.length == 0 ) {
							 message="没有文章！";
						 } else {
							result=p.r;
						 }
					} catch (Exception e) {
						message="在访问数据库的时候发现错误，错误信息如下：<br>"+e.getMessage();
					}
		%>           


<body>
	<table width="100%"  cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
 <% if (message.equals("")) {%>
	<tr>
    <td width="100%" style="background-image: url(/emadmin/images/c3/jsb.gif); background-repeat: repeat-x;">
	 	<%=category[3]%>[<%=result[3]%>]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="lt_titlelist.jsp?cid=<%=category[1]%>" class="linkline">返回</a> 
	 
	</td>
	</tr>
<tr>
 <td>

 <% for (int i=0;i<result.length;i+=19) { %>
	            
	
	<table width="100%"  border="1" cellpadding="5" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
      <tr class="tabletitle">
        <td colspan="6"><%=result[i+10].equals("0")?"主题":"回复主题"%>：<%=result[i+3]%></td>
      </tr>
	  <tr>
        <td width="26%" nowrap >发表人：&nbsp;<%=result[i+5]%></td>
        <td width="30%" nowrap>发表时间：&nbsp;<%=result[i+8]%></td>
        <td width="31%" nowrap>修改时间：&nbsp;<%=result[i+11]%></td>
       <%if(result[i+7].equals(session.getAttribute ("userId")) || category[9].equals(session.getAttribute("userId"))||
			 category[10].equals((String)session.getAttribute ("userId"))){%>  
			 <td width="4%" nowrap>
			 <a href="lt_changepaste.jsp?cid=<%=category[1]%>&id=<%=result[i+1]%>&father=<%=result[1]%>" class="linkline">修改</a></td>
         <%}else{%>
			<td>&nbsp;</td>    
		<%}%>
	        <td>&nbsp;</td>
         <%if(category[9].equals(session.getAttribute("userId"))||
			 category[10].equals((String)session.getAttribute ("userId"))){%>  
				 <td width="5%" nowrap>
				 <a href="lt_pastelist.jsp?id=<%=result[1]%>&rid=<%=result[i+1]%>&cid=<%=result[i+2]%>" class="linkline">删除</a></td>
              <%}else{%>
				<td>&nbsp;</td>     
			   <%}%>
	  
	  </tr>
      <tr>
        <td  colspan="6" style="background-color:white;">
		<%=result[i+13].equals("1")?(String)result[i+4]:Util.getChangeLine((String)result[i+4])%>&nbsp;</td>
      </tr>

      </table>
	  <%}%>
	<%=p.getBar(request)%>
    </td>
    </tr>
<%if(category[12].equals("1")){%>
  <tr>
    <td height="18">	
	<form name="form1" method="post" action="lt_pastelist1.jsp">

    <table width="100%"  border="0">
      <tr>
        <td nowrap>主题:
          <input type="text" name="title" value="" size="62" maxlength="200" style="background-color: white;">     
       </td>
	<% if (category[13].equals("0")) {%>

      <tr>
        <td>内容:<input type=hidden name=ishtml value="">
          <textarea name="content" cols="80" rows="8">&nbsp;</textarea>
       </td>
      </tr>
	<% } else {%>
      <tr>
        <td>内容:<input type=hidden name=ishtml value="1">
		  <div style=" display:none "><textarea name="content"></textarea></div>
<IFRAME ID="eWebEditor2" src="/emadmin/shared/webeditor/ewebeditor.htm?id=content&style=coolblue" frameborder="0" scrolling="no" width="96%" height="300"></IFRAME>
       </td>
      </tr>
		
	<% } %>
      <tr>
        <td >
		  <div align="center">
   		    <input type="hidden" name="cid" value="<%=category[1]%>">            
   		    <input type="hidden" name="father" value="<%=id%>">            
   		    <input type="hidden" name="id" value="<%=id%>">      
            <input type="image" name="Submit" src="/emadmin/images/c2/button/bill_ok.gif"  onclick="_click_button(form1)">
          </div></td>
      </tr>
    </table>
	</form>
	</td>
  </tr>
<%}%>
<% } else { %>
	<tr>
    <td width="100%">
	<table width="100%"  border="0">
	  <tr>
        <td width="56%" align="right"><a href="lt_titlelist.jsp?cid=<%=category[1]%>" class="linkline">返回</a> </td>
      </tr>
  	<tr><td><div align="center"><%=message%></div></td></tr>
  
	</table>
	</td>
	</tr>
	<%}%>
</table>


</body>
</html>
