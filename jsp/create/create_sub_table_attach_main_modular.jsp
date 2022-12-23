<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.net.*"%>
<%


   String modulId = request.getParameter("modul_id");
   String tableName = request.getParameter("id");


		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}

	     if( request.getMethod().equalsIgnoreCase("post") )
         {
             Serve.autoCreatSubAttachMain( request );

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








	
<form name="inputForm" method="post" action="create_sub_table_attach_main_modular.jsp" >
<input type="hidden" name="modul_id" value="<%=modulId%>">
<input type="hidden" name="tableName" value="<%=tableName%>">

<table  width="100%"   border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
	<tr  align="center" >
			<td  align="center" class="tabletitle" colspan="4"> 子表向主表导入数据创建  </td>
    </tr>


    <tr >
		<td class="tabletitle"  >主表名称：</td>                                                                                     
		<td class="tabletitle"  align="left" colspan="3" ><%=tableName%></td>   
    </tr>

    <tr >
		<td class="tabletitle" colspan="4" >&nbsp;</td>
    </tr>

    <tr >
		<td class="tabletitle"  >子表名称：</td>                                                                                     
		<td class="tabletitle"  ><input name="subTableName"  type="text"  value=""></td>   

		
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
