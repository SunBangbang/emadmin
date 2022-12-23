<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.net.*"%>

<%@page errorPage="/emadmin/shared/error.jsp"%>
<%


	String modul_id = request.getParameter("modul_id");
	


	if( !Serve.checkMkQx( request ) )	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}


	 if( request.getMethod().equalsIgnoreCase("post") )   {
			 String list_id = request.getParameter("list_id");
			 String table_name = request.getParameter("table_name");
			            
        	response.sendRedirect("warn_define_add.jsp?modul_id="+modul_id+"&list_id="+list_id+"&table_name="+table_name);
			return ;

      } 
%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				form1.submit();
			}
		}

		function _doSelect_mainarea_list_id() {  
						 var  mySubDialog = new Array(1); 
						 var  idValue=''; 
						 result=window.open('/emadmin/shared/popwindow.jsp?bringinitems=id,list_title,table_name&popid=win_xt_list&modul_id=aatest_addModul&keywords=' + idValue, mySubDialog,"resizable:Yes;status:no;dialogHeight:500px;dialogWidth:700px;"); 
						 if (result!=true) { 
								   return; 
						 } else { 
								   document.getElementsByName('list_id' )[0].value=mySubDialog[0][1]; 
								   document.getElementsByName('title' )[0].value=mySubDialog[0][2]; 
								   document.getElementsByName('table_name' )[0].value=mySubDialog[0][3]; 
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
			<td height="" valign="middle" class='x_center_head_bg'>
					<span class="x_center_title" >
						创建预警定义
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
          <!-- 按扭区 -->
					<table class="x_bill_outer_table" cellspacing="0" align="center">
						  <tr>
							<td align="left">	
						  <form action="warn_define_add_index.jsp" method="post" name="form1" >
								<TABLE id=bill_main_table cellSpacing=0 borderColorDark=#ffffff cellPadding=0 borderColorLight=#b3c3d0 border=1>



								<input name="list_id" value="" type=hidden>
								<input name="table_name" value= "" type=hidden>
								<input name="modul_id" value="<%=modul_id%>" type=hidden>


								<TR>


									<td  class="bill_td_00" width="20%" align="right">预警对应的列表:</td>
									<td  class="bill_td_01" width="30%" align="left"><input name="title"  type=text reg = "_r_"  regName ="预警对应的列表"  readonly    class="input_required"> <span style="color:red;">&nbsp;*</span>
									<a href="#" onClick="_doSelect_mainarea_list_id()">选择</a></td>  

								</TR>



								<TR>
								<td align="center" colspan=2 >
							  	<input type="button" name="Submit" value="下一步" onclick="_click_button(form1)">
								</td>
								</tr>  



								</table>
						  </form>
						   </td>
						  </tr>
						</table>
			<!-- 内容区 -->

</body>
</html>
