
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
}
.font2{
    font-size:10pt;
    padding:5px;

}
.footfont{
    font-size:8pt;
    padding:5px;

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
<%
	String r_cg_cgd[] = Api.sb( "select cgdh,cgrq,cglx,gys,gysbh,ck,zffs,fkqx,hth,bz,ywy_mc,ywbm_id,lrr,lrrq,shr,shrq  from cg_cgd where id='" + request.getParameter("id") + "'" );
	
	
	String r_rrl[] = Api.sb( "select name  from xt_yh where id=(select lrr from cg_cgd where id='" + request.getParameter("id") + "')" ); 
  String r_rrbm[] = Api.sb( "select name  from xt_bm where id=(select ywbm_id from cg_cgd where id='" + request.getParameter("id") + "')" ); 
                 
	String r_ck[] = Api.sb( "select ckmc  from jc_cksz where id=(select ck from cg_cgd where id='" + request.getParameter("id") + "')" );
	
	String r_zffs[] = Api.sb( "select mc from dm_zffs where  dm=(select zffs from xs_xsd where id='" + request.getParameter("id") + "')" );
	String r_zffs_new="";
	if( r_zffs != null && r_zffs.length>0 )
	 { 
	        r_zffs_new=r_zffs[0];
	      
  }   
	String r_shr="";
	String r_shrq="";	
	String r_sh[] = Api.sb( "select name  from xt_yh where id=(select shr from cg_cgd where id='" + request.getParameter("id") + "')" );
    		if( r_sh != null && r_sh.length>0 )
	 { 
	        r_shr=r_sh[0];
	        r_shrq=r_cg_cgd[15];
  } 
%>
<TABLE class=printcontent  style="WIDTH: 600px; BORDER-COLLAPSE: collapse" borderColor=#ffffff align=center>
<TBODY>

<TR>
<TD >&nbsp;</TD>
</TR>

<TR>
<TD align=center class=title colspan=2>采&nbsp;&nbsp;购&nbsp;&nbsp;单</TD></TR>
<TD  height=20>&nbsp;</TD>
<TR>
<TD  class=font2  width=40% >采购单号:<%=r_cg_cgd[0]%></TD><TD  class=font2  width=40% >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;采购日期:<%=r_cg_cgd[1]%></TD>
</TR>
<TR>
<TD  class=font2  width=40% >供应商:<%=r_cg_cgd[3]%></TD><TD  class=font2  width=40% >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;仓库:<%=r_ck[0]%></TD> 
</TR>


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
<TD noWrap align=middle>单价</TD>
<TD noWrap align=middle>金额</TD>

<TD noWrap align=middle>备注</TD>

</TR>
<%


String cg_cgd_sub[] = Api.sb(  "select  chbm,chmc,ggxh,dw,sl,hsdj,jshj,suilv,bz,xt_cpfz_xgsx from cg_cgd_sub  where fid='" + request.getParameter("id") + "'"  );
String r_zje[] = Api.sb(  "select sum(jshj) from cg_cgd_sub  where fid='" + request.getParameter("id") + "'"  );
String r_sl[] = Api.sb(  "select sum(sl) from cg_cgd_sub  where fid='" + request.getParameter("id") + "'"  );

for( int i=0; i < cg_cgd_sub.length; i += 10)
	{  
	      String chbm = cg_cgd_sub[i+0];
        String chmc = cg_cgd_sub[i+1];
        String ggxh = cg_cgd_sub[i+2];
        String   dw = cg_cgd_sub[i+3]; 
	      String   sl = parseSl( parseZero(cg_cgd_sub[i+4]));               
        String   dj = parseJe( parseZero(cg_cgd_sub[i+5]));
        String   je = parseJe( parseZero(cg_cgd_sub[i+6]));
        String   suilv = parseJe( parseZero(cg_cgd_sub[i+7]));
        String   bz = cg_cgd_sub[i+8];
        String   xt_cpfz_xgsx=cg_cgd_sub[i+9];
        String   xh=(i/10+1)+"";
      out.print( "<TR>" );  
	    out.print( "<TD style='width:50px' align=center class=footfont>"  + xh   + "</TD>" );
	    out.print( "<TD style='width:50px' align=center class=footfont>"  + chbm + "</TD>" ); 
	    out.print( "<TD style='width:50px' align=center class=footfont>"  + chmc + "</TD>" ); 
	    out.print( "<TD style='width:50px'align=center class=footfont>"  + ggxh + "</TD>" );
	    out.print( "<TD style='width:50px' align=center class=footfont>"  +  dw + "</TD>" );
	    out.print( "<TD style='width:50px' align=center class=footfont>"  +   sl + "</TD>" ); 
	    out.print( "<TD style='width:50px' align=center class=footfont>"  +   dj + "</TD>" );	   
	    out.print( "<TD style='width:50px' align=center class=footfont>"  +   je + "</TD>" );
	   // out.print( "<TD style='width:50px' align=center>"  +   suilv + "</TD>" );
	    out.print( "<TD style='width:100px' align=center class=footfont>"  +  bz   + "</TD>" );
	   // out.print( "<TD style='width:100px' align=center>"  + xt_cpfz_xgsx  + "</TD>" );
	    out.print( "</TR>" );
	}
	 out.print( "<Tr>" );
	    out.print( "<TD style='width:50px' align=center class=footfont>合计</TD>" );
	    out.print( "<TD style='width:50px' align=center></TD>" ); 
	    out.print( "<TD style='width:50px' align=center></TD>" ); 
	    out.print( "<TD style='width:50px'align=center></TD>" );
	    out.print( "<TD style='width:50px' align=center></TD>" );
	    out.print( "<TD style='width:50px' align=center class=footfont>"  +  parseSl( parseZero( r_sl [0])) + "</TD>" ); 
	    out.print( "<TD style='width:50px' align=center></TD>" );	   
	    out.print( "<TD style='width:50px' align=center class=footfont>"  +   parseJe( parseZero( r_zje[0] )) + "</TD>" );
	  //  out.print( "<TD style='width:50px' align=center></TD>" );
	    out.print( "<TD style='width:100px' align=center></TD>" );
	   // out.print( "<TD style='width:100px' align=center></TD>" );

	    out.print( "</TR>" );  
%>


</TBODY></TABLE>
<table class=printcontent align=center width="600px">
	<tr>
		<TD noWrap align=left  class=footfont>制单人：<%=r_rrl[0]%></td><TD noWrap align=left  class=footfont>审核人：<%=r_shr %></td><TD noWrap align=center  class=footfont>经办人：<%=r_cg_cgd[10]%></td><TD noWrap align=right  class=footfont>经办部门：<%=r_rrbm[0]%></td>
	
	
	
</tr>
</table>







</body>
</html>
