

<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.util.*,java.sql.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
	String id = "";
	String result = "";



	     if( request.getMethod().equalsIgnoreCase("post") )
         {

            
			 id = Serve.billActionUpdate( request );

        	 if (Serve.checkErrorString(id))
			 {
				response.sendRedirect("/emadmin/shared/usererror.jsp?id="+id);
				return;
			 }
			 
			 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作成功 ！","UTF-8"));
			 return ;
         }
		 else
			 result =Serve.getBillEditTemplate( request ); 

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
	  
		  <table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						<%=Serve.getModulName( request )%>
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
			<!-- 按扭区 --> 
							&nbsp;
			<!-- 按扭区 --> 
			<!-- 内容区 -->
					<table class="x_bill_outer_table" cellspacing="0" align="center">
						  <tr>
							<td align="left">	
								<form name="form1" method="post" action="gs_edit.jsp" >
					
										<input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
										 <%=result%>
													<div align="center" id="_button_area" style="display:block"><img src="/emadmin/images/c2/button/bill_save.gif" onMouseOver="this.style.cursor='hand'" onclick="_click_button(form1)"> 
														<img src="/emadmin/images/c2/button/bill_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);'>
													</div>
													<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
								</form>													
						   </td>
						  </tr>
						</table>
																
</body>
</html>
