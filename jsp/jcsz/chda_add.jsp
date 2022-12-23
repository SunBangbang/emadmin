<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

	String id = "";
	String result[] = new String [2];
	String chCk;
	if( !Serve.checkMkQx( request ) )	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}
    //如果是初始化状态
    if (Api.getXtPreferenceValueByName("isystemenabled").equals("0")) {
        response.sendRedirect("/emadmin/init.jsp");
        return;
    }
	 if( request.getMethod().equalsIgnoreCase("post") )   {
             id=Serve.billActionInsert( request );

			 

        	 if (Serve.checkErrorString(id))  {
				response.sendRedirect("/emadmin/shared/usererror.jsp?id="+id);
				return;
			 } else {
				 CWService.updateChCkResult(id,request);

				 String url =Serve.getDMBEditNextUrl( request )+"&id="+id;
				 response.sendRedirect(url);
				 return;
			 }
      } else {
			 result = Serve.commonGetSheetForModify( request );

			 chCk = CWService.getChCkResult("",request);
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
		  <%=result[0]%>&nbsp;<!-- 按扭区 -->
		  <!-- 内容区 -->
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
						  <form action="chda_add.jsp" method="post" name="form1" >
						  <tr>
							<td align="left">	
								  <%=result[1]%>
								  <%=chCk%>
								  
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="保存" onclick="_click_button(form1)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
						   </td>
						  </tr>
						  </form>
						</table>
			
			<!-- 内容区 -->

</body>
</html>
