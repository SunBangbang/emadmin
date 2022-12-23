<%@page contentType="text/html;charset=UTF-8"%>
<%@page isErrorPage="true"%>
<%exception.printStackTrace();%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<style>

</style>
</head>
<%@include file="/emadmin/shared/headres.jsp"%>
<body>

						<table width="100%"  border="0" cellpadding="0" cellspacing="0">
					  		<tr>
								<!-- 标题区开始--> 
								<td  class='x_import_kh_left'>
										&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
											出现了异常情况！
										</span>
								</td>
								<td  class='x_import_kh_right'>
									&nbsp;
								</td>
								<!-- 标题区结束 --> 
							  </tr>
						</table>
						<table class="x_message_table" cellspacing="0" align="center">
						  <% if (exception.getMessage()==null) {%>
						  <tr>
							<td align="center"  width="100"   class="x_message_message_td"><img src="/emadmin/images/c2/icon/error.gif" onMouseOver="this.style.cursor='hand'"   onclick="detail.style.display=''"  align="center"/> </td>
							<td  class="x_message_message_td">
                                       系统出现了未知情况，请返回重试，或尝试重启服务 ！
							</td>
							<td class="x_message_message_td" colspan="2" style="vertical-align: bottom;text-align: right;">
								<img src="/emadmin/images/c2/button/bill_back.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);'/>
							</td>
						  </tr>
						<%} else {%>
						  <tr>
							<td align="center"  width="100"   class="x_message_message_td"><img src="/emadmin/images/c2/icon/error.gif" onMouseOver="this.style.cursor='hand'"   onclick="detail.style.display=''"  align="center"/> </td>
							<td  class="x_message_message_td">
								<%=exception.getMessage().replaceAll("Data truncation","您当前录入的数据过长，被系统截断，请修改后重试!")%>
							</td>
							<td class="x_message_message_td" colspan="2" style="vertical-align: bottom;text-align: right;">
								<img src="/emadmin/images/c2/button/bill_back.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);'/>
							</td>
						  </tr>
						<%}%>
						</table>
						 <div id='detail' style='display:none' width="80%" align="center"></br></br>
							<% for (int i=0;i<exception.getStackTrace().length;i++) {
								out.println(exception.getStackTrace()[i].toString()+"</br>" );
							}%>
							&nbsp;</div>
</body>
</html>


