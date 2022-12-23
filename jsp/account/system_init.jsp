<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%


   String modulId = request.getParameter("modul_id");
   String tableName = request.getParameter("id");

   String ndyf = Serve.getNdYfResult ( request ); 


		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}

	     if( request.getMethod().equalsIgnoreCase("post") )
         {
			 String nd = request.getParameter("nd");
			 String yf = request.getParameter("yf");

             Serve.systemInit( request );

			 String qyrq = nd + "-"+yf + "-01";
			 Api.ub( "exec createKJRL '"+ qyrq +"'" ); 

			 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功，现在可以开始正式使用软件了 ！","UTF-8"));
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
					<form name="inputForm" method="post" action="system_init.jsp" >
					<input type="hidden" name="modul_id" value="<%=modulId%>">
					<input name="kj_qsrq" type="hidden" id="kj_qsrq" value="<%=Util.getDate()%>">

					<table  width="100%"   border="1" cellpadding="20" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
						<tr  align="center" >
								<td  align="center" class="tabletitle" colspan="4">系统启用</td>
						</tr>
						<tr >
						<td class="tabletitle">&nbsp;&nbsp;警告！<br>
							&nbsp;&nbsp;系统启用&nbsp;<%=ndyf%><br><br>
							&nbsp;&nbsp;1、系统启用将删除系统中所有已录入的数据，并将系统恢复到无数据的初始状态。<br>
							&nbsp;&nbsp;2、只有准备正式使用该系统，开始进行系统初始化时才进行此操作。<br>
							&nbsp;&nbsp;3、删除后数据将不可恢复，你确定继续吗？<br><br>
						</td>
						</tr>

						<tr > <td colspan="4" height="30"> 
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="确定清除数据并启用系统" onClick="_click_button(inputForm)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
						</tr>
					  </table>

					</form>
			
			<!-- 内容区 -->
</body>
</html>
