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

            
			 id = Serve.BMBillActionupdate( request );

        	 if (Serve.checkErrorString(id))
			 {
				response.sendRedirect("/emadmin/shared/usererror.jsp?id="+id);
				return;
			 }
			 
			 String url =Serve.getBmEditNextUrl( request );
			 
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



<script language=javascript>
<!--


 		function _click_button(form1) {
			if (document.getElementsByName('id')[0].value =="100")
			{
				form1.submit();
			}
			else
			{


				if (document.getElementsByName('_subArea_num')[0].value == "1")
				{
					for (var i = 0; i < form1.selectitem.options.length; i++)
						 form1.selectitem.options[i].selected = true;
					
					for (var i = 0; i < form1.nonselectitem.options.length; i++)
						 form1.nonselectitem.options[i].selected = true;
				}


				if (doCheck(form1)==true) {
					document.getElementById('_button_area' ).style.display="none";
					document.getElementById('_button_area_message' ).style.display="block";
					form1.submit();
				}

			}

		}
//-->
</script>



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

					<table class="x_bill_outer_table" cellspacing="0" align="center">
					  <tr>
						<td align="left">
			<form name="form1" method="post" action="edit.jsp"  onSubmit="return formBmQxsubmit()">
								<%=Serve.bMgetBillEditTemplate( request )%>
													<div align="center" id="_button_area" style="display:block"><img src="/emadmin/images/c2/button/bill_save.gif" onMouseOver="this.style.cursor='hand'" onclick="_click_button(form1)"> 
													<% String is_new_window=request.getParameter("is_new_window");
														if (is_new_window!=null && is_new_window.equals("1")) {%>
														<img src="/emadmin/images/c2/button/bill_close.gif" onMouseOver="this.style.cursor='hand'"   onclick='window.close();'/>
													<%} else {%>
														<img src="/emadmin/images/c2/button/bill_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);'>
													<%} %>
													</div>
													<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
			</form>													
						</td>
					  </tr>
					</table>
																
			<!-- 内容区 -->


</body>
</html>
