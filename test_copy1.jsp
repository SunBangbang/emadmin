<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
  
 //物料清单的复制
    Serve.creatBillCopy("scan_wlqd","scan_wlqd",

    "wlqdmc,djrq,chbm,chmc,ggxh,dw,sl,bz,ch_id,enabled",
    "wlqdmc,djrq,chbm,chmc,ggxh,dw,sl,bz,ch_id,enabled",

    "scan_wlqd_sub","scan_wlqd_sub",

   "chbm,chmc,ggxh,dw,sl,ch_id",
   "chbm,chmc,ggxh,dw,sl,ch_id",
   " scan_wlqd.enabled='1'","复制","复制");

%>

ok