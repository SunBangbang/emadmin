<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*, java.text.DecimalFormat;"%>
<%//凭证打印

		if( !request.getMethod().equalsIgnoreCase("post") && !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}  
        
		DecimalFormat df;
		df = new DecimalFormat("###,##0.00");

        String r[]=Api.sb(" select fdjs,pzbh,zdrq,lrr,shr,jzr from cw_jzpz where id='"
							+request.getParameter("id")+"'");
		
		
		
		String r1[]=Api.sb(" select zy,kmmc,jfje,dfje,xgsx from cw_jzpz_sub where fid='"
							+request.getParameter("id")+"' order by id ");
		

		String lrr="";
		String shr="";
		String jzr="";
		if(r[3].length()>0)	lrr=Api.sb(" select name from xt_yh where id='"+r[3]+"' ")[0];
		if(r[4].length()>0)	shr=Api.sb(" select name from xt_yh where id='"+r[4]+"' ")[0];
		if(r[5].length()>0)	jzr=Api.sb(" select name from xt_yh where id='"+r[5]+"' ")[0];
		
		double tmpDouble;
		double jfje=0,dfje=0;
		double hj=0;
		for(int i=0;r1.length>i;i+=5){
			jfje+=Double.valueOf(r1[2+i]).doubleValue();
			dfje+=Double.valueOf(r1[3+i]).doubleValue();

			tmpDouble = Double.valueOf(r1[2+i]).doubleValue();
			r1[2+i] = df.format(tmpDouble); 

			tmpDouble = Double.valueOf(r1[3+i]).doubleValue();
			r1[3+i] = df.format(tmpDouble); 
		}
		hj=jfje;
		String dx="";
		dx=new chineseMoney().getChineseMoney(hj);
		
		String jfjeStr = df.format(jfje); 
		String dfjeStr = jfjeStr;




     int col_num = 5; //记录的列数


	 int suml_line=r1.length/col_num;    //总行数
     int line_per_page=8;          //每页打印的行数
     int full_page_number=(int)Math.floor(r1.length/col_num/line_per_page); //整页页数
     int last_page_line= suml_line%line_per_page;  //最后剩余的半页的行数
	 boolean is_multi_page=(r1.length/col_num)<=line_per_page?false:true;

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<meta name=Generator content="Microsoft Word 10 (filtered)">
<title></title>

<style>
.{letter-spacing:0;}
.{word-spacing:0;}
.{line-height:0;}
<!--
 /* Font Definitions */
 @font-face
	{font-family:宋体;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@宋体";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:45.0pt 37.3pt 72.0pt 45.0pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=ZH-CN >


<%
	for ( int k=0;k<full_page_number;k++) {%>	


<div class=Section1 style='layout-grid:15.6pt'>


<table border="0" cellspacing="0" cellpadding="0" style='margin-left:14.4pt;border-collapse:collapse;border:none' width="720">
<tr>
<td>
<span lang=EN-US style='font-size:13.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><b><span style='font-size:13.5pt;font-family:宋体;'>
记 账 凭 证</span></b></td>
</tr>
<tr>

	<td align="right">
	<span style='font-family:宋体'><%=r[2]%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;</span><span lang=EN-US>&nbsp;</span>
	</td>

	<td align="right">
	<span style='font-size:12.0pt;font-family:宋体'>编号:</span>
	<span lang=EN-US style='font-size:12.0pt'><%=r[1]%> <%if(is_multi_page){%>- <%=k+1%><%}%></span>
	</td>
</tr>
</table>


<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
 style='margin-left:14.4pt;border-collapse:collapse;border:none' width="720">
 <tr style='height:25.5pt'>

  <td   width="20%"   style='border:solid windowtext 1.0pt;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>摘要</span></p>
  </td>

  <td width="56%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>科目名称</span></p>
  </td>

  <td width="12%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>借方金额</span></p>
  </td>

  <td width="12%" style='border:solid windowtext 1.0pt;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>贷方金额</span></p>



  </td>
  
 </tr>
 <%for( int i=(k)*line_per_page*col_num; (r1!= null) && (i < (k+1)*line_per_page*col_num); i+=col_num){%>  
 <% //for (int i=0;i<r1.length;i+=9) {%>
 <tr >

  <td style='border:solid windowtext 1.0pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:20px' nowrap>
  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US><%=r1[i]%></span></p>
  </td>

  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US><%=r1[i+1]%></span></p>
  </td>



  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=right style='text-align:right'><span lang=EN-US><%=r1[i+2]%></span></p>
  </td>


  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;' nowrap>
  <p class=MsoNormal align=right style='text-align:right'><span lang=EN-US><%=r1[i+3]%></span></p>
  </td>

 </tr>
 <%}%>
 <%System.out.println( (k+1)*line_per_page*col_num);%>
 <%System.out.println(r1.length);%>
 <%System.out.println(last_page_line);%>
 <% if (last_page_line==0 && (k+1)*line_per_page*col_num==r1.length) {  //如果是最后一行%>
 <tr style='height:25.5pt'>
  <td width="19%" style='border:solid windowtext 1.0pt;border-top:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>附单据数<%=r[0]%>张</span></p>
  </td>
  <td  style='border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>

  合计：<%=dx%>

	  
  </span></p>
  </td>

  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US><%=jfjeStr%></span></p>
  </td>


  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US><%=dfjeStr%></span></p>
  </td>


 </tr>
<%} else {%>
 <tr >
  <td style='border:solid windowtext 1.0pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:20px'  colspan="4"> <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>...下页续....</span></p>    
  </td>
 </tr>

<%}%>
 <tr height=0>

  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
	
 </tr>
</table>

<p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

<p class=MsoNormal style='text-indent:10.5pt'>

<span style='font-family:宋体'>记账：<%=jzr%>&nbsp;</span>
<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span style='font-family:宋体'>审核：<%=shr%>&nbsp;</span>
<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span style='font-family:宋体'>制单：<%=lrr%>&nbsp;</span>

</div>
<br>&nbsp;

<div style="PAGE-BREAK-AFTER: always"></div>
<% } %>	




 <% if (last_page_line>0) {  //如果有半页的%>

<div class=Section1 style='layout-grid:15.6pt'>


<table border="0" cellspacing="0" cellpadding="0" style='margin-left:14.4pt;border-collapse:collapse;border:none' width="720">
<tr>
<td>
<span lang=EN-US style='font-size:13.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><b><span style='font-size:13.5pt;font-family:宋体;'>
记 账 凭 证</span></b></td>
</tr>
<tr>

	<td align="right">
	<span style='font-family:宋体'><%=r[2]%></span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;</span>
	</td>

	<td align="right">
	<span style='font-size:12.0pt;font-family:宋体'>编号:</span>
	<span lang=EN-US style='font-size:12.0pt'><%=r[1]%> <%if(is_multi_page){%>- <%=full_page_number+1%><%}%></span>
	</td>
</tr>
</table>


<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
 style='margin-left:14.4pt;border-collapse:collapse;border:none' width="720">
 <tr style='height:25.5pt'>


  <td   width="20%"   style='border:solid windowtext 1.0pt;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>摘要</span></p>
  </td>

  <td width="56%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>科目名称</span></p>
  </td>

  <td width="12%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>借方金额</span></p>
  </td>

  <td width="12%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>贷方金额</span></p>


 </tr>



 <%for( int i=(full_page_number)*line_per_page*col_num; (r1!= null) && (i < r1.length); i+=col_num){%>  
 <tr >

  <td style='border:solid windowtext 1.0pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:20px' nowrap>
  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US><%=r1[i]%></span></p>
  </td>

  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US><%=r1[i+1]%></span></p>
  </td>

  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=right style='text-align:right'><span lang=EN-US><%=r1[i+2]%></span></p>
  </td>


  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;' nowrap>
  <p class=MsoNormal align=right style='text-align:right'><span lang=EN-US><%=r1[i+3]%></span></p>
  </td>

 </tr>
 <%}%>

 <%for( int i=0;  (i <line_per_page- last_page_line); i++){%>  
 <tr >

  <td style='border:solid windowtext 1.0pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:20px' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>&nbsp;</span></p>
  </td>

  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>&nbsp;</span></p>
  </td>


  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>&nbsp;</span></p>
  </td>

  
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>&nbsp;</span></p>
  </td>

 </tr>
 <%}%>

 <tr style='height:25.5pt'>
  
  <td width="19%" style='border:solid windowtext 1.0pt;border-top:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>附单据数<%=r[0]%>张</span></p>
  </td>
  <td  style='border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>

  合计：<%=dx%>

	  
  </span></p>
  </td>

  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US><%=jfjeStr%></span></p>
  </td>


  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US><%=dfjeStr%></span></p>
  </td>


 </tr>
 <tr height=0>
  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
 
 </tr>
</table>

<p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

<p class=MsoNormal style='text-indent:10.5pt'>

<span style='font-family:宋体'>记账：<%=jzr%>&nbsp;</span>
<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span style='font-family:宋体'>审核：<%=shr%>&nbsp;</span>
<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span style='font-family:宋体'>制单：<%=lrr%>&nbsp;</span>



</div>
 <%} %>



</body>

</html>
