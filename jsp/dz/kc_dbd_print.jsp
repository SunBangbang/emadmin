
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
	barkground-color: #FFFFFF;
	text-align: center;
	margin: 0px;
	padding: 0px;
}
.font2{
    font-size:8pt;

}
.font3{
    font-size:9pt;

}
.printcontent {
	font-family: Arial;
	font-size: 8pt;
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

<TABLE class=printcontent  style="WIDTH: 600px; BORDER-COLLAPSE: collapse" borderColor=#ffffff  align=center cellpadding=3>
<TBODY>

<TR>
<TD >&nbsp;</TD>
</TR>
<%
	String r_kc_dbd[] = Api.sb( "select dbdh,dbrq,dcck,drck,bz,ywy_mc,ywbm_id,lrr,lrrq,shr,shrq  from kc_dbd where id='" + request.getParameter("id") + "'" );

	String r_rrl[] = Api.sb( "select name  from xt_yh where id=(select lrr from kc_dbd where id='" + request.getParameter("id") + "')" ); 
  String r_rrbm[] = Api.sb( "select name  from xt_bm where id=(select ywbm_id from kc_dbd where id='" + request.getParameter("id") + "')" ); 
 
	String r_dcck[] = Api.sb( "select ckmc  from jc_cksz where id=(select dcck from kc_dbd where id='" + request.getParameter("id") + "')" );
	String r_drck[] = Api.sb( "select ckmc  from jc_cksz where id=(select drck from kc_dbd where id='" + request.getParameter("id") + "')" );

	String r_shr="";
	String r_shrq="";	
	String r_sh[] = Api.sb( "select name  from xt_yh where id=(select shr from kc_dbd where id='" + request.getParameter("id") + "')" );
  if( r_sh != null && r_sh.length>0 )
	 { 
	        r_shr=r_sh[0];
	        r_shrq=r_kc_dbd[10];
  } 
  
%>
<TR>
<TD align=center class=title colspan=2>调&nbsp;&nbsp;拨&nbsp;&nbsp;单</TD></TR>
<TD  height=20>&nbsp;</TD>
<TR>
<TD  class=font2  width=40% >调拨单号：<%=r_kc_dbd[0]%></TD><TD  class=font2  width=60% align=left >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;调拨日期：<%=r_kc_dbd[1]%></TD>
</TR>

<TR>
<TD  class=font2  width=40% >调出仓库：<%=r_dcck[0]%></TD>  <TD  class=font2  width=60% align=left >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;调入仓库：<%=r_drck[0]%></TD>
</TR>
<%
	System.out.println("=======================");

%>


<TR>
<TD >&nbsp;</TD>
</TR>
</TBODY></TABLE>


<TABLE class=printcontent style="BORDER-COLLAPSE: collapse" borderColor=#999999 cellSpacing=0 cellPadding=0 width="600px" border=1 align=center>
<TBODY>
<TR>
<TD noWrap align=middle>行号</TD>
<TD noWrap align=middle>货品编码</TD>
<TD noWrap align=middle>货品名称</TD>
<TD noWrap align=middle>规格型号</TD>
<TD noWrap align=middle>单位</TD>
<TD noWrap align=middle>数量</TD>

<TD noWrap align=middle>备注</TD>

</TR>
<%


String r_kc_dbd_sub[] = Api.sb(  "select  chbm,chmc,ggxh,dw,sl,dj,je,bz,xt_cpfz_xgsx from kc_dbd_sub  where fid='" + request.getParameter("id") + "'"  );
String r_zje[] = Api.sb(  "select sum(je) from kc_dbd_sub  where fid='" + request.getParameter("id") + "'"  );
String r_sl[] = Api.sb(  "select sum(sl) from kc_dbd_sub  where fid='" + request.getParameter("id") + "'"  );

for( int i=0; i < r_kc_dbd_sub.length; i += 9)
	{  
	      String chbm = r_kc_dbd_sub[i+0];
        String chmc = r_kc_dbd_sub[i+1];
        String ggxh = r_kc_dbd_sub[i+2];
        String   dw = r_kc_dbd_sub[i+3]; 
	      String   sl = parseSl( parseZero(r_kc_dbd_sub[i+4]));               
        String   dj = parseJe( parseZero(r_kc_dbd_sub[i+5]));
        String   je = parseJe( parseZero(r_kc_dbd_sub[i+6]));
        String   bz = r_kc_dbd_sub[i+7];
        String   xt_cpfz_xgsx=r_kc_dbd_sub[i+8];
        String   xh=(i/9+1)+"";
      out.print( "<TR>" );  
	    out.print( "<TD style='width:50px' align=center>"  + xh   + "</TD>" );
	    out.print( "<TD style='width:50px' align=center>"  + chbm + "</TD>" ); 
	    out.print( "<TD style='width:50px' align=center>"  + chmc + "</TD>" ); 
	    out.print( "<TD style='width:50px'align=center>"  + ggxh + "</TD>" );
	    out.print( "<TD style='width:50px' align=center>"  +  dw + "</TD>" );
	    out.print( "<TD style='width:50px' align=center>"  +   sl + "</TD>" ); 
	  //  out.print( "<TD style='width:50px' align=center>"  +   dj + "</TD>" );	   
	  //  out.print( "<TD style='width:50px' align=center>"  +   je + "</TD>" );
	    out.print( "<TD style='width:100px' align=center>"  +  bz   + "</TD>" );
	   // out.print( "<TD style='width:100px' align=center>"  + xt_cpfz_xgsx  + "</TD>" );
	    out.print( "</TR>" );
	}
	    out.print( "<Tr>" );
	    out.print( "<TD style='width:50px' align=center>合计</TD>" );
	    out.print( "<TD style='width:50px' align=center></TD>" ); 
	    out.print( "<TD style='width:50px' align=center></TD>" ); 
	    out.print( "<TD style='width:50px'align=center></TD>" );
	    out.print( "<TD style='width:50px' align=center></TD>" );
	    out.print( "<TD style='width:50px' align=center>"  +  parseSl( parseZero( r_sl [0])) + "</TD>" ); 
	   // out.print( "<TD style='width:50px' align=center></TD>" );	   
	   // out.print( "<TD style='width:50px' align=center>"  +   parseJe( parseZero( r_zje[0] )) + "</TD>" );
	    out.print( "<TD style='width:100px' align=center></TD>" );
	   // out.print( "<TD style='width:100px' align=center></TD>" );

	    out.print( "</TR>" );
	   
%>


</TBODY></TABLE>

<table class=printcontent align=center width="600px" >
	<tr>
		<TD noWrap align=left  class=footfont>制单人：<%=r_rrl[0]%></td><TD noWrap align=left  class=footfont>审核人：<%=r_shr %></td><TD noWrap align=center  class=footfont>经办人：<%=r_kc_dbd[5]%></td><TD noWrap align=right  class=footfont>经办部门：<%=r_rrbm[0]%></td>
</tr>
</TABLE>
</body>
</html>
