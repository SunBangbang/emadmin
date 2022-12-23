<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/emadmin/shared/checkAdminPermission.jsp"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%

	if( !Serve.checkMkQx( request ) )	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}


		String modulId = request.getParameter("modul_id");

	     if( request.getMethod().equalsIgnoreCase("post") )
         {
			 String n = request.getParameter("n");

			 Serve.cleanNMonthAgoWarnResult(n);
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
						&nbsp;&nbsp;&nbsp;<%=Serve.getModulName( request )%>
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
		  <!-- 内容区 -->
					<form name="inputForm" method="post" action="warn_clean_n_month_ago_result.jsp" >
					<input type="hidden" name="modul_id" value="<%=modulId%>">

					<table  width="100%"   border="1" cellpadding="20" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
						<tr  align="center" >
								<td  align="center" class="tabletitle" colspan="4">预警结果清除</td>
						</tr>




						<tr >
						<td class="tabletitle">
							&nbsp;&nbsp;清除&nbsp;<input onFocus="this.select()"  name="n"  type="text" value="12" regName ="几月前" size="5"  reg = "_int_" class="input_normal">个月前的预警结果信息！<br><br>
							&nbsp;&nbsp;警告！<br>
							&nbsp;&nbsp;1、结果清除后，不可以恢复。<br>
							&nbsp;&nbsp;2、如果想保留清除的预警结果信息，请先把数据导出到EXCEL文件，自行保存。<br>
							&nbsp;&nbsp;3、预警结果清除后，会提高预警信息处理的效率。<br>
							&nbsp;&nbsp;4、你确定继续吗？<br><br>
						</td>
						</tr>

						<tr > <td colspan="4" height="30"> 
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="确定" onClick="_click_button(inputForm)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
						</tr>
					  </table>

					</form>
			
			<!-- 内容区 -->
</body>
</html>
