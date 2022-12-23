<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*"%>
<%@include file="/emadmin/shared/checkPermission1.jsp"%>
<%
	 if( request.getMethod().equalsIgnoreCase("post") )   {
            //修改参数为不用提示
            Api.setXtPreferenceValueByName("isFirstRun","0");
            %>
              <SCRIPT language=JavaScript>
              <!-- 
                    
                window.close();
                --> 
              </SCRIPT>
            <%
	  }
%>
<html>
<body>
<form name="form1" method="post">
<img src="images/c1/start_window.gif" width="632" height="450" border="0" usemap="#Map">
<map name="Map"><area shape="rect" coords="392,364,409,381" href="#" onClick="form1.submit()"></map><br>
</form>
</body>
</html>






