<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
//删除统计：tablenames 的格式 'aatest','aatest_sub'
//系统自动删除，sql 在后台有显示

   Serve.deleteCount("'jc_cksz'");

%>



 
