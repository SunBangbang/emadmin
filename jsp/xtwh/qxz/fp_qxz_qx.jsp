<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

	 String id = request.getParameter("id");
	 String modul_id="Bill_List_XT_M116";

		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}


	     if( request.getMethod().equalsIgnoreCase("post") )
         { 
			 Serve.xtQxzfpUpdate( request );
			 
			 String url ="list.jsp"+"?modul_id=Bill_List_XT_M116";
			 response.sendRedirect(url);
			 return; 
         }

     
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<script language="javascript">
<!--
      function selectAll0(sender, name)	  
	  {
			for(i=0; i<form1.lc.value; i++)
			{
		        document.getElementsByName( name + i )[0].checked = sender.checked;
		    }
	  }
      function selectAll1()	  
	  {
	        if( !form1.cb3.checked )
			     return;
			for(i=0; i<form1.lc.value; i++)
			{
		        document.getElementsByName( "bm_" + i )[0].selectedIndex = form1.bm_0.selectedIndex;
				document.getElementsByName( "zdbm_" + i )[0].selectedIndex = form1.zdbm_0.selectedIndex;
				document.getElementsByName( "zdbmbh_" + i )[0].selectedIndex = form1.zdbmbh_0.selectedIndex;

		    }
	  }
-->
</script>
<%@include file="/emadmin/shared/headres.jsp"%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
 		function _click_button(form1) { 
			if (true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
   //-->
</SCRIPT>
</head>

<body>

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
		  &nbsp;<!-- 按扭区 -->
		  <!-- 内容区 -->
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
							<form action="fp_qxz_qx.jsp" method="post" name="form1">
							  <tr>
								<td align="left">	
										<table width="100%"  border="1" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
												  <tr align="center">
													<td width="6%" class="tabletitle">序号</td>
													<td width="20%" class="tabletitle"><input name="cb1" type="checkbox" id="cb1" value="checkbox" onClick="selectAll0( this, 'mid_')">      模块名称      </td>
													<td width="64%" class="tabletitle" colspan = 2 ><input name="cb3" type="checkbox" id="cb3" value="checkbox" onClick="selectAll1()">
													  权限定义     </td>
													
												  </tr>
												  <%= Serve.getXtQxzfpTemplate(id) %>
													  
												  <input type="hidden" name="lc" value="<%= Serve.getXtQxzfpLine(id) %>">
												  <input type="hidden" name="qxz_id" value="<%=id%>">
												  <input type="hidden" name="modul_id" value="<%=modul_id%>">
										</table>
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="保存" onclick="_click_button(form1)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
								</td>
							  </tr>
							</form>
						</table>
			
			<!-- 内容区 -->


</body>
</html>
