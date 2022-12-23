<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
    String result[] = new String [2];
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}
		else
			result = Serve.getBillDetailResult( request );


%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
<script>
function printData()
{
      document.getElementById('button_area').style.display="none";
      window.print();
}
function init()
{
      document.getElementById('button_area').style.display="block";
    
}

function   window.onbeforeprint(){  
         	   document.getElementById('button_area').style.display="none";
 }   
   function   window.onafterprint(){  
         	   document.getElementById('button_area').style.display="block";
 } 
 
</script>
</head>
<body onload="init();">
<br/>
<div>
<table width="80%"  border="0" cellspacing="0" cellpadding="0" align="center">
   <tr>
    <td align="left"  valign="top"><%=result[1]%></td>
  </tr>
</table>
</div>
<div id="button_area"><table border="0"  width=50% height=100% align=center cellpadding=5 cellspacing=5><tr><td align=center><input type=button value='打印' onclick="printData();"></input>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=button value='关闭' onclick="javascript:window.close();"></input></td></tr></table></div>
</body>
</html>
