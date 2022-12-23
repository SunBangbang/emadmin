<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*"%>
<%//发货单打印
	String result[];
	
		if( !request.getMethod().equalsIgnoreCase("post") && !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}  
		//读出公司的内容
        String r_gsxx[]=Api.sb("select gsqc,gsdz,yzbm,lxdh from xt_gs_da ");

		String gsqc = r_gsxx[0];
		String gsdz = r_gsxx[1];
		String yzbm = r_gsxx[2];
		String lxdh = r_gsxx[3];

 
        //读出发货单内容
        String r[]=Api.sb("select a.xslx,a.fhdh,a.kh,a.fhrq,a.ck,convert(numeric(16,2),sum(b.jshj)),convert(numeric(16,2),sum(je)),convert(numeric(16,2),sum(se)),a.dybh,a.lrr,a.shr,a.ywy_mc  from xs_fhd a,xs_fhd_sub  b  where a.id = b.fid and a.id='"+request.getParameter("id")+"' group by a.xslx,a.fhdh,a.kh,a.fhrq,a.ck ,a.dybh,a.lrr,a.shr,a.ywy_mc ");
        String r1[]=Api.sb("select chmc,dw,convert(numeric(16,0),sl),convert(numeric(16,2),hsdj),convert(numeric(16,2),jshj),100,convert(numeric(16,2),lsj),xt_cpfz_pc,case when   xt_cpfz_sxrq = '' then '' else substring (xt_cpfz_sxrq,1,7) end,ggxh,chbm,bz from xs_fhd_sub where fid='"+request.getParameter("id")+"' order by id ");
 
		
		String lrr="&nbsp;&nbsp;&nbsp;&nbsp;";
		String shr="&nbsp;&nbsp;&nbsp;&nbsp;";
		String hzr="&nbsp;&nbsp;&nbsp;&nbsp;";
		String dybh="";


		
		if(r[8].length()>0)	
		{
			String dybhRes[] = Api.sb(" select dynr from xsfh_sz_dybh where dm = '"+r[8]+"' ");
			if (dybhRes.length>0)
				dybh = dybhRes[0];
			else
				dybh = r[8];

		}
		
		String res[];

		if(r[9].length()>0)	
		{
			res = Api.sb(" select name from xt_yh where id='"+r[9]+"' ");
			if (res.length>0)
					lrr = res[0];

		}
		
		if(r[10].length()>0)	
		{
			res = Api.sb(" select name from xt_yh where id='"+r[10]+"' ");
			if (res.length>0)
					shr = res[0];


		}
		

		if(r[11].length()>0)	
		{
			//res = Api.sb(" select name from xt_yh where id='"+r[11]+"' ");
 			//if (res.length>0)
					hzr = r[11];

		}
		
		 


		String dx=new chineseMoney().getChineseMoney(Double.valueOf(r[5]).doubleValue());

	 int suml_line=r1.length/12;    //总行数
     int line_per_page=5;          //每页打印的行数
     int full_page_number=(int)Math.floor(r1.length/12/line_per_page); //整页页数
     int last_page_line= suml_line%line_per_page;  //最后剩余的半页的行数
	 boolean is_multi_page=(r1.length/12)<=line_per_page?false:true;

	 String print_title = gsqc;



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
.STYLE1 {font-family: "宋体"}
div.MsoNormal1 {margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
li.MsoNormal1 {margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
p.MsoNormal1 {margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
div.MsoNormal2 {margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
li.MsoNormal2 {margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
p.MsoNormal2 {margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
-->
</style>
</head>

<body lang=ZH-CN >


<%
	for ( int k=0;k<full_page_number;k++) {%>	


<div class=Section1 style='layout-grid:15.6pt'>

<p class=MsoNormal style='text-indent:159.8pt;'><b><span style='font-size:16.0pt;
font-family:宋体'>&nbsp;&nbsp;&nbsp;&nbsp;<%=print_title%></span></b></p>

<p class=MsoNormal style='text-indent:130.5pt'><span style='font-size:9.0pt;
font-family:宋体'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=gsdz%></span><span lang=EN-US style='font-size:9.0pt'>
<%=yzbm%> </span><span style='font-size:9.0pt;font-family:宋体'>电话：</span><span
lang=EN-US style='font-size:9.0pt'><%=lxdh%></span></p>

<table border="0" cellspacing="0" cellpadding="0" style='margin-left:14.4pt;border-collapse:collapse;border:none' width="800">
<tr>
<td>
<span lang=EN-US style='font-size:13.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%if(!r[0].equals("102")){%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%}%>
</span><b><span style='font-size:13.5pt;font-family:宋体;'>
<%if(r[0].equals("102")){%>委托<%}%>销售单</span></b></td>
<td align="right">
<span style='font-size:12.0pt;font-family:宋体'>编号:</span>
<span lang=EN-US style='font-size:12.0pt'><%=r[1]%><%=dybh%> <%if(is_multi_page){%>- <%=k+1%><%}%></span>
</td>
</tr>
<tr>
<td>
<span style='font-size:12.0pt;font-family:宋体'>&nbsp;购货单位：<%=r[2]%></span>
</td>
<td align="right">
<span style='font-family:宋体'>日期：<%=Util.getDate()%></span><span lang=EN-US>&nbsp;</span>
</td>
</tr>
</table>
<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
 style='margin-left:14.4pt;border-collapse:collapse;border:none' width="800">
 <tr style='height:25.5pt'>

  <td   width="10%"   style='border:solid windowtext 1.0pt;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'>编码</p>  </td>

  <td   width="30%"   style='border:solid windowtext 1.0pt;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'><div align="center"><span class="MsoNormal" style="text-align:center"><span
  style='font-family:宋体'>品名</span></span></div></td>
  <td width="10%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>规格</span></p>  </td>

  <td width="7%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>单位</span></p>  </td>
  <td width="7%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt' >
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>数量</span></p>  </td>
  <td  width="9%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'><span class="MsoNormal" style="text-align:center"><span class="STYLE1"><span class="MsoNormal" style="text-align:center">零售价</span></span></span></span></p>  </td>
  <td width="9%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span class="MsoNormal" style="text-align:center"><span
  style='font-family:宋体'>销售价</span></span></p>  </td>
  <td width="7%" nowrap style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span class="MsoNormal" style="text-align:center"><span
  style='font-family:宋体'>金额</span></span></p>  </td>
  <td width="10%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span class="MsoNormal" style="text-align:center"><span
  style='font-family:宋体'><span class="STYLE1"><span class="MsoNormal" style="text-align:center">产地</span></span></span></span></p>  </td>
  <td width="10%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span class="MsoNormal" style="text-align:center"><span class="MsoNormal" style="text-align:center"><span
  style='font-family:宋体'><span class="STYLE1">原编号</span></span></span></span></p>  </td>
  <td width="10%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'><span class="STYLE1">备注</span></span></p>  </td>
 </tr>
 <%for( int i=(k)*line_per_page*12; (r1!= null) && (i < (k+1)*line_per_page*12); i+=12){%>  
 <% 
 //取出产品档案的信息
 String chda[]=Api.sb("select cd,scs,bz from jc_chda where chbm='"+r1[i+10]+"'");
 //for (int i=0;i<r1.length;i+=9) {%>
 <tr >

  <td nowrap style='border:solid windowtext 1.0pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:20px'>
  <p class=MsoNormal align=center style='text-align:center'><%=r1[i+10]%></p>  </td>

  <td style='border:solid windowtext 1.0pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:20px'><span class="MsoNormal" style="text-align:center"><span lang=EN-US><%=r1[i]%></span></span></td>
  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US><%=r1[i+9]%></span></p>  </td>



  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US><%=r1[i+1]%></span></p>  </td>

  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US><%=Float.valueOf(r1[i+2]).intValue()%></span></p>  </td>
  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align="right" style='text-align:right'><span lang=EN-US>
  <span class="MsoNormal" style="text-align:center"><span class="MsoNormal" style="text-align:right"><span lang=EN-US><%=r1[i+6]%></span></span></span></span></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;' nowrap><p class=MsoNormal align="right" style='text-align:right'><span class="MsoNormal" style="text-align:right"><span lang=EN-US>
  <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
***
<%}else{%>
<%=r1[i+3]%>
<%}%>
  </span></span></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;' nowrap>
  <p class=MsoNormal1 align="right" style='text-align:right'><span lang=EN-US>
    <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
    ***
  <%}else{%>
  <%=r1[i+4]%>
  <%}%>
  </span></p>  </td>
  <td align="center" nowrap style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  '>
  <p class=MsoNormal align="center" style='text-align:center'><span class="MsoNormal" style="text-align:center"><span lang=EN-US><%=chda.length>0?chda[0]:"&nbsp;"%></span></span></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span class="MsoNormal" style="text-align:right"><span class="MsoNormal" style="text-align:center"><span lang=EN-US><%=chda.length>0?chda[2]:"&nbsp;"%></span></span></span></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US><%=r1[i+11]%></span></p>  </td>
 </tr>
 <%}%>
 <%System.out.println( (k+1)*line_per_page*10);%>
 <%System.out.println(r1.length);%>
 <%System.out.println(last_page_line);%>
 <% if (last_page_line==0 && (k+1)*line_per_page*12==r1.length) {  //如果是最后一行%>
 <tr style='height:25.5pt'>
  <td width="19%" colspan="2" style='border:solid windowtext 1.0pt;border-top:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>人民币大写</span></p>  </td>
  <td colspan=4 style='border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>
  <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
  ***
  <%}else{%>
  <%=dx%>
  <%}%>
	  
  </span></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>
  <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
  ***
  <%}else{%>
  <%=r[5]%>
  <%}%>
	  
  </span></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>货款</span></p>  </td>
  <td  style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>
  <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
  ***
  <%}else{%>
  <%=r[6]%>
  <%}%>
  
  </span></p>  </td>
  <td  style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>税款</span></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>
  <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
  ***
  <%}else{%>
  <%=r[7]%>
  <%}%>
  
  </span></p>  </td>
 </tr>
<%} else {%>
 <tr >
  <td style='border:solid windowtext 1.0pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:20px'  colspan="11"> <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>...下页续....</span></p>  </td>
 </tr>

<%}%>
 <tr height=0>
  <td colspan="2" style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
 </tr>
</table>

<p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

<p class=MsoNormal style='text-indent:10.5pt'>

<span style='font-family:宋体'>业务员：<%=hzr%>&nbsp;</span>
<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span style='font-family:宋体'>复核：<%=shr%>&nbsp;</span>
<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span style='font-family:宋体'>制单：<%=lrr%>&nbsp;</span>
<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span style='font-family:宋体'>仓库&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span style='font-family:宋体'>收货：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>


<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>



</div>


<div style="PAGE-BREAK-AFTER: always"></div>
<% } %>	




 <% if (last_page_line>0) {  //如果有半页的%>

<div class=Section1 style='layout-grid:15.6pt'>

<p class=MsoNormal style='text-indent:159.8pt'><b><span style='font-size:16.0pt;
font-family:宋体'>&nbsp;&nbsp;&nbsp;&nbsp;<%=print_title%></span></b></p>

<p class=MsoNormal style='text-indent:130.5pt'><span style='font-size:9.0pt;
font-family:宋体'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=gsdz%></span><span lang=EN-US style='font-size:9.0pt'>
<%=yzbm%> </span><span style='font-size:9.0pt;font-family:宋体'>电话：</span><span
lang=EN-US style='font-size:9.0pt'><%=lxdh%></span></p>

<table border="0" cellspacing="0" cellpadding="0" style='margin-left:14.4pt;border-collapse:collapse;border:none' width="800">
<tr>
<td>
<span lang=EN-US style='font-size:13.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%if(!r[0].equals("102")){%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%}%>
</span><b>
<span style='font-size:13.5pt;font-family:宋体'>
<%if(r[0].equals("102")){%>
委托<%}%>销售单</span></b></td>
<td align="right">
<span lang=EN-US style='font-size:12.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span style='font-size:12.0pt;font-family:宋体'>编号:</span>
<span lang=EN-US style='font-size:12.0pt'><%=r[1]%><%=dybh%>  <%if(is_multi_page){%>- <%=full_page_number+1%><%}%></span>
</td>
</tr>
<tr>
<td>
<span style='font-size:12.0pt;font-family:宋体'>&nbsp;购货单位：<%=r[2]%></span>
</td>
<td align="right">
<span style='font-family:宋体'>日期：<%=Util.getDate()%></span><span lang=EN-US>&nbsp;</span>
</td>
</tr>
</table>

<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
 style='margin-left:14.4pt;border-collapse:collapse;border:none' width="800">
 <tr style='height:25.5pt'>
  <td  width="10%"  style='border:solid windowtext 1.0pt;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span class="MsoNormal" style="text-align:center">编码</span></p>  </td>

  <td  width="30%"  style='border:solid windowtext 1.0pt;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'><div align="center"><span class="MsoNormal" style="text-align:center"><span
  style='font-family:宋体'>品名</span></span></div></td>
  <td width="10%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>规格</span></p>  </td>

  <td width="7%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>单位</span></p>  </td>
  <td width="7%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>数量</span></p>  </td> 
  <td width="9%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'><span class="MsoNormal" style="text-align:center">零售价</span></span></p>  </td> 
  <td width="9%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span class="MsoNormal" style="text-align:center"><span
  style='font-family:宋体'>销售价</span></span></p>  </td>
  <td width="7%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span class="MsoNormal" style="text-align:center"><span
  style='font-family:宋体'>金额</span></span></p>  </td>
  <td width="10%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span class="MsoNormal STYLE1" style="text-align:center"><span class="MsoNormal" style="text-align:center"><span
  style='font-family:宋体'><span class="STYLE1">产地</span></span></span></span></p>  </td>
  <td width="10%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span class="MsoNormal" style="text-align:center"><span class="MsoNormal STYLE1" style="text-align:center">原编号</span></span></p>  </td>
  <td width="10%" style='border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span class="STYLE1">备注</span></p>  </td>
 </tr>
 <%for( int i=(full_page_number)*line_per_page*12; (r1!= null) && (i < r1.length); i+=12){%>  
 <% //取出产品档案的信息
 String chda[]=Api.sb("select cd,scs,bz from jc_chda where chbm='"+r1[i+10]+"'");
%>
 <tr >
  <td nowrap style='border:solid windowtext 1.0pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:20px'>
  <p class=MsoNormal align=center style='text-align:center'><%=r1[i+10]%></p>  </td>

  <td style='border:solid windowtext 1.0pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:20px'><span class="MsoNormal" style="text-align:center"><span lang=EN-US><%=r1[i]%></span></span></td>
  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US><%=r1[i+9]%></span></p>  </td>

  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US><%=r1[i+1]%></span></p>  </td>
  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US><%=Float.valueOf(r1[i+2]).intValue()%></span></p>  </td>
  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align="right" style='text-align:right'><span lang=EN-US>
  	<span class="MsoNormal" style="text-align:right"><span lang=EN-US><%=r1[i+6]%></span></span></span></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;' nowrap><p class=MsoNormal align="right" style='text-align:right'><span class="MsoNormal" style="text-align:right"><span lang=EN-US>
    <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
***
<%}else{%>
<%=r1[i+3]%>
<%}%>
  </span></span></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;' nowrap>
  <p class=MsoNormal2 align="right" style='text-align:right'><span lang=EN-US>
    <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
    ***
  <%}else{%>
  <%=r1[i+4]%>
  <%}%>
  </span></p>  </td>
  <td align="center" nowrap style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  '><p class=MsoNormal align="center" style='text-align:center'><span class="MsoNormal" style="text-align:center"><span lang=EN-US><%=chda.length>0?chda[0]:"&nbsp;"%></span></span></p></td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><%=chda.length>0?chda[2]:"&nbsp;"%></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US><%=r1[i+11]%></span></p>  </td>
 </tr>
 <%}%>

 <%for( int i=0;  (i <line_per_page- last_page_line); i++){%>  
 <tr >

 <td nowrap style='border:solid windowtext 1.0pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:20px'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>&nbsp;</span></p>  </td>
  <td nowrap style='border:solid windowtext 1.0pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:20px'>&nbsp;</td>
  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>&nbsp;</span></p>  </td>


  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>&nbsp;</span></p>  </td>

  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>&nbsp;</span></p>  </td>
  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>&nbsp;</span></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>&nbsp;</span></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>&nbsp;</span></p>  </td>
  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  ' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>&nbsp;</span></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>&nbsp;</span></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;' nowrap>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>&nbsp;</span></p>  </td>
 </tr>
 <%}%>
 <tr style='height:25.5pt'>
  <td  width="19%" colspan="2" style='border:solid windowtext 1.0pt;border-top:
  none;padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>人民币大写</span></p>  </td>
  <td colspan=4 style='border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>
  <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
  ***
  <%}else{%>
  <%=dx%>
  <%}%>
  </span></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:right'><span lang=EN-US>
  <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
  ***
  <%}else{%>
  <%=r[5]%>
  <%}%>
  </span></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>货款</span></p>  </td>
  <td style='border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:right'><span lang=EN-US>
  <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
  ***
  <%}else{%>
  <%=r[6]%>
  <%}%>
  </span></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>税款</span></p>  </td>
  <td style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:right'><span lang=EN-US>
  <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
  ***
  <%}else{%>
  <%=r[7]%>
  <%}%>
  </span></p>  </td>
 </tr>
 <tr height=0>
  <td colspan="2" style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
  <td style='border:none'></td>
 </tr>
</table>

<p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

<p class=MsoNormal style='text-indent:10.5pt'>

<span style='font-family:宋体'>业务员：<%=hzr%>&nbsp;</span>
<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span style='font-family:宋体'>复核：<%=shr%>&nbsp;</span>
<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span style='font-family:宋体'>制单：<%=lrr%>&nbsp;</span>
<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span style='font-family:宋体'>仓库：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span style='font-family:宋体'>收货：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>

<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>



</div>
 <%} %>



</body>

</html>
