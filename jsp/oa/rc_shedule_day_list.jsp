<%@page contentType="text/html;charset=UTF-8"%>
<%@page
	import="java.sql.*,com.lf.lfbase.service.*,com.lf.util.*,java.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
	String date = request.getParameter("date");
	if (date == null)
		date = Util.getDate();
	int k = 0;
	String result[] = null;
	String work[] = null;									
	result=OaService.getDayList(date,request);					
	work=OaService.getDayListForAssignment(date,request);					
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
		
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						日程表(<font color="red"><%=date %></font>)
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
		  <!--日程信息循环显示开始 -->
		 <table width="99%"  border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff align="center">
			  	<tr bgcolor="#d8e2f4">
			  		<td width="100px;" align="center">
			  			日期
			  		</td>
			  		<td width="70px;" align="center">
			  			时间
			  		</td>
			  		<td align="center">
			  			主题
			  		</td>
			  		<td width="70px;" align="center">
			  			日程状态
			  		</td>
			  	</tr>
			  	<%
			  		if(result.length!=0){
			  			for(int i=0;i<result.length;i+=8){
			  	%>
			  	<tr>
			  		<td align="center"><%=result[i+1]%></td>
			  		<td align="center"><%=result[i+2]%></td>
			  		<td>&nbsp;<img src="/emadmin/images/c3/rc.gif">&nbsp;<a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rc_detailModul&id=<%=result[i+0]%>"><%=result[i+3]%></a></td>
			  		<td align="center"><%=result[i+5]%></td>
			  	</tr>
			  	<%}}else{%>
			  	<tr>
			  		<td colspan="4" align="center">今日暂无日程安排</td>
			  	</tr>
			  	<%} %>
		  </table>
		  <!--日程信息循环显示结束 -->
		  <table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						相关任务(<font color="red"><%=date %></font>)
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
		   <!--相关任务循环显示开始 -->
		 <table width="99%"  border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff align="center">
			  	<tr bgcolor="#d8e2f4">
			  		<td align="center">
			  			任务主题
			  		</td>
			  		<td width="70px;" align="center">
			  			任务类型
			  		</td>
			  		<td width="150px;" align="center">
			  			开始日期
			  		</td>
			  		<td width="150px;" align="center">
			  			完成日期
			  		</td>
			  	</tr>
			  	<%
			  		if(work.length!=0){
			  			for(int i=0;i<work.length;i+=7){
			  	%>
			  	<tr>
			  		<td>&nbsp;<img src="/emadmin/images/c3/rw_<%=work[i+6]%>.gif" style="vertical-align: text-bottom;">&nbsp;<a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rw_detailModul&id=<%=work[i+0]%>"><%=work[i+1]%></a></td>
			  		<td width="70px;">&nbsp;<%=work[i+2]%></td>
			  		<td align="center"  width="150px;"><%=work[i+4]%></td>
			  		<td align="center"  width="150px;"><%=work[i+5]%></td>
			  	</tr>
			  	<%}}else{ %>
			  	<tr>
			  		<td colspan="4" align="center">今日暂无任务</td>
			  	</tr>
			  	<%}%>
		  </table>
		   <!--相关任务循环显示结束 -->
		   <!--这边挂显示的方式-->
		  <table width="100%" border="0" cellpadding="0" cellspacing="0"
										borderColorLight=#B3C3D0 borderColorDark=#ffffff>
				<tr>
					<td width="100%" valign="top" align="center">
						<a href="/emadmin/jsp/oa/rc_schedule_month_list.jsp">按月显示</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="/emadmin/jsp/oa/rc_shedule_week_list.jsp?modul_id=oa_rc_listModul">按周显示</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="/emadmin/jsp/oa/rc_shedule_day_list.jsp">按天显示</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="/emadmin/jsp/oa/rc_shedule_day_list.jsp?date=<%=Util.getDate(date,-1)%>">上一天</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="/emadmin/jsp/oa/rc_shedule_day_list.jsp?date=<%=Util.getDate(date,1)%>">下一天</a>
					</td>
				</tr>
		  </table>
	</body>
</html>
