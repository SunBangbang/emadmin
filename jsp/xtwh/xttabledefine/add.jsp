<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%

	String id = "";
			if( !Serve.checkMkQx( request ) )
			{
				response.sendRedirect("/emadmin/shared/gotologin.jsp");
				return ;
			}


	     if( request.getMethod().equalsIgnoreCase("post") )
         {
             id=Serve.billActionInsert( request );
        	 if (Serve.checkErrorString(id))
			 {
				response.sendRedirect("/emadmin/shared/usererror.jsp?id="+id);
				return;
			 }
			 
			 //String modulId =Serve.getNextModule(request);

			 //response.sendRedirect(new String(("list.jsp?id="+id+"&modul_id=" +modulId).getBytes("gbk"), "iso8859-1"));
			 String url =Serve.getDMBEditNextUrl(request);

			 response.sendRedirect(url);

			 return ;
         }
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>
<body>
<form name="form1" method="post" action="add.jsp" onSubmit="return doCheck(form1)">
<table width="800"  border="0">
  <tr>
    <td>	
  <%=Serve.commonGetSheetForModify( request )[1]%>
    </td></tr>
</table>
<table width="100%"  border="0" cellspacing="10" cellpadding="0" align="center">
  <tr>
    <td align="center"><input type="submit" name="Submit" value="保存"></td>
  </tr>
</table>
</form>
</body>
</html>
