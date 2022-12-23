<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
	String result;
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}
		result = XSService.get_Acbj_bstzy( request );
		String num_p=request.getParameter("num_p");
		String num_a=request.getParameter("num_a");
		String dj=request.getParameter("dj");


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
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

				<form name="form1" action="get_acbj_bstzy.jsp" method="get">
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
					  <tr>
						<td align="left" height="25">
				
								<table class="ck_ch_table">
								
									<tr >
										<td  nowrap  class='list_result_td00' >数量P:
											<input  onFocus="this.select()"  type='text' name='num_p' value='<%=num_p%>' 
											regName ="数量P"  reg = "_r__real_" class="input_required" >
											<span style="color:red;">&nbsp;*</span></td>
										</td>
										<td  nowrap  class='list_result_td00' >数量A:
											<input  onFocus="this.select()"  type='text' name='num_a' value='<%=num_a%>' 
											regName ="数量A"  reg = "_r__real_" class="input_required" >
											<span style="color:red;">&nbsp;*</span></td>
										</td>
									</tr>

									<tr >
										<td  nowrap  class='list_result_td01' >单价:
											<input  onFocus="this.select()"  type='text' name='dj' value='<%=dj%>' 
											regName ="单价"  reg = "_r__real_" class="input_required" >
											<span style="color:red;">&nbsp;*</span></td>
										</td>
										
									</tr>

								</table>



							  <input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
							  <div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="确定" onclick="_click_button(form1)"> </div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
						</td>
					  </tr>
					</table>
				</form>	
				<form name="form2" action="rs_pb_edit.jsp" method="post">
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
					  <tr>
						<td align="left"><br/>
								成本合计：<%=result%>&nbsp;							  
						</td>
					  </tr>
					</table>
				</form>													
											
			<!-- 内容区 -->

</body>
</html>
