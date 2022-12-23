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
	


	 if( request.getMethod().equalsIgnoreCase("post") )   {
				 String url =Serve.getBm_GysyeResultUrl( request );
				 response.sendRedirect(url);
				 return;
      } else {
			 result = Serve.getKm_GysyeQryTemplate( request );
	  }
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

		function _doSelect_gys() {  
                 var  mySubDialog = new Array(1); 
                 var  idValue=''; 
                 idValue = document.getElementsByName('gys')[0].value; 
                 result=window.open('/emadmin/shared/popwindow.jsp?bringinitems=gysqc&popid=win_gysda&modul_id=cg_dd_listModul&keywords=' + idValue, mySubDialog,"resizable:Yes;status:no;dialogHeight:500px;dialogWidth:700px;"); 
                 if (result!=true) { 
                           return; 
                 } else { 
                           document.getElementsByName('gys' )[0].value=mySubDialog[0][1]; 
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
						  <form action="gyskmyeb_qry.jsp" method="post" name="form1" >
						  <tr>
							<td align="left">	
								  <%=result%>							
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="确定" onclick="_click_button(form1)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
						   </td>
						  </tr>
						  </form>
						</table>
			
			<!-- 内容区 -->

</body>
</html>
