<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

	String id = "";
	String result[] = new String [2];

    //如果是初始化状态
    if (Api.getXtPreferenceValueByName("isystemenabled").equals("0")) { %>
		<SCRIPT LANGUAGE='JavaScript'>
			<!--
				alert("系统目前处于初始化状态，不能执行此项操作，请先进行系统初始化！");
				window.location.href="/emadmin/init.jsp";
		   //-->
		</SCRIPT>
<%      
        return;
    }

	if( !Serve.checkMkQx( request ) )	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}

	 if( request.getMethod().equalsIgnoreCase("post") )   {
             id=Serve.billActionInsert( request );
        	 if (Serve.checkErrorString(id))  {
				response.sendRedirect("/emadmin/shared/usererror.jsp?id="+id);
				return;
			 } else {
				 String url =Serve.getDMBEditNextUrl( request )+"&id="+id;
				 response.sendRedirect(url);
				 return;
			 }
      } else {
			 result = Serve.commonGetSheetForModify( request );
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
			<!-- 标题区 --> 
			<td height="" align="left" valign="middle" id="center_head_bg">
					<span class="center_title" style="width:100%;">
						&nbsp;&nbsp;&nbsp;<%=Serve.getModulName( request )%>
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
          <!-- 按扭区 -->
		  <div align="left" style='padding-top:5px;padding-bottom:5px;padding-left:27px;padding-right:5px;'><%=result[0]%></div>
		  <!-- 内容区 -->
            <div align="left" style='padding-top:5px;padding-bottom:5px;padding-left:25px;padding-right:5px;'>
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="left">
						  <form action="add.jsp" method="post" name="form1" >

    <tr colspan=4  >


     				<td class="tabletitle">&nbsp;&nbsp;注意！<br>
							
							&nbsp;&nbsp;1、上传的文件必须是EXCEL文件。<br>

							&nbsp;&nbsp;2、文件的第一行必须是标题；文件的第二行后是内容<br>

							&nbsp;&nbsp;3、第一列必须是本表单的重要字段，并且，不能为空，为空时，系统认为上传文件内容已经结束<br>

							&nbsp;&nbsp;4、请在文件中，不要合并单元格，否则，系统无法处理<br>



					</td>     
                                                                                               
    </tr>


						  <tr>
							<td align="left">	
								  <%=result[1]%>							
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="保存" onclick="_click_button(form1)">
                                <% String is_new_window=request.getParameter("is_new_window");
                                    if (is_new_window!=null && is_new_window.equals("1")) {%>
                                    <img src="/emadmin/images/c2/button/bill_close.gif" onMouseOver="this.style.cursor='hand'"   onclick='window.close();'/>
                                <%} else {%>
                                    <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'>
                                <%} %>
                                </div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
						   </td>
						  </tr>
						  </form>
						</table>
			
            </div>																
			<!-- 内容区 -->

</body>
</html>
