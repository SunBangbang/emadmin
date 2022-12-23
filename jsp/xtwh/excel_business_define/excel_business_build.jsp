<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.net.*"%>
<%


   String modulId = request.getParameter("modul_id");
   String id = request.getParameter("id");

	//读出标题
	String r_titel[]=Api.sb("select name from xt_excel_define where id = '"+ id +"'");
	String title = r_titel[0];

		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}

	     if( request.getMethod().equalsIgnoreCase("post") )
         {
             Serve.saveExcelDefineSet( request );

			 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功 ！为使操作生效，请按F5刷新页面，或退出系统并重新登录！","UTF-8"));
			 return ;
         }
		 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>

<script language=javascript src="/emadmin/js/do_check.js"></script>
<script language=javascript src="/emadmin/js/pop_selections.js"></script>
<script language=javascript src="/emadmin/js/bi_sub_table.js"></script>
<script language=javascript src="/emadmin/js/print.js"></script>

<script language=javascript>
<!--

function formBmQxsubmit()
{
	
	return doCheck(form1)
}


-->
</script>

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








	
<form name="form1" method="post" action="excel_business_build.jsp"   onSubmit="return formBmQxsubmit()">
<input type="hidden" name="modul_id" value="<%=modulId%>">
<input type="hidden" name="id" value="<%=id%>">

<table  width="100%"   border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
	<tr  align="center" >
			<td  align="center" class="tabletitle" > EXCEL自定义业务设置  </td>
    </tr>
    <tr >
    <td class="tabletitle"> 标题：<%=title%>     </td>
    </tr>


  <tr>
    <td>	
       <%=Serve.getExcelDefineSet( request )%>
    </td>
  </tr>

	<tr > <td colspan="4" height="20"> 
	   <div align="center">
        <input type=submit  value="提交" class="text" >&nbsp;
	    
       </div>
    </tr>
  </table>

</form>
	
			<!-- 内容区 -->
		<%@include file="/emadmin/shared/content_4.jsp"%>


</body>
</html>
