<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.lfbase.service.*"%>
<%
				response.setHeader("Pragma","No-cache"); 
                response.setHeader("Cache-Control","no-cache"); 
                response.setDateHeader("Expires", 0); 
String message = request.getParameter("message");
if (message==null || message.length()==0) message="操作成功！";
String back= request.getParameter("back");
%>
<html>
<head>
<title></title>
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/emadmin/shared/headres.jsp"%>
</head>
<body>
						<table width="100%"  border="0" cellpadding="0" cellspacing="0">
					  		<tr>
								<!-- 标题区开始--> 
								<td  class='x_import_kh_left'>
										&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
										温馨提示！
										</span>
								</td>
								<td  class='x_import_kh_right'>
									&nbsp;
								</td>
								<!-- 标题区结束 --> 
							  </tr>
						</table>

          			<table class="x_message_table" cellspacing="0" align="center">
						  <tr>
							<td align="center"  width="100"   class="x_message_message_td"><img src="/emadmin/images/c2/icon/message.gif"/> </td>
							<td  class="x_message_message_td">
                                       <%=message%>
							</td>
							<td class="x_message_message_td" colspan="2" style="vertical-align: bottom;text-align: right;">
								 <% if (back != null && back.length()>0) {%>
								 <img src="/emadmin/images/c2/button/bill_ok.gif" onMouseOver="this.style.cursor='hand'"   onclick='location.href="<%=back%>"'/>
								 <%}%>
								 &nbsp;&nbsp;
								 <%if (back == null || back.length()==0) {%>
								 <img src="/emadmin/images/c2/button/bill_back.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);'/>
								<%}%>
							</td>
						  </tr>
						</table>

</body>
</html>
