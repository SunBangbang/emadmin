<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*" %>
<%  if(session.getAttribute("userId")==null)  { %>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
		window.returnValue = false;
		window.dialogArguments.relogin=1;
		window.dialogArguments.url='/emadmin/index.jsp';
		window.close();
	//-->
	</SCRIPT>
<%}%>
<%


		String sfpcgl=request.getParameter("sfpcgl");
		String sfbzqgl=request.getParameter("sfbzqgl");
		String ch_id=request.getParameter("ch_id");
		
		String result = Serve.getChXgsxTemplate( request ); 

		


%>

<html>
<head>
<title><%=Serve.popGetTitle(request.getParameter("popid"))%></title>
<%@include file="/emadmin/shared/headres.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Pragma" content="no-cache">
</head>


<BODY>
<table width="100%"  border="0" align="center">
  <tr>
    <td align="center" valign="middle">
	<form name='form1' >
		<%=result%>
		
		      <br>
      <img src="/emadmin/images/c2/button/pop_ok.gif" onMouseOver="this.style.cursor='hand'"   onClick="doOK();"/>

	</form>	
	</td>
  </tr>
</table>
</BODY>
<script language="JavaScript">
<!--

function doOK() {
	if( doCheck( document.form1 ) )	
	{
		window.returnValue = true;
		if (window.returnValue == true && window.dialogArguments != null) {
			window.dialogArguments.pc =form1.pc.value;

			window.dialogArguments.scrq =form1.scrq.value;
			window.dialogArguments.sxrq =form1.sxrq.value;
			window.dialogArguments.yxq =form1.yxq.value;

			window.dialogArguments.xgsx ="";
			if (window.dialogArguments.pc != null && window.dialogArguments.pc !="")
				window.dialogArguments.xgsx += "批次:" +window.dialogArguments.pc;
			if (window.dialogArguments.scrq !=null && window.dialogArguments.scrq !=""){
				window.dialogArguments.xgsx += "  生产日期:" + window.dialogArguments.scrq;
				//window.dialogArguments.xgsx += "    有效期:" + window.dialogArguments.yxq;
				window.dialogArguments.xgsx += "  失效日期:" + window.dialogArguments.sxrq;
			}

			
		}
		window.close();
	}

}
//-->
</script>

</HTML>