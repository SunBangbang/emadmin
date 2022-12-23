<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.lfbase.service.*,com.lf.util.Util,java.util.Date,java.text.SimpleDateFormat"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
	

	String date = request.getParameter("date");
	if (date == null)
		date = Util.getDate();
	String weekStart = Util.getWeekStart(date);
	int k = 0;
	String result[] = null;
	String work[] = null;
	result = OaService.getWeekList(date, request);
	work = OaService.getWeekListForAssignment(date, request);
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
	<body>

		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<!-- 标题区开始-->
				<td class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="index1_font"> 日程表(周) </span>
				</td>
				<td class='x_import_kh_right'>
					&nbsp;
				</td>
				<!-- 标题区结束 -->
			</tr>
		</table>
		<table width="99%" border="1" cellpadding="0" cellspacing="0" align="center" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
			<tr bgcolor="#e0e9f6">
				<td width="100%" height="2px;" valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						borderColorLight=#B3C3D0 borderColorDark=#ffffff height="2px;">
						<tr>
							<td width="14%" height="2px;">
								<div align="center">
									星期一
									<br>
									<%=weekStart%>
								</div>
							</td>
							<td width="14%">
								<div align="center">
									星期二
									<br>
									<%=Util.getDate(weekStart, 1)%>
								</div>
							</td>
							<td width="14%">
								<div align="center">
									星期三
									<br>
									<%=Util.getDate(weekStart, 2)%>
								</div>
							</td>
							<td width="14%">
								<div align="center">
									星期四
									<br>
									<%=Util.getDate(weekStart, 3)%>
								</div>
							</td>
							<td width="14%">
								<div align="center">
									星期五
									<br>
									<%=Util.getDate(weekStart, 4)%>
								</div>
							</td>
							<td width="14%">
								<div align="center">
									星期六
									<br>
									<%=Util.getDate(weekStart, 5)%>
								</div>
							</td>
							<td>
								<div align="center">
									星期日
									<br>
									<%=Util.getDate(weekStart, 6)%>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						borderColorLight=#B3C3D0 borderColorDark=#ffffff>
						<tr>
							<td width="14%" valign="top" style="border-right: 1px solid #B3C3D0;">
								<div>
									<%
										//星期一的日程安排,首先是日程安排，然后是任务安排
										for (int i = 0; i < result.length; i += 10) {
											if (result[i + 1].trim().equals(weekStart.trim()))
												out
												.println("&nbsp;•"
												+ result[i + 2]
												+ "&nbsp;<a href='/emadmin/jsp/common/detail.jsp?modul_id=oa_rc_detailModul&id="
												+ result[i + 0] + "'>" + result[i + 3]
												+ "</a></br>");

										}
										for (int i = 0; i < work.length; i += 5) {
											if (weekStart.compareTo(work[i + 3])>=0&&weekStart.compareTo(work[i + 4])<=0)
												out
												.println("&nbsp;•"
												+ work[i + 3].substring(work[i + 3]
														.indexOf(" ") + 1, work[i + 3]
														.length())
												+ "&nbsp;<a href='/emadmin/jsp/common/detail.jsp?modul_id=oa_rw_detailModul&id="
												+ work[i + 0] + "'>" + work[i + 1]
												+ "</a></br>");

										}
									%>
									&nbsp;
								</div>
							</td>
							<td width="14%" valign="top" style="border-right: 1px solid #B3C3D0;">
								<div>
									<%
										//星期二的日程安排
										for (int i = 0; i < result.length; i += 10) {
											if (result[i + 1].equals(Util.getDate(weekStart, 1)))
												out
												.println("&nbsp;•"
												+ result[i + 2]
												+ "&nbsp;<a href='/emadmin/jsp/common/detail.jsp?modul_id=oa_rc_detailModul&id="
												+ result[i + 0] + "'>" + result[i + 3]
												+ "</a></br>");

										}
										for (int i = 0; i < work.length; i += 5) {
											if (Util.getDate(weekStart, 1).compareTo(work[i + 3])>=0&&Util.getDate(weekStart, 1).compareTo(work[i + 4])<=0)
												out
												.println("&nbsp;•"
												+ work[i + 3].substring(work[i + 3]
														.indexOf(" ") + 1, work[i + 3]
														.length())
												+ "&nbsp;<a href='/emadmin/jsp/common/detail.jsp?modul_id=oa_rw_detailModul&id="
												+ work[i + 0] + "'>" + work[i + 1]
												+ "</a></br>");

										}
									%>
									&nbsp;
								</div>
							</td>
							<td width="14%" valign="top" style="border-right: 1px solid #B3C3D0;">
								<div>
									<%
										//星期三的日程安排
										for (int i = 0; i < result.length; i += 10) {
											if (result[i + 1].equals(Util.getDate(weekStart, 2)))
												out
												.println("&nbsp;•"
												+ result[i + 2]
												+ "&nbsp;<a href='/emadmin/jsp/common/detail.jsp?modul_id=oa_rc_detailModul&id="
												+ result[i + 0] + "'>" + result[i + 3]
												+ "</a></br>");
										}
										for (int i = 0; i < work.length; i += 5) {
											if (Util.getDate(weekStart, 2).compareTo(work[i + 3])>=0&&Util.getDate(weekStart, 2).compareTo(work[i + 4])<=0)
												out
												.println("&nbsp;•"
												+ work[i + 3].substring(work[i + 3]
														.indexOf(" ") + 1, work[i + 3]
														.length())
												+ "&nbsp;<a href='/emadmin/jsp/common/detail.jsp?modul_id=oa_rw_detailModul&id="
												+ work[i + 0] + "'>" + work[i + 1]
												+ "</a></br>");

										}
									%>
									&nbsp;
								</div>
							</td>
							<td width="14%" valign="top" style="border-right: 1px solid #B3C3D0;">
								<div>
									<%
										//星期四的日程安排
										for (int i = 0; i < result.length; i += 10) {
											if (result[i + 1].trim().equals(
											Util.getDate(weekStart, 3).trim()))
												out
												.println("&nbsp;•"
												+ result[i + 2]
												+ "&nbsp;<a href='/emadmin/jsp/common/detail.jsp?modul_id=oa_rc_detailModul&id="
												+ result[i + 0] + "'>" + result[i + 3]
												+ "</a></br>");
										}
										for (int i = 0; i < work.length; i += 5) {
											if (Util.getDate(weekStart, 3).compareTo(work[i + 3])>=0&&Util.getDate(weekStart, 3).compareTo(work[i + 4])<=0)
												out
												.println("&nbsp;•"
												+ work[i + 3].substring(work[i + 3]
														.indexOf(" ") + 1, work[i + 3]
														.length())
												+ "&nbsp;<a href='/emadmin/jsp/common/detail.jsp?modul_id=oa_rw_detailModul&id="
												+ work[i + 0] + "'>" + work[i + 1]
												+ "</a></br>");

										}
									%>
									&nbsp;
								</div>
							</td>
							<td width="14%" valign="top" style="border-right: 1px solid #B3C3D0;">
								<div>
									<%
										//星期五的日程安排
										for (int i = 0; i < result.length; i += 10) {
											if (result[i + 1].equals(Util.getDate(weekStart, 4)))
												out
												.println("&nbsp;•"
												+ result[i + 2]
												+ "&nbsp;<a href='/emadmin/jsp/common/detail.jsp?modul_id=oa_rc_detailModul&id="
												+ result[i + 0] + "'>" + result[i + 3]
												+ "</a></br>");
										}
										for (int i = 0; i < work.length; i += 5) {
											if (Util.getDate(weekStart, 4).compareTo(work[i + 3])>=0&&Util.getDate(weekStart, 4).compareTo(work[i + 4])<=0)
												out
												.println("&nbsp;•"
												+ work[i + 3].substring(work[i + 3]
														.indexOf(" ") + 1, work[i + 3]
														.length())
												+ "&nbsp;<a href='/emadmin/jsp/common/detail.jsp?modul_id=oa_rw_detailModul&id="
												+ work[i + 0] + "'>" + work[i + 1]
												+ "</a></br>");

										}
									%>
									&nbsp;
								</div>
							</td>
							<td width="14%" valign="top" style="border-right: 1px solid #B3C3D0;">
								<div>
									<%
										//星期六的日程安排
										for (int i = 0; i < result.length; i += 10) {
											if (result[i + 1].equals(Util.getDate(weekStart, 5)))
												out
												.println("&nbsp;•"
												+ result[i + 2]
												+ "&nbsp;<a href='/emadmin/jsp/common/detail.jsp?modul_id=oa_rc_detailModul&id="
												+ result[i + 0] + "'>" + result[i + 3]
												+ "</a></br>");
										}
										System.out.println(work.length);
										for (int i = 0; i < work.length; i +=5) {
											if (Util.getDate(weekStart,5).compareTo(work[i + 3])>=0&&Util.getDate(weekStart,5).compareTo(work[i + 4])<=0)
												out
												.println("&nbsp;•"
												+ work[i + 3].substring(work[i + 3]
														.indexOf(" ") + 1, work[i + 3]
														.length())
												+ "&nbsp;<a href='/emadmin/jsp/common/detail.jsp?modul_id=oa_rw_detailModul&id="
												+ work[i + 0] + "'>" + work[i + 1]
												+ "</a></br>");

										}
									%>
									&nbsp;
								</div>
							</td>
							<td valign="top">
								<div>
									<%
										//星期天的日程安排
										for (int i = 0; i < result.length; i += 10) {
											if (result[i + 1].equals(Util.getDate(weekStart, 6)))
												out
												.println("&nbsp;•"
												+ result[i + 2]
												+ "&nbsp;<a href='/emadmin/jsp/common/detail.jsp?modul_id=oa_rc_detailModul&id="
												+ result[i + 0] + "'>" + result[i + 3]
												+ "</a></br>");
										}
										for (int i = 0; i < work.length; i += 5) {
											if (Util.getDate(weekStart, 6).compareTo(work[i + 3])>=0&&Util.getDate(weekStart, 6).compareTo(work[i + 4])<=0)
												out
												.println("&nbsp;•"
												+ work[i + 3].substring(work[i + 3]
														.indexOf(" ") + 1, work[i + 3]
														.length())
												+ "&nbsp;<a href='/emadmin/jsp/common/detail.jsp?modul_id=oa_rw_detailModul&id="
												+ work[i + 0] + "'>" + work[i + 1]
												+ "</a></br>");

										}
									%>
									&nbsp;
								</div>
							</td>
						</tr>
						<tr>

						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
		<!--这边挂显示的方式-->
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			borderColorLight=#B3C3D0 borderColorDark=#ffffff>
			<tr>
				<td width="100%" valign="top" align="center">
					<a href="/emadmin/jsp/oa/rc_schedule_month_list.jsp">按月显示</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a
						href="/emadmin/jsp/oa/rc_shedule_week_list.jsp?modul_id=oa_rc_listModul">按周显示</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="/emadmin/jsp/oa/rc_shedule_day_list.jsp">按天显示</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a
						href="/emadmin/jsp/oa/rc_shedule_week_list.jsp?modul_id=oa_rc_listModul&date=<%=Util.getDate(date, -7)%>">上一周</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a
						href="/emadmin/jsp/oa/rc_shedule_week_list.jsp?modul_id=oa_rc_listModul&date=<%=Util.getDate(date, 7)%>">下一周</a>
				</td>
			</tr>
		</table>
	</body>
</html>
