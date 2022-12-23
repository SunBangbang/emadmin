<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%

	String id = "";
	
	String result[] = new String [2];
			if( !Serve.checkMkQx( request ) )
			{
				response.sendRedirect("/emadmin/shared/gotologin.jsp");
				return ;
			}


	     if( request.getMethod().equalsIgnoreCase("post") )
         {
             id=Serve.billCopyActionInsert( request );
        	 if (Serve.checkErrorString(id))
			 {
				response.sendRedirect("/emadmin/shared/usererror.jsp?id="+id);
				return;
			 }
			 
			 String nextPage[] =Serve.getNextPage(request);

			 response.sendRedirect(new String(( nextPage[0] + "?id="+id+"&modul_id=" +nextPage[1]).getBytes("gbk"), "iso8859-1"));
			 return ;
         }
		 else
			 result = Serve.getCopySheetForModify( request );
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
		function _after_load() {
            if (window.top.document.getElementById('_global_save')!=null && window.top.document.getElementById('_global_save').value.length>0) {
                document.body.innerHTML=window.top.document.getElementById('_global_save').value;
                window.top.document.getElementById('_global_save').value="";
 			    document.getElementById('_button_area' ).style.display="block";
			    document.getElementById('_button_area_message' ).style.display="none";
                reAttachSubAreaEvent();              

           }
			if (form1.all("_sys_txm")!=null && form1.all("_sys_txm").type=='text') {
                			//条形码
			        form1.all("_sys_txm").onkeydown = function(){ _doTxmInput() };
			        form1.all("_sys_txm").focus();
            }
			
		}
 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
                 if (window.top.document.getElementById('_global_save')!=null)  window.top.document.getElementById('_global_save').value= document.body.innerHTML
				form1.submit();
			}
		}
   //-->
</SCRIPT>
</head>
<body   onload="_after_load();">
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
 		 <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left' style="vertical-align: bottom;">
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

		  <%=result[0]%>&nbsp;<!-- 按扭区 -->
		  <!-- 内容区 -->
					<table width="98%"  border="0" cellspacing="0" cellpadding="0" align="center">
						  <form name="form1" method="post" action="bill_copy_add.jsp">
						  <tr>
							<td align="left"><%=result[1]%>							
							  	<div align="center" id="_button_area" style="display:block; padding-top:10px;vertical-align:bottom; clear:both;">
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
</body>

</html>
