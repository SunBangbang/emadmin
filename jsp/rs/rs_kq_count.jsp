<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%//考勤计算
	String result[];
	
		if( !request.getMethod().equalsIgnoreCase("post") && !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}  
	     if( request.getMethod().equalsIgnoreCase("post") )
         {  
			   RSService.countKQ( request );        

			 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("数据已经成功导入 ！","UTF-8"));
			 return ;
         }


%>
<%! public String getSelected(String x1,String x2) {
			if (x1==null || x2==null) return "";
			if (x1.equals(x2)) {
				return "selected"; 
			} else {
				return "";
			}
		}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<style type="text/css">
.readonly_input {
	height:18px;
	font-size: 12px;
	border:#7F9DB9 solid 0PX;
	margin:1px 2px 1px 2px;
    FONT-WEIGHT: normal;
    FONT-FAMILY: "宋体"
}

</style>
<%@include file="/emadmin/shared/headres.jsp"%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
   //-->
</SCRIPT>
</head>
<body >
		  <table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区 --> 
			<td height="" align="left" valign="middle" id="center_head_bg">
					<span class="center_title" style="width:100%;">
						&nbsp;&nbsp;&nbsp;<%=Serve.getModulName( request )%>
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
			<!-- 内容区 -->

				<form name="form1" action="rs_kq_count.jsp" method="post">
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
					  <tr>
						<td align="left"><br/>选择计算的年度月份：
						<select name='nd'>
                            <%=Api.getOptionSourceResultOptionScript("11884402013800027",request,Util.getYear(),"0")%>
						</select> 年 
						<select name='yf'>
							<option value='01' <%=getSelected(Util.getMonth(),"01")%>>01</option>
							<option value='02' <%=getSelected(Util.getMonth(),"02")%>>02</option>
							<option value='03' <%=getSelected(Util.getMonth(),"03")%>>03</option>
							<option value='04' <%=getSelected(Util.getMonth(),"04")%>>04</option>
							<option value='05' <%=getSelected(Util.getMonth(),"05")%>>05</option>
							<option value='06' <%=getSelected(Util.getMonth(),"06")%>>06</option>
							<option value='07' <%=getSelected(Util.getMonth(),"07")%>>07</option>
							<option value='08' <%=getSelected(Util.getMonth(),"08")%>>08</option>
							<option value='09' <%=getSelected(Util.getMonth(),"09")%>>09</option>
							<option value='10' <%=getSelected(Util.getMonth(),"10")%>>10</option>
							<option value='11' <%=getSelected(Util.getMonth(),"11")%>>11</option>
							<option value='12' <%=getSelected(Util.getMonth(),"12")%>>12</option>
						</select> 月</br></br> 
						<font color='#ff0000'>警告：该操作将自动清除已存在的当月考勤数据，并且不可恢复！</font>
							  <input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
							  <input type="hidden" name="_mainCN" value="<%=request.getParameter("_mainCN")%>">
							  <input type="hidden" name="is_reopen" value="1">
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="确定下一步" onclick="_click_button(form1)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>

						</td>
					  </tr>
					</table>
				</form>													
							 
											
			<!-- 内容区 -->

</body>
</html>
