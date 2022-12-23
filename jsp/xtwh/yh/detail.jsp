<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>

<%
    String result[] = new String [2];
	String yhQxResult = "";

		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}
		else
		{
			result = Serve.getBillDetailTemplate( request );
			yhQxResult = Serve.yhQxResult(request);		
		}


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
<script>
function printData()
{
     var  title = "标题";
     print_this(print_table, title);
}
</script>
</head>
<body >

			<!-- 按扭区 --> 
					<div class="x_bill_detail_button_div"><%=result[0]%></div>
			<!-- 按扭区 --> 
					<table class="x_bill_outer_table" cellspacing="0" align="center">
					  <tr>
						<td align="left"><%=result[1]%></td>
					  </tr>
					  <tr>
						<td align="left">
                            <br/>
                             <table   cellspacing="0"  class="x_list_result_table">
                                  <tr>
                                    <td class='x_list_result_title_td' align='center' colspan='4' nowrap>用户岗位</td>
                                  </tr>

                                  <tr >
                                      <td  class="x_list_result_title_td" width="10%"> 序号  </td>
                                      <td   class="x_list_result_title_td"  width="10%"> 岗位 </td>
                                      <td   class="x_list_result_title_td"  width="10%"> 序号 </td>
                                      <td   class="x_list_result_title_td"   width="10%"> 岗位 </td>
                                  </tr>

                                    <%=yhQxResult%>
                            </table>
                       </td>
					  </tr>
					</table>

																
			<!-- 内容区 -->

</body>
</html>
