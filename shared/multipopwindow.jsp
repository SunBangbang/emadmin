<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*" %>
<%

    	String modelId =(String) request.getParameter("modul_id");
    	
    	//如果 参数不存在，从页面中读取
    	if (modelId==null)
    	    modelId=(String)request.getParameter("_control_modul_id");

%>
<script type="text/javascript"> 

	function setTarget(){
		 document.getElementById("myframe").height=document.body.clientHeight+"px";
		 document.getElementById("myframe").width=document.body.clientWidth+"px";
	}
</script>

<html>
<head>
<title><%=Serve.popGetTitle(request.getParameter("popid"))%></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/emadmin/css/main.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Pragma" content="no-cache">
</head>


<BODY  onLoad="setTarget();" TOPMARGIN=0 LEFTMARGIN=0 BGPROPERTIES="FIXED" BGCOLOR="#FFFFFF" LINK="#000000" VLINK="#808080" ALINK="#000000">
<table width="100%"  border="0" align="center">
  <tr>
    <td align="center" valign="middle"><iframe id="myframe"  src="multipop.jsp?bringinitems=<%=request.getParameter("bringinitems")%>&cz_id=<%=request.getParameter("cz_id")%>&czbm=<%=request.getParameter("czbm")%>&popid=<%=request.getParameter("popid")%><%=Serve.getPopControlParameter(request)%>&modul_id=<%=modelId%>&keywords=<%=request.getParameter("keywords")%>" width="700" height="500"></iframe></td>
  </tr>
</table>
</BODY>

</HTML>