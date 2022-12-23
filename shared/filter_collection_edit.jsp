<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
	String id = "";
	String result = "";
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}


	     if( request.getMethod().equalsIgnoreCase("post") )
         {

            
			 String url  = Serve.xtListFilterCollectionEditSave( request );
        	 
			 
			 
			 response.sendRedirect(url);
			 return; 
         }
		 else
			 result =Serve.getXtListFilterCollectionEditTemplate( request ); 

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
   //-->
</SCRIPT>

<body>
			<!-- 内容区 -->
    <table class="x_bill_outer_table" cellspacing="0" align="center">
          <tr>
            <td align="left">	
			<form name="form1" method="post" action="filter_collection_edit.jsp" >
							
							<%=result%>
                            </br>
                            <div align="center" id="_button_area" style="display:block; padding-top:10px;vertical-align:bottom;">
								<img src="/emadmin/images/c2/button/bill_save.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form1)"/> &nbsp;&nbsp;&nbsp;&nbsp;
                                <% String is_new_window=request.getParameter("is_new_window");
                                    if ((is_new_window!=null && is_new_window.equals("1")) || (request.getParameter("back_item_value")!=null)){%>
                                    <img src="/emadmin/images/c2/button/bill_close.gif" onMouseOver="this.style.cursor='hand'"   onclick='window.close();'/>
                                <%} else {%>
                                    <img src="/emadmin/images/c2/button/bill_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);'/> 
                                <%} %>
                                </div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
			</form>													
        </td>
      </tr>
    </table>
</body>
</html>
