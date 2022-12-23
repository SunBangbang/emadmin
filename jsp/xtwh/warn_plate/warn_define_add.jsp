<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

	String id = "";
	String result;



	if( !Serve.checkMkQx( request ) )	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}

	String old_filtertemplateid = request.getParameter("old_filtertemplateid");
	String filtertemplateid = request.getParameter("filtertemplateid");


	 if( request.getMethod().equalsIgnoreCase("post") )   {
             id=Serve.billActionInsert( request );
        	 if (Serve.checkErrorString(id))  {
				response.sendRedirect("/emadmin/shared/usererror.jsp?id="+id);
				return;
			 } else {
                 String url="/emadmin/jsp/xtwh/warn_plate/warn_define_set_warn_condition.jsp?modul_id=condition_set_Mod&_mainCN=view_xt_list&_mainID="+request.getParameter("_mainID")+"&id="+id;
				 response.sendRedirect(url);
				 return;
			 }
      } else {
			 result = Serve.xtWarnDefineSetGetEditTemplate( request );
	  }
%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
		function _after_load() {
			

			for (var i = 0; i <form1.elements.length ; i++) 
			{
				
				thisItem=form1.elements.elements[i]; 
				
				if(thisItem.name.indexOf('maxcount')>0)
				{

					var maxcount_i = parseInt(thisItem.value);

					//alert (maxcount_i);

					if (maxcount_i <= 0)
						document.getElementsByName('add' )[0].click();


				}
				
			}
			
			
		}
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
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>

<body onload="_after_load();">
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
          <!-- 按扭区 -->


		  <!-- 内容区 -->
					<table class="x_bill_outer_table" cellspacing="0" align="center">
						  <tr>
							<td align="left">	
						  <form action="warn_define_add.jsp" method="post" name="form1" >
						  <input type="hidden" name="listretid" value="<%=request.getParameter("listretid")%>">
								  <%=result%>							
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="保存" onclick="_click_button(form1)">
                                <% String is_new_window=request.getParameter("is_new_window");
                                    if (is_new_window!=null && is_new_window.equals("1")) {%>
                                    <img src="/emadmin/images/c2/button/bill_close.gif" onMouseOver="this.style.cursor='hand'"   onclick='window.close();'/>
                                <%} else {%>
                                    <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'>
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
