<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}

	String result[] = null;

	     if( request.getMethod().equalsIgnoreCase("post") )
         {
            OaService.rwqs(request);
            
			

			 String url =Serve.getDMBEditNextUrl( request );
			 
			 response.sendRedirect(url+"&id="+request.getParameter("id"));
			 return; 
         } else {
            result=OaService.rwgetDatail(request);
         }

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
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
			<!-- 按扭区 --> 
							&nbsp;
			<!-- 按扭区 --> 
			<!-- 内容区 -->
			<form name="form1" method="post" action="" >
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
					<input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
					<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
					  <tr>
						<td align="right">任务主题：</td>
                        <td align="left"><div><%=result[5]%></div>
						</td>
					  </tr>
					  <tr>
						<td align="right">完成期限：</td>
                        <td align="left"><div><%=result[3]%></div>
						</td>
					  </tr>
					  <tr>
						<td align="right">任务内容：</td>
                        <td align="left"><div><%=result[6]%></div>
						</td>
					  </tr>
					  <tr>
						<td align="right">签收说明：</td>
                        <td align="left"><div><textarea name="qssm"   regName ="签收说明"  reg = "_r_" size="10" class="text_required"></textarea></div>
						</td>
					  </tr>
					  <tr>
						<td align="left" colspan="2">
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="保存" onclick="_click_button(form1)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>

						</td>
					  </tr>
					</table>
			</form>													
																
</body>
</html>
