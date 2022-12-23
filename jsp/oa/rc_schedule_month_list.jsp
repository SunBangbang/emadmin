<%@page contentType="text/html;charset=UTF-8"%>
<%@page
	import="java.sql.*,com.lf.lfbase.service.*,com.lf.util.*,java.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
	String date = request.getParameter("date");
	if (date == null)
		date = Util.getDate();
	String firstDay = Util.getFirstDay(date);
	String lastDay = Util.getLastDay(date);
	String weekStart = Util.getWeekStart(firstDay);
	String weekEnd = Util.getWeekEnd(lastDay);
	String point = weekStart;
	int k = 0;
	String result[] = null;
	String work[] = null;
	result = OaService.getMonthList(date, request);
	work=OaService.getMonthListForAssignment(date,request);
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
					<span class="index1_font"> 日程表(<font color="red"><%=date.substring(5,7)%>月</font>)</span>
				</td>
				<td class='x_import_kh_right'>
					&nbsp;
				</td>
				<!-- 标题区结束 -->
			</tr>
		</table>
		<!--显示星期区域 -->
		<table width="99%" border="1" cellpadding="0" cellspacing="0"
			borderColorLight=#B3C3D0 borderColorDark=#ffffff  align="center">
			<tr>
				<td width="14%">
					<div align="center">
						星期一
					</div>
				</td>
				<td width="14%">
					<div align="center">
						星期二
					</div>
				</td>
				<td width="14%">
					<div align="center">
						星期三
					</div>
				</td>
				<td width="14%">
					<div align="center">
						星期四
					</div>
				</td>
				<td width="14%">
					<div align="center">
						星期五
					</div>
				</td>
				<td width="14%">
					<div align="center">
						星期六
					</div>
				</td>
				<td>
					<div align="center">
						星期日
					</div>
				</td>
			</tr>
			<!--按月视图循环日历开始 -->
			<%
			while (weekStart.compareTo(weekEnd) < 0) {
			%>
			<tr>
				<!--星期一 -->
				<td height="60" width="14%" valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<%
							if (weekStart.compareTo(firstDay) >= 0
									&& weekStart.compareTo(lastDay) <= 0) {
							%>
							<td bgcolor="dfe8f7">
								<div align="center">
									<%=weekStart%>
								</div>
							</td>
							<%
							} else {
							%>
							<td>
								<div align="center">
									&nbsp;
								</div>
							</td>
							<%
							}
							%>
						</tr>
						<tr>
							<td valign="top">
								<%
									while (k < result.length && point.compareTo(result[k + 1]) > 0)
										k += 10;
								%>
								<table width="100%" border="0">
									<%
									if (k < result.length && point.equals(result[k + 1])) {
										while (k < result.length && point.equals(result[k + 1])) {
									%>
									<tr>
										<td height="12px;">
											&nbsp;&nbsp;<%=result[k+2]%>
											<img src="/emadmin/images/c3/rc.gif">&nbsp;<a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rc_detailModul&id=<%=result[k+0]%>"><%=result[k+3]%></a>
										</td>
									</tr>
									<%
										k += 10;}}
									 else {
									%>
									<tr>
										<td>
											&nbsp;
										</td>
									</tr>
									<%
									}
									//现在开始循环任务
									for (int m=0;m<work.length;m+=5) {
										if (point.compareTo(work[m+2].substring(0,work[m+2].indexOf(" ")))>=0 && point.compareTo(work[m+3].substring(0,work[m+2].indexOf(" ")))<=0) { 
									 %>
									  <tr>
					          		 	<td > 
											&nbsp;&nbsp;<%=work[m+2].substring(work[m+2].indexOf(" ")+1,work[m+2].length())%>
											<img src="/emadmin/images/c3/rw_<%=work[m+4]%>.gif" style="vertical-align: text-bottom;">&nbsp;<a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rw_detailModul&id=<%=work[m+0]%>"><%=work[m+1]%></a>
										 </td>
									 </tr>
									<%}}%>
								</table>

							</td>
						</tr>
					</table>
				</td>
				
				<!--星期二 -->
				<td height="60" width="14%" valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<%
							if (Util.getDate(weekStart,1).compareTo(firstDay) >= 0
									&& Util.getDate(weekStart,1).compareTo(lastDay) <= 0) {
							%>
							<td bgcolor="dfe8f7">
								<div align="center">
									<%=Util.getDate(weekStart,1)%>
								</div>
							</td>
							<%
							} else {
							%>
							<td>
								<div align="center">
									&nbsp;
								</div>
							</td>
							<%
							}
							%>
						</tr>
						<tr>
							<td valign="top">
								<%
									point=Util.getDate(point,1);
									while (k < result.length && point.compareTo(result[k + 1]) > 0)
										k += 10;
								%>
								<table width="100%" border="0">
									<%
									if (k < result.length && point.equals(result[k + 1])) {
										while (k < result.length && point.equals(result[k + 1])) {
									%>
									<tr>
										<td height="12px;">
											&nbsp;&nbsp;<%=result[k+2]%>
											<img src="/emadmin/images/c3/rc.gif">&nbsp;<a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rc_detailModul&id=<%=result[k+0]%>"><%=result[k+3]%></a>
										</td>
									</tr>
									<%
										k += 10;}}
									 else {
									%>
									<tr>
										<td>
											&nbsp;
										</td>
									</tr>
									<%
									}
									//现在开始循环任务
									for (int m=0;m<work.length;m+=5) {
										if (point.compareTo(work[m+2].substring(0,work[m+2].indexOf(" ")))>=0 && point.compareTo(work[m+3].substring(0,work[m+2].indexOf(" ")))<=0) { 
									 %>
									  <tr>
					          		 	<td > 
											&nbsp;&nbsp;<%=work[m+2].substring(work[m+2].indexOf(" ")+1,work[m+2].length())%>
											<img src="/emadmin/images/c3/rw_<%=work[m+4]%>.gif" style="vertical-align: text-bottom;">&nbsp;<a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rw_detailModul&id=<%=work[m+0]%>"><%=work[m+1]%></a>
										 </td>
									 </tr>
									<%}}%>
								</table>
							</td>
						</tr>
					</table>
				</td>
				<!--星期三 -->
				<td height="60" width="14%" valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<%
							if (Util.getDate(weekStart,2).compareTo(firstDay) >= 0
									&& Util.getDate(weekStart,2).compareTo(lastDay) <= 0) {
							%>
							<td bgcolor="dfe8f7">
								<div align="center">
									<%=Util.getDate(weekStart,2)%>
								</div>
							</td>
							<%
							} else {
							%>
							<td>
								<div align="center">
									&nbsp;
								</div>
							</td>
							<%
							}
							%>
						</tr>
						<tr>
							<td valign="top">
								<%
									point=Util.getDate(point,1);
									while (k < result.length && point.compareTo(result[k + 1]) > 0)
										k += 10;
								%>
								<table width="100%" border="0">
									<%
									if (k < result.length && point.equals(result[k + 1])) {
										while (k < result.length && point.equals(result[k + 1])) {
									%>
									<tr>
										<td height="12px;">
											&nbsp;&nbsp;<%=result[k+2]%>
											<img src="/emadmin/images/c3/rc.gif">&nbsp;<a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rc_detailModul&id=<%=result[k+0]%>"><%=result[k+3]%></a>
										</td>
									</tr>
									<%
										k += 10;}}
									 else {
									%>
									<tr>
										<td>
											&nbsp;
										</td>
									</tr>
									<%
									}
									//现在开始循环任务
									for (int m=0;m<work.length;m+=5) {
										if (point.compareTo(work[m+2].substring(0,work[m+2].indexOf(" ")))>=0 && point.compareTo(work[m+3].substring(0,work[m+2].indexOf(" ")))<=0) { 
									 %>
									  <tr>
					          		 	<td > 
											&nbsp;&nbsp;<%=work[m+2].substring(work[m+2].indexOf(" ")+1,work[m+2].length())%>
											<img src="/emadmin/images/c3/rw_<%=work[m+4]%>.gif" style="vertical-align: text-bottom;">&nbsp;<a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rw_detailModul&id=<%=work[m+0]%>"><%=work[m+1]%></a>
										 </td>
									 </tr>
									<%}}%>
								</table>
							</td>
						</tr>
					</table>
				</td>
				<!--星期四 -->
				<td height="60" width="14%" valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<%
							if (Util.getDate(weekStart,3).compareTo(firstDay) >= 0
									&& Util.getDate(weekStart,3).compareTo(lastDay) <= 0) {
							%>
							<td bgcolor="dfe8f7">
								<div align="center">
									<%=Util.getDate(weekStart,3)%>
								</div>
							</td>
							<%
							} else {
							%>
							<td>
								<div align="center">
									&nbsp;
								</div>
							</td>
							<%
							}
							%>
						</tr>
						<tr>
							<td valign="top">
								<%
									point=Util.getDate(point,1);
									while (k < result.length && point.compareTo(result[k + 1]) > 0)
										k += 10;
								%>
								<table width="100%" border="0">
									<%
									if (k < result.length && point.equals(result[k + 1])) {
										while (k < result.length && point.equals(result[k + 1])) {
									%>
									<tr>
										<td height="12px;">
											&nbsp;&nbsp;<%=result[k+2]%>
											<img src="/emadmin/images/c3/rc.gif">&nbsp;<a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rc_detailModul&id=<%=result[k+0]%>"><%=result[k+3]%></a>
										</td>
									</tr>
									<%
										k += 10;}}
									 else {
									%>
									<tr>
										<td>
											&nbsp;
										</td>
									</tr>
									<%
									}
									//现在开始循环任务
									for (int m=0;m<work.length;m+=5) {
										if (point.compareTo(work[m+2].substring(0,work[m+2].indexOf(" ")))>=0 && point.compareTo(work[m+3].substring(0,work[m+2].indexOf(" ")))<=0) { 
									 %>
									  <tr>
					          		 	<td > 
											&nbsp;&nbsp;<%=work[m+2].substring(work[m+2].indexOf(" ")+1,work[m+2].length())%>
											<img src="/emadmin/images/c3/rw_<%=work[m+4]%>.gif" style="vertical-align: text-bottom;">&nbsp;<a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rw_detailModul&id=<%=work[m+0]%>"><%=work[m+1]%></a>
										 </td>
									 </tr>
									<%}}%>
								</table>
							</td>
						</tr>
					</table>
				</td>
				<!--星期五 -->
				<td height="60" width="14%" valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<%
							if (Util.getDate(weekStart,4).compareTo(firstDay) >= 0
									&& Util.getDate(weekStart,4).compareTo(lastDay) <= 0) {
							%>
							<td bgcolor="dfe8f7">
								<div align="center">
									<%=Util.getDate(weekStart,4)%>
								</div>
							</td>
							<%
							} else {
							%>
							<td>
								<div align="center">
									&nbsp;
								</div>
							</td>
							<%
							}
							%>
						</tr>
						<tr>
							<td valign="top">
								<%
									point=Util.getDate(point,1);
									while (k < result.length && point.compareTo(result[k + 1]) > 0)
										k += 10;
								%>
								<table width="100%" border="0">
									<%
									if (k < result.length && point.equals(result[k + 1])) {
										while (k < result.length && point.equals(result[k + 1])) {
									%>
									<tr>
										<td height="12px;">
											&nbsp;&nbsp;<%=result[k+2]%>
											<img src="/emadmin/images/c3/rc.gif">&nbsp;<a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rc_detailModul&id=<%=result[k+0]%>"><%=result[k+3]%></a>
										</td>
									</tr>
									<%
										k += 10;}}
									 else {
									%>
									<tr>
										<td>
											&nbsp;
										</td>
									</tr>
									<%
									}
									//现在开始循环任务
									for (int m=0;m<work.length;m+=5) {
										if (point.compareTo(work[m+2].substring(0,work[m+2].indexOf(" ")))>=0 && point.compareTo(work[m+3].substring(0,work[m+2].indexOf(" ")))<=0) { 
									 %>
									  <tr>
					          		 	<td > 
											&nbsp;&nbsp;<%=work[m+2].substring(work[m+2].indexOf(" ")+1,work[m+2].length())%>
											<img src="/emadmin/images/c3/rw_<%=work[m+4]%>.gif" style="vertical-align: text-bottom;">&nbsp;<a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rw_detailModul&id=<%=work[m+0]%>"><%=work[m+1]%></a>
										 </td>
									 </tr>
									<%}}%>
								</table>
							</td>
						</tr>
					</table>
				</td>
				<!--星期六 -->
				<td height="60" width="14%" valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<%
							if (Util.getDate(weekStart,5).compareTo(firstDay) >= 0
									&& Util.getDate(weekStart,5).compareTo(lastDay) <= 0) {
							%>
							<td bgcolor="dfe8f7">
								<div align="center">
									<%=Util.getDate(weekStart,5)%>
								</div>
							</td>
							<%
							} else {
							%>
							<td>
								<div align="center">
									&nbsp;
								</div>
							</td>
							<%
							}
							%>
						</tr>
						<tr>
							<td valign="top">
								<%
									point=Util.getDate(point,1);
									while (k < result.length && point.compareTo(result[k + 1]) > 0)
										k += 10;
								%>
								<table width="100%" border="0">
									<%
									if (k < result.length && point.equals(result[k + 1])) {
										while (k < result.length && point.equals(result[k + 1])) {
									%>
									<tr>
										<td height="12px;">
											&nbsp;&nbsp;<%=result[k+2]%>
											<img src="/emadmin/images/c3/rc.gif">&nbsp;<a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rc_detailModul&id=<%=result[k+0]%>"><%=result[k+3]%></a>
										</td>
									</tr>
									<%
										k += 10;}}
									 else {
									%>
									<tr>
										<td>
											&nbsp;
										</td>
									</tr>
									<%
									}
									//现在开始循环任务
									for (int m=0;m<work.length;m+=5) {
										if (point.compareTo(work[m+2].substring(0,work[m+2].indexOf(" ")))>=0 && point.compareTo(work[m+3].substring(0,work[m+2].indexOf(" ")))<=0) { 
									 %>
									  <tr>
					          		 	<td > 
											&nbsp;&nbsp;<%=work[m+2].substring(work[m+2].indexOf(" ")+1,work[m+2].length())%>
											<img src="/emadmin/images/c3/rw_<%=work[m+4]%>.gif" style="vertical-align: text-bottom;">&nbsp;<a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rw_detailModul&id=<%=work[m+0]%>"><%=work[m+1]%></a>
										 </td>
									 </tr>
									<%}}%>
								</table>
							</td>
						</tr>
					</table>
				</td>
				<!--星期天 -->
				<td height="60" width="14%" valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<%
							if (Util.getDate(weekStart,6).compareTo(firstDay) >= 0
									&& Util.getDate(weekStart,6).compareTo(lastDay) <= 0) {
							%>
							<td bgcolor="dfe8f7">
								<div align="center">
									<%=Util.getDate(weekStart,6)%>
								</div>
							</td>
							<%
							} else {
							%>
							<td>
								<div align="center">
									&nbsp;
								</div>
							</td>
							<%
							}
							%>
						</tr>
						<tr>
							<td valign="top">
								<%
									point=Util.getDate(point,1);
									while (k < result.length && point.compareTo(result[k + 1]) > 0)
										k += 10;
								%>
								<table width="100%" border="0">
									<%
									if (k < result.length && point.equals(result[k + 1])) {
										while (k < result.length && point.equals(result[k + 1])) {
									%>
									<tr>
										<td height="12px;">
											&nbsp;&nbsp;<%=result[k+2]%>
											<img src="/emadmin/images/c3/rc.gif">&nbsp;<a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rc_detailModul&id=<%=result[k+0]%>"><%=result[k+3]%></a>
										</td>
									</tr>
									<%
										k += 10;}}
									 else {
									%>
									<tr>
										<td>
											&nbsp;
										</td>
									</tr>
									<%
									}
									//现在开始循环任务
									for (int m=0;m<work.length;m+=5) {
										if (point.compareTo(work[m+2].substring(0,work[m+2].indexOf(" ")))>=0 && point.compareTo(work[m+3].substring(0,work[m+2].indexOf(" ")))<=0) { 
									 %>
									  <tr>
					          		 	<td > 
											&nbsp;&nbsp;<%=work[m+2].substring(work[m+2].indexOf(" ")+1,work[m+2].length())%>
											<img src="/emadmin/images/c3/rw_<%=work[m+4]%>.gif" style="vertical-align: text-bottom;">&nbsp;<a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rw_detailModul&id=<%=work[m+0]%>"><%=work[m+1]%></a>
										 </td>
									 </tr>
									<%}}%>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<%
					weekStart = Util.getDate(weekStart, 7);
					point = weekStart;
				}
			%>
			<!--按月视图循环日历结束 -->
		</table>
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
						href="/emadmin/jsp/oa/rc_schedule_month_list.jsp?date=<%=Util.getDate(date, -30)%>">上一月</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a
						href="/emadmin/jsp/oa/rc_schedule_month_list.jsp?date=<%=Util.getDate(date, 30)%>">下一月</a>
				</td>
			</tr>
		</table>
	</body>
</html>
