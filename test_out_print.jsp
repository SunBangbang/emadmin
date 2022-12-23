
<%@ page contentType="text/html; charset=UTF-8" %>
<%
   String sonOption="";
   try
   {
		String FZJB= request.getParameter("FZJB");
		sonOption="<option value='0'>abd</option>";
		out.println(sonOption);

   }
   catch(Exception e)
   {
	e.printStackTrace();
   }

%>