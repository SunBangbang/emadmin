<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*"%>
<%//发货单打印
	
/*		if( !request.getMethod().equalsIgnoreCase("post") && !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}  
*/        //读出旅行社提成打印内容
		String id=request.getParameter("id");
		if(id==null)id="";
        String r[]=Api.sb(" select jdrq,sj,lxsmc,slrts,slgwje,gwhsl,slrtf,rts,gwje,gwhdl,kslhdy,cslr,tcf,jl,fyf,qtfy,sfqd from qd_qdjsd where id='"+id+"' ");				 
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<meta name=Generator content="Microsoft Word 10 (filtered)">
<title>北京宝树堂科技药业有限公司</title>
</head>

<body>
<div>
<%if(r[16].equals("0")){%>
<table border="0" cellspacing="0" cellpadding="0" width="800">
<tr>
	<td colspan="4" align="center">
	<span>欢迎光临</span>
	</td>
</tr>
<tr>
	<td align="right" colspan="4">
	<span>日期：<%=r[0]%></span><span>&nbsp;</span><span>时间：<%=r[1]%></span>
	</td>
</tr>
<tr>
	<td>旅行社：</td><td><%=r[2]%></td>
	<td>人数：</td><td><%=r[3]%></td>
</tr>
<tr>
	<td>购物金额：</td><td><%=r[4]%></td>
	<td>利润：</td><td><%=Double.valueOf(r[5]).doubleValue()+Double.valueOf(r[6]).doubleValue()%></td>
</tr>
</table>
<br>
<br>
<%}%>
<table border="0" cellspacing="0" cellpadding="0" width="800">
<tr>
	<td colspan="4" align="center"><span>欢迎光临</span></td>
</tr>
<tr>
	<td align="right" colspan="4">
		<span>日期：<%=r[0]%></span><span>&nbsp;</span><span>时间：<%=r[1]%></span>
	</td>
</tr>
<tr>
	<td>旅行社：</td><td><%=r[2]%></td>
	<td>人数：</td><td><%=r[7]%></td>
</tr>
<tr>
	<td>购物流水：</td><td><%=r[8]%></td>
	<td>利润：</td><td><%=Double.valueOf(r[9]).doubleValue()+Double.valueOf(r[10]).doubleValue()+Double.valueOf(r[11]).doubleValue()%></td>
</tr>
<%if(Double.valueOf(r[12])!=0||Double.valueOf(r[13])!=0){%>
<tr>
	<%if(Double.valueOf(r[12])!=0){%>
	<td>停车费：</td><td><%=r[12]%></td>
	<%}%>
	<%if(Double.valueOf(r[13])!=0){%>
	<td>奖励：</td><td><%=r[13]%></td>
	<%}%>
</tr>
<%}%>
<%if(Double.valueOf(r[14])!=0||Double.valueOf(r[15])!=0){%>
<tr>
	<%if(Double.valueOf(r[14])!=0){%>
	<td>翻译费：</td><td><%=r[14]%></td>
	<%}%>
	<%if(Double.valueOf(r[15])!=0){%>
	<td>其他费用：</td>
	<td><%=r[15]%></td>
	<%}%>
</tr>
<%}%>
<tr>
	<td>总计：</td><td><%=Double.valueOf(r[9]).doubleValue()+Double.valueOf(r[10]).doubleValue()+Double.valueOf(r[11]).doubleValue()+Double.valueOf(r[12]).doubleValue()+Double.valueOf(r[13]).doubleValue()+Double.valueOf(r[14]).doubleValue()+Double.valueOf(r[15]).doubleValue()%></td>
</tr>

</table>

</div>
</body>
</html>
