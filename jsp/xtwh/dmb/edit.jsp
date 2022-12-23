<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.util.*,com.lf.lfbase.service.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>

<%

		String id = "";
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}


	     if( request.getMethod().equalsIgnoreCase("post") )
         {

            
			 id = Serve.DMBBillActionUpdateDMB( request );

        	 if (Serve.checkErrorString(id))
			 {
				response.sendRedirect("/emadmin/shared/usererror.jsp?id="+id);
				return;
			 }

			 String url ;

			 String r[]=Api.sb("select max(id)  from xt_option_code where  '"+ id +"' like id +'%' and len(id)<len ('"+ id +"') ");

			 if (r.length >0)
				url ="list.jsp"+"?father_id="+ r[0] +"&modul_id=xt_option_code_listModul";
			 else
				url = "/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功 ！","UTF-8");

			 
			 
			 response.sendRedirect(url);
			 return; 
         }

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
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
</head>

<body>

		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区 --> 
			<td height="" valign="middle" class='x_center_head_bg'>
					<span class="x_center_title" >
						<%=Serve.getModulName( request )%>
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
			<!-- 按扭区 --> 
							&nbsp;
			<!-- 按扭区 --> 
			<!-- 内容区 -->
					<table class="x_bill_outer_table" cellspacing="0" align="center">
			<form name="form1" method="post" action="edit.jsp" >
					  <tr>
						<td align="left"><%=Serve.getBillEditTemplate( request )%>
                                  <br/>
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
						</td>
					  </tr>
			</form>													
					</table>

</body>
</html>
