<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
	String result[];
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
			//throw new Exception ("结果未查询到！");
		}
		else 
			result = Serve.getListResult( request );


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
<style type="text/css">
<!--
body {padding:0px;margin:0px;}
-->
</style>
</head>
<SCRIPT LANGUAGE='JavaScript'>
            if (window.top.document.getElementById('_global_save')!=null)    window.top.document.getElementById('_global_save').value="";
</SCRIPT>
<%if(request.getParameter("modul_id").equals("view_kc_slhz_listModul") || request.getParameter("modul_id").equals("dview_yszhz_listModul") || request.getParameter("modul_id").equals("dview_yfzhz_listModul") || request.getParameter("modul_id").equals("view_xs_khdzd_listModul") || request.getParameter("modul_id").equals("view_cg_gysdzd_listModul") || request.getParameter("modul_id").equals("view_cw_szjl_hz_listModul")){ %>
<script type="text/javascript">
	window.onload=function(){
		document.getElementById('search_td').className="x_list_keyword_search_td_1";
		document.getElementsByName('keyword')[0].className="x_list_keyword_search_keyword_input_1";
		document.getElementsByName('djrq111')[0].className="x_list_keyword_search_keyword_input_1";
		document.getElementsByName('djrq112')[0].className="x_list_keyword_search_keyword_input_1";
		document.getElementById('searchbtn').className="";
		document.getElementById('searchbtn').src="/emadmin/images/c2/button/list_start_serach.gif";
		document.getElementById('list_search').className="x_list_keyword_search_keyword_span4";
		document.getElementById('_xt_list_add_to_favorite').className="x_list_keyword_search_keyword_span5";
		document.getElementById('list_adv_search').className="x_list_keyword_search_keyword_span5";
		
		
	}
</script>
<% }%>
<body>

			<!-- 内容区 -->

							<form name="form1" action="list.jsp" method="get">
								<%=result[0]%>
							</form>  
							 <%=result[1]%>	
											
			<!-- 内容区 -->

</body>
</html>
