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
<head>
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
	//取得客户ID
	String kh_id=lst[0];
	//取得开始日期
	String startTime=lst[1];
	//取得结束日期
	String endTime=lst[2];
	String execSql=Api.getDTable("view_xs_khdzd","<\"djrq111\">",startTime,"<\"djrq112\">",endTime,"");

	execSql="select * from "+execSql+" where kh_id='"+kh_id+"' ";
	String khdzd_main[]=Api.sb(execSql);

	//发货明细
	String fhmx[]=Api.sb("select a.xsrq,b.chbm,b.chmc,b.ggxh,b.dw,b.sl,b.hsdj,b.jshj,b.bz from  xs_xsd a,xs_xsd_sub b  where xsrq between '"+startTime+"' and '"+endTime+"' and a.id=b.fid and kh_id='"+kh_id+"' and b.sl>0  order by xsrq ");

	//退货明细
	String thmx[]=Api.sb("select a.xsrq,b.chbm,b.chmc,b.ggxh,b.dw,b.sl,b.hsdj,b.jshj,b.bz from  xs_xsd a,xs_xsd_sub b  where xsrq between '"+startTime+"' and '"+endTime+"' and a.id=b.fid and kh_id='"+kh_id+"' and b.sl<=0  order by xsrq");
	//发货明细合计
	String fhmx_sum[]=Api.sb("select case when convert(numeric(19,8),sum(b.sl)) is null then 0 else  convert(numeric(19,8),sum(b.sl)) end zsl, case when convert(numeric(19,8),sum(jshj)) is null then 0 else convert(numeric(19,8),sum(jshj)) end zje from  xs_xsd a,xs_xsd_sub b  where xsrq between '"+startTime+"' and '"+endTime+"' and a.id=b.fid and kh_id='"+kh_id+"' and b.sl>0 ");
	//退货明细合计
	String thmx_sum[]=Api.sb("select case when convert(numeric(19,8),sum(b.sl)) is null then 0 else convert(numeric(19,8),sum(b.sl)) end  zsl,case when convert(numeric(19,8),sum(jshj)) is null then 0 else convert(numeric(19,8),sum(jshj)) end  zje from  xs_xsd a,xs_xsd_sub b  where xsrq between '"+startTime+"' and '"+endTime+"' and a.id=b.fid and kh_id='"+kh_id+"' and b.sl<=0 ");
	//应收明细
	String ysmx[]=Api.sb("select djrq,je,ysje,wsje,bz from cw_ysd where djrq between '"+startTime+"' and '"+endTime+"' and kh_id='"+kh_id+"'");
	//收款明细
	String skmx[]=Api.sb("select skrq,(select mc from dm_zffs where dm=xs_skd.zffs) as zffs,ssje,bz from xs_skd where  skrq between '"+startTime+"' and '"+endTime+"' and kh_id='"+kh_id+"'");

	//应收明细合计
	String ysmx_sum[]=Api.sb("select case when convert(numeric(19,8),sum(je)) is null then 0 else convert(numeric(19,8),sum(je)) end ,case when convert(numeric(19,8),sum(ysje)) is null then 0 else convert(numeric(19,8),sum(ysje)) end ,case when convert(numeric(19,8),sum(wsje)) is null then 0 else convert(numeric(19,8),sum(wsje)) end  from cw_ysd where djrq between '"+startTime+"' and '"+endTime+"' and kh_id='"+kh_id+"'");

	//收款明细合计
	String skmx_sum[]=Api.sb("select case when convert(numeric(19,8),sum(ssje)) is null then 0 else convert(numeric(19,8),sum(ssje)) end  from xs_skd where skrq  between '"+startTime+"' and '"+endTime+"' and kh_id='"+kh_id+"' ");

	
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


<body lang=ZH-CN>
<div class=Section1 >
 <table class="printcontent"  style="WIDTH: 680px; BORDER-COLLAPSE: collapse" borderColor="#ffffff" align="center" >
 <tr>
 <td colspan="2" align="center" height="30"><b><span style="font-size:13.5pt;font-family:宋体;"><%=gsqc%></span></b>
</td>
 </tr>
 <tr>
 <td colspan="2" align="center" height="30"><b><span style="font-size:13.5pt;font-family:宋体;">客户对账单</span></b>
</td>
 </tr>
 <tr>
 <td class="font2" width='40%'>客户名称：<%=khdzd_main[2]%></td>
 <td class="font2" align="right">所属日期：<%=startTime%>&nbsp;至&nbsp;<%=endTime%></td>
 </tr>
 </table>
 <TABLE class="printcontent" style="BORDER-COLLAPSE: collapse;" borderColor="#000000" cellSpacing="0" cellPadding="0" width="680px" border="1" align="center">
 <TR><td colspan="4" style="padding-left:20px" >发货汇总</td></TR>
 <TR>
 <td class="table_td" width="25%">订货数量</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[4]))%></td>
 <td class="table_td" width="25%">订货金额</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[5]))%></td>
 </TR>
  <TR>
 <td class="table_td" width="25%">销售发货数量</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[6]))%></td>
 <td class="table_td" width="25%">销售发货金额</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[7]))%></td>
 </TR>
  <TR>
 <td class="table_td" width="25%">退货数量</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[8]))%></td>
 <td class="table_td" width="25%">退货金额</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[9]))%></td>
 </TR>
  <TR>
 <td class="table_td" width="25%">实际发货数量</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[10]))%></td>
 <td class="table_td" width="25%">实际发货金额</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[11]))%></td>
 </TR>
 </TABLE>
  <br>
  <TABLE class="printcontent" style="BORDER-COLLAPSE: collapse;" borderColor="#000000" cellSpacing="0" cellPadding="0" width="680px" border="1" align="center">
 <TR><td style="padding-left:20px"   colspan="6">结算汇总</td></TR>
 <TR>
 <td class="table_td"  width="18%">开票小计</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[12]))%></td>
 <td class="table_td"  width="18%">本期开票金额</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[13]))%></td>
  <td class="table_td"  width="18%">他期开票金额</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[14]))%></td>
 </TR>
  <TR>
 <td class="table_td"  width="18%">应收小计</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[15]))%></td>
 <td class="table_td"  width="18%">销售应收</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[16]))%></td>
  <td class="table_td"  width="18%">其他应收</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[17]))%></td>
 </TR>
 <TR>
 <td class="table_td"  width="18%">本期收款</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[18]))%></td>
 <td class="table_td"  width="18%">结本期欠款</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[19]))%></td>
  <td class="table_td"  width="18%">结他期欠款</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[20]))%></td>
 </TR>
  <TR>
 <td class="table_td">本期欠款余额</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[21]))%></td>
 <td class="table_td">累计欠款余额</td><td class="table_td">&nbsp;<%=parseJe(parseZero(khdzd_main[22]))%></td>
  <td class="table_td">&nbsp;</td><td class="table_td"></td>
 </TR>
 </TABLE>

 <TABLE class=printcontent  style="WIDTH: 680px; BORDER-COLLAPSE: collapse;margin-top:0px;" borderColor=#ffffff cellSpacing=0 cellPadding=0 border=0 align=center>
 <TR><TD>公司地址：<%=gsdz%></TD><TD>邮编：<%=yzbm%></TD><TD>联系电话：<%=lxdh%></TD></TR>
 </TABLE>
  <!--分页-->
  <%if(null!=fhmx&&fhmx.length>0){out.print("<br><div style=\"PAGE-BREAK-AFTER: always\"></div>"); }%>

  <%  
		 //头部共用部分
		 header="<table class=\"printcontent\"  style=\"WIDTH: 680px; BORDER-COLLAPSE: collapse\" borderColor=\"#ffffff\"	       align=\"center\" >"+
				 "<tr>"+
				 "<td colspan=\"2\" align=\"center\" height=\"30\"><b><span style=\"font-size:13.5pt;font-family:宋体;\">"+gsqc+"&nbsp;客户对账单</span></b></td>"+
				 "</tr>"+
				 "<tr>"+
				 "<td colspan=\"2\" align=\"center\" height=\"30\"><b><span style=\"font-size:13.5pt;font-family:宋体;\">发货明细</span></b></td>"+
				 "</tr>"+
				 "<tr>"+
				 "<td class=\"font2\" width='40%'>客户名称："+khdzd_main[2]+"</td>"+
				 "<td class=\"font2\" align=\"right\">所属日期："+startTime+"&nbsp;至&nbsp;"+endTime+"</td> "+
				 "</tr>"+
				 "</table>";

		//子表以下的内容,可以根据客户的要求定制
        footer=" <TABLE class=printcontent  style=\"WIDTH: 680px; BORDER-COLLAPSE: collapse;margin-top:0px;\" borderColor=#ffffff cellSpacing=0 cellPadding=0 border=0 align=center>"+
			   "<TR><TD>公司地址："+gsdz+"</TD><TD>邮编："+yzbm+"</TD><TD>联系电话："+lxdh+"</TD></TR>"+
				"</TABLE>";
		
		//列与子表要打印的列数相同
        blank="<TR>"+
        "<TD align=center noWrap>&nbsp;</TD>"+
		"<TD align=center noWrap>&nbsp;</TD>"+
        "<TD align=center noWrap>&nbsp;</TD>"+
        "<TD align=center noWrap>&nbsp;</TD>"+
        "<TD align=center noWrap>&nbsp;</TD>"+
        "<TD align=center noWrap>&nbsp;</TD>"+
        "<TD align=center noWrap>&nbsp;</TD>"+
        "<TD align=center noWrap>&nbsp;</TD>"+
		"<TD align=center noWrap>&nbsp;</TD>"+
		"<TD align=center noWrap>&nbsp;</TD>"+
        "</TR>";
		//列与子表要打印的列数相同
        colname="<TABLE class=\"printcontent\" style=\"BORDER-COLLAPSE: collapse;\" borderColor=\"#000000\" cellSpacing=\"0\" cellPadding=\"0\" width=\"680px\" border=\"1\" align=\"center\">"+
        "<TBODY>"+
		"<TR><td style=\"padding-left:20px\"   colspan=\"10\">发货明细</td></TR>"+
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
				"<TD align=center>"+parseJe(parseZero(fhmx_sum[0]))+"</TD>"+
				"<TD align=center>&nbsp;</TD>"+
				"<TD align=center>"+parseJe(parseZero(fhmx_sum[1]))+"</TD>"+
				"<TD align=center>&nbsp;</TD>"+
				"</TR>";
				
		//对子表进行循环打印
         for (int i=0,j=0;i<fhmx.length;i+=sub_cols,j++)  {
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
							 "<td class=\"font2\" align=\"center\">"+fhmx[i+0]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+fhmx[i+1]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+fhmx[i+2]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+fhmx[i+3]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+fhmx[i+4]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+parseJe(parseZero(fhmx[i+5]))+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+parseJe(parseZero(fhmx[i+6]))+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+parseJe(parseZero(fhmx[i+7]))+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+fhmx[i+8]+"</td>"+
							 "</TR>";

         }
        //补空行
        //for (int j=0;j<rows- (fhmx.length/sub_cols)%rows;j++) {
        //    result+=blank; 
        //}
	   if(null!=fhmx&&fhmx.length>0){
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
		header="<table class=\"printcontent\"  style=\"WIDTH: 680px; BORDER-COLLAPSE: collapse\" borderColor=\"#ffffff\"	       align=\"center\" >"+
				 "<tr>"+
				 "<td colspan=\"2\" align=\"center\" height=\"30\"><b><span style=\"font-size:13.5pt;font-family:宋体;\">"+gsqc+"&nbsp;客户对账单</span></b></td>"+
				 "</tr>"+
				 "<tr>"+
				 "<td colspan=\"2\" align=\"center\" height=\"30\"><b><span style=\"font-size:13.5pt;font-family:宋体;\">退货明细</span></b></td>"+
				 "</tr>"+
				 "<tr>"+
				 "<td class=\"font2\" width='40%'>客户名称："+khdzd_main[2]+"</td>"+
				 "<td class=\"font2\" align=\"right\">所属日期："+startTime+"&nbsp;至&nbsp;"+endTime+"</td> "+
				 "</tr>"+
				 "</table>";
		//列与子表要打印的列数相同
        colname="<TABLE class=\"printcontent\" style=\"BORDER-COLLAPSE: collapse;\" borderColor=\"#000000\" cellSpacing=\"0\" cellPadding=\"0\" width=\"680px\" border=\"1\" align=\"center\">"+
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
                               
                            //打印表头  
                            //header+page_title
                            result+=header;
                            result+=colname;
                    }

					   //子表

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
			if(null!=ysmx&&ysmx.length>0){out.print("<br><div style=\"PAGE-BREAK-AFTER: always\"></div>"); }
		 }
 %>
   <!--应收明细-->
   <%
	   //清空result的值
	   result="";
	   sub_cols=5;      //子表的列数
	   //头部共用部分
	  header="<table class=\"printcontent\"  style=\"WIDTH: 680px; BORDER-COLLAPSE: collapse\" borderColor=\"#ffffff\"	       align=\"center\" >"+
				 "<tr>"+
				 "<td colspan=\"2\" align=\"center\" height=\"30\"><b><span style=\"font-size:13.5pt;font-family:宋体;\">"+gsqc+"&nbsp;客户对账单</span></b></td>"+
				 "</tr>"+
				 "<tr>"+
				 "<td colspan=\"2\" align=\"center\" height=\"30\"><b><span style=\"font-size:13.5pt;font-family:宋体;\">应收明细</span></b></td>"+
				 "</tr>"+
				 "<tr>"+
				 "<td class=\"font2\" width='40%'>客户名称："+khdzd_main[2]+"</td>"+
				 "<td class=\"font2\" align=\"right\">所属日期："+startTime+"&nbsp;至&nbsp;"+endTime+"</td> "+
				 "</tr>"+
				 "</table>";
	   colname="<TABLE class=\"printcontent\" style=\"BORDER-COLLAPSE: collapse;\" borderColor=\"#000000\" cellSpacing=\"0\" cellPadding=\"0\" width=\"680px\" border=\"1\" align=\"center\">"+
        "<TBODY>"+
		"<TR><td style=\"padding-left:20px\"   colspan=\"6\">应收明细</td></TR>"+
        "<TR>"+
		"<td class=\"font2\" align=\"center\">序号</td>"+
        "<td class=\"font2\" align=\"center\">日期</td>"+
		"<td class=\"font2\" align=\"center\">应收金额</td>"+
		"<td class=\"font2\" align=\"center\">已收金额</td>"+
		"<td class=\"font2\" align=\"center\">未收金额</td>"+
		"<td class=\"font2\" align=\"center\">备注</td>"+
        "</TR>";

		 //合计项
        sum_row="<TR>"+
				 "<TD align=center>合计</TD>"+
				 "<TD align=center>&nbsp;</TD>"+
				 "<TD align=center>"+parseJe(parseZero(ysmx_sum[0]))+"</TD>"+
				 "<TD align=center>"+parseJe(parseZero(ysmx_sum[1]))+"</TD>"+
				 "<TD align=center>"+parseJe(parseZero(ysmx_sum[2]))+"</TD>"+
				 "<TD align=center>&nbsp;</TD>"+
				"</TR>";
		//对子表进行循环打印
         for (int i=0,j=0;i<ysmx.length;i+=sub_cols,j++)  {
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
							 "<td class=\"font2\" align=\"center\">"+ysmx[i+0]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+parseJe(parseZero(ysmx[i+1]))+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+parseJe(parseZero(ysmx[i+2]))+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+parseJe(parseZero(ysmx[i+3]))+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+ysmx[i+4]+"</td>"+
							 "</TR>";

         }


		  if(null!=ysmx&&ysmx.length>0){
			result+=sum_row;//打印合计行
			result+=footer; //打印表尾
			out.print(result);
			if(null!=skmx&&skmx.length>0){out.print("<br><div style=\"PAGE-BREAK-AFTER: always\"></div>"); }
		  }
       
   %>

 <!--收款明细页显示-->
   <%
	   //清空result的值
	   result="";
	   sub_cols=4;      //子表的列数
	   header="<table class=\"printcontent\"  style=\"WIDTH: 680px; BORDER-COLLAPSE: collapse\" borderColor=\"#ffffff\"	       align=\"center\" >"+
				 "<tr>"+
				 "<td colspan=\"2\" align=\"center\" height=\"30\"><b><span style=\"font-size:13.5pt;font-family:宋体;\">"+gsqc+"&nbsp;客户对账单</span></b></td>"+
				 "</tr>"+
				 "<tr>"+
				 "<td colspan=\"2\" align=\"center\" height=\"30\"><b><span style=\"font-size:13.5pt;font-family:宋体;\">收款明细</span></b></td>"+
				 "</tr>"+
				 "<tr>"+
				 "<td class=\"font2\" width='40%'>客户名称："+khdzd_main[2]+"</td>"+
				 "<td class=\"font2\" align=\"right\">所属日期："+startTime+"&nbsp;至&nbsp;"+endTime+"</td> "+
				 "</tr>"+
				 "</table>";
	   colname="<TABLE class=\"printcontent\" style=\"BORDER-COLLAPSE: collapse;\" borderColor=\"#000000\" cellSpacing=\"0\" cellPadding=\"0\" width=\"680px\" border=\"1\" align=\"center\">"+
        "<TBODY>"+
		"<TR><td style=\"padding-left:20px\"   colspan=\"5\">收款明细</td></TR>"+
        "<TR>"+
		"<td class=\"font2\" align=\"center\">序号</td>"+
        "<td class=\"font2\" align=\"center\">日期</td>"+
		"<td class=\"font2\" align=\"center\">支付方式</td>"+
		"<td class=\"font2\" align=\"center\">收款金额</td>"+
		"<td class=\"font2\" align=\"center\">备注</td>"+
        "</TR>";

		 //合计项
        sum_row="<TR>"+
				 "<TD align=center>合计</TD>"+
				 "<TD align=center>&nbsp;</TD>"+
				 "<TD align=center>&nbsp;</TD>"+
				 "<TD align=center>"+parseJe(parseZero(skmx_sum[0]))+"</TD>"+
				 "<TD align=center>&nbsp;</TD>"+
				"</TR>";
		//对子表进行循环打印
         for (int i=0,j=0;i<skmx.length;i+=sub_cols,j++)  {
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
							 "<td class=\"font2\" align=\"center\">"+skmx[i+0]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+skmx[i+1]+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+parseJe(parseZero(skmx[i+2]))+"</td>"+
							 "<td class=\"font2\" align=\"center\">"+skmx[i+3]+"</td>"+
							 "</TR>";

         }
		if(null!=skmx&&skmx.length>0){
			result+=sum_row;//打印合计行
			result+=footer; //打印表尾
			out.print(result);
		  }
       
   %>
 </div>
 <div id="button_area"><table border="0"  width=50%  align=center cellpadding=5 cellspacing=5><tr><td align=center><input type=button value='打印' onclick="printData();"></input>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=button value='关闭' onclick="javascript:window.close();"></input></td></tr></table></div>
</body>
</html>
