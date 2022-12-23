<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
	//向包含客户　供应商　等单据　的列表和统计，增加客户和供应商信息
   Serve.createOtherRelateToMainTable();

%>



 
