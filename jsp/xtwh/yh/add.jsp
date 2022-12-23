<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
                String is_ukey=Api.getXtPreferenceValueByName("is_ukey");
                if (Util.isBlankString(is_ukey)) is_ukey="0";

	        String id = "";
			if( !Serve.checkMkQx( request ) )
			{
				response.sendRedirect("/emadmin/shared/gotologin.jsp");
				return ;
			}


	     if( request.getMethod().equalsIgnoreCase("post") )
         {
             try {
                 id=Serve.YhBillActionInsert( request );
				   //如果是添加用户的时候
				response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("恭喜您，该用户添加成功!<br>您可以使用该帐号登录系统!<br>密码默认为:111111，请您登录系统后及时修改!","UTF-8"));
					 return;
             }catch (Exception e) {
                if (request.getParameter("back_item_value")!=null){
                    response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("出现了异常情况 ！错误信息如下: <br><br>"+e.getMessage()+" 请重新输入!","UTF-8")+"&back="+URLEncoder.encode(request.getParameter("_backurl"),"UTF-8"));
                } else {
                    throw e;
                }
             }
            if (request.getParameter("back_item_value")!=null){  %>
                <SCRIPT LANGUAGE='JavaScript'>
                    window.returnValue = true;
                    window.dialogArguments[0] = "<%=id%>";
                    window.close();

                </SCRIPT>
                <% return;
            }


        	 if (Serve.checkErrorString(id))
			 {
				response.sendRedirect("/emadmin/shared/usererror.jsp?id="+id);
				return;
			 }
			 
			 String url =Serve.getDMBEditNextUrl(request);
			 response.sendRedirect(url);
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
<%@include file="/emadmin/js/ukey.jsp"%>


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
                <% if (is_ukey.equals("1")  && ((String)session.getAttribute("userId")).equalsIgnoreCase("admin")) {%>
                        <input type="button" value="绑定V盾" onclick="bind_ukey();">
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="button" value="取消绑定V盾" onclick="unbind_ukey();">
                <%}%>
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
		  <!-- 内容区 -->

					<table class="x_bill_outer_table" cellspacing="0" align="center">
						<form name="form1" method="post" action="add.jsp">
						  <tr>
							<td align="left">	
								 <%=Serve.YhBillActionGetSheetForModify( request )%>	<input type='hidden' name="_backurl" value="<%=request.getRequestURI()%>?<%=request.getQueryString() %>">
                                 <br/>
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
						   </td>
						  </tr>
						  </form>
						</table>
			
			<!-- 内容区 -->
<%
	String productCode=Api.getXtPreferenceValueByName("productCode");
	if (productCode.equals("kcs")){%>
			<script>
				document.getElementById('x_item_select_table').style.display='none';
				form1.nonselectitem.options[0].selected = true;
				copySelectedListItem(form1.nonselectitem,form1.selectitem);
			</script>
<%}%>
</body>
</html>
