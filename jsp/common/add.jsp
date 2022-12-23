<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

	String id = "";
	String result[] = new String [2];

    if( !Serve.checkMkQx( request ) )	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}

	 if( request.getMethod().equalsIgnoreCase("post") )   {

         try {
             id=Serve.billActionInsert( request );
         }catch (Exception e) {
             if (request.getParameter("back_item_value")!=null){
                response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("出现了异常情况 ！错误信息如下: <br><br>"+e.getMessage()+" 请重新输入!","UTF-8")+"&back="+URLEncoder.encode(request.getParameter("_backurl"),"UTF-8"));
            } else {
                throw e;
            }
         }
             //判断是否是弹出窗口挂新增
        if (request.getParameter("back_item_value")!=null){  %>
            <SCRIPT LANGUAGE='JavaScript'>
                window.top.document.getElementById('_global_save').value="";
                window.returnValue = true;
                window.dialogArguments[0] = "<%=id%>";
                window.close();
            </SCRIPT>
			<% return;
        } else {
        	 if (Serve.checkErrorString(id))  {
				response.sendRedirect("/emadmin/shared/usererror.jsp?id="+id);
				return;
			 } else {

				 String url =Serve.getDMBEditNextUrl( request )+"&id="+id;
				 response.sendRedirect(url);
				 return;
			 }
        }
      } else {
			 result = Serve.commonGetSheetForModify( request );
	  }
%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
   //设置网页打印的页眉页脚为空 

		function _after_load() {
			
						
            if (window.top.document.getElementById('_global_save')!=null && window.top.document.getElementById('_global_save').value.length>0) {
                document.body.innerHTML=window.top.document.getElementById('_global_save').value;
                window.top.document.getElementById('_global_save').value="";
 			    document.getElementById('_button_area' ).style.display="block";
			    document.getElementById('_button_area_message' ).style.display="none";
 			    reAttachSubAreaEvent();              
           }
          
			for (var i = 0; i <form1.elements.length ; i++) 
			{
				if(!form1.elements.elements) return;
				thisItem= form1.elements.elements[i]; 
				
				if(thisItem.name.indexOf('maxcount')>0)
				{

					var maxcount_i = parseInt(thisItem.value);


					if (maxcount_i <= 0 && (form1.all("_sys_txm")==null || form1.all("_sys_txm").type!='text')) {
                            if (document.getElementsByName('add' ).length>0) {
                                document.getElementsByName('add' )[0].click();
                            } else if  (document.getElementById('add' )!=null) {
						        document.getElementById('add' ).click();
                            }
                    }

				}
				
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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META name=save content=history >
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>

<body onLoad="_after_load();">
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
		 <div><%=result[0]%></div>

		  <!-- 内容区 -->
					<table class="x_bill_outer_table" cellspacing="0" align="center">
						  <tr>
							<td align="left">	
						  <form action="add.jsp" method="post" name="form1" >
						  <input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
						  <input type='hidden' name="_backurl" value="<%=request.getRequestURI()%>?<%=request.getQueryString() %>">	
                                  <input type="hidden" name="listretid" value="<%=request.getParameter("listretid")%>">
								  <%=result[1]%>


                                <div align="center" id="_button_area" style="display:block; padding-top:10px;vertical-align:bottom; clear:both;">
								<img src="/emadmin/images/c2/button/bill_save.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form1)"/> &nbsp;&nbsp;&nbsp;&nbsp;
                                <% String is_new_window=request.getParameter("is_new_window");
                                    if ((is_new_window!=null && is_new_window.equals("1")) || (request.getParameter("back_item_value")!=null)){%>
                                    <img src="/emadmin/images/c2/button/bill_close.gif" onMouseOver="this.style.cursor='hand'"   onclick='window.close();'/>
                                <%} else {%>
                                    <img src="/emadmin/images/c2/button/bill_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);'/> 
                                <%} %>
                                </div>
								<div align="center" id="_button_area_message" style="display:none;clear:both;">正在处理，请稍等...</div>
						  </form>
						   </td>
						  </tr>
						</table>
			
			<!-- 内容区 -->

</body>
</html>
