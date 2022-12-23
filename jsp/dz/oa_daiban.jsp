<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*,java.text.DecimalFormat,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
	 String r_dbsx[]=Serve.getAllDaiBanShenHe(request,30);			
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<title>待处理单据</title>
		<%@include file="/emadmin/shared/headres.jsp"%>
		<style type="text/css">
				tr{
					background-color:expression('#ECF5FF,white'.split(',')[rowIndex%2]);
				}
		</style>
	</head>
<body>
		
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						待处理单据
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
			  	<tr style="background-color:#d8e2f4;">
			  		<td width="30%" align="center">
			  			单据名称
			  		</td>
			  		<td width="40%" align="center">
			  			当前单据状态
			  		</td>
			  		<td align="center">
			  			未处理数量
			  		</td>
					<td width="55px;" align="center">
			  			操&nbsp;&nbsp;作
			  		</td>
			  	</tr>
				 <% if(r_dbsx.length!=0){
					 for (int i=0;i<r_dbsx.length;i+=6) {%>
								<tr>
									<td align="center"><a href="<%=r_dbsx[i+1]%>?modul_id=<%=r_dbsx[i]%>&dfilter=<%=URLEncoder.encode(r_dbsx[i+4])%>" target="_blank"><%=(r_dbsx[i+2].length()>20)?(r_dbsx[i+2].substring(0,20))+"...":(r_dbsx[i+2])%></a></td>
									<td  align="center"><a href="<%=r_dbsx[i+1]%>?modul_id=<%=r_dbsx[i]%>&dfilter=<%=URLEncoder.encode(r_dbsx[i+4])%>" target="_blank"><%=r_dbsx[i+5]%></a></td>
									<td style="padding-left:10px;" align="center"><a href="<%=r_dbsx[i+1]%>?modul_id=<%=r_dbsx[i]%>&dfilter=<%=URLEncoder.encode(r_dbsx[i+4])%>" target="_blank"><%=r_dbsx[i+3]%></a></td>
									<td  align="center"><a href="<%=r_dbsx[i+1]%>?modul_id=<%=r_dbsx[i]%>&dfilter=<%=URLEncoder.encode(r_dbsx[i+4])%>" target="_blank"><img src="/emadmin/images/c3/view.gif" border=0></a></td>
								</tr>		  	
			  	<%}}else{%>
			  	<tr>
			  		<td colspan="4" align="center">暂无待处理单据</td>
			  	</tr>
			  	<%} %>
		  </table>
		   <!--这边挂显示的方式-->
	</body>
</html>
