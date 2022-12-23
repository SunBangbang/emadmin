<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.net.*"%>
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
            
             Serve.saveQxzForbidItemDefine( request );

			 response.sendRedirect("/emadmin/shared/message.jsp?back="+URLEncoder.encode("/emadmin/jsp/xtwh/qxz/list.jsp?modul_id=Bill_List_XT_M116")+"&message="+URLEncoder.encode("操作已成功 ！","UTF-8"));
			 return ;

         }
%>
<html>

<script language=javascript>
<!--


 		function _click_button(form1) { 
			for (var i = 0; i < form1.selectitem.options.length; i++)
				 form1.selectitem.options[i].selected = true;
			
			for (var i = 0; i < form1.nonselectitem.options.length; i++)
				 form1.nonselectitem.options[i].selected = true;
			if (doCheck(form1)==true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
//-->
</script>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
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
		  &nbsp;<!-- 按扭区 -->
		  <!-- 内容区 -->

					<table class="x_bill_outer_table" cellspacing="0" align="center">
						<form name="form1" method="post" action="qxz_data_qx.jsp">
						  <tr>
							<td align="left">	
								 <%=Serve.getQxzForbidItemDefine( request )%>					
							  	<div align="center" id="_button_area" style="display:block; padding-top:20px;vertical-align:bottom;">
								<img src="/emadmin/images/c2/button/bill_save.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form1)"/> &nbsp;&nbsp;&nbsp;&nbsp;
                                    <img src="/emadmin/images/c2/button/bill_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);'/> 
                                </div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
						   </td>
						  </tr>
						  </form>
						</table>
			
			<!-- 内容区 -->



</body>
</html>
