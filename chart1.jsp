
<form method=post action=""><input name="type" type=text/>
	<input name="keywords" type=text/><input type=submit />
</form>

sdjfsdlkjfsd;fjsdjfldsjfklsdjfklsdjfksdljflsdjkfsd
<% if (request.getParameter("type")!=null && !request.getParameter("type").equals("1")) {%>
<img src="chart.jsp?keywords=xxx" />
<%}else {%>
	统计表
<%}%>