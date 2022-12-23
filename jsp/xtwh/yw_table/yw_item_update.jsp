<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/emadmin/shared/checkAdminPermission.jsp"%>
<%@page import="com.lf.util.*,java.sql.*,com.lf.lfbase.service.*,java.io.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.* ,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

	if( !Serve.checkMkQx( request ) )
	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}


	String modul_id = request.getParameter("modul_id");

	String id = request.getParameter("id");

	//取业务表的名称
	String r[]=Api.sb("select display_name from xt_tables where id = '"+id +"'");
	String yw_table = "";
	if (r !=null && r.length>0)
		yw_table = r[0];


	

	 if( request.getMethod().equalsIgnoreCase("post") )   {
			Serve.saveYwItemUpdate(request);

			response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功 ！","UTF-8"));
			return ;

	  }


%>
<html>
<head>
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>
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

<body >
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区 --> 
			<td height="" align="left" valign="middle" id="center_head_bg">
					<span class="center_title" style="width:100%;">
							&nbsp;&nbsp;&nbsp; 业务表[<%=yw_table%>]项目修改
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
		  &nbsp;<!-- 按扭区 -->
		  <!-- 内容区 --> 
					<table width="90%"  border="0" cellspacing="0" cellpadding="10" align="center">
						
					<form name="form1" method="post" action="yw_item_update.jsp" >

						  
						<input type="hidden" name="modul_id" value="<%=modul_id%>">
						<input type="hidden" name="id" value="<%=id%>">
		
				 <tr>
					<td>	
					   <%=Serve.getYwItemUpdateTemplate( request )%>
					</td>
				  </tr>
  
						

						  <tr >
							<td align="left">
							  	<div align="left" id="_button_area" style=" line-height:25px;font-size:12px;display:block"><br/>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="Submit" value="保存" onClick="_click_button(form1)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style=" line-height:25px;font-size:12px;display:none">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;正在处理，请稍等...</div>						   
							</td>
						  </tr>



						  </form>
						</table>
			
			<!-- 内容区 -->

</body>
</html>
