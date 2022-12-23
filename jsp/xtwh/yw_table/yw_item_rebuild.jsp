<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/emadmin/shared/checkAdminPermission.jsp"%>
<%@page import="com.lf.util.*,java.sql.*,com.lf.lfbase.service.*,java.io.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.* ,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

   String modulId = request.getParameter("modul_id");
   String id = request.getParameter("id");


	//取业务表的名称
	String r[]=Api.sb("select display_name,replace(table_name,'_sub','') from xt_tables where id = '"+id +"'");
	String yw_table = "";
	String table_name = "";
	if (r !=null && r.length>1)
	{
		yw_table = r[0];
		table_name = r[1];
	}



	if( !Serve.checkMkQx( request ) )
	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}

	 if( request.getMethod().equalsIgnoreCase("post") )
	 {
		 Serve.autoReCreatBill( request );

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

<body>




		<%@include file="/emadmin/shared/content_1.jsp"%>
			<!-- 标题区 --> 
				[<%=yw_table%>]业务重建
			<!-- 标题区 --> 
		<%@include file="/emadmin/shared/content_2.jsp"%>
			<!-- 按扭区 --> 
							&nbsp;
			<!-- 按扭区 --> 
		<%@include file="/emadmin/shared/content_3.jsp"%>
			<!-- 内容区 -->








	
<form name="form1" method="post" action="yw_item_rebuild.jsp" >
<input type="hidden" name="modul_id" value="<%=modulId%>">
<input type="hidden" name="tableName" value="<%=table_name%>">

<table  width="100%"   border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
	<tr  align="center" >
			<td  align="center" class="tabletitle" colspan="4"> --业务重建--  </td>
    </tr>
    <tr >


     				<td class="tabletitle">&nbsp;&nbsp;注意！<br>
							
							&nbsp;&nbsp;1、选择保存自定义样式，新增的项目会自动添加到你定义的表单样式后面。<br>

							&nbsp;&nbsp;2、你确定继续吗？<br><br>
					</td>     


                                                                                               
    </tr>


<tr>
<td align="left">
	<input name="save_old_template" type="checkbox" id="cb1" value="save_old_template" checked> 
		保存自定义表单样式    
</td>  
</tr>


  <tr >
	<td align="center">
		<div align="left" id="_button_area" style=" line-height:25px;font-size:12px;display:block"><br/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="Submit" value="提交" onClick="_click_button(form1)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
		<div align="center" id="_button_area_message" style=" line-height:25px;font-size:12px;display:none">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;正在处理，请稍等...</div>						   
	</td>
  </tr>

  
  
  </table>

</form>
	
			<!-- 内容区 -->
		<%@include file="/emadmin/shared/content_4.jsp"%>


</body>
</html>
