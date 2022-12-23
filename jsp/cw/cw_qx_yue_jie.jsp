<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%//生成工作日
	String result[];

				//读出当前日历
	        String r[]=Api.sb("select '系统当前月为'+qsrq+'至'+jsrq from jc_cw_kjrl where zt='002' ");


	
		if( !request.getMethod().equalsIgnoreCase("post") && !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}  
	     if( request.getMethod().equalsIgnoreCase("post") )
         {  
			   Api.ub( "exec CW_XTQXYJ " );       

			 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作成功 ！","UTF-8"));
			 return ;
         }


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<style type="text/css">
.readonly_input {
	height:18px;
	font-size: 12px;
	border:#7F9DB9 solid 0PX;
	margin:1px 2px 1px 2px;
    FONT-WEIGHT: normal;
    FONT-FAMILY: "宋体"
}

</style>
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
<body >
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

				<form name="form1" action="cw_qx_yue_jie.jsp" method="post">
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
					  <tr>
						<td align="left"><br/><%=r[0]%>; 取消上月的月结，需要把本月的全部凭证取消记账，你确认取消月结吗？
							  <input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
							  <input type="hidden" name="_mainCN" value="<%=request.getParameter("_mainCN")%>">
							  <input type="hidden" name="is_reopen" value="1">
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="确定" onclick="_click_button(form1)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>

						</td>
					  </tr>
					</table>
				</form>													
							 
											
			<!-- 内容区 -->

</body>
</html>







