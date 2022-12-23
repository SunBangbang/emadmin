<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

			if( !Serve.checkMkQx( request ) )
			{
				response.sendRedirect("/emadmin/shared/gotologin.jsp");
				return ;
			}
			String [] r=UserListener.getSessionList();
			String sid=request.getParameter("sid");
			if (sid!=null) UserListener.kill(sid);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>
<body>
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						在线安全监控
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
<table width="100%"  border="0" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
  <tr>
    <td width="80%" height="25" valign="middle"><div align="left">&nbsp;&nbsp;&nbsp;当前登录数：<%=UserListener.getCount()%></div></td>
    <td width="20%" height="25" valign="middle"><div align="right"><a href="xt_online_monitor.jsp?modul_id=<%=request.getParameter("modul_id")%>">
    <img src="/emadmin/images/c2/button/xt_yh_online_refresh.gif" border='0'/></a>&nbsp;&nbsp;&nbsp;</div></td>
  </tr>
  <tr>
    <td colspan="2" valign="top">
    <div style='padding-left:5px;width: 99%;'>
      <table  cellspacing="0" class="x_list_result_table">
      <tr>
        <td  height="25"  class="x_list_result_title_td"><div align="center">序号</div></td>
        <td      class="x_list_result_title_td"><div align="center">登录名</div></td>
        <td      class="x_list_result_title_td"><div align="center">姓名</div></td>
        <td    class="x_list_result_title_td"><div align="center">部门</div></td>
        <td    class="x_list_result_title_td"><div align="center">IP地址</div></td>
        <td    class="x_list_result_title_td"><div align="center">联接时间</div></td>
        <td    class="x_list_result_title_td"><div align="center">持续时长</div></td>
        <td    class="x_list_result_title_td"><div align="center">最后访问时间</div></td>
        <td      class="x_list_result_title_td"><div align="center">操作</div></td>
        </tr>
<%	for (int i=0;i<r.length;i+=8) { 
	System.out.println("----------------"+r[i]);
 %>

      <tr>
        <td  class="x_xtwh_yh_online_td"  height="25" align="center"><%=(i/8+1)%></td>
        <td  class="x_xtwh_yh_online_td" align="center"><%=(r[i+1]==null?"未登录":r[i+1])%>&nbsp;</td>
        <td  class="x_xtwh_yh_online_td" align="center"><%=(r[i+2]==null?"未登录":r[i+2])%>&nbsp;</td>
        <td  class="x_xtwh_yh_online_td" align="center"><%=(r[i+3]==null?"未登录":r[i+3])%>&nbsp;</td>
        <td  class="x_xtwh_yh_online_td" align="center"><%=(r[i+4]==null?"未登录":r[i+4])%>&nbsp;</td>
        <td  class="x_xtwh_yh_online_td" align="center"><%=r[i+5]%>&nbsp;</td>
        <td  class="x_xtwh_yh_online_td" align="center"><%=r[i+6]%>&nbsp;</td>
        <td  class="x_xtwh_yh_online_td" align="center"><%=r[i+7]%>&nbsp;</td>
        <td  class="x_xtwh_yh_online_td" align="center"><div align="center"><a href="xt_online_monitor.jsp?modul_id=<%=request.getParameter("modul_id")%>&sid=<%=r[i]%>" class="linkline">禁止</a></div></td>
        </tr>
<%	}  %>
    </table></div></td>
  </tr>
</table>
</body>
</html>