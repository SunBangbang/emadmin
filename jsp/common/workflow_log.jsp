<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}
        String  r[]=Serve.getBillWorkFlowKLog(request);
        //level,type,title,shjg,shyj,shr,shbm,shrq
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
body {padding:0px;margin:0px;text-align:center; }
-->
</style>
</head>
<body>
<table class='x_list_result_header_table'  cellspacing='0'>
      <tr>
        <td class='x_list_result_header_table_td' ><br>工作流处理记录</td>
      </tr>
</table>
<br>
<div style="width:80%;	text-align:center; ">
<table  class='x_list_result_table'  cellspacing='0'>
      <tr>
          <td   class='x_list_result_title_td'  width="5%"> 行 号 </td>
          <td  class='x_list_result_title_td'>流程名称</td>
           <td  class='x_list_result_title_td'>处理结果</td>
            <td  class='x_list_result_title_td'>处理意见</td>
            <td  class='x_list_result_title_td'>处理日期 </td>
            <td  class='x_list_result_title_td'>处理人</td>
            <td  class='x_list_result_title_td'>处理部门</td>
      </tr>
      <% for (int i=0;i<r.length;i+=8) {
            String name="通过";
            if (r[i+3].equals("0")) name="拒绝";
            if (r[i+3].equals("2")) name="取消";
        %>
       <tr>
             <td class='x_list_result_td01' align='center' nowrap><%=String.valueOf(i/8+1)%></td>
            <td rowspan='1'  nowrap  class='x_list_result_td01'><%=r[i+2]%></td>
            <td rowspan='1'  nowrap  class='x_list_result_td00'><%=name%></td>
            <td rowspan='1'                  class='x_list_result_td01'><%=r[i+4]%>&nbsp;</td>
            <td rowspan='1'  nowrap  class='x_list_result_td00'><%=r[i+7]%></td>
            <td rowspan='1'  nowrap  class='x_list_result_td01'><%=Api.getValueName("001",r[i+5])%></td>
            <td rowspan='1'  nowrap  class='x_list_result_td01'><%=Api.getValueName("000",r[i+6])%></td>
      </tr>
    <% } %>

</table>
</div>
</body>
</html>
