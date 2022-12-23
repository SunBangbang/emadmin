<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="/emadmin/shared/checkPermission1.jsp"%>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*,java.net.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<%
	String cid=request.getParameter("cid");
	String src="left.jsp";
	if (cid!=null) src+="?cid="+cid+"&cname="+request.getParameter("cname");
		String dm_category[]=Api.sb("select top 1  cid from oa_forum_category order by id");
	String dm_cid="";
	
	if(dm_category==null || "".equals(dm_category)){
			 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("公司栏目项目为空，请先设置栏目！","UTF-8"));
			 return; 
	
	}else{
	
			dm_cid=dm_category[0];
			String dm_name[]=Api.sb("select top 1  name from oa_forum_category  where cid="+dm_cid+" order by id ");
			if(dm_name==null || "".equals(dm_name)){
			 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("公司栏目项目为空，请先设置栏目！","UTF-8"));
			 return; 
	
			}
	
	}
%>
<frameset cols="120,*" frameborder="no" border="0" framespacing="0">
  <frame src="<%=src%>" name="leftFrame" scrolling="no" >
  <frame src="/emadmin/jsp/forum/web/lt_titlelist.jsp?cid=<%=dm_cid%>" name="mainFrame"  scrolling="auto" >
</frameset>
<noframes><body>
</body></noframes>
</html>
