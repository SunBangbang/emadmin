<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html;charset=UTF-8">
		<link rel="stylesheet" href="/emadmin/css/c1/style_new.css">
		<%@include file="/emadmin/js/functions.jsp"%>
		<%@ include file="/emadmin/shared/checkPermission1.jsp"%>
		<script language=javascript src="/emadmin/js/pop_selections.js"></script>
	</head>
	<%
		String message = "";
		String result[] = null;
		try {
			result = OaService.getAlertDetail(request);
			OaService.updateAlertstate(request);

		} catch (Exception e) {
			message = "在访问数据库的时候发现错误，错误信息如下：<br>" + e.getMessage();
		}
	%>
	<SCRIPT LANGUAGE="JavaScript">
<!--
	function confirm() {
		return true;
	}
	function submit() {
		form1.submit();
		return true;
	}
	function show() {
		if(form1.reply.checked==true){
			reply_text.style.display="";
			
		} else {	
			reply_text.style.display="none";
			
		}
	}
	function hidePreset() {
			preset.style.display="none";
	}
	function showPreset() {
			preset.style.display="";
	}
//-->
</SCRIPT>
	<%
	if (result != null && result.length > 0) {
	%>
	<body onbeforeunload="javascript:confirm();">
		<!--页面顶部-->
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td class="x_xt_alert_bar_left">
					&nbsp;
					<font class="x_tixing_font"><b>预设/发送消息</b>
					</font>
				</td>
				<td class="x_xt_alert_bar_middle">
					&nbsp;
				</td>
				<td class="x_xt_alert_bar_right">
					&nbsp;
				</td>
			</tr>
		</table>

		<!--页面顶部图片-->
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td class="x_xt_alert_message_top_left">
					&nbsp;
				</td>
				<td class="x_xt_alert_message_top_middle">
					&nbsp;
				</td>
				<td class="x_xt_alert_message_top_right">
					&nbsp;
				</td>
			</tr>
		</table>

		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td class="x_xt_alert_left" rowspan="2">
					&nbsp;
				</td>
				<td>
					<!--页面的主要内容在此操作-->
					<form name="form1" method="post" action="xt_alert_message1.jsp">

						<table width="100%" border="0" cellpadding="5" cellspacing="0"
							bgcolor="#f9fbfd" align="center">

							<tr>
								<td style=" padding-top:0;" height=10%>
									<table width="100%" border="0" cellpadding="0" cellspacing="0"
										style="padding:1px" bgcolor="#f9fbfd">
										<tr>
											<td width="80px;" class="share" nowrap style="padding:5px">
												提醒类型:
											</td>
											<td nowrap style="padding:5px">
												<%=Server.getValueName("224", result[1])%>
												&nbsp;
											</td>
											<td width="80px;" nowrap style="padding:5px">
												发送时间:
											</td>
											<td nowrap style="padding:5px">
												<%=result[4]%>
												&nbsp;
											</td>
										</tr>
										<tr>
											<td width="80px;" nowrap style="padding:5px">
												<div>
													接&nbsp;收&nbsp;人:
												</div>
											</td>
											<td nowrap style="padding:5px">
												<%=result[7]%>
												&nbsp;
											</td>
											<td width="80px;" nowrap style="padding:5px">
												<div>
													发&nbsp;送&nbsp;人:
												</div>
											</td>
											<td nowrap style="padding:5px">
												<%=Server.getValueName("001", result[9])%>
												&nbsp;
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr height=10px;>
								<td class="share">
									<div>
										&nbsp;提醒内容:
										<%=result[15]%>
									</div>
								</td>
							</tr>
							<tr height="100px;">
								<td valign="center">
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td style="padding-left:5px;" align=LEFT>
												<div id="ccccc" style="display:block;">
													<%=Util.getChangeLine(result[5])%>
												</div>
											</td>
										</tr>
										<%
										if (result[11].length() > 0) {
										%>
										<tr>
											<td>
												附件:
												<a href="/upload/<%=result[11]%>" target="_blank"><%=result[11]%>
												</a>
											</td>
										</tr>
										<%
										}
										%>
									</table>
								</td>
							</tr>
							<tr>
								<td style="padding-left:18px;" height="60px">
									<table width="100%" border="0">
										<td width="15%">
											<div align="left">
												<input type="radio" name="clickType" value="nopop" checked
													onClick="hidePreset()">
												不再提醒
											</div>
										</td>
										<td width="15%">
											<div align="left">
												<input type="radio" name="clickType" value="delete"
													onClick="hidePreset()">
												永久删除
											</div>
										</td>
										<td width="55%">
											<div align="left">
												<input type="radio" name="clickType" value="realert"
													onClick="showPreset()">
												再次提醒
												<span id="preset" style="display:none"> <input
														name="alert_date" type="text"
														onclick="doSelectCalendar('alert_date');" size="10"
														maxlength="10" reg="_date_" regName="定时"> 日 <select
														name="alert_time1">
														<option value="00">
															00
														</option>
														<option value="01">
															01
														</option>
														<option value="02">
															02
														</option>
														<option value="03">
															03
														</option>
														<option value="04">
															04
														</option>
														<option value="05">
															05
														</option>
														<option value="06">
															06
														</option>
														<option value="07">
															07
														</option>
														<option value="08">
															08
														</option>
														<option value="09">
															09
														</option>
														<option value="10">
															10
														</option>
														<option value="11">
															11
														</option>
														<option value="12">
															12
														</option>
														<option value="13">
															13
														</option>
														<option value="14">
															14
														</option>
														<option value="15">
															15
														</option>
														<option value="16">
															16
														</option>
														<option value="17">
															17
														</option>
														<option value="18">
															18
														</option>
														<option value="19">
															19
														</option>
														<option value="20">
															20
														</option>
														<option value="21">
															21
														</option>
														<option value="22">
															22
														</option>
														<option value="23">
															23
														</option>
													</select> 时 <select name="alert_time2">
														<option value="01">
															01
														</option>
														<option value="02">
															02
														</option>
														<option value="03">
															03
														</option>
														<option value="04">
															04
														</option>
														<option value="05">
															05
														</option>
														<option value="06">
															06
														</option>
														<option value="07">
															07
														</option>
														<option value="08">
															08
														</option>
														<option value="09">
															09
														</option>
														<option value="10">
															10
														</option>
														<option value="11">
															11
														</option>
														<option value="12">
															12
														</option>
														<option value="13">
															13
														</option>
														<option value="14">
															14
														</option>
														<option value="15">
															15
														</option>
														<option value="16">
															16
														</option>
														<option value="17">
															17
														</option>
														<option value="18">
															18
														</option>
														<option value="19">
															19
														</option>
														<option value="20">
															20
														</option>
														<option value="21">
															21
														</option>
														<option value="22">
															22
														</option>
														<option value="23">
															23
														</option>
														<option value="24">
															24
														</option>
														<option value="25">
															25
														</option>
														<option value="26">
															26
														</option>
														<option value="27">
															27
														</option>
														<option value="28">
															28
														</option>
														<option value="29">
															29
														</option>
														<option value="30">
															30
														</option>
														<option value="31">
															31
														</option>
														<option value="32">
															32
														</option>
														<option value="33">
															33
														</option>
														<option value="34">
															34
														</option>
														<option value="35">
															35
														</option>
														<option value="36">
															36
														</option>
														<option value="37">
															37
														</option>
														<option value="38">
															38
														</option>
														<option value="39">
															39
														</option>
														<option value="40">
															40
														</option>
														<option value="41">
															41
														</option>
														<option value="42">
															42
														</option>
														<option value="43">
															43
														</option>
														<option value="44">
															44
														</option>
														<option value="45">
															45
														</option>
														<option value="46">
															46
														</option>
														<option value="47">
															47
														</option>
														<option value="48">
															48
														</option>
														<option value="49">
															49
														</option>
														<option value="50">
															50
														</option>
														<option value="51">
															51
														</option>
														<option value="52">
															52
														</option>
														<option value="53">
															53
														</option>
														<option value="54">
															54
														</option>
														<option value="55">
															55
														</option>
														<option value="56">
															56
														</option>
														<option value="57">
															57
														</option>
														<option value="58">
															58
														</option>
														<option value="59">
															59
														</option>
													</select> 分 </span>
											</div>
										</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td style="padding-left:5px;">
									<table width="100%" border="0">
										<tr height=10%>
											<td valign="top" style="padding-left:5px;"
												align=LEFT>
												<input type="checkbox" name="reply" value="1"
													onClick="show()">
												回复
											</td>
										</TR>
										<tr>
											<td valign="top">
												<div id="reply_text" style="display:none;padding-left:5px;">
													<textarea name="reply_alert_content"
														wrap="off | hard | virtual | physical" rows=6 cols=68
														style="border:1px solid #55a5d6;overflow:auto;background-color:#e8f6ff;"></textarea>
												</div>
											</td>
										</tr>
										</tr>
										<tr>
											<td valign="top">
												<div align="right">
													<input type="hidden" name="click" value="0">
													<input type="hidden" name="id" value="<%=result[0]%>">
													<input type="hidden" name="sender_time"
														value="<%=result[4]%>">
													<input type="hidden" name="sender" value="<%=result[9]%>">
													<input type="hidden" name="old_alert_content"
														value="<%=result[5]%>">
													<input type="hidden" name="receipt" value="<%=result[12]%>">
													<img src="/emadmin/images/c2/btn_tixing.jpg"
														onClick="javascript:form1.click.value='1';submit();"></img>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												&nbsp;
											</td>
										</tr>

									</table>
								</td>
							</tr>
						</table>
					</form>
				</td>
				<td class="x_xt_alert_right" rowspan="2">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td class="x_xt_alert_bottom_middle">
					&nbsp;
				</td>
			</tr>
		</table>

	</body>
	<%
	} else {
	%>
	<body>
		<table>
			<tr>
				<td>
					对不起，此条信息不存在！
				</td>
			</tr>
		</table>
	</body>
	<%
	}
	%>
</html>
