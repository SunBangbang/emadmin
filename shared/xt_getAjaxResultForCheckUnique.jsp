<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*"%>
<%              //以下3句话防止cache
                response.setHeader("Pragma","No-cache"); 
                response.setHeader("Cache-Control","no-cache"); 
                response.setDateHeader("Expires", 0); 
				
				request.setCharacterEncoding("UTF-8") 	;
				response.setCharacterEncoding("UTF-8") ;

				String message="";
				String result=null;
				try {	
						result=Server.getAjaxResultForCheckUnique(request);	
					} catch (Exception e) {
                        e.printStackTrace();
                        System.out.println(e.getMessage());
						out.print("");
					}
                 out.print(result);
				
%>

