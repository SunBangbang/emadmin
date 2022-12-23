<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*"%>
<%
	String result[];
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}
		else 
			result = Serve.getCountResult( request,null );

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
<SCRIPT LANGUAGE="JavaScript">
<!--
	var _result_type_arry = new Array();
	_result_type_arry[0]="<img src='chart_img/chart_00.gif' width='20' height='20'/><span>&nbsp;0 统计表</span>";
	_result_type_arry[1]="<img src='chart_img/chart_01.gif' width='20' height='20'/><span>&nbsp;1 横柱图</span>";
	_result_type_arry[2]="<img src='chart_img/chart_02.gif' width='20' height='20'/><span>&nbsp;2 纵柱图</span>";
	_result_type_arry[3]="<img src='chart_img/chart_03.gif' width='20' height='20'/><span>&nbsp;3 三维横柱图</span>";
	_result_type_arry[4]="<img src='chart_img/chart_04.gif' width='20' height='20'/><span>&nbsp;4 三维纵柱图</span>";
	_result_type_arry[5]="<img src='chart_img/chart_05.gif' width='20' height='20'/><span>&nbsp;5 层次横柱图</span>";
	_result_type_arry[6]="<img src='chart_img/chart_06.gif' width='20' height='20'/><span>&nbsp;6 层次纵柱图</span>";
	_result_type_arry[7]="<img src='chart_img/chart_07.gif' width='20' height='20'/><span>&nbsp;7 饼图</span>";
	_result_type_arry[8]="<img src='chart_img/chart_08.gif' width='20' height='20'/><span>&nbsp;8 三维饼图</span>";
	_result_type_arry[9]="<img src='chart_img/chart_09.gif' width='20' height='20'/><span>&nbsp;9 区域图</span>";
	_result_type_arry[10]="<img src='chart_img/chart_10.gif' width='20' height='20'/><span>&nbsp;10 线性图</span>";
	_result_type_arry[11]="<img src='chart_img/chart_11.gif' width='20' height='20'/><span>&nbsp;11 堆栈图</span>";

	function _select_chart(index) {
		_result_type_title.innerHTML =_result_type_arry[index];
		form1.result_type.value=index;
		//var s=form1.curren_url.value;
		//alert(s);
		//form1.curren_url.value=s+"&result_type="+form1.result_type.value;
	    //form1.submit();
		location.href="count.jsp?result_type="+form1.result_type.value+"&<%=ChartsetConvertBean.convert(Util.setUrlParameter(request.getQueryString(),"count_collection_title",""),"ISO8859_1","UTF-8")%>";
	}
	
	function _select_default_chart(index) {
		_result_type_title.innerHTML =_result_type_arry[index];
		form1.result_type.value=index;
	}
//-->
</SCRIPT>

<body>

<div class="x_list_outer_table" style='z-index:0;' >

                <form name="form1" action="count.jsp" method="get" style="margin: 0px; padding: 0px;">

                    <%=result[0]%>

                  <input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
                  <input type="hidden" name="is_reopen" value="1">
                </form> 
		<% if (request.getParameter("result_type")!=null && !request.getParameter("result_type").equals("0")) {%>
			<img src="chart.jsp?<%=ChartsetConvertBean.convert(Util.setUrlParameter(request.getQueryString(),"count_collection_title",""),"ISO8859_1","UTF-8")%>" />
		<%}else {%>
			 <%=result[1]%>
		<%}%>  	
</div>
<%if (request.getParameter("result_type")!=null) { %>
<SCRIPT LANGUAGE="JavaScript">
	 var tempint=<%=request.getParameter("result_type")%>;
	 _select_default_chart(tempint);
//-->
</SCRIPT>
<%}%>
<div id="_result_type_select"  style='position:absolute;background-color:#ffffff;left:10px; top:10px; zIndex :200; height: 24px; visibility: hidden' onmouseover="javascript:this.style.visibility='visible';" onmouseout="javascript:this.style.visibility='hidden';">
<table class='x_count_chart_table' cellpadding="0" cellspacing="0" >
	<tr>
		<td align="center" nowrap class="x_relate_list_result_td"><img src="chart_img/chart_00.gif" width='100' height='100' onclick="_result_type_select.style.visibility='hidden';_select_chart(0)"/><br/>0 统计表</td>
		<td align="center" nowrap class="x_relate_list_result_td"><img src="chart_img/chart_01.gif" width='100' height='100' onclick="_result_type_select.style.visibility='hidden';_select_chart(1)"/><br/>1 横柱图</td>
		<td align="center" nowrap class="x_relate_list_result_td"><img src="chart_img/chart_02.gif" width='100' height='100' onclick="_result_type_select.style.visibility='hidden';_select_chart(2)"/><br/>2 纵柱图</td>
		<td align="center" nowrap class="x_relate_list_result_td"><img src="chart_img/chart_03.gif" width='100' height='100' onclick="_result_type_select.style.visibility='hidden';_select_chart(3)"/><br/>3 三维横柱图</td>
	</tr>
	<tr>
		<td align="center" nowrap class="x_relate_list_result_td"><img src="chart_img/chart_04.gif" width='100' height='100' onclick="_result_type_select.style.visibility='hidden';_select_chart(4)"/><br/>4 三维纵柱图</td>
		<td align="center" nowrap class="x_relate_list_result_td"><img src="chart_img/chart_05.gif" width='100' height='100' onclick="_result_type_select.style.visibility='hidden';_select_chart(5)"/><br/>5 层次横柱图</td>
		<td align="center" nowrap class="x_relate_list_result_td"><img src="chart_img/chart_06.gif" width='100' height='100' onclick="_result_type_select.style.visibility='hidden';_select_chart(6)"/><br/>6 层次纵柱图</td>
		<td align="center" nowrap class="x_relate_list_result_td"><img src="chart_img/chart_07.gif" width='100' height='100' onclick="_result_type_select.style.visibility='hidden';_select_chart(7)"/><br/>7 饼图</td>
	</tr>
	<tr>
		<td align="center" nowrap class="x_relate_list_result_td"><img src="chart_img/chart_08.gif" width='100' height='100' onclick="_result_type_select.style.visibility='hidden';_select_chart(8)"/><br/>8 三维饼图</td>
		<td align="center" nowrap class="x_relate_list_result_td"><img src="chart_img/chart_09.gif" width='100' height='100' onclick="_result_type_select.style.visibility='hidden';_select_chart(9)"/><br/>9 区域图</td>
		<td align="center" nowrap class="x_relate_list_result_td"><img src="chart_img/chart_10.gif" width='100' height='100' onclick="_result_type_select.style.visibility='hidden';_select_chart(10)"/><br/>10 线性图</td>
		<td align="center" nowrap class="x_relate_list_result_td"><img src="chart_img/chart_11.gif" width='100' height='100' onclick="_result_type_select.style.visibility='hidden';_select_chart(11)"/><br/>11 堆栈图</td>
	</tr>
</table>
</div>



</body>
</html>
