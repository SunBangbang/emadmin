<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%


		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}

	 String id = request.getParameter("qxz_id");
	 String name = Serve.getQxzNameById(id);
	 String menu_id = request.getParameter("menu_id");
	 String modul_id="Bill_List_XT_M116";

	     if( request.getMethod().equalsIgnoreCase("post") )
         { 
			 Serve.xtQxzfpUpdate( request );
			 
			 String url ="success.htm";
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
      function selectAll4()	  
	  {
	        if( !form1.cb4.checked )
			     return;
			for(i=0; i<form1.lc.value; i++)
			{
		        document.getElementsByName( "time_" + i )[0].value = form1.time_0.value;
		    }
	  }
      function _show_zdbm(id)	  
	  {
		    var bm=document.getElementsByName( "bm_" + id )[0];
	        if( bm.options[bm.selectedIndex].value==2) {
			     document.getElementsByName( "zdbm_" + id )[0].style.display='';
			     //document.getElementsByName( "show_detail_" + id)[0].style.display='none';
		    } else {
			     document.getElementsByName( "zdbm_" + id )[0].style.display='none';
			     //document.getElementsByName( "show_detail_" + id)[0].style.display='none';
			}
			return true;
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
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						<%=Serve.getModulName( request )%>(当前岗位：<font color=red><strong><%=name%></strong></font>)
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
            <div style="width:96%;text_align:center">
                <table cellspacing="0" class="x_list_result_table" align="center">
							<form action="fp_qxz_qx_1.jsp" method="post" name="form1">
										  <tr align="center">
											<td width="6%" class="x_list_result_title_td" colspan="2">&nbsp;</td>
											<td class="x_list_result_title_td"><input name="cb1" type="checkbox" id="cb1" value="checkbox" onClick="selectAll0( this, 'mid_')"> 全选      </td>
											<td class="x_list_result_title_td" colspan = 2 ><input name="cb3" type="checkbox" id="cb3" value="checkbox" onClick="selectAll1()">全部采用相同设置     </td>
											 <td width="6%" class="x_list_result_title_td"><input name="cb4" type="checkbox" id="cb4" value="checkbox" onClick="selectAll4()">全部采用相同设置</td>
											 <td width="6%" class="x_list_result_title_td">&nbsp;</td>
										  </tr>
										  <tr>
											<td  class="x_list_result_title_td">表单名</td>
											<td  class="x_list_result_title_td">序号</td>
											<td  class="x_list_result_title_td">模块名称</td>
											<td  class="x_list_result_title_td">选择权限范围</td>
											<td  class="x_list_result_title_td">选择指定的部门</td>
											 <td width="6%" class="x_list_result_title_td" title="（仅能访问几日内数据，“0”表示无限制）">时间权限</td>
											<td  class="x_list_result_title_td">高级控制</td>
										  </tr>
										  <%= Serve.getXtQxzfpTemplate(id,menu_id,request)[0] %>
											  
										  <input type="hidden" name="lc" value="<%= Serve.getXtQxzfpTemplate(id,menu_id,request)[1] %>">
										  <input type="hidden" name="qxz_id" value="<%=id%>">
										  <input type="hidden" name="modul_id" value="<%=modul_id%>">
										  <input type="hidden" name="menu_id" value="<%=menu_id%>">
							</form>
										</table>
                                            </br>
													<div align="center" id="_button_area" style="display:block"><img src="/emadmin/images/c2/button/bill_save.gif" onMouseOver="this.style.cursor='hand'" onclick="_click_button(form1)"> 
                                                    &nbsp;&nbsp;&nbsp;&nbsp;<img src="/emadmin/images/c2/button/bill_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:window.parent.location.href="/emadmin/jsp/common/list.jsp?modul_id=xt_qxz_listModul";'/> 
													</div>
													<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
			
			<!-- 内容区 -->

                    </div>

</body>
<SCRIPT LANGUAGE='JavaScript'>
    <!--

function  qx_pop_editor(myinput) {  
				 var  tmValue = new Array(1); 
                 tmValue[0]=myinput.value; 
                 result=window.open('/emadmin/shared/qx_pop_editor.html' , tmValue,"resizable:Yes;status:no;dialogHeight:400px;dialogWidth:600px;"); 
                 if (result!=true) { 
                           return; 
                 } else { 
							myinput.value=tmValue[0];
				 }  
} 
    //-->
</SCRIPT> 



</html>



