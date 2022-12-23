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


	
	//取顺序号
	r = Api.sb("select count(*) * 10 from xt_tables_define,xt_tables "
			+ " where xt_tables.table_name = xt_tables_define.table_name and xt_tables.id = '"+id +"'");
	String row_index = "100";
	if (r !=null && r.length>0)
		row_index = r[0];


	

	 if( request.getMethod().equalsIgnoreCase("post") )   {
			Serve.saveYwItemAdd(request);

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
						&nbsp;&nbsp;&nbsp; 业务表[<%=yw_table%>]项目新增
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
		  &nbsp;<!-- 按扭区 -->
		  <!-- 内容区 --> 
					<table width="90%"  border="0" cellspacing="0" cellpadding="10" align="center">
						
					<form name="form1" method="post" action="yw_item_add.jsp" >
						<input type="hidden" name="modul_id" value="<%=modul_id%>">
						<input type="hidden" name="id" value="<%=id%>">
						

		


  <table  width="90%"   border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff   align="center">
  
  <tr>
    <td  class="bill_td_10" width="20%" align="right">项目名称:</td>
    <td  class="bill_td_11" width="30%" align="left"><input onFocus="this.select()"  size=50 
	name="display_name"  type="text" regName ="项目名称"  reg = "_r_" class="input_required">
	<span style="color:red;">&nbsp;*</span></td>  

	<td  class="bill_td_00" width="20%" align="right">序号:</td>
    <td  class="bill_td_01" width="30%" align="left">
	<input onFocus="this.select()"  name="row_index" 
	type="text" regName ="序号"  reg = "_int_" value="<%=row_index%>" class="input_normal"></td>  
  </tr>

  <tr>
    <td  class="bill_td_00" width="20%" align="right">列数据类型:</td>
    <td  class="bill_td_01" width="30%" align="left"><select name="colume_type" regName ="列数据类型"  reg = "_rs_" class="select_required" >      <option value="">请选择</option>      
	<option value="1" selected>文本</option>      
	<option value="2">实数</option>      
	<option value="3">日期</option>      
	<option value="4">大文本</option>            
	<option value="6">整数</option></select><span style="color:red;">&nbsp;*</span></td>  

    <td  class="bill_td_00" width="20%" align="right">小数的位数:</td>
    <td  class="bill_td_01" width="30%" align="left">
	<input onFocus="this.select()"  name="decimal_num"  type="text" regName ="小数的位数"  reg = "_int_" value="2" class="input_normal"></td> 	
  </tr>

  <tr>
    <td  class="bill_td_10" width="20%" align="right">表单项目类型:</td>
    <td  class="bill_td_11" width="30%" align="left"><select name="bdxmlx" regName ="表单项目类型" class="select_normal" >      
		<option value="">请选择</option>          
		<option value="020">录入框</option>         
		<option value="080">文件上传</option>      
		<option value="130">日期</option>      
		<option value="140">图文混排</option>
		<option value="030">单选下拉框</option>      
		<option value="031">多选下拉框</option> 
	</select>
	</td>  

    <td  class="bill_td_10" width="20%" align="right">是否需要合计:</td>
    <td  class="bill_td_11" width="30%" align="left"><select name="is_required_sum" regName ="是否需要合计" class="select_normal" >      <option value="">请选择</option>      <option value="0">否</option>      <option value="1">是</option></select></td>  

  </tr>

  <tr>
      <td  class="bill_td_10" width="20%" align="right">是否必须输入:</td>
    <td  class="bill_td_11" width="30%" align="left"><select name="is_required" regName ="是否必须输入"  reg = "_rs_" class="select_required" >      <option value="">请选择</option>      <option value="0" selected>否</option>      <option value="1">是</option></select><span style="color:red;">&nbsp;*</span></td>  

    <td  class="bill_td_00" width="20%" align="right">是否隐藏:</td>
    <td  class="bill_td_01" width="30%" align="left"><select name="is_hidden" regName ="是否隐藏"  reg = "_rs_" class="select_required" >      <option value="">请选择</option>      <option value="0" selected>否</option>      <option value="1">是</option></select><span style="color:red;">&nbsp;*</span></td>  

  </tr>


  <tr>

	<td  class="bill_td_00" width="20%" align="right">系统默认定义:</td>
    <td  class="bill_td_01" width="30%" align="left"><select name="xtdefaultdefine" regName ="系统默认定义" class="select_normal" >      
	<option value="">请选择</option>      
	<option value="getdate">当前日期</option>      
	<option value="getyear">当前年</option>      
	<option value="getuserbm">操作员部门</option>      
	<option value="getuserid">操作员姓名</option>      
	<option value="getuserip">操作员ip地址</option>      
	<option value="getyearmonth">当前月</option>      
	<option value="gettime">当前时间</option>      
	<option value="getmonth">当前月(不含年)</option>
	</select></td>  

	    <td  class="bill_td_10" width="20%" align="right">常量默认定义:</td>
    <td  class="bill_td_11" width="30%" align="left"><input onFocus="this.select()"  name="finaldefine"  type="text" regName ="常量默认定义" class="input_normal"></td>  

  </tr>



  <tr>


      <td  class="bill_td_10" width="20%" align="right">选项内容（用西文的“,”分隔）:</td>
    <td  class="bill_td_11" width="70%" align="left" colspan="3"><input onFocus="this.select()"  name="option_content"  type="text" regName ="下拉列表内容" class="input_normal"  style= "width:   90%; "></td>  

</tr>

</table>




						  <tr >
							<td align="center">
							  	<div align="left" id="_button_area" style=" line-height:25px;font-size:12px;display:block"><br/>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="Submit" value="保存" onClick="_click_button(form1)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style=" line-height:25px;font-size:12px;display:none">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;正在处理，请稍等...</div>						   
							</td>
						  </tr>



						  </form>
						</table>
			
			<!-- 内容区 -->

</body>
</html>
