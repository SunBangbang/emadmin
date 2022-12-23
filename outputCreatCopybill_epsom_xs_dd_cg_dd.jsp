<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%

   //----------------------------------------------------------------

//Serve.creatBillCopy(source_table,target_table,source_cols,target_cols,source_sub_table
//,target_sub_table,source_sub_cols,target_sub_cols)

 //销售订单 复制到 采购订单
    Serve.creatBillCopy("xs_dd","cg_dd",

    "''xs_dd'',id,ddbh,kh,'''' ,kh_id,khbh,dhrq,fyd,mdd,bzyq,jgtk,bz",
    "czbm,cz_id,czbh,khl,zdzy,kh_id,khbh,dhrq,fyd,mdd,bzyq,jgtk,bz",

    "xs_dd_sub","cg_dd_sub",

   "chbm,chmc,ggxh,bzdw,bzsl,dw,sl,bizhong,dj,bq,tm,beizhu,hsl,ch_id,id",
   "chbm,chmc,ggxh,bzdw,bzsl,dw,sl,bizhong,dj,bq,tm,bz, hsl,ch_id,xs_dd_sub_id"," shzt='1' and gbzt='0' ","复制");


%>

ok
