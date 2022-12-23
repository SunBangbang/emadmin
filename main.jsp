<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*"%>
<%@include file="/emadmin/version.jsp"%>
<% 
                response.setHeader("Pragma","No-cache"); 
                response.setHeader("Cache-Control","no-cache"); 
                response.setDateHeader("Expires", 0); 
     String zhanghao;
	 String password;
	 String type;
	 String message = "";
	 zhanghao = request.getParameter("zhanghao");
	 password = request.getParameter("pwd");
	 type = request.getParameter("type");
     if (type==null) type="login";

	 

	 if( type.equals("login"))
	 {
	    if(request.getMethod().equalsIgnoreCase("post") )  {
				message = Serve.userVerify(request,response);
	     } 
    } else	 {
                 session.invalidate();
				 response.sendRedirect("/emadmin/shared/gotologin.jsp");
				 return ;
	}
%>
<html>
<head>
<title>北京安创明圣科技发展有限公司 企业管理软件</title>
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/c1/style_new.css" rel="stylesheet" type="text/css">
</head>
<body  bgcolor="#e3e1d5">
<table width="800" height="527" border="0" align="center" cellpadding="0" cellspacing="0" background="images/c2/index_main.jpg">
  <tr>
    <td width="422" height="196">&nbsp;</td>
    <td >&nbsp;</td>
  </tr>
  <tr>
    <td width="422" height="312">&nbsp;</td>
    <td width="378">
<div >
  <form name="form1" method="post" action="index.jsp">
    <table border="0" cellpadding="5" cellspacing="0" width="20">
	<tr>
	  <td colspan="2"><span class="x_index_input_main_title">请输入您的用户名及密码</span></td>
	<tr>
	<tr><td nowrap="nowrap"><span class="x_index_input_main_title">用户帐号：</span></td><td nowrap="nowrap"><input type="text" maxlength="100" name="zhanghao" value="admin" onMouseOver="this.style.backgroundColor='#FFFFFF'" class="x_bill_item_input"></td>
	</tr>
	<tr>
	<td nowrap="nowrap"><span class="x_index_input_main_title">登录密码：</span></td><td nowrap="nowrap"><input type="password" maxlength="32"  name="pwd" onMouseOver="this.style.backgroundColor='#FFFBFF'"  value="111111" class="x_password_input" style="width:150px"></td>
	</tr>
	<tr>
	<td height=20>	</tr>
	<tr>
	<td><input type="image" name="Submit" src="/emadmin/images/c2/logon.gif" ></td>
	<tr>
	</table>
  </form>
</div>	</td>
  </tr>
  <tr>
    <td height="19" colspan="2">
	<table border=0 width=100% cellpadding="0" cellspacing="0">
      <tr>
        <td class="x_index_support">技术支持&nbsp;&nbsp;QQ:&nbsp;&nbsp;814735034&nbsp;&nbsp;&nbsp;&nbsp;服务电话：010-82782651&nbsp;&nbsp;<a href="http://www.jindongli.com.cn" target="_blank">www.jindongli.com.cn</a></td>
        </tr>
        <tr>
          <td align=right><span class="x_index_foot_right">Copyright 2009 @ Lingfei Technology Co.,Ltd. All rights reserved.</span></td>
        </tr>
    </table></td>
  </tr>
</table>
<%if(message.length()>0){%>
<script language="javaScript">
<!--
	alert(<%="'"+message+"'"%>);
-->
</script>
<%}%>
</body>
</html>
