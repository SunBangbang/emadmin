<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.net.*"%>
<%
	String result[];
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}
	
	Serve.testGetParameter(request);	
	String isstandardlist = request.getParameter( "isstandardlist" );
		 if( isstandardlist!=null && isstandardlist.equalsIgnoreCase("no")  )
         { 
			 Serve.batchSave( request );
			 
			 response.sendRedirect("/emadmin/shared/message.jsp?back=&message="+URLEncoder.encode("操作已成功 ！","UTF-8"));
			 return; 
         }
		 else 
			result = Serve.getBatchListResult( request );



%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<script language="javascript">
<!--
      function selectAll0(sender, name)	  
	  {
			for(i=0; i<form1.page_rows.value; i++)
			{
		        document.getElementsByName( name + i )[0].checked = sender.checked;
		    }
	  }



-->
</script>

<%@include file="/emadmin/shared/headres.jsp"%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
 		function _click_button(form1) { 
			if (true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
   //-->
</SCRIPT>
<style type="text/css">
        <!--
        body {padding:0px;margin:0px;}
        -->
</style>
</head>
<body>
			<!-- 内容区 -->

							<form name="form1" action="batch_bill.jsp" method="get">
								<%=result[0]%>
								<%=result[1]%>	
							  <input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
							  <input type="hidden" name="is_reopen" value="1">
							 <div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="提交选择" onclick="_click_button(form1)"></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>

							</form>  
											

</body>
</html>
