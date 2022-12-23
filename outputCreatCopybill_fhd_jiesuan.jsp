<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
//Serve.creatBillCopy(source_table,target_table,source_cols,target_cols,source_sub_table
//,target_sub_table,source_sub_cols,target_sub_cols)


 //发货单 复制到 委托代销结算 
    Serve.creatBillCopy("xs_fhd ","xs_wtdx_js",

    "''xs_fhd'',id,   fhdh,    kh,xslx,kh_id,ywbm_mc,ywy_mc,ywbm_id,ywy_id,bz, kh,skqx,jsfs,fkfs",
	"czbm  ,cz_id,czbh,    kh,xslx,kh_id,ywbm_mc,ywy_mc,ywbm_id,ywy_id,bz,     kh,skqx,jsfs,fkfs",

    "xs_fhd_sub","xs_wtdx_js_sub",

   "chbm,chmc,ggxh,bzdw,bzsl,dw,sl,dj,je,suilv,se,jshj,bz,hsl,hsdj,ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx	",
   "chbm,chmc,ggxh,bzdw,bzsl,dw,sl,dj,je,suilv,se,jshj,bz,hsl,hsdj,ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx	"
   ,"  1=1  ","复制");
//-------------------------------------------------------------------------------





%>


