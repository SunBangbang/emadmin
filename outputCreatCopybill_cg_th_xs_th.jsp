<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
//Serve.creatBillCopy(source_table,target_table,source_cols,target_cols,source_sub_table
//,target_sub_table,source_sub_cols,target_sub_cols)


 //销售发货单 复制到 销售退货单
    Serve.creatBillCopy("xs_fhd","xs_thd",

    "''xs_fhd'',id,   fhdh,''2'',  kh,kh_id,khbh,ck,jsfs,ywbm_mc,ywy_mc,ywbm_id,ywy_id",
    "czbm  , cz_id, czbh,czlx , kh,kh_id,khbh,ck,jsfs,ywbm_mc,ywy_mc,ywbm_id,ywy_id",

    "xs_fhd_sub","xs_thd_sub",

   "chbm,chmc,ggxh,bzdw,bzsl,dw,sl,dj,je,suilv,se,jshj,bz,hsl,hsdj,ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx	",
   "chbm,chmc,ggxh,bzdw,bzsl,dw,sl,dj,je,suilv,se,jshj,bz,hsl,hsdj,ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx	"
,"  1=1  ","复制");

   //----------------------------------------------------------------

//Serve.creatBillCopy(source_table,target_table,source_cols,target_cols,source_sub_table
//,target_sub_table,source_sub_cols,target_sub_cols)


 //采购到货单 复制到 采购退货单
    Serve.creatBillCopy("cg_dhd","cg_thd",

    "''cg_dhd'',id,   dhdh,''2'',gys,gys_id,gysbh,ywbm_mc,ywy_mc,ywbm_id,ywy_id,bz,cglx,ck,jsfs ",
    "czbm     ,cz_id, czbh,czlx ,gys,gys_id,gysbh,ywbm_mc,ywy_mc,ywbm_id,ywy_id,bz,cglx,ck,jsfs",

    "cg_dhd_sub","cg_thd_sub",

   "chbm,chmc,ggxh,bzdw,bzsl,dw,sl,dj,je,suilv,se,jshj,bz,hsl,hsdj,ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx	",
   "chbm,chmc,ggxh,bzdw,bzsl,dw,sl,dj,je,suilv,se,jshj,bz,hsl,hsdj,ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx	"
," 1=1 ","复制");



%>


