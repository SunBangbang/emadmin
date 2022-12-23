<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.net.*"%>
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
 
			 Serve.saveSpecialList( request );

			 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功 ！","UTF-8"));
			 return; 
         }
		 else
			 result =Serve.createSpecialListTemplate( request ); 

%>





<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
<SCRIPT language=JavaScript>
<!-- 
function doSubmit( )
{
	if( doCheck( document.form1 ) )	
	     form1.submit();	
	else
	     return false;
}


                                                                        
function formCreatListSubmit()                                        
{                                                                       
	                                                                
	                                                                
	for (var i = 0; i < form1.selectadvancesearch.options.length; i++)  
	     form1.selectadvancesearch.options[i].selected = true;          
	                                                                
	for (var i = 0; i < form1.select_up_advancesearch.options.length; i++)     
	     form1.select_up_advancesearch.options[i].selected = true;             
	                                                                
	for (var i = 0; i < form1.selectitem.options.length; i++)     
	     form1.selectitem.options[i].selected = true;             
	                                                                
	for (var i = 0; i < form1.selectdefaultitem.options.length; i++)     
	     form1.selectdefaultitem.options[i].selected = true;             
	                                                                
	for (var i = 0; i < form1.selectmodulonlist.options.length; i++)     
	     form1.selectmodulonlist.options[i].selected = true;             
     	                                                        
		                                                        
	document.form1.submit();                                        
}                                                                       


-->
</SCRIPT>
</head>

<body>
		<%@include file="/emadmin/shared/content_1.jsp"%>
			<!-- 标题区 --> 
				<%=Serve.getModulName( request )%>
			<!-- 标题区 --> 
		<%@include file="/emadmin/shared/content_2.jsp"%>
			<!-- 按扭区 --> 
							&nbsp;
			<!-- 按扭区 --> 
		<%@include file="/emadmin/shared/content_3.jsp"%>
			<!-- 内容区 -->
						<table width="100%"  height='100%' border="0"  style='table-layout: fixed;'>
						  <tr>
							<td>	
						  <%=result%>							
						   </td>
						  </tr>
						</table>
																
			<!-- 内容区 -->
		<%@include file="/emadmin/shared/content_4.jsp"%>
</body>
</html>
