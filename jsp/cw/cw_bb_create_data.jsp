<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%
	String result[];
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}
	     if( request.getMethod().equalsIgnoreCase("post") )
         {  
			CWService.create_bb_data( request );        

			 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("该报表数据已经成功生成 ！","UTF-8"));
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

				<form name="form1" action="cw_bb_create_data.jsp" method="post" onSubmit="return doCheck(this)">
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
					  <tr>
						<td align="left"><br/>报表日期：
								<input name=bbrq  type=text  regName =报表日期 reg=_date_ value=><a href='#' onclick='doSelectCalendar("bbrq")'>选择</a>&nbsp;
							  <input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
							  <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
							  <input type="hidden" name="is_reopen" value="1">
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="保存" onclick="_click_button(form1)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>

						</td>
					  </tr>
					</table>
				</form>													
							 
											
			<!-- 内容区 -->

</body>
</html>
