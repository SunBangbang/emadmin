<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
			//按照版本进行程序的配置
				String sql=" exec sp_product_config "+ request.getParameter( "id");
				Api.ub(sql);
				//系统重建需要重建的表单
				Serve.autoReCreatMultiBill("select table_name from xt_pack_need_rebuild");

%>
完成
 
 
