<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

	String id = "";

			if( !Serve.checkMkQx( request ) )
			{
				response.sendRedirect("/emadmin/shared/gotologin.jsp");
				return ;
			}


	     if( request.getMethod().equalsIgnoreCase("post") )
         {
             id=Serve.billActionInsert( request );
        	 if (Serve.checkErrorString(id))
			 {
				response.sendRedirect("/emadmin/shared/usererror.jsp?id="+id);
				return;
			 }
			 //对根组织自动配置此权限组和把修改密码自动给权限组
			 Serve.updateQxzBmResult(id,request);

			 
			 String modulId =Serve.getNextModule(request);

			 response.sendRedirect(new String(("list.jsp?id="+id+"&modul_id=" +modulId).getBytes("gbk"), "iso8859-1"));
			 return ;
         }
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
   //-->s
</SCRIPT>
</head>
<body>

		 <table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						<%=Serve.getModulName( request )%>
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
		  <!-- 内容区 -->

					<table class="x_bill_outer_table" cellspacing="0" align="center" width="99%">
						<form name="form1" method="post" action="add.jsp" >
						  <tr>
							<td align="left" width="99%">	
								 <%=Serve.commonGetSheetForModify( request )[1]%>

								 
								<%if(Api.getXtPreferenceValueByName("sf_cydjqxms").equals("1")){%>
																 <%=Serve.getQxzBmResult("",request)%>
								<%}%>
							  	<div align="center" id="_button_area" style="display:block; padding-top:20px;vertical-align:bottom;">
								<img src="/emadmin/images/c2/button/bill_save.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form1)"/> &nbsp;&nbsp;&nbsp;&nbsp;
                                <% String is_new_window=request.getParameter("is_new_window");
                                    if ((is_new_window!=null && is_new_window.equals("1")) || (request.getParameter("back_item_value")!=null)){%>
                                    <img src="/emadmin/images/c2/button/bill_close.gif" onMouseOver="this.style.cursor='hand'"   onclick='window.close();'/>
                                <%} else {%>
                                    <img src="/emadmin/images/c2/button/bill_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);'/> 
                                <%} %>
                                </div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
						   </td>
						  </tr>
						  <tr>
							<td align="center" valign="top"><div class="x_message_big1">&nbsp;&nbsp;&nbsp;&nbsp;<font color="blue">温馨提示：</font><font color="red">为了方便您以后操作，建议您添加完岗位之后，对此岗位点击“授权”链接，进行授权!</font></div>
						   </td>
						  </tr>
						  </form>
						</table>
			
			<!-- 内容区 -->


</body>
</html>
