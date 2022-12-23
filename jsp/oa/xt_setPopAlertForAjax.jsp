<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*"%>
		<%
                response.setHeader("Pragma","No-cache"); 
                response.setHeader("Cache-Control","no-cache"); 
                response.setDateHeader("Expires", 0); 
				String type=request.getParameter("type");
				// System.out.println(type);
				if (type!=null) {
						try {	
								Server.setPreference("001",(String)session.getAttribute("userId"),type);							
							 } catch (Exception e) {
								e.printStackTrace();
							}
				}
		%>           
