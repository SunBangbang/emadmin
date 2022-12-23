
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
	String r_kc_pdd[] = Api.sb( "select pddh,pdrq,ck,bz,ywy_mc,ywbm_id,lrr,lrrq,shr,shrq  from kc_pdd where id='" + request.getParameter("id") + "'" );

	String r_rrl[] = Api.sb( "select name  from xt_yh where id=(select lrr from kc_pdd where id='" + request.getParameter("id") + "')" ); 
  String r_rrbm[] = Api.sb( "select name  from xt_bm where id=(select ywbm_id from kc_pdd where id='" + request.getParameter("id") + "')" ); 
 
	String r_ck[] = Api.sb( "select ckmc  from jc_cksz where id=(select ck from kc_pdd where id='" + request.getParameter("id") + "')" );
	
	String r_shr="";
	String r_shrq="";	
	String r_sh[] = Api.sb( "select name  from xt_yh where id=(select shr from kc_pdd where id='" + request.getParameter("id") + "')" );
    		if( r_sh != null && r_sh.length>0 )
	 { 
	        r_shr=r_sh[0];
	        r_shrq=r_kc_pdd[7];
  } 
  
%>
<TR>
<TD align=center class=title colspan=2>盘&nbsp;&nbsp;点&nbsp;&nbsp;单</TD></TR>
<TD  height=20>&nbsp;</TD>
<TR>
<TD  class=font2  width=40% >盘点单号：<%=r_kc_pdd[0]%></TD><TD  class=font2  width=60% align=left >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;盘点日期：<%=r_kc_pdd[1]%></TD>
</TR>

<TR>
<TD  class=font2  width=60% align=left >仓库：<%=r_ck[0]%></TD>
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
<TD noWrap align=middle>账面数量</TD>
<TD noWrap align=middle>实盘数量</TD>
<TD noWrap align=middle>损益数量</TD>
<TD noWrap align=middle>备注</TD>

</TR>
<%


String r_kc_pdd_sub[] = Api.sb(  "select  chbm,chmc,ggxh,dw,zmsl,pdsl,sysl,dj,je,bz,xt_cpfz_xgsx from kc_pdd_sub  where fid='" + request.getParameter("id") + "'"  );
String r_zje[] = Api.sb(  "select sum(je) from kc_pdd_sub  where fid='" + request.getParameter("id") + "'"  );
String r_zmsl[] = Api.sb(  "select sum(zmsl) from kc_pdd_sub  where fid='" + request.getParameter("id") + "'"  );
String r_pdsl[] = Api.sb(  "select sum(pdsl) from kc_pdd_sub  where fid='" + request.getParameter("id") + "'"  );
String r_sysl[] = Api.sb(  "select sum(sysl) from kc_pdd_sub  where fid='" + request.getParameter("id") + "'"  );

for( int i=0; i < r_kc_pdd_sub.length; i += 11)
	{  
	      String chbm = r_kc_pdd_sub[i+0];
        String chmc = r_kc_pdd_sub[i+1];
        String ggxh = r_kc_pdd_sub[i+2];
        String   dw = r_kc_pdd_sub[i+3]; 
	      String   zmsl = parseSl( parseZero(r_kc_pdd_sub[i+4]));               
        String   pdsl = parseSl( parseZero(r_kc_pdd_sub[i+5]));
        String   sysl = parseSl( parseZero(r_kc_pdd_sub[i+6]));
        String   bz = r_kc_pdd_sub[i+9];
        String   xt_cpfz_xgsx=r_kc_pdd_sub[i+10];
        String   xh=(i/9+1)+"";
      out.print( "<TR>" );  
	    out.print( "<TD style='width:50px' align=center>"  + xh   + "</TD>" );
	    out.print( "<TD style='width:50px' align=center>"  + chbm + "</TD>" ); 
	    out.print( "<TD style='width:50px' align=center>"  + chmc + "</TD>" ); 
	    out.print( "<TD style='width:50px'align=center>"  + ggxh + "</TD>" );
	    out.print( "<TD style='width:50px' align=center>"  +  dw + "</TD>" );
	    out.print( "<TD style='width:50px' align=center>"  +   zmsl + "</TD>" ); 
	     out.print( "<TD style='width:50px' align=center>"  +   pdsl + "</TD>" );
	      out.print( "<TD style='width:50px' align=center>"  +   sysl + "</TD>" );
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
	    out.print( "<TD style='width:50px' align=center>"  +  parseSl( parseZero( r_zmsl [0])) + "</TD>" ); 
	     out.print( "<TD style='width:50px' align=center>"  +  parseSl( parseZero( r_pdsl [0])) + "</TD>" ); 
	      out.print( "<TD style='width:50px' align=center>"  +  parseSl( parseZero( r_sysl [0])) + "</TD>" ); 
	   // out.print( "<TD style='width:50px' align=center></TD>" );	   
	   // out.print( "<TD style='width:50px' align=center>"  +   parseJe( parseZero( r_zje[0] )) + "</TD>" );
	    out.print( "<TD style='width:100px' align=center></TD>" );
	   // out.print( "<TD style='width:100px' align=center></TD>" );

	    out.print( "</TR>" );
	   
%>


</TBODY></TABLE>

<table class=printcontent align=center width="600px" >
	<tr>
		<TD noWrap align=left  class=footfont>制单人：<%=r_rrl[0]%></td><TD noWrap align=left  class=footfont>审核人：<%=r_shr %></td><TD noWrap align=center  class=footfont>经办人：<%=r_kc_pdd[4]%></td><TD noWrap align=right  class=footfont>经办部门：<%=r_rrbm[0]%></td>
</tr>
</TABLE>
</body>
</html>
