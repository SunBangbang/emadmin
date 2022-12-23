<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.lfbase.common.*"%>
<%
     String errorCode = request.getParameter("errorCode");
     String message = "";
	 boolean   zjc = false;
	 if( "2627".equals(errorCode) ){
	      message = "插入重复记录请检查";
		  zjc=true;}
     else
	      message = "发生数据库错误,错误代码:" + errorCode;
%>
<html>
<head>
<title>河北省南堡盐场设备管理软件</title>
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="1">
  <tr>
    <td align="center" valign="middle">

	<table width="50%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"><font color="#FF0000"><%=message%></font></td>
          </tr>
        </table>
<%if( zjc ){%>			
          <table width="100%"  border="0" cellspacing="0" cellpadding="5">
            <tr align="left">
              <td width="100%" colspan="2" align="center">
			  <input type="button" name="Submit" value="返回" onClick="history.go(-1)"></td>
            </tr>
          </table>
<%}%>		  
		  </td>
      </tr>
    </table>

</td>
  </tr>
</table>
</body>
</html>
