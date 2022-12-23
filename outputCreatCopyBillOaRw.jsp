<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%

//Serve.creatBillCopy(source_table,target_table,source_cols,target_cols,source_sub_table
//,target_sub_table,source_sub_cols,target_sub_cols)


 //销售发货单 复制到 销售退货单
    Serve.creatBillCopy("oa_rw","oa_rw",

    "rwzt,rwnr,rwlx,fj,qtzxr",
    "rwzt,rwnr,rwlx,fj,qtzxr",

    "","",

   "",
   "","  1=1  ","复制");


%>


