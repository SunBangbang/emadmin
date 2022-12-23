<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.net.*"%>
<%


   String modulId = request.getParameter("modul_id");   




	     if( request.getMethod().equalsIgnoreCase("post") )
         {
             Serve.reload( request );

			 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功 ！","UTF-8"));
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








	
<form name="inputForm" method="post" action="reload.jsp" >
<input type="hidden" name="modul_id" value="<%=modulId%>">


<table  width="100%"   border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
	<tr  align="center" >
			<td  align="center" class="tabletitle" colspan="4"> 系统重新装载  </td>
    </tr>

    <tr >
    <td class="tabletitle"><input name="all" type="checkbox" id="cb1" value="all" >  全部重新装载 </td> 
    </tr>

    <tr >
    <td class="tabletitle"><input name="BillFactory" type="checkbox" id="cb1" value="BillFactory" >  表单 </td> 
    </tr>

    <tr >
    <td class="tabletitle"><input name="PopFactory" type="checkbox" id="cb1" value="PopFactory" >  弹出窗口 </td> 
    </tr>

	<tr >
    <td class="tabletitle"><input name="XtBillCopyFactory" type="checkbox" id="cb1" value="XtBillCopyFactory" >  表单复制 </td> 
    </tr>

	<tr >
    <td class="tabletitle"><input name="XtCountFactory" type="checkbox" id="cb1" value="XtCountFactory" >  统计 </td> 
    </tr>

	<tr >
    <td class="tabletitle"><input name="XtListFactory" type="checkbox" id="cb1" value="XtListFactory" >  列表 </td> 
    </tr>

	<tr >
    <td class="tabletitle"><input name="XtModuleFactory" type="checkbox" id="cb1" value="XtModuleFactory" >  功能定义 </td> 
    </tr>

	<tr >
    <td class="tabletitle"><input name="XtModulTypeFactory" type="checkbox" id="cb1" value="XtModulTypeFactory" >  功能类型定义 </td> 
    </tr>

	<tr >
    <td class="tabletitle"><input name="XtOptionFactory" type="checkbox" id="cb1" value="XtOptionFactory" >  代码表 </td> 
    </tr>


	<tr >
    <td class="tabletitle"><input name="XtTableFactory" type="checkbox" id="cb1" value="XtTableFactory" >  业务表定义 </td> 
    </tr>

	<tr >
    <td class="tabletitle"><input name="XtTableRelationFactory" type="checkbox" id="cb1" value="XtTableRelationFactory" >  业务表关系定义 </td> 
    </tr>

	<tr >
    <td class="tabletitle"><input name="XtTableUseLimitFactory" type="checkbox" id="cb1" value="XtTableUseLimitFactory" >  业务表使用控制定义 </td> 
    </tr>

	<tr >
    <td class="tabletitle"><input name="XtValueLimitFactory" type="checkbox" id="cb1" value="XtValueLimitFactory" >  业务表字段使用约束定义 </td> 
    </tr>

	<tr >
    <td class="tabletitle"><input name="XtMenuTree" type="checkbox" id="cb1" value="XtMenuTree" >  系统菜单 </td> 
    </tr>

	<tr >
    <td class="tabletitle"><input name="Qx" type="checkbox" id="cb1" value="Qx" >  岗位权限定义 </td> 
    </tr>



	<tr > <td colspan="4" height="20"> 
	   <div align="center">
        <input type=submit  value="提交" class="text" >&nbsp;
	    <input type=reset value="重填" class="text" >&nbsp;
       </div>
    </tr>
  </table>

</form>
	
			<!-- 内容区 -->
		<%@include file="/emadmin/shared/content_4.jsp"%>


</body>
</html>
