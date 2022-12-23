<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/emadmin/shared/checkAdminPermission.jsp"%>
<%@page import="com.lf.util.*,java.sql.*,com.lf.lfbase.service.*,java.io.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.* ,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

	String id = "";
	String result[] = new String [2];
/*
	if( !Serve.checkMkQx( request ) )
	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}

*/
	String[] tmpStr =(String[])request.getSession().getAttribute("userInfo");
	String user_id = tmpStr[0];
	String bm_id = tmpStr[3];

	String modul_id = request.getParameter("modul_id");
	//业务表
	String table_name = "";
	String r[]=Api.sb("select table_name from xt_modul where id = '"+ modul_id +"'");
	if (r!=null && r.length>0)	
		table_name = r[0];


	

	//业务名称
	r=Api.sb("select name from xt_excel_define where table_name = '"+ table_name +"'");
	String yw_name = "";
	if (r!=null && r.length>0)	
		yw_name = r[0];

	
	//批号
	String ph_script = Api.getOptionSourceResultOptionScript(table_name +"_ph", request, "", "0");

	 if( request.getMethod().equalsIgnoreCase("post") )   {
			Serve.excelDefineDoImport(request,response);

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
						&nbsp;&nbsp;&nbsp;<%=yw_name%> &nbsp;&nbsp; 导入EXCEL数据
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
		  &nbsp;<!-- 按扭区 -->
		  <!-- 内容区 --> 
					<table width="90%"  border="0" cellspacing="0" cellpadding="10" align="center">
						
					<form name="form1" method="post" action="import_excel.jsp" >

						  
						  
						<input type="hidden" name="modul_id" value="<%=modul_id%>">
						<input type="hidden" name="user_id" value="<%=user_id%>">
						<input type="hidden" name="bm_id" value="<%=bm_id%>">
    <tr colspan=4>


     				<td class="tabletitle">&nbsp;&nbsp;注意！<br>
							
							&nbsp;&nbsp;1、上传的文件必须是EXCEL文件。<br>

							&nbsp;&nbsp;2、文件的第一行必须是标题;文件的第二行后是内容 <br>

							&nbsp;&nbsp;3、第一列必须是本表单的重要字段，并且，不能为空，为空时，系统认为上传文件内容已经结束<br>

							&nbsp;&nbsp;4、请在文件中，不要合并单元格，否则，系统无法处理<br>

							&nbsp;&nbsp;5、第一列必须同首次的格式文件内容一致，否则，系统认为文件的格式不正确<br>


					</td>     
                                                                                               
    </tr>



						
					<tr  height="30px">

						<td nowrap  class='list_result_td01'>

							<input name="add_type" type="radio" value="1" checked > 
							按批新增
						</td>
					</tr>

					<tr  height="30px">																										  
						<td  nowrap  class='list_result_td01'>
						<input name="add_type" type="radio" value="2" > 
							按批修改&nbsp;&nbsp;选择批号 <select name="replace_ph" > <%=ph_script%> </select>
						</td>   
																											   
					</tr>
		
						  
						  
						  <tr height="30px"> 
								<td nowrap  class='list_result_td01'>
									  <div align="left"  style=" line-height:25px;font-size:12px;"><br/>
										 &nbsp;&nbsp;&nbsp;&nbsp;请指定要上传的文件 :	&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="gswj"  type="hidden"   value="" readonly><img src="/emadmin/images/shangchuan.jpg" onclick="do_upload('gswj')">  
				<span id="gswj_div">  </span> 
				<input type="hidden" name="gswj_old_file" value="">
				<span style="color:red;">&nbsp;*</span>										 

										 <br/>								  </div>							   </td>
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
