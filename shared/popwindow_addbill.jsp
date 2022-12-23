<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*" %>
<%

    	String modelId =(String) request.getParameter("add_bill_modul_id");
    	String linkaddr =(String) request.getParameter("linkaddr");
    	String back_item_value =(String) request.getParameter("back_item_value");
    	String _mainCN = request.getParameter("_mainCN");
    	String _mainID =(String) request.getParameter("_mainID");
    	String id =(String) request.getParameter("id");
    	

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
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/emadmin/css/main.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Pragma" content="no-cache">
</head>


<BODY  onLoad="setTarget(); " TOPMARGIN=0 LEFTMARGIN=0 BGPROPERTIES="FIXED" BGCOLOR="#FFFFFF" LINK="#000000" VLINK="#808080" ALINK="#000000">
<table width="100%"  border="0" align="center">
  <tr><input type="hidden" id="_global_save" value="">
    <td align="center" valign="middle"><iframe id="myframe"  name="myframe"  src="<%=linkaddr%>?modul_id=<%=modelId%><%=(_mainCN!=null?"&_mainCN="+_mainCN+"&_mainID="+_mainID+"&id="+id:"")%>&back_item_value=<%=back_item_value%>" width="700" height="500"></iframe></td>
  </tr>
</table>
</BODY>

</HTML>