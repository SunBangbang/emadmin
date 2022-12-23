<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%

	String result = "";
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}

		result =Serve.getAllSysItemOutput(  ); 

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


                                                                        
function formCreatTableSubmit()                                        
{                                                                       
	                                                                
	                                                                
	for (var i = 0; i < form1.selectadvancesearch.options.length; i++)  
	     form1.selectadvancesearch.options[i].selected = true;          
		                                                        
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
								导出的系统字段脚本：							
						   </td>
						  </tr>

						  <tr>
							<td>
								<textarea name="gznrms" cols=100 rows=30 class="tr1"    maxsize="600">
								<%=result%>
								</textarea>	
						   </td>
						  </tr>

						</table>
																
			<!-- 内容区 -->
		<%@include file="/emadmin/shared/content_4.jsp"%>
</body>
</html>
