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
	
     result = Serve.getKm_RjzResult( request );

	 
%>
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
<html>
<head>
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>

<body >
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区 --> 
			<td height="" align="left" valign="middle" id="center_head_bg">
					<span class="center_title" style="width:100%;">
						&nbsp;&nbsp;&nbsp;<%=Serve.getModulName( request )%>
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
		  &nbsp;<!-- 按扭区 -->
		  <!-- 内容区 -->
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
						  <form action="kmyeb_qry.jsp" method="post" name="form1" >
						  <tr>
							<td align="left">	
								  <%=result%>							
							  	
						   </td>
						  </tr>
						  </form>
						</table>
			
			<!-- 内容区 -->

</body>
</html>
