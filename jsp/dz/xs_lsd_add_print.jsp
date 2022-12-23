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
 	//查询所选定的菜牌类别的内容
	String reqId=request.getParameter("id");
	
    //零售主表信息
	String sql_lsd_main="select id,lsdh,lsrq,ck,yingshouje,ywy_mc,ywy_id,xianjin,neika,waika,zhipiao,daijinquan,qt1,qt2,qt3,qt4,qt5,ssje,zhaoling from xs_lsd where id='"+reqId+"'";
	String sql_lsd_sub="select chbm,sl,hsdj,zkl,jshj,chmc from xs_lsd_sub where fid='"+reqId+"'";
	String zffs[]=Api.sb("select display_name from xt_tables_define where table_name='xs_lsd' and colume_name in ('neika','waika','zhipiao','daijinquan','qt1','qt2','qt3','qt4','qt5')");//定义支付方式
	String lsd_main[]=Api.sb(sql_lsd_main);
	String lsd_sub[]=Api.sb(sql_lsd_sub);
	String zhifufs="";
	if(Double.parseDouble(lsd_main[7])>0)	{zhifufs+="现金:"+parseZero(parseJe(lsd_main[7])); }
	if(Double.parseDouble(lsd_main[8])>0)	{zhifufs+=""+zffs[0]+":"+parseZero(parseJe(lsd_main[8])); }
	if(Double.parseDouble(lsd_main[9])>0)	{zhifufs+=""+zffs[1]+":"+parseZero(parseJe(lsd_main[9])); }
	if(Double.parseDouble(lsd_main[10])>0)	{zhifufs+=""+zffs[2]+":"+parseZero(parseJe(lsd_main[10])); }
	if(Double.parseDouble(lsd_main[11])>0)	{zhifufs+=""+zffs[3]+":"+parseZero(parseJe(lsd_main[11])); }
	if(Double.parseDouble(lsd_main[12])>0)	{zhifufs+=""+zffs[4]+":"+parseZero(parseJe(lsd_main[12])); }
	if(Double.parseDouble(lsd_main[13])>0)	{zhifufs+=""+zffs[5]+""+parseZero(parseJe(lsd_main[13])); }
	if(Double.parseDouble(lsd_main[14])>0)	{zhifufs+=""+zffs[6]+":"+parseZero(parseJe(lsd_main[14]));}
	if(Double.parseDouble(lsd_main[15])>0)	{zhifufs+=""+zffs[7]+":"+parseZero(parseJe(lsd_main[15]));}
	if(Double.parseDouble(lsd_main[16])>0)	{zhifufs+=""+zffs[8]+":"+parseZero(parseJe(lsd_main[16]));}
	String dymb[]=Api.sb("select mc from dm_xpdymb where id='12648406493820595'");
	String spxx[]=Api.sb("select xt_bm.bm_dh,xt_bm.name,xt_bm.bmdh from xt_bm,xt_yh where xt_yh.bm_id=xt_bm.id and xt_yh.id='"+((String[])session.getAttribute("userInfo"))[0]+"'");
	//替换商铺号
	dymb[0]=dymb[0].replace("<INPUT value=商&nbsp;铺&nbsp;号 name=control_id_sph>",spxx[0]);
	//替换商铺名称
	dymb[0]=dymb[0].replace("<INPUT value=商铺名称 name=control_id_spmc>",spxx[1]);
	//替换商铺电话
	dymb[0]=dymb[0].replace("<INPUT value=商铺电话 name=control_id_spdh>",spxx[2]);
	//替换收银员
	dymb[0]=dymb[0].replace("<INPUT value=收&nbsp;银&nbsp;员 name=control_id_syy>",((String[])session.getAttribute("userInfo"))[2]);
	//替换交易号
	dymb[0]=dymb[0].replace("<INPUT value=交&nbsp;易&nbsp;号 name=control_id_jyh>",lsd_main[1].replace("-","").replace("XS",""));
	//替换交易日期
	dymb[0]=dymb[0].replace("<INPUT value=交易日期 name=control_id_jyrq>",Util.getDateTime());
	//替换货品子表信息
	String sub="<TABLE style='BORDER-COLLAPSE: collapse; margin-top:10px;margin-left:5px;' align=left cellpadding='0' cellspacing='0'>";
	sub+="<TBODY>";
	sub+="<TR>";
	sub+="<TD width='82' >商品号</TD>";
	sub+="<TD width='30' >数量</TD>";
	sub+="<TD width='50'>单价</TD>";
	sub+="<TD width='40' >折扣%</TD>";
	sub+="<TD align='right'>金额</TD>";
	sub+="</TR>";
	for(int i=0;i<lsd_sub.length;i+=6){ 
		sub+="<TR>";
		sub+="<TD width='82' nowrap='nowrap'>"+lsd_sub[i+0]+"</TD>";
		sub+="<TD width='30' nowrap='nowrap'>"+parseZero(parseSl(lsd_sub[i+1]))+"</TD>";
		sub+="<TD width='50' nowrap='nowrap'>"+parseZero(parseJe(lsd_sub[i+2]))+"</TD>";
		sub+="<TD width='40' nowrap='nowrap'>"+parseZero(parseJe(lsd_sub[i+3]))+"</TD>";
		sub+="<TD  align='right' nowrap='nowrap'>"+parseZero(parseJe(lsd_sub[i+4]))+"</TD>";
		sub+="</TR>";
		sub+="<TR>";
		sub+="<TD class='cpcd' colspan='5'>"+lsd_sub[i+5]+"</TD>";
		sub+="</TR>";
	}
	sub+="<TR>";
	sub+="<TD style='padding-top:3px'>合计：</TD><TD colspan=4 align=right>"+parseZero(parseJe(lsd_main[4]))+"</TD>";
	sub+="</TR>";
	sub+="</TBODY>";
	sub+="</TABLE>";

	dymb[0]=dymb[0].replace("<INPUT size=18 value=零售单明细 name=control_subarea_xs_lsd_xs_lsd_sub_print>",sub);
	//替换金额合计
	dymb[0]=dymb[0].replace("<INPUT value=金额合计 name=control_id_yingshouje>",parseZero(parseJe(lsd_main[4])));
	//替换实收金额
	dymb[0]=dymb[0].replace("<INPUT value=实收合计 name=control_id_ssje>",parseZero(parseJe(lsd_main[17])));
	//替换找零
	if(lsd_main[18]=="0E-8") lsd_main[18]="0";
	dymb[0]=dymb[0].replace("<INPUT value=找&nbsp;&nbsp;&nbsp;&nbsp;零 name=control_id_zhaoling>",parseZero(parseJe(lsd_main[18])));
	//替换支付方式
	dymb[0]=dymb[0].replace("<INPUT value=支付方式 name=control_id_zffs>",zhifufs);
	//得到当前登录人  
	String shouyinyuan=((String[])session.getAttribute("userInfo"))[2];    //取当前登录人姓名

	 
%>

<style>
<!--
.body{
	font-family: "宋体";
	font-size: 8pt;
}
.printcontent {
	font-size: 10pt;
	font-style: normal;
	line-height: 18px;
	font-variant: normal;
	text-transform: none;
	margin: 0px;
	padding-top: 0;
	padding-bottom: 0;
}
.cpcd{
border-collapse:inherit;
border-left-width:0px;
border-right-width:0px;
border-top-width:0px;
border-bottom-color:#000000;
border-bottom-style:dashed;
border-bottom-width:1px;
padding-bottom:2px;
padding-top:2px;
white-space:nowrap;
}
-->
</style>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>

<body>
<%=dymb[0]%>

</body>

</html>
