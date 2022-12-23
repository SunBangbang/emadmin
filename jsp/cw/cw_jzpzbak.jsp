<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*"%>
<%//发货单打印
	
		if( !request.getMethod().equalsIgnoreCase("post") && !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}  
        //读出旅行社提成打印内容
        String r[]=Api.sb(" select fdjs,pzbh,zdrq,lrr,shr,jzr from cw_jzpz where id='"+request.getParameter("id")+"' order by id ");
		String r1[]=Api.sb(" select zy,kmmc,jfje,dfje,xgsx from cw_jzpz_sub where fid='"+request.getParameter("id")+"' order by id ");
		
		String lrr="";
		String shr="";
		String jzr="";
		if(r[3].length()>0)	lrr=Api.sb(" select name from xt_yh where id='"+r[3]+"' ")[0];
		if(r[4].length()>0)	shr=Api.sb(" select name from xt_yh where id='"+r[4]+"' ")[0];
		if(r[5].length()>0)	jzr=Api.sb(" select name from xt_yh where id='"+r[5]+"' ")[0];
		
		
		double jfje=0,dfje=0;
		double hj=0;
		for(int i=0;r1.length>i;i+=5){
			jfje+=Double.valueOf(r1[2+i]).doubleValue();
			dfje+=Double.valueOf(r1[3+i]).doubleValue();
		}
		hj=jfje;
		String dx="";
		dx=new chineseMoney().getChineseMoney(hj);
			
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
<table border="1" cellspacing="0" cellpadding="0" width="800">
<tr>
<td colspan="5" align="center"><span  style="font-size:18px;"><b>记账凭证</b></span></td>
</tr>
<tr>
<td colspan="5">
<span>凭证编号：<%=r[1]%></span>
<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span>制单日期：<%=r[2]%></span>
</td>
</tr>
<tr>
<th width="15%">摘要</th><th width="25%">科目名称</th><th width="15%">借方金额</th><th width="15%">贷方金额</th><th width="30%">相关信息</th>
</tr>
<%for(int i=0;r1.length>i;i+=5){%>
<tr>
	<td><%=r1[i]%>&nbsp;</td>
	<td><%=r1[i+1]%>&nbsp;</td>
	<td><%=r1[i+2]%>&nbsp;</td>
	<td><%=r1[i+3]%>&nbsp;</td>
	<td><%=r1[i+4]%>&nbsp;</td>
</tr>
<%}%>
<tr>
<td>附单据数<%=r[0]%>张&nbsp;</td><td>合计：<%=dx%>&nbsp;</td><td><%=jfje%>&nbsp;</td><td><%=dfje%>&nbsp;</td><td>&nbsp;</td>
</tr>
<tr>
<td colspan="5"><span>记账：<%=jzr%></span>
<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span>审核：<%=shr%></span>
<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span>制单：<%=lrr%></span></td>
</tr>
</table>

</div>
</body>
</html>
