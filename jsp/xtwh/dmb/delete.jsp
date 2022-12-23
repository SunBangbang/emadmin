<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>

<%
	String id = request.getParameter("id");;
    String father_id=request.getParameter("father_id");

		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}

		Serve.BillActionXtDelete(request);


			 String url ;

			 String r[]=Api.sb("select max(id)  from xt_option_code where  '"+ id +"' like id +'%' and len(id)<len ('"+ id +"') ");

			 if (r.length >0)
				url ="list.jsp"+"?father_id="+ r[0] +"&modul_id=xt_option_code_listModul";
			 else
				url = "/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功 ！","UTF-8");

			response.sendRedirect(url);
			

/*	   
	
		 
	  String url =Serve.getDMBEditNextUrl( request );
	 response.sendRedirect(url);
					
*/

%>
