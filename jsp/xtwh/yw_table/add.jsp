<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%


    if( !Serve.checkMkQx( request ) )	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}

	String modul_id = request.getParameter("modul_id");

	String table_name = request.getParameter("_mainCN");

    if( request.getMethod().equalsIgnoreCase("post") )   {
			DefineService.addItem(request);

			response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功 ！","UTF-8"));
			return ;

	  }


    String sql="select distinct b.table_name,b.display_name from xt_bill_area a, xt_tables b ";
                sql+=" where a.table_name=b.table_name";
                sql+=" and a.bill_id in (select bill_id from xt_bill_area where table_name='"+table_name+"')";

    String r[]=Api.sb(sql);
    if (r==null || r.length==0) throw new  LFException("未能找到需要设置的表单定义，请联系系统管理员！");


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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>

<body >
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
 		 <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						添加自定义项目
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
          <!-- 按扭区 -->
        <%@include file="menu.jsp"%>

		  <!-- 内容区 -->
					<table class="x_bill_outer_table" cellspacing="0" align="center">
						  <tr>
							<td align="left">	
						  <form action="add.jsp" method="post" name="form1" >
            						<input type="hidden" name="modul_id" value="<%=modul_id%>">
            						<input type="hidden" name="table_name" value="<%=table_name%>">

  <table  width="90%"   border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff   align="center">
  
  <tr>
    <td  class="bill_td_10" width="20%" align="right">自定义项目名称:</td>
    <td  class="bill_td_11" width="30%" align="left"><input onFocus="this.select()"  size=50 
	name="display_name"  type="text" regName ="自定义项目名称"  reg = "_r_" class="input_required">
	<span style="color:red;">&nbsp;*</span></td>  
  </tr>


  <tr>
    <td  class="bill_td_00" width="20%" align="right">自定义项目类型:</td>
    <td  class="bill_td_01" width="30%" align="left"><select name="colume_type" regName ="自定义项目类型"  reg = "_rs_" class="select_required" >
	<option value="1" selected>文本</option>      
	<option value="2">实数</option>      
	<option value="3">日期</option>      
	<option value="4">大文本</option>            
	<option value="6">整数</option></select><span style="color:red;">&nbsp;*</span></td>  
  </tr>
  <% if (r.length>2) {%>
  <tr>
	<td  class="bill_td_00" width="20%" align="right">项目添加位置：</td>
    <td  class="bill_td_01" width="30%" align="left">
            <select name="add_table_name"  regName ="项目添加位置"  reg = "_rs_" class="x_select_required">
               <%  for (int i=0;i<r.length;i+=2) { %>
                    <option value="<%=r[i]%>"><%=r[i+1]%></option>
                <%}%>
            </select>
    </td>  
  </tr>
   <%} else {%>
            <input type="hidden" name="add_table_name"  value="<%=r[0]%>">
   <%}%>
  <tr>
	<td  class="bill_td_00" width="20%" align="right">该项目出现在：</td>
    <td  class="bill_td_01" width="30%" align="left"> <input type="checkbox" name="is_add"  checked value="1">新增界面&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="is_update"  checked value="1">修改界面&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="is_detail"  checked value="1">详情界面&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="is_print"  checked value="1">打印界面&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="is_list"  checked value="1">列表查询界面</td>  
  </tr>


</table>


                                <div align="center" id="_button_area" style="display:block; padding-top:10px;vertical-align:bottom;">
								<img src="/emadmin/images/c2/button/bill_save.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form1)"/> &nbsp;&nbsp;&nbsp;&nbsp;
                                <% String is_new_window=request.getParameter("is_new_window");
                                    if ((is_new_window!=null && is_new_window.equals("1")) || (request.getParameter("back_item_value")!=null)){%>
                                    <img src="/emadmin/images/c2/button/bill_close.gif" onMouseOver="this.style.cursor='hand'"   onclick='window.close();'/>
                                <%} else {%>
                                    <img src="/emadmin/images/c2/button/bill_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);'/> 
                                <%} %>
                                </div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
						  </form>
						   </td>
						  </tr>
						</table>
			
			<!-- 内容区 -->

</body>
</html>
