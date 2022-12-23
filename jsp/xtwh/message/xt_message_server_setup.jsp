<%@page contentType="text/html;charset=UTF-8"%>
<%@page
	import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.io.*,org.apache.commons.io.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%!public String getSelected(String x1, String x2) {
		if (x1 == null || x2 == null)
			return "";
		if (x1.equals(x2)) {
			return "selected";
		} else {
			return "";
		}
	}%>
<%
	if (!Serve.checkMkQx(request)) {
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return;
	}

	if (request.getMethod().equalsIgnoreCase("post")) {
		MessageService.update(request);
		response
				.sendRedirect("/emadmin/shared/message.jsp?back=&message="
						+ URLEncoder.encode("操作已成功 ！", "UTF-8"));
		return;
	}
	String r[] = MessageService.getStatus();
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
		<style type="text/css">
body {padding:0px;margin:0px;}
table{
	margin: 0px;padding: 0px;color:#3d7298;
}
</style>
	</head>
	<body>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" >
			<tr>
				<!-- 标题区开始-->
				<td class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="index1_font"> 信息平台参数 </span>
				</td>
				<td class='x_import_kh_right'>
					&nbsp;
				</td>
				<!-- 标题区结束 -->
			</tr>
		</table>
		<!-- 按扭区 -->
		<!-- 内容区 -->
		<form name="form1" method="post" action="">
			<table width="95%"  align="center"  border ="1" cellpadding="0" cellspacing="0" borderColor=#dee7f6>
				<tr>
					<td height="30" width="100px;">
						&nbsp;&nbsp;短信服务提供商
					</td>
					<td height="30">
						&nbsp;&nbsp;<select name="smsCompany">
							<option value="yimeiruantong"
								<%=getSelected("yimeiruantong", r[1])%>>
								亿美通软
							</option>
							<option value="dongfangboxing"
								<%=getSelected("dongfangboxing", r[1])%>>
								东方博星
							</option>
							<option value="chinasms" <%=getSelected("chinasms", r[1])%>>
								商讯中国
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<td height="30">
						&nbsp;&nbsp;短信服务器地址：
					</td>
					<td height="30">
						&nbsp;&nbsp;<input type="text" name="smsHost" value="<%=r[2]%>">
					</td>
				</tr>
				<tr>
					<td height="30">
						&nbsp;&nbsp;短信服务器帐号：
					</td>
					<td height="30">
						&nbsp;&nbsp;<input type="text" name="smsUser" value="<%=r[3]%>">
					</td>
				</tr>
				<tr>
					<td height="30">
						&nbsp;&nbsp;短信服务器密码：
					</td>
					<td height="30">
						&nbsp;&nbsp;<input type="password" name="smsPassword" value="<%=r[4]%>">
					</td>
				</tr>
				<tr>
					<td height="30">
						&nbsp;&nbsp;短信发送时间：
					</td>
					<td height="30">&nbsp;&nbsp;
						为了不打扰别人休息，短信只能在
						<select name="smsSendTime1">
							<option value='00' <%=getSelected("00", r[9])%>>
								00
							</option>
							<option value='01' <%=getSelected("01", r[9])%>>
								01
							</option>
							<option value='02' <%=getSelected("02", r[9])%>>
								02
							</option>
							<option value='03' <%=getSelected("03", r[9])%>>
								03
							</option>
							<option value='04' <%=getSelected("04", r[9])%>>
								04
							</option>
							<option value='05' <%=getSelected("05", r[9])%>>
								05
							</option>
							<option value='06' <%=getSelected("06", r[9])%>>
								06
							</option>
							<option value='07' <%=getSelected("07", r[9])%>>
								07
							</option>
							<option value='08' <%=getSelected("08", r[9])%>>
								08
							</option>
							<option value='09' <%=getSelected("09", r[9])%>>
								09
							</option>
							<option value='10' <%=getSelected("10", r[9])%>>
								10
							</option>
							<option value='11' <%=getSelected("11", r[9])%>>
								11
							</option>
							<option value='12' <%=getSelected("12", r[9])%>>
								12
							</option>
							<option value='13' <%=getSelected("13", r[9])%>>
								13
							</option>
							<option value='14' <%=getSelected("14", r[9])%>>
								14
							</option>
							<option value='15' <%=getSelected("15", r[9])%>>
								15
							</option>
							<option value='16' <%=getSelected("16", r[9])%>>
								16
							</option>
							<option value='17' <%=getSelected("17", r[9])%>>
								17
							</option>
							<option value='18' <%=getSelected("18", r[9])%>>
								18
							</option>
							<option value='19' <%=getSelected("19", r[9])%>>
								19
							</option>
							<option value='20' <%=getSelected("20", r[9])%>>
								20
							</option>
							<option value='21' <%=getSelected("21", r[9])%>>
								21
							</option>
							<option value='22' <%=getSelected("22", r[9])%>>
								22
							</option>
							<option value='23' <%=getSelected("23", r[9])%>>
								23
							</option>
						</select>
						点至
						<select name="smsSendTime2">
							<option value='00' <%=getSelected("00", r[10])%>>
								00
							</option>
							<option value='01' <%=getSelected("01", r[10])%>>
								01
							</option>
							<option value='02' <%=getSelected("02", r[10])%>>
								02
							</option>
							<option value='03' <%=getSelected("03", r[10])%>>
								03
							</option>
							<option value='04' <%=getSelected("04", r[10])%>>
								04
							</option>
							<option value='05' <%=getSelected("05", r[10])%>>
								05
							</option>
							<option value='06' <%=getSelected("06", r[10])%>>
								06
							</option>
							<option value='07' <%=getSelected("07", r[10])%>>
								07
							</option>
							<option value='08' <%=getSelected("08", r[10])%>>
								08
							</option>
							<option value='09' <%=getSelected("09", r[10])%>>
								09
							</option>
							<option value='10' <%=getSelected("10", r[10])%>>
								10
							</option>
							<option value='11' <%=getSelected("11", r[10])%>>
								11
							</option>
							<option value='12' <%=getSelected("12", r[10])%>>
								12
							</option>
							<option value='13' <%=getSelected("13", r[10])%>>
								13
							</option>
							<option value='14' <%=getSelected("14", r[10])%>>
								14
							</option>
							<option value='15' <%=getSelected("15", r[10])%>>
								15
							</option>
							<option value='16' <%=getSelected("16", r[10])%>>
								16
							</option>
							<option value='17' <%=getSelected("17", r[10])%>>
								17
							</option>
							<option value='18' <%=getSelected("18", r[10])%>>
								18
							</option>
							<option value='19' <%=getSelected("19", r[10])%>>
								19
							</option>
							<option value='20' <%=getSelected("20", r[10])%>>
								20
							</option>
							<option value='21' <%=getSelected("21", r[10])%>>
								21
							</option>
							<option value='22' <%=getSelected("22", r[10])%>>
								22
							</option>
							<option value='23' <%=getSelected("23", r[10])%>>
								23
							</option>
						</select>
						点发送。
					</td>
				</tr>
				<tr>
					<td height="30">
						&nbsp;&nbsp;邮件服务器地址：
					</td>
					<td height="30">
						&nbsp;&nbsp;<input type="text" name="emailHost" value="<%=r[5]%>">
					</td>
				</tr>
				<tr>
					<td height="30">
						&nbsp;&nbsp;邮件服务器帐号：
					</td>
					<td height="30">
						&nbsp;&nbsp;<input type="text" name="emailUser" value="<%=r[6]%>">
					</td>
				</tr>
				<tr>
					<td height="30">
						&nbsp;&nbsp;邮件服务器密码：
					</td>
					<td height="30">
						&nbsp;&nbsp;<input type="password" name="emailPassword" value="<%=r[7]%>">
					</td>
				</tr>
				<tr>
					<td height="30">
						&nbsp;&nbsp;邮件发件地址：
					</td>
					<td height="30">
						&nbsp;&nbsp;<input type="text" name="emailAddress" value="<%=r[8]%>">
					</td>
				</tr>
			</table>
<br>
			<div align="center" id="_button_area" style="display: block">
				<input type="image" src="/emadmin/images/c2/button/bill_save.gif" >
			</div>
			<div align="center" id="_button_area_message" style="display: none;font-size:12px;">
				正在处理，请稍等...
			</div>
		</form>

		<!-- 内容区 -->

	</body>
</html>
