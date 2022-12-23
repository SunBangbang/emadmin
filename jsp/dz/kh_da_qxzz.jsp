<%@page contentType="text/html;charset=UTF-8"%>

<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>

<%

		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}
        String id=request.getParameter("id");
        String modulId=request.getParameter("modul_id");

        //根据id 取出 客户名称
  String khmc[]=Api.sb("select khjc from kh_da where id='"+id+"'");
	     if( request.getMethod().equalsIgnoreCase("post") )
         {
               id=request.getParameter("id");
               modulId=request.getParameter("modul_id");
            
						 Api.ub("exec sp_kh_kh_da_qxzz '"+id+"' ");
						 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功！","UTF-8"));
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
   //-->
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
					<form name="form1" method="post" action="kh_da_qxzz.jsp" >
					<input type="hidden" name="modul_id" value="<%=modulId%>">
					<input type="hidden" name="id" value="<%=id%>">

				<div style="width:80%;margin-left:150px " align=center >
				 <table cellspacing="0" class="x_list_export_result_table"  style="height:100px;"> 
						<tr >
								 <td class="x_list_export_result_title_td" width="110px;"><img src="/emadmin/images/c3/wenhao.gif"></td>
								 <td class="x_list_export_result_title_td" style="text-align:left;">你确认将名称为<font color="red"><b><%=khmc[0]%></b></font>的客户转回意向客户吗？<br> 执行此操作后，该客户将被转移到意向客户档案中。</td>
						</tr>
					  </table>
					</div>
                                  <br/>
                                <div align="center" id="_button_area" style="display:block; padding-top:10px;vertical-align:bottom;">
								<img src="/emadmin/images/c2/button/bill_save.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form1)"/> &nbsp;&nbsp;&nbsp;&nbsp;
                                    <img src="/emadmin/images/c2/button/bill_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);'/> 
                                </div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
					</form>
			
			<!-- 内容区 -->
</body>
</html>
