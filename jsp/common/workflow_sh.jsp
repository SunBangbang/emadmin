<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}
         if( request.getMethod().equalsIgnoreCase("post") )   {
                Serve.doBillWorkFlowshenhe(request);
                String url =Serve.getNextUrl( request );
                response.sendRedirect(url);
         }

		String r=Serve.getBillWorkFlowshenhe(request);
        if (r.equals("")) {
		    String url =Serve.getNextUrl( request );
		    response.sendRedirect(url);
        }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
   //

 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
			
		}
   //-->
</SCRIPT>
</head>
<body>
					<table class="x_bill_outer_table" cellspacing="0" align="center">
					  <tr>
						<td align="left">
						    <form action="" method="post" name="form1" >
                                  <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
                                  <input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
                                        <%=r%>
                                </form >
                                   <div align="center" id="_button_area" style="display:block; padding-top:10px;vertical-align:bottom; clear:both;">
								<img src="/emadmin/images/c2/button/bill_save.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form1)"/> &nbsp;&nbsp;&nbsp;&nbsp;
                                    <img src="/emadmin/images/c2/button/bill_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);'/> 
                                </div>
								<div align="center" id="_button_area_message" style="display:none;clear:both;">正在处理，请稍等...</div>

                               </form>
                        </td>
					  </tr>
					</table>
</body>
</html>




