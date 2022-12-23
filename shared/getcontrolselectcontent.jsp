<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
                response.setHeader("Pragma","No-cache"); 
                response.setHeader("Cache-Control","no-cache"); 
                response.setDateHeader("Expires", 0); 
  try
   {
		String selectcontent = Serve.getSelectContent( request );
		//sonOption="<option value='0'>abd</option>";
		out.println(selectcontent);

   }
   catch(Exception e)
   {
	e.printStackTrace();
   }

%>