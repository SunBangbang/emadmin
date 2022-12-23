<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
 //生产单 复制到  产品完工登记
    Serve.creatBillCopy("scan_sccpdj","scan_cpwgdj",

    "''scan_sccpdj'',id      ,cpph,''2'',cpph,  ch_id    ,chbm	 ,chmc	 ,dw	 ,ggxh	 ,wldh ",
    "czbm           ,cz_id   ,czbh,czlx ,cpph,  ch_id    ,chbm	 ,chmc	 ,dw	 ,ggxh	 ,wldh ",

    "","",

   "",
   "",
   " shzt = '1' and cpph not in (select cpph from scan_cpwgdj) ","完工登记");



%>

 
 
