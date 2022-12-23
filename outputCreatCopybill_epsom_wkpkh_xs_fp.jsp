<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%


 //未开票客户 复制到 销售发票
    Serve.creatBillCopy("view_wkpkh","xs_fp",

    "kh,kh_id,khbh",
    "kh,kh_id,khbh",

    "view_wkpkh_sub","xs_fp_sub",

   "chbm,chmc,ggxh,bzdw,bzsl,dw,wkpsl,bizhong,hsdj,jshj,suilv,dj,wkpje,se,beizhu,hsl,ch_id, dd_id, ddbh,wkpsl,wkpje,dwcb,sl*dwcb,''1''",
   "chbm,chmc,ggxh,bzdw,bzsl,dw,sl,   bizhong,hsdj,jshj,suilv,dj,je   ,se,bz,    hsl,ch_id, dd_id, ddbh,wkpsl,wkpje,dwcb,cbje,sfgb","  1=1  ","复制");

   //----------------------------------------------------------------

//Serve.creatBillCopy(source_table,target_table,source_cols,target_cols,source_sub_table
//,target_sub_table,source_sub_cols,target_sub_cols)


%>

ok
