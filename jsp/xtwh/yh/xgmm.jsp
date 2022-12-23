<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.net.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%


   String modulId = request.getParameter("modul_id");

	     if( request.getMethod().equalsIgnoreCase("post") )
         {
             int id=Serve.changPassword( request );
        	 if (id>0)
			 {
				 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功 ！","UTF-8"));
				return;
			 }

			 String url  ="fail.htm";

			 response.sendRedirect(url);
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

<SCRIPT language=javascript>
    <!--
			function checkall(inputForm) {
						 if(inputForm.pwd1.value== ""){
						   alert("请输入原密码");
						  return false;
						  }
						  if (inputForm.pwd2.value == ""){
									 alert("请输入新密码!");
						 return false;
					}
					if (inputForm.pwd2.value == ""){
									 alert("请输入确认密码!");
						 return false;
					}
			   if(inputForm.pwd2.value!=inputForm.pwd3.value)
								   {
									 alert("两次输入的密码不一致");
									 return false;
								   }
			   if(inputForm.pwd2.value.length>10)
								{
									 alert("密码不能大于10位");
									 return false;
								   }
				return true;
			}
   //-->
</SCRIPT>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
 		function _click_button(form1) { 
			if (checkall(form1)==true) {
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
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						<%=Serve.getModulName( request )%>
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
			<!-- 内容区 -->
					<table cellspacing="0" class="x_list_result_table" align="center">
					<form name="form1" method="post" action="xgmm.jsp" >
								<input type="hidden" name="modul_id" value="<%=modulId%>">
								<tr >
									<td width="30%" height="20" align="right"  class="x_list_result_title_td"  nowrap>输入旧密码: </td>
									<td colspan="3" height="20"  class="x_list_result_td00"  > &nbsp;<input type="password" name="pwd1" size=30 class='text'><font color=red> *</font>
																															</td>
								</tr>
								<tr >
									<td width="30%" height="20" align="right"  class="x_list_result_title_td"  nowrap>输入新密码:</td>
									<td colspan="3" height="20"  class="x_list_result_td00"  > &nbsp;<input type="password" name="pwd2" size=30 class='text'><font color=red> *</font>
									</td>
								</tr>
								<tr >
									<td width="30%" height="20" align="right"  class="x_list_result_title_td"  nowrap>确认新密码:</td>
									<td colspan="3" height="20"  class="x_list_result_td00"  > &nbsp;<input type="password" name="pwd3" size=30 class='text'><font color=red> *</font>
									</td>
								</tr>
					</form>
					</table>
																
                                                    <br/>
													<div align="center" id="_button_area" style="display:block"><img src="/emadmin/images/c2/button/bill_save.gif" onMouseOver="this.style.cursor='hand'" onclick="_click_button(form1)"> 
													</div>
													<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
			<!-- 内容区 -->


</body>
</html>
