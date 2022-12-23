<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
//Serve.creatBillCopy(source_table,target_table,source_cols,target_cols,source_sub_table
//,target_sub_table,source_sub_cols,target_sub_cols)


 //未收款客户 复制到 收款单 
    Serve.creatBillCopy("view_sf_wsk_kh","sf_skd",

    "kh,kh_id,ywbm_mc,ywy_mc,ywbm_id,ywy_id,wskje,wskje ssje",
    "kh,kh_id,ywbm_mc,ywy_mc,ywbm_id,ywy_id,je   ,ssje",

    "view_sf_wsk_kh_sub","sf_skd_sub",

   "id ys_id,ysdh,jshj,khxje,khxje jsje,zy, autokeyword",
   "ys_id,ysdh,jshj,wskje,jsje,zy,autokeyword	","  1=1  ","复制");

   //----------------------------------------------------------------

//Serve.creatBillCopy(source_table,target_table,source_cols,target_cols,source_sub_table
//,target_sub_table,source_sub_cols,target_sub_cols)


 //未付款供应商 复制到 付款单 
    Serve.creatBillCopy("view_sf_wfk_gys","sf_fkd",

    "gys,gys_id,ywbm_mc,ywy_mc,ywbm_id,ywy_id,wfkje,wfkje sfje ",
    "gys,gys_id,ywbm_mc,ywy_mc,ywbm_id,ywy_id,je   ,sfje",

    "view_sf_wfk_gys_sub","sf_fkd_sub",

   "id yf_id,yfdh,jshj,khxje,khxje jsje,zy, autokeyword",
   "yf_id,yfdh,jshj,wfkje,jsje,zy,autokeyword"," 1=1 ","复制");


%>


