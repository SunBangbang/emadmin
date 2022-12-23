<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*" %>
<%

    	String modelId =(String) request.getParameter("modul_id");
    	
    	//如果 参数不存在，从页面中读取
    	if (modelId==null)
    	    modelId=(String)request.getParameter("_control_modul_id");

%>
<script type="text/javascript"> 
    window.onresize=setTarget;
	function setTarget(){
		 document.getElementById("myframe").height=document.body.clientHeight+"px";
		 document.getElementById("myframe").width=document.body.clientWidth+"px";
	}
</script>

<html>
<head>
<title><%=Serve.popGetTitle(request.getParameter("popid"))%></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
</head>


<BODY  onLoad="setTarget();" >
<table width="100%"  border="0" align="center">
  <tr><input type="hidden" id="_global_save" value="">
    <td align="center" valign="middle"><iframe id="myframe"  name="myframe"  src="pop.jsp?bringinitems=<%=request.getParameter("bringinitems")%>&cz_id=<%=request.getParameter("cz_id")%>&czbm=<%=request.getParameter("czbm")%>&popid=<%=request.getParameter("popid")%><%=Serve.getPopControlParameter(request)%>&modul_id=<%=modelId%>&keywords=<%=request.getParameter("keywords")%>" width="700" height="500" ></iframe></td>
  </tr>
</table>
</BODY>

</HTML>