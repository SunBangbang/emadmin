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
             Serve.autoCreatSubBill( request );

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
<SCRIPT LANGUAGE='JavaScript'>
    <!--
 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
   //-->
</SCRIPT>

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








	
<form name="inputForm" method="post" action="create_sub_table_modular.jsp" >
<input type="hidden" name="modul_id" value="<%=modulId%>">
<input type="hidden" name="tableName" value="<%=tableName%>">

<table  width="100%"   border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
	<tr  align="center" >
			<td  align="center" class="tabletitle" colspan="4"> 子表单模板创建  </td>
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
		<td class="tabletitle"  ><input name="subTableName"  type="text"  value="<%=tableName%>_sub"></td>   

		<td class="tabletitle"  >子表的外键名称：</td> 
		<td class="tabletitle"  ><input name="foreignKey"  type="text"  value="fid"></td>   

    </tr>

    <tr >
		<td class="tabletitle" colspan= "4" >  不需要创建子表到主表的统计和列表的表 ,请到 xt_preference的 not_creat_sub_to_main_list_and_count上注册</td>                                                                                     
		

    </tr>

	<tr > <td colspan="4" height="20"> 
	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="提交" onclick="_click_button(inputForm)">
    &nbsp;
	    <input type=reset value="重填" class="text" >&nbsp;
       </div><div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
    </tr>
  </table>

</form>
	
			<!-- 内容区 -->
		<%@include file="/emadmin/shared/content_4.jsp"%>


</body>
</html>
