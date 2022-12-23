<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
             Serve.creatBillCopy("xs_lsd","xs_lsd",

    "''xs_lsd'',id,   lsdh,''2'',-1*ssje,-1*yingshouje,kahao,huiyuan,-1*jifen,hyjb,jfbl,-1*xianjin,-1*neika,-1*waika,-1*zhipiao,-1*daijinquan,-1*qt1,-1*qt2,-1*qt3,-1*qt4,-1*qt5,-1*zhaoling,xslx,ck,kh,khbh,shdz,shouhuoren,lxdh,kh_id,jhrq,zffs,skqx,hth,bz,ywy_mc,ywy_id,ywbm_mc,ywbm_id",
    "czbm ,cz_id,czbh,czlx,ssje,yingshouje,kahao,huiyuan,jifen,hyjb,jfbl,xianjin,neika,waika,zhipiao,daijinquan,qt1,qt2,qt3,qt4,qt5,zhaoling,xslx,ck,kh,khbh,shdz,shouhuoren,lxdh,kh_id,jhrq,zffs,skqx,hth,bz,ywy_mc,ywy_id,ywbm_mc,ywbm_id",

    "xs_lsd_sub","xs_lsd_sub",

    "chbm,chmc,ggxh,bzdw,hsl,-1*bzsl,dw,-1*sl,hsdj,-1*jshj,suilv,dj,-1*je,-1*se,bz,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl,zkl",
    "chbm,chmc,ggxh,bzdw,hsl,bzsl,dw,sl,hsdj,jshj,suilv,dj,je,se,bz,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl,zkl"," 1=1 and shzt='1' and (select count(*) from xs_lsd_sub where sl<0 and xs_lsd.id=xs_lsd_sub.fid)=0  and jiezhangzt<>'1' and (select sum(sl) from xs_lsd_sub a , xs_lsd b where a.fid=b.id and ( b.id =xs_lsd.id or b.cz_id =xs_lsd.id) )<>0","退货","零售退货");

%>

ok