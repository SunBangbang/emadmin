<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

	String id = "";
	String result;



	if( !Serve.checkMkQx( request ) )	{
 		response.sendRedirect("/emadmin/shared/gotologin.jsp");
 		return ;
 	}

	String old_filtertemplateid = request.getParameter("old_filtertemplateid");
	String filtertemplateid = request.getParameter("filtertemplateid");


	 if( request.getMethod().equalsIgnoreCase("post") && filtertemplateid.equalsIgnoreCase(old_filtertemplateid))   {
             id=Serve.warnDefineSetSaveWarnCondition( request );
        	 if (Serve.checkErrorString(id))  {
				response.sendRedirect("/emadmin/shared/usererror.jsp?id="+id);
				return;
			 } else {
                 String url="/emadmin/jsp/common/list.jsp?modul_id=xt_warn_define_listModul&_mainCN=view_xt_list&_mainID="+request.getParameter("_mainID")+"&id="+request.getParameter("_mainID");
            //String url =Serve.getDMBEditNextUrl( request )+"&id="+id;
				 response.sendRedirect(url);
				 return;
			 }
      } else {
			 result = Serve.warnDefineSetGetWarnCondition( request );
	  }
%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
		function _after_load() {
			

			for (var i = 0; i <form1.elements.length ; i++) 
			{
				
				thisItem=form1.elements.elements[i]; 
				
				if(thisItem.name.indexOf('maxcount')>0)
				{

					var maxcount_i = parseInt(thisItem.value);

					//alert (maxcount_i);

					if (maxcount_i <= 0)
						document.getElementsByName('add' )[0].click();


				}
				
			}
			
			
		}
 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
   //-->
</SCRIPT>
<html>
<head>
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>

<body onload="_after_load();">
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- ????????? --> 
			<td height="" valign="middle" class='x_center_head_bg'>
					<span class="x_center_title" >
						<%=Serve.getModulName( request )%>
					</span>
			</td>
			<!-- ????????? --> 
		  </tr>
		  </table>
          <!-- ????????? -->


		  <!-- ????????? -->
					<table class="x_bill_outer_table" cellspacing="0" align="center">
						  <tr>
							<td align="left">	
                                  <form action="warn_define_set_warn_condition.jsp" method="post" name="form1" >
                                  <input type="hidden" name="listretid" value="<%=request.getParameter("listretid")%>">
                                  <input type="hidden" name="_mainID" value="<%=request.getParameter("_mainID")%>">
                                  <tr>
                                    <td align="left">	
                                          <%=result%>							
                                        <div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="??????" onclick="_click_button(form1)">
                                        <% String is_new_window=request.getParameter("is_new_window");
                                            if (is_new_window!=null && is_new_window.equals("1")) {%>
                                            <img src="/emadmin/images/c2/button/bill_close.gif" onMouseOver="this.style.cursor='hand'"   onclick='window.close();'/>
                                        <%} else {%>
                                            <input type="button" name="cancel" value="??????"  onclick='javascript:history.back(-1);'>
                                        <%} %>
                                        </div>
                                        <div align="center" id="_button_area_message" style="display:none">????????????????????????...</div>
                                   </td>
                                  </tr>
                                  </form>
						   </td>
						  </tr>
						</table>
			<!-- ????????? -->

</body>
</html>
