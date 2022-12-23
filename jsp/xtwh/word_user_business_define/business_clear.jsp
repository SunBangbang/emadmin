<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/emadmin/shared/checkAdminPermission.jsp"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%


   String modulId = request.getParameter("modul_id");
   String id = request.getParameter("id");



	//读出标题
	String r_titel[]=Api.sb("select name from xt_uword_define where id = '"+ id +"'");
	String title = r_titel[0];


		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}

	     if( request.getMethod().equalsIgnoreCase("post") )
         {

			  Serve.userWordDefineClear( request ); 
			  Serve.reloadAll();

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



</head>

<body>

		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区 --> 
			<td height="" align="left" valign="middle" id="center_head_bg">
					<span class="center_title" style="width:100%;">
						&nbsp;&nbsp;&nbsp;
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
		  <!-- 内容区 -->
					<form name="inputForm" method="post" action="business_clear.jsp" >
					<input type="hidden" name="modul_id" value="<%=modulId%>">
					<input type="hidden" name="id" value="<%=id%>">

					<table  width="100%"   border="1" cellpadding="20" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
						<tr  align="center" >
								<td  align="center" class="tabletitle" colspan="4">[<%=title%>]WORD自定义业务清除</td>
						</tr>



						<tr >
						<td class="tabletitle">&nbsp;&nbsp;警告！<br>
							
							&nbsp;&nbsp;1、自定义业务清除，会丢失 [<%=title%>] 录入的业务数据。<br>
							&nbsp;&nbsp;2、为安全考虑，请做好数据备份和导出数据。<br>
							&nbsp;&nbsp;3、清除后，你对项目类型等不能修改的信息进行修改了。<br>
							&nbsp;&nbsp;4、如果你只是增加数据项目，请不要选择清除，你可以直接修改格式模板，然后，再选择“创建”就可以了。<br>
							&nbsp;&nbsp;5、清除后不可恢复，你确定继续吗？<br><br>
						</td>
						</tr>

						<tr > <td colspan="4" height="30"> 
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="确定清除数据" onClick="_click_button(inputForm)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
						</tr>
					  </table>

					</form>
			
			<!-- 内容区 -->
</body>
</html>
