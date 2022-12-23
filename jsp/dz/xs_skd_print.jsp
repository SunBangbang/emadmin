
<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
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
    //入库单打印
    
    
	if( !request.getMethod().equalsIgnoreCase("post") && !Serve.checkMkQx( request ) )
	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}

%>

<style>
<!--
.body{
	font-family: "宋体";
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
	barkground-color: #FFFFFF;
	text-align: center;
	margin: 0px;
	padding: 0px;
	 border-bottom-style:none;
     border-bottom-width:0px;
     border-bottom-color:#000000;
}
.font2{
    font-size: 10pt;

}
.font3{
    font-size:9pt;

}
.x_bill_td_00 {  
	 BACKGROUND: #ffffff;
	 
	 TEXT-ALIGN: right;
	border-bottom-style:solid;
	border-bottom-width:0px;
	border-bottom-color:#000000;
	border-top-style:solid;
	border-top-width:1px;
	border-top-color:#000000;
	border-left-style:solid;
	border-left-width:1px;
	border-left-color:#000000;
	border-right-style:solid;
	border-right-width:0px;
	border-right-color:#000000;
	height:20px;
	padding:5px;
	 font-size: 10pt;
}
.x_bill_td_00_00 {  
	 BACKGROUND: #ffffff;
	 
	 TEXT-ALIGN: left;
	border-bottom-style:none;
	border-bottom-width:0px;
	border-bottom-color:#000000;
	border-top-style:none;
	border-top-width:0px;
	border-top-color:#000000;
	border-left-style:none;
	border-left-width:0px;
	border-left-color:#000000;
	border-right-style:none;
	border-right-width:0px;
	border-right-color:#000000;
	height:20px;
	padding:5px;
	 font-size: 8pt;
}
.x_bill_td_00_00_00 {  
	 BACKGROUND: #ffffff;
	 
	 TEXT-ALIGN: left;
	border-bottom-style:none;
	border-bottom-width:0px;
	border-bottom-color:#000000;
	border-top-style:solid;
	border-top-width:1px;
	border-top-color:#000000;
	border-left-style:none;
	border-left-width:0px;
	border-left-color:#000000;
	border-right-style:none;
	border-right-width:0px;
	border-right-color:#000000;
	height:20px;
	padding:5px;
	 font-size: 8pt;
}
.x_bill_td_01 {  
	TEXT-ALIGN: left;
	 BACKGROUND: #ffffff;
	 border-bottom-style:solid;
	 border-bottom-width:0px;
	 border-bottom-color:#000000;
	 border-top-style:solid;
	 border-top-width:1px;
	 border-top-color:#000000;
	 border-left-style:solid;
	 border-left-width:1px;
	 border-left-color:#000000;
	 border-right-style:solid;
	 border-right-width:1px;
	 border-right-color:#000000;
	 padding:5px;
	  font-size:10pt;
}
.x_bill_td_01_00 {  
	TEXT-ALIGN: left;
	 BACKGROUND: #ffffff;
	 border-bottom-style:none;
	 border-bottom-width:0px;
	 border-bottom-color:#000000;
	 border-top-style:none;
	 border-top-width:0px;
	 border-top-color:#000000;
	 border-left-style:none;
	 border-left-width:0px;
	 border-left-color:#000000;
	 border-right-style:none;
	 border-right-width:0px;
	 border-right-color:#000000;
	 padding:5px;
	  font-size: 10pt;
}
.x_bill_td_01_00_00 {  
	TEXT-ALIGN: center;
	 BACKGROUND: #ffffff;
	 border-bottom-style:none;
	 border-bottom-width:0px;
	 border-bottom-color:#000000;
	 border-top-style:solid;
	 border-top-width:1px;
	 border-top-color:#000000;
	 border-left-style:none;
	 border-left-width:0px;
	 border-left-color:#000000;
	 border-right-style:none;
	 border-right-width:0px;
	 border-right-color:#000000;
	 padding:5px;
	  font-size: 8pt;
}
.x_bill_td_10 {  
	 BACKGROUND: #ffffff;
	border-bottom-style:solid;
	border-bottom-width:0px;
	border-bottom-color:#000000;
	border-top-style:solid;
	border-top-width:1px;
	border-top-color:#000000;
	border-left-style:solid;
	border-left-width:1px;
	border-left-color:#000000;
	border-right-style:solid;
	border-right-width:0px;
	border-right-color:#000000;
	 TEXT-ALIGN: right;
	  
	padding:5px;
	 font-size: 10pt;
}
.x_bill_td_10_00 {  
	 BACKGROUND: #ffffff;
	border-bottom-style:none;
	border-bottom-width:0px;
	border-bottom-color:#000000;
	border-top-style:none;
	border-top-width:0px;
	border-top-color:#000000;
	border-left-style:none;
	border-left-width:0px;
	border-left-color:#000000;
	border-right-style:none;
	border-right-width:0px;
	border-right-color:#000000;
	 TEXT-ALIGN: right;
	  
	padding:5px;
	 font-size: 8pt;
}
.x_bill_td_10_00_00 {  
	 BACKGROUND: #ffffff;
	border-bottom-style:none;
	border-bottom-width:0px;
	border-bottom-color:#000000;
	border-top-style:solid;
	border-top-width:1px;
	border-top-color:#000000;
	border-left-style:none;
	border-left-width:0px;
	border-left-color:#000000;
	border-right-style:none;
	border-right-width:0px;
	border-right-color:#000000;
	 TEXT-ALIGN: center;
	  
	padding:5px;
	 font-size: 8pt;
}
.x_bill_td_11 {  
	 BACKGROUND: #ffffff;
	 TEXT-ALIGN: left; 
	 border-bottom-style:solid;
     border-bottom-width:0px;
     border-bottom-color:#000000;
	 border-top-style:solid;
	border-top-width:1px;
	border-top-color:#000000;
	border-left-style:solid;
	border-left-width:1px;
	border-left-color:#000000;
	border-right-style:solid;
	border-right-width:1px;
	border-right-color:#000000;
	padding:5px;
	 font-size: 10pt;
}
.x_bill_td_11_00 {  
	 BACKGROUND: #ffffff;
	 TEXT-ALIGN: left; 
	 border-bottom-style:none;
     border-bottom-width:0px;
     border-bottom-color:#000000;
	 border-top-style:none;
	border-top-width:0px;
	border-top-color:#000000;
	border-left-style:none;
	border-left-width:0px;
	border-left-color:#000000;
	border-right-style:none;
	border-right-width:0px;
	border-right-color:#000000;
	padding:5px;
	 font-size: 10pt;
}
.x_bill_td_11_00_00 {  
	 BACKGROUND: #ffffff;
	 TEXT-ALIGN: right; 
	 border-bottom-style:none;
     border-bottom-width:0px;
     border-bottom-color:#000000;
	 border-top-style:solid;
	border-top-width:1px;
	border-top-color:#000000;
	border-left-style:none;
	border-left-width:0px;
	border-left-color:#000000;
	border-right-style:none;
	border-right-width:0px;
	border-right-color:#000000;
	padding:5px;
	 font-size: 8pt;
}

.printcontent {
	font-family: Arial;
	font-size: 10pt;
	font-style: normal;
	line-height: normal;
	font-variant: normal;
	text-transform: none;
	barkground-color: #FFFFFF;
	margin: 0px;
	padding-top: 3px;
	padding-bottom: 3px;
}
.table_td {
	line-height: 30px;
}
-->
</style>
</head>


<body>
<%
	String xs_skd[] = Api.sb( "select skdh,skrq,xsdh,kh,zffs,ssje,bz,khbh,ywy_mc,ywbm_mc,shr,shrq,lrr,lrrq  from xs_skd where id='" + request.getParameter("id") + "'" );
	
	String xs_lrl[] = Api.sb( "select name  from xt_yh where id=(select lrr from xs_skd where id='" + request.getParameter("id") + "')" ); 
  String xs_lrbm[] = Api.sb( "select name  from xt_bm where id=(select ywbm_id from xs_skd where id='" + request.getParameter("id") + "')" ); 
 	String r_zffs[] = Api.sb( "select mc from dm_zffs where  dm=(select zffs from xs_skd where id='" + request.getParameter("id") + "')" );
	String r_zffs_new="";
	if( r_zffs != null && r_zffs.length>0 )
	 { 
	        r_zffs_new=r_zffs[0];
	      
  }

	

  
	String xs_shr="";
	String xs_shrq="";
	
	
	String xs_sh[] = Api.sb( "select name  from xt_yh where id=(select shr from xs_skd where id='" + request.getParameter("id") + "')" );
    		if( xs_sh!= null && xs_sh.length>0 )
	 { 
	        xs_shr=xs_sh[0];
	        xs_shrq=xs_skd[11];
  } 
%>
<TABLE class=printcontent  style="WIDTH: 650px; BORDER-COLLAPSE: collapse" borderColor=#000000 border=0 cellpadding=5 cellspacing=0 align=center>
<TBODY>


<TR >
<TD align=center class=title colspan=4 height=50 >收&nbsp;&nbsp;款&nbsp;&nbsp;单</TD></TR>


<TR>
<TD  class=x_bill_td_00_00  width=10% colspan=2 >收款单号：<%=xs_skd[0]%></TD>

<TD  class=x_bill_td_10_00  width=10% colspan=2>收款日期：<%=xs_skd[1]%></td>

</TR>
<TR>
<TD  class=x_bill_td_00  width=10%  >客户</td>
<td width=15% class=x_bill_td_01><%=xs_skd[3]%></TD>
<TD  class=x_bill_td_10  width=10% >销售单号</td>
<td width=15% class=x_bill_td_11><%=xs_skd[2]%></TD>
</TR>

<TR>
<TD  class=x_bill_td_00  width=10% >实收金额</td>
<td  width=15% class=x_bill_td_01><%=parseJe( parseZero( xs_skd[5] ))%></TD>
<TD  class=x_bill_td_10  width=10% >支付方式</td>
<td width=15% class=x_bill_td_11><%=r_zffs_new%></TD>
</TR>

<TR>
<TD  class=x_bill_td_00  width=10% >经办人</td>
<td width=15% class=x_bill_td_01><%=xs_skd[8]%></TD>  
<TD  class=x_bill_td_10   width=10% >经办部门</td>
<td width=15% class=x_bill_td_11 ><%=xs_skd[9]%></TD>
</TR>

<TR>
<TD  class=x_bill_td_00_00_00  width=15% >制单人:<%=xs_lrl[0]%></TD> 
<TD  class=x_bill_td_01_00_00  width=20%>制单日期:<%=xs_skd[13]%></TD>
<TD  class=x_bill_td_10_00_00  width=15% >审核人:<%=xs_shr%></TD>
<TD  class=x_bill_td_11_00_00 width=20%>审核日期:<%=xs_skd[11]%></TD>  

</TR>

</TBODY></TABLE>



<TBODY>


</body>
</html>
