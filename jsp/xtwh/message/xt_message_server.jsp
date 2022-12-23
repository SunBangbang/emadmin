<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.io.*,org.apache.commons.io.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%


		if( !Serve.checkMkQx( request ) )
			{
				response.sendRedirect("/emadmin/shared/gotologin.jsp");
				return ;
			}

	     if( request.getMethod().equalsIgnoreCase("post") )
         {
			if (request.getParameter("status").equals("1")) {
                MessageService.startServer();

            } else {
                MessageService.stopServer();
            }
         }
         String r[]=MessageService.getStatus();
%>

<script language=javascript>
<!--
 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
//-->
</script>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>
<body>

		<table width="100%" border="0" cellpadding="0" cellspacing="0" >
			<tr>
				<!-- 标题区开始-->
				<td class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="index1_font"> 启动/停止服务 </span>
				</td>
				<td class='x_import_kh_right'>
					&nbsp;
				</td>
				<!-- 标题区结束 -->
			</tr>
		</table>
		  &nbsp;<!-- 按扭区 -->
		  <!-- 内容区 -->
					<table class="x_bill_outer_table" cellspacing="0" align="center">
						  <tr>
							<td align="left">	
							<form name="form1" method="post" action="">
									<table width="80%" border="0" align="center">
										<tr>
										  <td height="40"><p>目前信息服务器状态为： <%=r[0].equals("1")?"已启动":"已停止"%>
								            
									      </p> </td>
									  </tr>
								  </table>	
								 <input type="hidden" name="status" value="<%=r[0].equals("1")?"0":"1"%>">
	
							  	<div align="center" id="_button_area" style="display:block"><input type="Submit" name="Submit" value="<%=r[0].equals("1")?"停止服务":"启动服务"%>"></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
							</form>
								</td>
							  </tr>
					</table>
			
			<!-- 内容区 -->

</body>
</html>
