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
			DefineService.updateTemplate(request);

			response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功 ！","UTF-8"));
			return ;

	  }

	//取业务表的名称
	String r[]=Api.sb("select display_name,table_name from xt_tables where table_name = '"+table_name +"'");
	String yw_table = "";
	if (r !=null && r.length>1)
	{
		yw_table = r[0];
		table_name = r[1];
	}

	String bill_template = "";
	String bill_id = "";
	
	r=Api.sb("select bill_template,id from xt_bills where id ='"+table_name +"_updateBill'");
	if (r ==null || r.length<1)
	{
		throw new Exception("表样式不存在！");
	}

	bill_template = r[0];
	bill_id = r[1];




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
						设计<%=yw_table%>【修改界面】
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
						  <form action="" method="post" name="form1" >
                                <div ></div>                                
                              <input type="hidden" name="modul_id" value="<%=modul_id%>">
						      <input type="hidden" name="table_name" value="<%=table_name%>">

                                <div style=" display:none ">
    <textarea name="template"   regName ="大文本" rows=5 cols = 50 class="text_normal">
	    <%=bill_template%>
    </textarea></div>
     <IFRAME ID="ewebeditorttt" src="/emadmin/shared/webeditor/ewebeditor.htm?id=template&style=coolblue" frameborder="0" scrolling="no" width="800" height="450">
    </IFRAME>
    
    <div  style="padding-top:5px;"><input name="update_other_template" type="checkbox"  value="update_other_template" checked> 
		同步更新<%=yw_table%>【新增界面】。</div>            

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
