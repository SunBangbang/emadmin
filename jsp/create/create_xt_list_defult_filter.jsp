<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.net.*"%>

<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

	String id = request.getParameter("id");
	String modul_id = request.getParameter("modul_id");
	


	if( !Serve.checkMkQx( request ) )	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}

	 if( request.getMethod().equalsIgnoreCase("post") )   {
            Serve.saveListSystemFilter( request );
        	response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功 ！","UTF-8"));
			return ;

      } 
%>
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
<html>
<head>
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
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
          <!-- 按扭区 -->
		  <div align="left" style='padding-top:5px;padding-bottom:5px;padding-left:27px;padding-right:5px;'></div>
		  <!-- 内容区 -->
            <div align="left" style='padding-top:5px;padding-bottom:5px;padding-left:25px;padding-right:5px;'>
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="left">
						  <form action="create_xt_list_defult_filter.jsp" method="post" name="form1" >

						  <tr>
							<td align="left">	
								<TABLE id=bill_main_table cellSpacing=0 borderColorDark=#ffffff cellPadding=0 borderColorLight=#b3c3d0 border=1>



								<TR>
								<TD class=bill_td_00 align=right width="60%" colspan=2>列表id:<%=id%></TD>
								</TR>


								<TR>
								<TD class=bill_td_00 align=right width="20%">选项标题:</TD>
								<TD class=bill_td_01 align=left colSpan=3><input onFocus="this.select()"  name="xxbt"  type="text" regName ="选项标题"  reg = "_r_" size="40" class="input_required"><span style="color:red;">&nbsp;*</span></TD></TR>
								<TR>

								<TR>
								<TD class=bill_td_10 align=right width="20%">默认选择条件:</TD>
								<TD class=bill_td_11 align=left colSpan=3><textarea name="default_filter"   regName ="默认选择条件"  reg = "_r_" rows=6 cols = 50 class="text_required"></textarea><span style="color:red;">&nbsp;*</span></TD>
								</TR>

								<input name="modul_id" value="<%=modul_id%>" type=hidden>
								<input name="id" value= "<%=id%>" type=hidden>


	
								  
								</table>
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="保存" onclick="_click_button(form1)">
                                <% String is_new_window=request.getParameter("is_new_window");
                                    if (is_new_window!=null && is_new_window.equals("1")) {%>
                                    <img src="/emadmin/images/c2/button/bill_close.gif" onMouseOver="this.style.cursor='hand'"   onclick='window.close();'/>
                                <%} else {%>
                                    <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'>
                                <%} %>
                                </div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
						   </td>
						  </tr>
						  </form>
						</table>
			
            </div>																
			<!-- 内容区 -->

</body>
</html>
