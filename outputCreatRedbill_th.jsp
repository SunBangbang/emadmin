<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>


<%
	//红字 采购退货单
    Serve.creatBillRed(
	"cg_thd",

    "''cg_thd'',id,   cgthdh,''1'',gys,gys_id,gysbh,ywbm_mc,ywy_mc,ywbm_id,ywy_id,bz,cglx,ck,jsfs,thyy",
    "czbm     ,cz_id, czbh,  czlx ,gys,gys_id,gysbh,ywbm_mc,ywy_mc,ywbm_id,ywy_id,bz,cglx,ck,jsfs,thyy",

    "cg_thd_sub",

   "-1*sl,chbm,chmc,ggxh,bzdw,-1*bzsl,dw,dj,-1*je,suilv,hsdj,-1*se,-1*jshj,bz ,hsl,ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx",   
   "sl   ,chbm,chmc,ggxh,bzdw,bzsl   ,dw,dj,je   ,suilv,hsdj,se   ,jshj   ,bz ,hsl,ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx"   
   );
%>



<%
    //红字 销售退货单
    Serve.creatBillRed(
    "xs_thd",

    "''xs_thd'',id,   xsthdh,''1'',  kh,kh_id,khbh,ck,jsfs,ywbm_mc,ywy_mc,ywbm_id,ywy_id,thyy",
    "czbm  , cz_id,   czbh,   czlx , kh,kh_id,khbh,ck,jsfs,ywbm_mc,ywy_mc,ywbm_id,ywy_id,thyy",

    "xs_thd_sub",

   "-1*sl,chbm,chmc,ggxh,bzdw,-1*bzsl,dw,dj,-1*je,suilv,hsdj,-1*se,-1*jshj,bz,hsl,ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx",
   "sl   ,chbm,chmc,ggxh,bzdw,bzsl   ,dw,dj,je   ,suilv,hsdj,se   ,jshj   ,bz,hsl,ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx"
   );
%>

