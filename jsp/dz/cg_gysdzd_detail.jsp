<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*"%>

<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<style>

  <!--
  .body{
  	font-family: Arial;
  	font-size: 11pt;
  }
      
  .title {
  	font-family: Arial;
  	font-size: 16pt;
  	font-style: normal;
  	line-height: normal;
  	font-weight: bold;
  	font-variant: normal;
  	text-transform: none;
  	background-color: #FFFFFF;
  	text-align: center;
  	margin: 0px;
  	padding: 0px;
  }
  .title1 {
  	font-family: Arial;
  	font-size: 13.5pt;
  	font-style: normal;
  	line-height: normal;
  	font-weight: bold;
  	font-variant: normal;
  	text-transform: none;
  	background-color: #FFFFFF;
  	text-align: center;
  	margin: 0px;
  	padding: 0px;
  }
  .font2{
      font-size:10pt;
  }

  .font3{
      font-size:10pt;
  }
  .printcontent {
  	font-family: Arial;
  	font-size: 10pt;
  	font-style: normal;
  	line-height: normal;
  	font-variant: normal;
  	text-transform: none;
  	background-color: #FFFFFF;
  	margin: 0px;
  	padding-top: 3px;
  	padding-bottom: 3px;
  }
  .table_td {
  	line-height: 15px;
	font-size:10pt;
	text-align:left;
	padding-left:20px;
	
  }
  -->
  </style>
  <script>
function printData()
{
      document.getElementById('button_area').style.display="none";
      window.print();
}
function init()
{
      document.getElementById('button_area').style.display="block";
    
}

function   window.onbeforeprint(){  
         	   document.getElementById('button_area').style.display="none";
 }   
   function   window.onafterprint(){  
         	   document.getElementById('button_area').style.display="block";
 } 
</script>
<head>
<%!
    /* 将格式如"0E-8"的字符串表示的零值,转换成普通的双精度零值字符串. */
    public String parseZero( String str )
    {
        if( str.indexOf( "0E" ) >= 0 )
	    {
	         return "0.000";
	    }
	    
	    return str;
    }
    /* 截取金额到小数点后2位 */   
    public String parseJe( String str )
    {
	    return str.substring( 0 , str.indexOf( "." ) + 3 );
    }
    
    /* 截取数量到小数点 */
    public String parseSl( String str )
    {
        return str.substring( 0 , str.indexOf( "." ) + 0);
    }
%>
<%
    
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

	String id= request.getParameter( "id" );
	String lst[]=id.split(":");
	//取得供应商
	String gys_id=lst[0];
	//取得开始日期
	String startTime=lst[1];
	//取得结束日期
	String endTime=lst[2];
	String execSql=Api.getDTable("view_cg_gysdzd","<\"djrq111\">",startTime,"<\"djrq112\">",endTime,"");
	//得到查询的SQL直接进行Api.sb即可

	execSql="select * from "+execSql+" where gys_id='"+gys_id+"' ";
	String gysdzd_main[]=Api.sb(execSql);

	//进货明细
	String jhmx[]=Api.sb("select a.cgrq,b.chbm,b.chmc,b.ggxh,b.dw,b.sl,b.hsdj,b.jshj,b.bz from  cg_cgd a,cg_cgd_sub b  where cgrq between '"+startTime+"' and '"+endTime+"' and a.id=b.fid and gys_id='"+gys_id+"' and b.sl>0  order by cgrq ");
	//退货明细
	String thmx[]=Api.sb("select a.cgrq,b.chbm,b.chmc,b.ggxh,b.dw,b.sl,b.hsdj,b.jshj,b.bz from  cg_cgd a,cg_cgd_sub b  where cgrq between '"+startTime+"' and '"+endTime+"' and a.id=b.fid and gys_id='"+gys_id+"' and b.sl<=0  order by cgrq");
	//进货明细合计
	String jhmx_sum[]=Api.sb("select case when convert(numeric(19,8),sum(b.sl)) is null then 0 else  convert(numeric(19,8),sum(b.sl)) end zsl, case when convert(numeric(19,8),sum(jshj)) is null then 0 else convert(numeric(19,8),sum(jshj)) end zje from  cg_cgd a,cg_cgd_sub b  where cgrq between '"+startTime+"' and '"+endTime+"' and a.id=b.fid and gys_id='"+gys_id+"' and b.sl>0 ");
	//退货明细合计
	String thmx_sum[]=Api.sb("select case when convert(numeric(19,8),sum(b.sl)) is null then 0 else convert(numeric(19,8),sum(b.sl)) end  zsl,case when convert(numeric(19,8),sum(jshj)) is null then 0 else convert(numeric(19,8),sum(jshj)) end  zje from  cg_cgd a,cg_cgd_sub b  where cgrq between '"+startTime+"' and '"+endTime+"' and a.id=b.fid and gys_id='"+gys_id+"' and b.sl<=0 ");

	//应付明细
	String yfmx[]=Api.sb("select djrq,je,yfje,wfje,bz from cw_yfd where djrq between '"+startTime+"' and '"+endTime+"' and gys_id='"+gys_id+"'");

	//付款明细
	String fkmx[]=Api.sb("select fkrq,(select mc from dm_zffs where dm=cg_fkd.zffs) as zffs,sfje,bz from cg_fkd where  fkrq between '"+startTime+"' and '"+endTime+"' and gys_id='"+gys_id+"'");

	//应付明细合计
	String yfmx_sum[]=Api.sb("select case when convert(numeric(19,8),sum(je)) is null then 0 else convert(numeric(19,8),sum(je)) end ,case when convert(numeric(19,8),sum(yfje)) is null then 0 else convert(numeric(19,8),sum(yfje)) end ,case when convert(numeric(19,8),sum(wfje)) is null then 0 else convert(numeric(19,8),sum(wfje)) end  from cw_yfd where djrq between '"+startTime+"' and '"+endTime+"' and gys_id='"+gys_id+"'");

	//付款明细合计
	String fkmx_sum[]=Api.sb("select case when convert(numeric(19,8),sum(sfje)) is null then 0 else convert(numeric(19,8),sum(sfje)) end  from cg_fkd where fkrq  between '"+startTime+"' and '"+endTime+"' and gys_id='"+gys_id+"' ");

	
    String header="";    //表头
	String footer="";    //表尾
	String blank ="";    //空行



	int sub_cols=9;      //子表的列数
	int rows=38;          //每页打印的行数
	String result="";    //结果1
	String colname="";   //表列名
	String sum_row ="";  //合计行
%>
</head>


<body>

<div class=Section1 >
 <table class="printcontent"  style="WIDTH: 660px; BORDER-COLLAPSE: collapse" borderColor="#ffffff" align="center" >
 <tr>
 <td colspan="2" align="center" height="30"><b><span style="font-size:13.5pt;font-family:宋体;"><%=gsqc%></span></b>
</td>
 </tr>
 <tr>
 <td colspan="2" align="center" height="30"><b><span style="font-size:13.5pt;font-family:宋体;">供应商对账单</span></b>
</td>
 </tr>
 <tr>
 <td class="font2" width='40%'>供应商名称：<%=gysdzd_main[2]%></td>
 <td class="font2" align="right">所属日期：<%=startTime%>&nbsp;至&nbsp;<%=endTime%></td>
 </tr>
 </table>
 <TABLE class="printcontent" style="BORDER-COLLAPSE: collapse;" borderColor="#000000" cellSpacing="0" cellPadding="0" width="650px" border="1" align="center">
 <TR><td colspan="4" align="center" >进货汇总</td></TR>
 <TR>
 <td class="table_td" width="25%">订货数量</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[4]))%></td>
 <td class="table_td" width="25%">订货金额</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[5]))%></td>
 </TR>
  <TR>
 <td class="table_td" width="25%">采购进货数量</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[6]))%></td>
 <td class="table_td" width="25%">采购进货金额</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[7]))%></td>
 </TR>
  <TR>
 <td class="table_td" width="25%">退货数量</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[8]))%></td>
 <td class="table_td" width="25%">退货金额</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[9]))%></td>
 </TR>
  <TR>
 <td class="table_td" width="25%">实际进货数量</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[10]))%></td>
 <td class="table_td" width="25%">实际进货金额</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[11]))%></td>
 </TR>
 </TABLE>
  <!--分页-->
  <br>
  <TABLE class="printcontent" style="BORDER-COLLAPSE: collapse;" borderColor="#000000" cellSpacing="0" cellPadding="0" width="650px" border="1" align="center">
 <TR><td align="center"  colspan="6">结算汇总</td></TR>
 <TR>
 <td class="table_td"  width="18%">开票小计</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[12]))%></td>
 <td class="table_td"  width="18%">本期开票金额</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[13]))%></td>
  <td class="table_td"  width="18%">他期开票金额</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[14]))%></td>
 </TR>
  <TR>
 <td class="table_td"  width="18%">应付小计</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[15]))%></td>
 <td class="table_td"  width="18%">采购应付</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[16]))%></td>
  <td class="table_td"  width="18%">其他应付</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[17]))%></td>
 </TR>
 <TR>
 <td class="table_td"  width="18%">本期付款</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[18]))%></td>
 <td class="table_td"  width="18%">结本期欠款</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[19]))%></td>
  <td class="table_td"  width="18%">结他期欠款</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[20]))%></td>
 </TR>
  <TR>
 <td class="table_td">本期欠款余额</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[21]))%></td>
 <td class="table_td">累计欠款余额</td><td class="table_td">&nbsp;<%=parseJe(parseZero(gysdzd_main[22]))%></td>
  <td class="table_td">&nbsp;</td><td class="table_td"></td>
 </TR>
 </TABLE>
 <TABLE class=printcontent  style="WIDTH: 660px; BORDER-COLLAPSE: collapse;margin-top:0px;" borderColor=#ffffff cellSpacing=0 cellPadding=0 border=0 align=center>
 <TR><TD>公司地址：<%=gsdz%></TD><TD>邮编：<%=yzbm%></TD><TD>联系电话：<%=lxdh%></TD></TR>
 </TABLE>
  <!--分页-->
<%if(null!=jhmx&&jhmx.length>0){out.print("<br><div style=\"PAGE-BREAK-AFTER: always\"></div>"); }%>
 <!--进货明细可能要页显示-->

  <%  
		//头部共用部分
		 header="<table class=\"printcontent\"  style=\"WIDTH: 660px; BORDER-COLLAPSE: collapse\" borderColor=\"#ffffff\"	       align=\"center\" >"+
				 "<tr>"+
				 "<td colspan=\"2\" align=\"center\" height=\"30\"><b><span style=\"font-size:13.5pt;font-family:宋体;\">"+gsqc+"&nbsp;供应商对账单</span></b></td>"+
				 "</tr>"+
				 "<tr>"+
				 "<td colspan=\"2\" align=\"center\" height=\"30\"><b><span style=\"font-size:13.5pt;font-family:宋体;\">进货明细</span></b></td>"+
				 "</tr>"+
				 "<tr>"+
				 "<td class=\"font2\" width='40%'>供应商名称："+gysdzd_main[2]+"</td>"+
				 "<td class=\"font2\" align=\"right\">所属日期："+startTime+"&nbsp;至&nbsp;"+endTime+"</td> "+
				 "</tr>"+
				 "</table>";

		//子表以下的内容,可以根据供应商的要求定制
        footer=" <TABLE class=printcontent  style=\"WIDTH: 660px; BORDER-COLLAPSE: collapse;margin-top:0px;\" borderColor=#ffffff cellSpacing=0 cellPadding=0 border=0 align=center>"+
			   "<TR><TD>公司地址："+gsdz+"</TD><TD>邮编："+yzbm+"</TD><TD>联系电话："+lxdh+"</TD></TR>"+
				"</TABLE>";
		

		//列与子表要打印的列数相同
        colname="<TABLE class=\"printcontent\" style=\"BORDER-COLLAPSE: collapse;\" borderColor=\"#000000\" cellSpacing=\"0\" cellPadding=\"0\" width=\"660px\" border=\"1\" align=\"center\">"+
        "<TBODY>"+
		"<TR><td style=\"padding-left:20px\"   colspan=\"10\">进货明细</td></TR>"+
        "<TR>"+
		"<td class=\"font2\" align=\"center\">序号</td>"+
        "<td class=\"font2\" align=\"center\">日期</td>"+
		"<td class=\"font2\" align=\"center\">货品编号</td>"+
		"<td class=\"font2\" align=\"center\">货品名称</td>"+
		"<td class=\"font2\" align=\"center\">规格型号</td>"+
		"<td class=\"font2\" align=\"center\">单位</td>"+
		"<td class=\"font2\" align=\"center\">数量</td>"+
		"<td class=\"font2\" align=\"center\">单价</td>"+
		"<td class=\"font2\" align=\"center\">金额</td>"+
		"<td class=\"font2\" align=\"center\">备注</td>"+
        "</TR>";

		 //合计项
        sum_row="<TR>"+
				"<TD align=center>合计</TD>"+
				"<TD align=center>&nbsp;</TD>"+
				"<TD align=center>&nbsp;</TD>"+
				"<TD align=center>&nbsp;</TD>"+
				"<TD align=center>&nbsp;</TD>"+
				"<TD align=center>&nbsp;</TD>"+
				"<TD align=center>"+parseJe(parseZero(jhmx_sum[0]))+"</TD>"+
				"<TD align=center>&nbsp;</TD>"+
				"<TD align=center>"+parseJe(parseZero(jhmx_sum[1]))+"</TD>"+
				"<TD align=center>&nbsp;</TD>"+
				"</TR>";
				
		//对子表进行循环打印
         for (int i=0,j=0;i<jhmx.length;i+=sub_cols,j++)  {
                    //没有特殊处理下面这个if就不用改动
                    if (i/sub_cols%rows==0) {
                         if(i/sub_cols>0)  { 
                            result+="</TBODY></TABLE>";//表的结束
                            result+=footer;//打印表尾
                            result+="<div style=\"PAGE-BREAK-AFTER: always\"></div>"; //换页
                         }
                                //计算页码
                                //如果不到一页，不用打印
                                //if （r1.length<=rows*sub_cols）{
                                //  page_title="";
                                //} else {
                                // page_title=ceiling(i/sub_cols/rows);
                               // }
                            //打印表头  
                            //header+page_title
                            result+=header;
                            result+=colname;
                    }

					   //子表

                    //打印表体---子表有多少列就打印多少个<td></td>
                    result+="<TR>"+
							 "<td class=\"font2\" align=\"center\">"+(j+1)+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+jhmx[i+0]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+jhmx[i+1]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+jhmx[i+2]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+jhmx[i+3]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+jhmx[i+4]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+parseJe(parseZero(jhmx[i+5]))+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+parseJe(parseZero(jhmx[i+6]))+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+parseJe(parseZero(jhmx[i+7]))+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+jhmx[i+8]+"</td>"+
							 "</TR>";

         }
	   if(null!=jhmx&&jhmx.length>0){
        result+=sum_row;//打印合计行
        result+=footer; //打印表尾
		out.print(result);
		if(null!=thmx&&thmx.length>0){out.print("<br><div style=\"PAGE-BREAK-AFTER: always\"></div>"); }
	   }
       
  %>
 <!--退货明细-->
 <%
		//清空result的值
		result="";
		//头部共用部分
		header="<table class=\"printcontent\"  style=\"WIDTH: 660px; BORDER-COLLAPSE: collapse\" borderColor=\"#ffffff\"	       align=\"center\" >"+
				 "<tr>"+
				 "<td colspan=\"2\" align=\"center\" height=\"30\"><b><span style=\"font-size:13.5pt;font-family:宋体;\">"+gsqc+"&nbsp;供应商对账单</span></b></td>"+
				 "</tr>"+
				 "<tr>"+
				 "<td colspan=\"2\" align=\"center\" height=\"30\"><b><span style=\"font-size:13.5pt;font-family:宋体;\">退货明细</span></b></td>"+
				 "</tr>"+
				 "<tr>"+
				 "<td class=\"font2\" width='40%'>供应商名称："+gysdzd_main[2]+"</td>"+
				 "<td class=\"font2\" align=\"right\">所属日期："+startTime+"&nbsp;至&nbsp;"+endTime+"</td> "+
				 "</tr>"+
				 "</table>";
		//列与子表要打印的列数相同
        colname="<TABLE class=\"printcontent\" style=\"BORDER-COLLAPSE: collapse;\" borderColor=\"#000000\" cellSpacing=\"0\" cellPadding=\"0\" width=\"660px\" border=\"1\" align=\"center\">"+
        "<TBODY>"+
		"<TR><td style=\"padding-left:20px\"   colspan=\"10\">退货明细</td></TR>"+
        "<TR>"+
		"<td class=\"font2\" align=\"center\">序号</td>"+
        "<td class=\"font2\" align=\"center\">日期</td>"+
		"<td class=\"font2\" align=\"center\">货品编号</td>"+
		"<td class=\"font2\" align=\"center\">货品名称</td>"+
		"<td class=\"font2\" align=\"center\">规格型号</td>"+
		"<td class=\"font2\" align=\"center\">单位</td>"+
		"<td class=\"font2\" align=\"center\">数量</td>"+
		"<td class=\"font2\" align=\"center\">单价</td>"+
		"<td class=\"font2\" align=\"center\">金额</td>"+
		"<td class=\"font2\" align=\"center\">备注</td>"+
        "</TR>";

		 //合计项
        sum_row="<TR>"+
				"<TD align=center>合计</TD>"+
				"<TD align=center>&nbsp;</TD>"+
				"<TD align=center>&nbsp;</TD>"+
				"<TD align=center>&nbsp;</TD>"+
				"<TD align=center>&nbsp;</TD>"+
				"<TD align=center>&nbsp;</TD>"+
				"<TD align=center>"+parseJe(parseZero(thmx_sum[0]))+"</TD>"+
				"<TD align=center>&nbsp;</TD>"+
				"<TD align=center>"+parseJe(parseZero(thmx_sum[1]))+"</TD>"+
				"<TD align=center>&nbsp;</TD>"+
				"</TR>";
		//对子表进行循环打印
         for (int i=0,j=0;i<thmx.length;i+=sub_cols,j++)  {
                    //没有特殊处理下面这个if就不用改动
                    if (i/sub_cols%rows==0) {
                         if(i/sub_cols>0)  { 
                            result+="</TBODY></TABLE>";//表的结束
                            result+=footer;//打印表尾
                            result+="<div style=\"PAGE-BREAK-AFTER: always\"></div>"; //换页
                         }
                            result+=header;
                            result+=colname;
                    }

                    //打印表体---子表有多少列就打印多少个<td></td>
                    result+="<TR>"+
							 "<td class=\"font2\" align=\"center\">"+(j+1)+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+thmx[i+0]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+thmx[i+1]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+thmx[i+2]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+thmx[i+3]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+thmx[i+4]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+parseJe(parseZero(thmx[i+5]))+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+parseJe(parseZero(thmx[i+6]))+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+parseJe(parseZero(thmx[i+7]))+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+thmx[i+8]+"</td>"+
							 "</TR>";

         }
		 if(null!=thmx&&thmx.length>0){
			result+=sum_row;//打印合计行
			result+=footer; //打印表尾
			out.print(result);
			if(null!=yfmx&&yfmx.length>0){out.print("<br><div style=\"PAGE-BREAK-AFTER: always\"></div>"); }
		 }
 %>
   <!--应付明细-->
   <%
	   //清空result的值
	   result="";
	   sub_cols=5;      //子表的列数
	   header="<table class=\"printcontent\"  style=\"WIDTH: 660px; BORDER-COLLAPSE: collapse\" borderColor=\"#ffffff\"	       align=\"center\" >"+
				 "<tr>"+
				 "<td colspan=\"2\" align=\"center\" height=\"30\"><b><span style=\"font-size:13.5pt;font-family:宋体;\">"+gsqc+"&nbsp;供应商对账单</span></b></td>"+
				 "</tr>"+
				 "<tr>"+
				 "<td colspan=\"2\" align=\"center\" height=\"30\"><b><span style=\"font-size:13.5pt;font-family:宋体;\">应付明细</span></b></td>"+
				 "</tr>"+
				 "<tr>"+
				 "<td class=\"font2\" width='40%'>供应商名称："+gysdzd_main[2]+"</td>"+
				 "<td class=\"font2\" align=\"right\">所属日期："+startTime+"&nbsp;至&nbsp;"+endTime+"</td> "+
				 "</tr>"+
				 "</table>";
	   colname="<TABLE class=\"printcontent\" style=\"BORDER-COLLAPSE: collapse;\" borderColor=\"#000000\" cellSpacing=\"0\" cellPadding=\"0\" width=\"660px\" border=\"1\" align=\"center\">"+
        "<TBODY>"+
		"<TR><td style=\"padding-left:20px\"   colspan=\"6\">应付明细</td></TR>"+
        "<TR>"+
		"<td class=\"font2\" align=\"center\">序号</td>"+
        "<td class=\"font2\" align=\"center\">日期</td>"+
		"<td class=\"font2\" align=\"center\">应付金额</td>"+
		"<td class=\"font2\" align=\"center\">已付金额</td>"+
		"<td class=\"font2\" align=\"center\">未付金额</td>"+
		"<td class=\"font2\" align=\"center\">备注</td>"+
        "</TR>";

		 //合计项
        sum_row="<TR>"+
				 "<TD align=center>合计</TD>"+
				 "<TD align=center>&nbsp;</TD>"+
				 "<TD align=center>"+parseJe(parseZero(yfmx_sum[0]))+"</TD>"+
				 "<TD align=center>"+parseJe(parseZero(yfmx_sum[1]))+"</TD>"+
				 "<TD align=center>"+parseJe(parseZero(yfmx_sum[2]))+"</TD>"+
				 "<TD align=center>&nbsp;</TD>"+
				"</TR>";
		//对子表进行循环打印
         for (int i=0,j=0;i<yfmx.length;i+=sub_cols,j++)  {
                    //没有特殊处理下面这个if就不用改动
                    if (i/sub_cols%rows==0) {
                         if(i/sub_cols>0)  { 
                            result+="</TBODY></TABLE>";//表的结束
                            result+=footer;//打印表尾
                            result+="<div style=\"PAGE-BREAK-AFTER: always\"></div>"; //换页
                         }
                            result+=header;
                            result+=colname;
                    }

					   //子表

                    //打印表体---子表有多少列就打印多少个<td></td>
                    result+="<TR>"+
							 "<td class=\"font2\" align=\"center\">"+(j+1)+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+yfmx[i+0]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+parseJe(parseZero(yfmx[i+1]))+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+parseJe(parseZero(yfmx[i+2]))+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+parseJe(parseZero(yfmx[i+3]))+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+yfmx[i+4]+"</td>"+
							 "</TR>";

         }
		  if(null!=yfmx&&yfmx.length>0){
			result+=sum_row;//打印合计行
			result+=footer; //打印表尾
			out.print(result);
			if(null!=fkmx&&fkmx.length>0){out.print("<br><div style=\"PAGE-BREAK-AFTER: always\"></div>"); }
		  }
       
   %>

 <!--付款明细页显示-->
   <%
	   //清空result的值
	   result="";
	   sub_cols=4;      //子表的列数
	   header="<table class=\"printcontent\"  style=\"WIDTH: 660px; BORDER-COLLAPSE: collapse\" borderColor=\"#ffffff\"	       align=\"center\" >"+
				 "<tr>"+
				 "<td colspan=\"2\" align=\"center\" height=\"30\"><b><span style=\"font-size:13.5pt;font-family:宋体;\">"+gsqc+"&nbsp;供应商对账单</span></b></td>"+
				 "</tr>"+
				 "<tr>"+
				 "<td colspan=\"2\" align=\"center\" height=\"30\"><b><span style=\"font-size:13.5pt;font-family:宋体;\">付款明细</span></b></td>"+
				 "</tr>"+
				 "<tr>"+
				 "<td class=\"font2\" width='40%'>供应商名称："+gysdzd_main[2]+"</td>"+
				 "<td class=\"font2\" align=\"right\">所属日期："+startTime+"&nbsp;至&nbsp;"+endTime+"</td> "+
				 "</tr>"+
				 "</table>";
	   colname="<TABLE class=\"printcontent\" style=\"BORDER-COLLAPSE: collapse;\" borderColor=\"#000000\" cellSpacing=\"0\" cellPadding=\"0\" width=\"660px\" border=\"1\" align=\"center\">"+
        "<TBODY>"+
		"<TR><td style=\"padding-left:20px\"   colspan=\"5\">付款明细</td></TR>"+
        "<TR>"+
		"<td class=\"font2\" align=\"center\">序号</td>"+
        "<td class=\"font2\" align=\"center\">日期</td>"+
		"<td class=\"font2\" align=\"center\">支付方式</td>"+
		"<td class=\"font2\" align=\"center\">付款金额</td>"+
		"<td class=\"font2\" align=\"center\">备注</td>"+
        "</TR>";

		 //合计项
        sum_row="<TR>"+
				 "<TD align=center>合计</TD>"+
				 "<TD align=center>&nbsp;</TD>"+
				 "<TD align=center>&nbsp;</TD>"+
				 "<TD align=center>"+parseJe(parseZero(fkmx_sum[0]))+"</TD>"+
				 "<TD align=center>&nbsp;</TD>"+
				"</TR>";
		//对子表进行循环打印
         for (int i=0,j=0;i<fkmx.length;i+=sub_cols,j++)  {
                    //没有特殊处理下面这个if就不用改动
                    if (i/sub_cols%rows==0) {
                         if(i/sub_cols>0)  { 
                            result+="</TBODY></TABLE>";//表的结束
                            result+=footer;//打印表尾
                            result+="<div style=\"PAGE-BREAK-AFTER: always\"></div>"; //换页
                         }
                            result+=header;
                            result+=colname;
                    }

					   //子表

                    //打印表体---子表有多少列就打印多少个<td></td>
                    result+="<TR>"+
							 "<td class=\"font2\" align=\"center\">"+(j+1)+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+fkmx[i+0]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+fkmx[i+1]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+parseJe(parseZero(fkmx[i+2]))+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+fkmx[i+3]+"</td>"+
							 "</TR>";

         }
		if(null!=fkmx&&fkmx.length>0){
			result+=sum_row;//打印合计行
			result+=footer; //打印表尾
			out.print(result);
		}
       
   %>

 </div>
 <div id="button_area"><table border="0"  width=50%  align=center cellpadding=5 cellspacing=5><tr><td align=center><input type=button value='打印' onclick="printData();"></input>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=button value='关闭' onclick="javascript:window.close();"></input></td></tr></table></div>
</body>
</html>
