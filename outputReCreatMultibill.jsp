<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%

	//自动重新创建多个表：sql 为查询多个表的sql 语句
    Serve.autoReCreatMultiBill(" select table_name from view_xt_need_rebuid_table  ");

%>
完成
 
 
