<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/emadmin/shared/checkAdminPermission.jsp"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%

		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}

   String modulId = request.getParameter("modul_id");
   String tableName = request.getParameter("id");

   String ndyf = Serve.getNdYfResult ( request ); 
   String _productCode=Api.getXtPreferenceValueByName("productCode");
              


	     if( request.getMethod().equalsIgnoreCase("post") )
         {

			  String s[]=Api.sb("select id from xt_yh where zhanghao='admin' and password='"+Util.GetMD5(Util.checkForSql(request.getParameter("pw")))+"' ");
              if (s==null || s.length==0) throw new Exception("密码不正确！");
			 String nd = request.getParameter("nd");
			 String yf = request.getParameter("yf");

			 String qyrq = nd + "-"+yf + "-01";
			 Api.ub( "exec xt_system_start '"+ qyrq +"'" ); 
			 Serve.reloadAll();
             Thread.sleep(3000);
			 //if(_productCode.equals("kcs")){
				 //response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功，恭喜你，现在可以开始正式使用软件了 ！<br>温馨提示：我们特地为您准备了『<a href='/emadmin/jsp/xtwh/system/system_xszn.jsp?modul_id=xt_xszn_Modul'>新手指南</a>』，在您初始化系统的过程中它会助您一臂之力","UTF-8"));
			// }
			// else{
				response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功，恭喜你，现在可以开始正式使用软件了 ！","UTF-8"));
			// }
			 return ;
         }
		 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>

<script language=javascript src="/emadmin/js/do_check.js"></script>
<script language=javascript src="/emadmin/js/pop_selections.js"></script>
<script language=javascript src="/emadmin/js/bi_sub_table.js"></script>
<script language=javascript src="/emadmin/js/print.js"></script>
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
					<form name="inputForm" method="post" action="" >
					<input type="hidden" name="modul_id" value="<%=modulId%>">

					<table   cellspacing="0" class="x_list_result_table" align="center">
						<tr  align="center" >
								<td  align="center"  class="x_list_result_title_td" colspan="4"><div style="color:red" >警  告！</div></td>
						</tr>
						<tr >
						<td class="x_list_result_td00">
							&nbsp;&nbsp;<span title="指系统开始使用的时间，只能录入该时间之后的单据，如果你想补录以前的单据，请采用最早的单据时间作为启用时间，如果您不清楚怎么做，请采用默认值。"><Strong>系统启用时间</Strong>&nbsp;<%=ndyf%></span><br><br>
							&nbsp;&nbsp;1、系统启用将删除系统中所有已录入的数据，并将系统恢复到无数据的初始状态。<br>
							&nbsp;&nbsp;2、只有准备正式使用该系统时才进行此操作。<br>
							<% if(_productCode.equals("kcs")){%>
							&nbsp;&nbsp;3、删除后数据将不可恢复，你确定继续吗？<br><br>
							<%}else{%>
							&nbsp;&nbsp;3、系统启用后，需要每月末对库存进行月结处理。<br>
							&nbsp;&nbsp;4、删除后数据将不可恢复，你确定继续吗？<br><br>
							<%}%>
						</td>
						</tr>
						<tr >
						<td class="x_list_result_td00"><br>&nbsp;&nbsp;只有管理员才能够进行此项操作,请输入管理员密码:&nbsp;&nbsp;<input type="password" regName ="管理员密码"  reg = "_r_"  name="pw" ><span style="color:red;">&nbsp;*</span><br><br>
						</td>
						</tr>

					  </table>

                                  <br/>
                                <div align="center" id="_button_area" style="display:block; padding-top:10px;vertical-align:bottom;">
								<img src="/emadmin/images/c2/button/xt_system_start.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(inputForm)"/> &nbsp;&nbsp;&nbsp;&nbsp;
                                    <img src="/emadmin/images/c2/button/bill_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);'/> 
                                </div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
					</form>
			
			<!-- 内容区 -->
</body>
</html>
