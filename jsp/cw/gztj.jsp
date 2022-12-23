<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.ca1234.admin.*,com.lf.util.Util,com.lf.ca1234.*,java.util.*"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*,java.text.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>

<%
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}
		String[] years = CaUtil.getCodeByGroupname("年度");
		String[] months = CaUtil.getCodeByGroupname("月");
		String[] employees = Employee.searchListForYg(request);
%><head>
	<script type="text/javascript">
		function check(){
			var year = document.getElementById('year');
			var month = document.getElementById('month');
			var employee = document.getElementById('employee');
			if(year.value==""){
				alert("请选择年度");
				year.focus();
				return false;
			}
			if(month.value==""){
				alert("请选择月份");
				month.focus();
				return false;
			}
			return true;
		}
	</script>
</head>

<table width="800" border="1" cellspacing="2" cellpadding="2">
<form id="form1" name="form1" method="post" action="gztj1.jsp" onsubmit="return check();">
  <tr>
    <td width="217"><div align="right"></div></td>
    <td width="563"><div align="right"></div></td>
  </tr>
  <tr>
    <td><div align="right">年度：</div></td>
    <td>      <label>
        <div align="left">
		<select name="year" id="year">
			<option value="">请选择</option>
			<%for(int i=0;i<years.length;i+=2){%>
				<option value="<%=years[i]%>"><%=years[i+1]%></option>
			<%}%>
		</select>
		</div>
        </label>    </td>
  </tr>
  <tr>
    <td><div align="right">月份：</div></td>
    <td>      <label>
        <div align="left">
		<select name="month" id="month">
			<option value="">请选择</option>
			<%for(int i=0;i<months.length;i+=2){%>
				<option value="<%=months[i]%>"><%=months[i+1]%></option>
			<%}%>
		</select>
        </div>
        </label>    </td>
  </tr>
  <tr>
    <td><div align="right">员工：</div></td>
    <td>      <label>
        <div align="left">
		<select name="employee" size="8" multiple="multiple" id="employee">
			<%for(int i=0;i<employees.length;i+=2){%>
				<option value="<%=employees[i]%>"><%=employees[i+1]%></option>
			<%}%>
		</select>
        </div>
        </label>    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input name="modul_id" type="hidden" value="<%=request.getParameter("modul_id")%>"><input type="submit" name="提交"/></td>
  </tr>
 </form>
</table>
