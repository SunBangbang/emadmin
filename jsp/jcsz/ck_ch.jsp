<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,com.lf.util.*,java.util.*"%>
<%
	String result[];
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}
		result = Serve.getCkChResult( request );

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
				if (document.getElementById('_button_area' )!=null) document.getElementById('_button_area' ).style.display="none";
				if (document.getElementById('_button_area_message' )!=null) document.getElementById('_button_area_message' ).style.display="block";
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

				<form name="form1" action="ck_ch.jsp" method="get">
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
					  <tr>
						<td align="left" height="25">
								<%=result[0]%>&nbsp;&nbsp;<span id="btn"><img src="/emadmin/images/c2/button/list_start_serach.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form1);" style="vertical-align:top;padding-top:1px" /></span>
							  <input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
							  <input type="hidden" name="is_reopen" value="1">
						</td>
					  </tr>
					</table>
		

				<%
					if (result[1].length()>0 && result[1].indexOf("</tr>")<0) {%>
						<br><br><br><br><br>
						<div align="center"><font size=2 color=red>温馨提示:</font><font size=2>本次查询的货品信息有<%=result[1]%>条,可能需要较长时间，您愿意继续吗 ？</font> <br><br><br><img src="/emadmin/images/c2/button/bill_ok.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form1);" style="vertical-align:top;padding-top:1px" />&nbsp;&nbsp;&nbsp;<img src="/emadmin/images/c2/button/bill_cancel.gif" onMouseOver="this.style.cursor='hand'"   onClick="window.location.href='/emadmin/jsp/jcsz/ck_ch.jsp?modul_id=jc_ck_ch_dz'" style="vertical-align:top;padding-top:1px" />
						</div>
						<input type=hidden name="is_continue" value="1">
					</form>	
				<%} else {%>
					</form>	
					<% if (result[1].length()>0) { %>
					<form name="form2" action="ck_ch_edit.jsp" method="post">
						<table class="x_bill_outer_table" cellspacing="0" align="center">
						  <tr>
							<td align="left"><br/>
									<%=result[1]%>&nbsp;
								  <input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
								  <input type="hidden" name="is_reopen" value="1">
									<div align="center" id="_button_area" style="display:block; padding-top:10px;vertical-align:bottom;">
									<img src="/emadmin/images/c2/button/bill_save.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form2)"/> &nbsp;&nbsp;&nbsp;&nbsp;
										<img src="/emadmin/images/c2/button/bill_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);'/> 
									</div>
									<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>

							</td>
						  </tr>
						</table>
					</form>													
					<% } %>
				<% } %>											
			<!-- 内容区 -->
</body>
</html>
