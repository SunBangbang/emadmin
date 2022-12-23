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
        //String r[]=Api.sb("select a.xslx,a.fhdh,a.kh,a.fhrq,a.ck,convert(numeric(16,2),sum(b.jshj)),convert(numeric(16,2),sum(je)),convert(numeric(16,2),sum(se)),a.dybh,a.lrr,a.shr,a.ywy_mc  from xs_fhd a,xs_fhd_sub  b  where a.id = b.fid and a.id='"+request.getParameter("id")+"' group by a.xslx,a.fhdh,a.kh,a.fhrq,a.ck ,a.dybh,a.lrr,a.shr,a.ywy_mc ");
        String r[]=Api.sb("select a.xslx,a.xsthdh,a.kh,a.thrq,a.ck,convert(numeric(16,2),sum(b.jshj)),convert(numeric(16,2),sum(je)),convert(numeric(16,2),sum(se)),'',a.lrr,a.shr,a.ywy_mc  from xs_thd a,xs_thd_sub  b  where a.id = b.fid and a.id='"+request.getParameter("id")+"' group by a.xslx,a.xsthdh,a.kh,a.thrq,a.ck ,a.lrr,a.shr,a.ywy_mc");
        //String r1[]=Api.sb("select chmc,dw,convert(numeric(16,0),sl),convert(numeric(16,2),hsdj),convert(numeric(16,2),jshj),100,convert(numeric(16,2),lsj),xt_cpfz_pc,case when   xt_cpfz_sxrq = '' then '' else substring (xt_cpfz_sxrq,1,7) end,ggxh,chbm,bz from xs_fhd_sub where fid='"+request.getParameter("id")+"' order by id ");
        String r1[]=Api.sb("select chmc,dw,convert(numeric(16,0),sl),convert(numeric(16,2),hsdj),convert(numeric(16,2),jshj),100,convert(numeric(16,2),0) lsj,xt_cpfz_pc,case when   xt_cpfz_sxrq = '' then '' else substring (xt_cpfz_sxrq,1,7) end,ggxh,chbm,bz from xs_thd_sub where fid='"+request.getParameter("id")+"' order by id ");
 
		
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
	 if (suml_line==5) {
	 	full_page_number=0;
		last_page_line=5;
	 }



%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="undefined">
<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<title></title>
<style>
<!--
td{font-size:14px}
span{font-size:14px}

-->
</style>
</head>
<body bgcolor="#FFFFFF" >
<%
	for ( int k=0;k<full_page_number;k++) {%>


<div style="width:740px">
<div >
  <div align="center"><Strong><span style='font-size:16px;
font-family:宋体'>&nbsp;&nbsp;&nbsp;&nbsp;<%=print_title%></span></strong></div>
</div>

  <div>
    <div align="center"><span style='font-size:12px;
font-family:宋体'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=gsdz%></span><span  style='font-size:12px'> <%=yzbm%> </span><span style='font-size:12px;font-family:宋体'>电话：</span><span
 style='font-size:12px'><%=lxdh%></span></div>
  </div>
  <table border="0" cellspacing="0" cellpadding="0" width="740">
    <tr>
      <td><span  style='font-size:12px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <%if(!r[0].equals("102")){%>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <%}%>
        </span><b><span style='font-size:12px;font-family:宋体;'>
        <%if(r[0].equals("102")){%></span><span style="font-size:14px;font-family:宋体">委托</span><span style='font-size:12px;font-family:宋体;'>
        <%}%>
        </span><span style="font-size:14px;font-family:宋体"> &nbsp;&nbsp;&nbsp;&nbsp;退 &nbsp;货&nbsp;&nbsp;单</span></b></td>
      <td align="right"><span style='font-size:12px;font-family:宋体'>编号:</span> <span  style='font-size:12px'><%=r[1]%><%=dybh%>
        <%if(is_multi_page){%>
        - <%=k+1%>
        <%}%>
      </span> </td>
    </tr>
    <tr>
      <td><span style='font-size:14px;font-family:宋体'>&nbsp;购货单位：<%=r[2]%></span></td>
      <td align="right"><span style='font-family:宋体'>日期：<%=Util.getDate()%></span><span >&nbsp;</span> </td>
    </tr>
  </table>
  <table border=1 cellspacing=0 cellpadding=2 width="740" style="border-collapse:collapse">
    <tr>
      <td   width="19%" nowrap><p align=center style='text-align:center'>编码</p></td>
      <td   width="30%" nowrap><div align="center"><span style="text-align:center"><span
  style='font-family:宋体'>品名</span></span></div></td>
      <td width="10%" nowrap><p align=center style='text-align:center'><span
  style='font-family:宋体'>规格</span></p></td>
      <td width="7%" nowrap><p align=center style='text-align:center'><span
  style='font-family:宋体'>单位</span></p></td>
      <td colspan="2" nowrap ><p align=center style='text-align:center'><span
  style='font-family:宋体'>数量</span></p>        </td>
      <td width="9%" nowrap><p align=center style='text-align:center'><span style="text-align:center"><span
  style='font-family:宋体'>销售价</span></span></p></td>
      <td width="7%" nowrap><p align=center style='text-align:center'><span style="text-align:center"><span
  style='font-family:宋体'>金额</span></span></p></td>
      <td width="10%" nowrap><p align=center style='text-align:center'><span style="text-align:center"><span
  style='font-family:宋体'><span class="STYLE1"><span style="text-align:center">产地</span></span></span></span></p></td>
      <td width="10%" nowrap><p align=center style='text-align:center'><span style="text-align:center"><span style="text-align:center"><span
  style='font-family:宋体'><span class="STYLE1">原编号</span></span></span></span></p></td>
      <td width="10%" nowrap><p align=center style='text-align:center'><span
  style='font-family:宋体'><span class="STYLE1">备注</span></span></p></td>
    </tr>
    <%for( int i=(k)*line_per_page*12; (r1!= null) && (i < (k+1)*line_per_page*12); i+=12){%>
    <% 
 //取出产品档案的信息
 String chda[]=Api.sb("select cd,scs,ybm from jc_chda where chbm='"+r1[i+10]+"'");
 //for (int i=0;i<r1.length;i+=9) {%>
    <tr >
      <td nowrap><%=r1[i+10]%></td>
      <td  style="font-size:11px"><%=r1[i]%></td>
      <td nowrap><%=r1[i+9]%></td>
      <td nowrap><%=r1[i+1]%></td>
      <td colspan="2" nowrap><div align="right"><%=Float.valueOf(r1[i+2]).intValue()%></div>        <div align="right"></div></td>
      <td nowrap>
        <div align="right">
          <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
          ***
          <%}else{%>
          <%=r1[i+3]%>
          <%}%>
        </div></td>
      <td nowrap><p1 align="right" style='text-align:right'>
        <div align="right">
          <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
        ***
        <%}else{%>
        <%=r1[i+4]%>
        <%}%>
        </p>      
        </div></td>
      <td align="center" nowrap><span style="text-align:center"><span ><%=chda.length>0?chda[0]:"&nbsp;"%></span></span>&nbsp;</td>
      <td nowrap><span style="text-align:right"><span style="text-align:center"><span ><%=chda.length>0?chda[2]:"&nbsp;"%></span></span></span>&nbsp;</td>
      <td nowrap><%=r1[i+11]%>&nbsp;</td>
    </tr>
    <%}%>
    <%System.out.println( (k+1)*line_per_page*12);%>
    <%System.out.println(r1.length);%>
    <%System.out.println(last_page_line);%>
    <% if (last_page_line==0 && (k+1)*line_per_page*12==r1.length) {  //如果是最后一行%>
    <tr>
      <td width="19%" colspan="2"><p align=center style='text-align:center'><span
  style='font-family:宋体'>人民币大写</span></p></td>
      <td colspan=4><p align=center style='text-align:center'><span >
          <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
          ***
          <%}else{%>
          <%=dx%>
          <%}%>
          </span></p></td>
      <td><p align=center style='text-align:center'><span >
          <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
          ***
          <%}else{%>
          <%=r[5]%>
          <%}%>
          </span></p></td>
      <td nowrap><p align=center style='text-align:center'><span
  style='font-family:宋体'>货款</span></p></td>
      <td><p align=center style='text-align:center'><span >
          <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
          ***
          <%}else{%>
          <%=r[6]%>
          <%}%>
          </span></p></td>
      <td><p align=center style='text-align:center'><span
  style='font-family:宋体'>税款</span></p></td>
      <td><p align=center style='text-align:center'><span >
          <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
          ***
          <%}else{%>
          <%=r[7]%>
          <%}%>
          </span></p></td>
    </tr>
    <%} else {%>
    <%}%>
    <tr height=0>
      <td colspan="2"></td>
      <td></td>
      <td></td>
      <td width="7%"></td>
      <td width="9%"></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
    </tr>
  </table>
  <span >&nbsp;</span>&nbsp;&nbsp;<span style='font-family:宋体'>业务员：<%=hzr%>&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style='font-family:宋体'>复核：<%=shr%>&nbsp;</span> <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</span> <span style='font-family:宋体'>制单：<%=lrr%>&nbsp;</span> <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;<span style='font-family:宋体'>仓库&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp; <span style='font-family:宋体'>收货：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></div>
<div style="PAGE-BREAK-AFTER: always"></div>
<% } %>
<% if (last_page_line>0) {  //如果有半页的%>
<div style="width:740px">
<div align="center" ><Strong><span style='font-size:16px;
font-family:宋体'>&nbsp;&nbsp;&nbsp;&nbsp;<%=print_title%></span></Strong></div>
  <div align="center"><span style='font-size:12px;
font-family:宋体'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=gsdz%></span><span  style='font-size:12px'> <%=yzbm%> </span><span style='font-size:12px;font-family:宋体'>电话：</span><span
 style='font-size:12px'><%=lxdh%></span></div>
  <table border="0" cellspacing="0" cellpadding="0" style="width:740px">
    <tr>
      <td><span  style='font-size:12px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <%if(!r[0].equals("102")){%>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <%}%>
        </span><b> <span style='font-size:14px;font-family:宋体'>
        <%if(r[0].equals("102")){%>
        委托
        <%}%>
        &nbsp;&nbsp;&nbsp;&nbsp;退 &nbsp;货&nbsp;&nbsp;单</span></b></td>
      <td align="right"><span  style='font-size:12px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <span style='font-size:12px;font-family:宋体'>编号:</span> <span  style='font-size:12px'><%=r[1]%><%=dybh%>
        <%if(is_multi_page){%>
        - <%=full_page_number+1%>
        <%}%>
      </span> </td>
    </tr>
    <tr>
      <td><span style='font-size:14px;font-family:宋体'>&nbsp;购货单位：<%=r[2]%></span> </td>
      <td align="right"><span style='font-family:宋体'>日期：<%=Util.getDate()%></span><span >&nbsp;</span> </td>
    </tr>
  </table>
  <table border=1 cellspacing=0 cellpadding=2 width="740" style="border-collapse:collapse">
    <tr>
      <td  width="19%" nowrap><p align=center style='text-align:center'><span style="text-align:center">编码</span></p></td>
      <td  width="30%" nowrap><div align="center"><span style="text-align:center"><span
  style='font-family:宋体'>品名</span></span></div></td>
      <td width="10%" nowrap><p align=center style='text-align:center'><span
  style='font-family:宋体'>规格</span></p></td>
      <td width="7%" nowrap><p align=center style='text-align:center'><span
  style='font-family:宋体'>单位</span></p></td>
      <td colspan="2" nowrap><p align=center style='text-align:center'><span
  style='font-family:宋体'>数量</span></p>        </td>
      <td width="9%" nowrap><p align=center style='text-align:center'><span style="text-align:center"><span
  style='font-family:宋体'>销售价</span></span></p></td>
      <td width="7%" nowrap><p align=center style='text-align:center'><span style="text-align:center"><span
  style='font-family:宋体'>金额</span></span></p></td>
      <td width="10%" nowrap><p align=center style='text-align:center'><span class="MsoNormal STYLE1" style="text-align:center"><span style="text-align:center"><span
  style='font-family:宋体'><span class="STYLE1">产地</span></span></span></span></p></td>
      <td width="10%" nowrap><p align=center style='text-align:center'><span style="text-align:center"><span class="MsoNormal STYLE1" style="text-align:center">原编号</span></span></p></td>
      <td width="10%" nowrap><p align=center style='text-align:center'><span class="STYLE1">备注</span></p></td>
    </tr>
    <%for( int i=(full_page_number)*line_per_page*12; (r1!= null) && (i < r1.length); i+=12){%>
    <% //取出产品档案的信息
 String chda[]=Api.sb("select cd,scs,ybm from jc_chda where chbm='"+r1[i+10]+"'");
%>
    <tr >
      <td valign="middle" nowrap><%=r1[i+10]%></td>
      <td valign="middle" style="font-size:11px"><%=r1[i]%></td>
      <td valign="middle" nowrap><%=r1[i+9]%></td>
      <td valign="middle" nowrap><%=r1[i+1]%></td>
      <td colspan="2" valign="middle" nowrap><div align="right"><%=Float.valueOf(r1[i+2]).intValue()%></div>        <div align="right"></div></td>
      <td valign="middle" nowrap>
        <div align="right">
          <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
          ***
          <%}else{%>
          <%=r1[i+3]%>
          <%}%>
        </div></td>
      <td valign="middle" nowrap><p2 align="right" style='text-align:right'>
        <div align="right">
          <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
        ***
        <%}else{%>
        <%=r1[i+4]%>
        <%}%>
      </div></td>
      <td align="center" valign="middle" nowrap><span style="text-align:center"><span ><%=chda.length>0?chda[0]:"&nbsp;"%></span></span>&nbsp;</td>
      <td valign="middle" nowrap><%=chda.length>0?chda[2]:"&nbsp;"%>&nbsp;</td>
      <td valign="middle" nowrap><%=r1[i+11]%>&nbsp;</td>
    </tr>
    <%}%>
    <%for( int i=0;  (i <line_per_page- last_page_line); i++){%>
    <tr >
      <td nowrap>&nbsp;</td>
      <td nowrap>&nbsp;</td>
      <td nowrap>&nbsp;</td>
      <td nowrap>&nbsp;</td>
      <td colspan="2" nowrap>&nbsp;</td>
      <td nowrap>&nbsp;</td>
      <td nowrap>&nbsp;</td>
      <td nowrap>&nbsp;</td>
      <td nowrap>&nbsp;</td>
      <td nowrap>&nbsp;</td>
    </tr>
    <%}%>
    <tr>
      <td  width="19%" colspan="2"><p align=center style='text-align:center'><span
  style='font-family:宋体'>人民币大写</span></p></td>
      <td colspan=4><p align=center style='text-align:center'><span >
          <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
          ***
          <%}else{%>
          <%=dx%>
          <%}%>
          </span></p></td>
      <td><p align=center style='text-align:right'><span >
          <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
          ***
          <%}else{%>
          <%=r[5]%>
          <%}%>
          </span></p></td>
      <td><p align=center style='text-align:center'><span
  style='font-family:宋体'>货款</span></p></td>
      <td><p align=center style='text-align:right'><span >
          <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
          ***
          <%}else{%>
          <%=r[6]%>
          <%}%>
          </span></p></td>
      <td><p align=center style='text-align:center'><span
  style='font-family:宋体'>税款</span></p></td>
      <td><p align=center style='text-align:right'><span >
          <%if(r[4].equals("11817157275150019")||r[4].equals("11835121316250323")){%>
          ***
          <%}else{%>
          <%=r[7]%>
          <%}%>
          </span></p></td>
    </tr>
    <tr height=0>
      <td colspan="2"></td>
      <td></td>
      <td></td>
      <td width="7%"></td>
      <td width="9%"></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
    </tr>
  </table>
   <span style='font-family:宋体'>&nbsp;</span><span style='font-family:宋体'>业务员：<%=hzr%>&nbsp;</span> <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;</span> <span style='font-family:宋体'>复核：<%=shr%>&nbsp;</span> <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;</span> <span style='font-family:宋体'>制单：<%=lrr%>&nbsp;</span> <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;<span style='font-family:宋体'>仓库：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp; <span style='font-family:宋体'>收货：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></div>
<%} %>
</body>
</html>
