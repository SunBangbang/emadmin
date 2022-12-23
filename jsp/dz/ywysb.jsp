<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.io.*,com.lf.util.*,java.text.SimpleDateFormat,com.lf.lfbase.service.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,javax.servlet.http.HttpServletRequest,java.net.*,java.text.*"%>
<%
	Api.ub("update dstf set scsbr='"+((String[])session.getAttribute("userInfo"))[0]+"',scsbrq='"+Util.getDate()+"' where id='"+request.getParameter("id")+"'");
%>

<br><br><br><br>
<div align="center" style="text-align:center">
	<font size="2px;">恭喜你上报成功，当前记录上报进度为：</font><br><br><br>
<img src="/emadmin/images/c2/sbsq.gif">
</div>