<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.text.DecimalFormat,java.net.*"%>
<%


   String modulId = request.getParameter("modul_id");
   String tableName = request.getParameter("id");
   

		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}

	     if( request.getMethod().equalsIgnoreCase("post") )
         {  
			 String nd = request.getParameter("nd");
			 String yf = request.getParameter("yf");

			   Api.ub( " delete jc_cw_kjrl " ); 
			   Api.ub( "exec cw_qcjz '"+ nd +"','"+ yf +"' " ); 
			 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作成功 ！","UTF-8"));
			 return ;
         }

		 
		String ndyf = Serve.getNdYfResult ( request ); 
		
		String check_result[]=CWService.check_qcye();  
		double zc_nc=0f;
		double fz_nc=0f;
		double qy_nc=0f;
		double cb_nc=0f;
		double sy_nc=0f;

		double zc_qc=0f;
		double fz_qc=0f;
		double qy_qc=0f;
		double cb_qc=0f;
		double sy_qc=0f;

		double ljjf=0f;
		double ljdf=0f;


		String s_zc_nc="";
		String s_fz_nc="";
		String s_qy_nc="";
		String s_cb_nc="";
		String s_sy_nc="";

		String s_zc_qc="";
		String s_fz_qc="";
		String s_qy_qc="";
		String s_cb_qc="";
		String s_sy_qc="";

		String s_ljjf="";
		String s_ljdf="";

				DecimalFormat df;
				df =  new DecimalFormat("###,##0.00");

				Double d_tmp; 
			 
				try {
					zc_nc=Double.valueOf(check_result[0]).doubleValue();					
					
					d_tmp = Double.valueOf(check_result[0]);

					s_zc_nc = df.format(d_tmp);

				} catch (Exception e) {};
				try {
					fz_nc=Double.valueOf(check_result[1]).doubleValue();										
					d_tmp = Double.valueOf(check_result[1]);
					s_fz_nc = df.format(d_tmp);

				} catch (Exception e) {};
				try {
					qy_nc=Double.valueOf(check_result[2]).doubleValue();										
					d_tmp = Double.valueOf(check_result[2]);
					s_qy_nc = df.format(d_tmp);
				} catch (Exception e) {};
				try {
					cb_nc=Double.valueOf(check_result[3]).doubleValue();										
					d_tmp = Double.valueOf(check_result[3]);
					s_cb_nc = df.format(d_tmp);
				} catch (Exception e) {};
				try {
					sy_nc=Double.valueOf(check_result[4]).doubleValue();										
					d_tmp = Double.valueOf(check_result[4]);
					s_sy_nc = df.format(d_tmp);
				} catch (Exception e) {};

				try {
					zc_qc=Double.valueOf(check_result[5]).doubleValue();										
					d_tmp = Double.valueOf(check_result[5]);
					s_zc_qc = df.format(d_tmp);
				} catch (Exception e) {};
				try {
					fz_qc=Double.valueOf(check_result[6]).doubleValue();										
					d_tmp = Double.valueOf(check_result[6]);
					s_fz_qc = df.format(d_tmp);
				} catch (Exception e) {};
				try {
					qy_qc=Double.valueOf(check_result[7]).doubleValue();										
					d_tmp = Double.valueOf(check_result[7]);
					s_qy_qc = df.format(d_tmp);
				} catch (Exception e) {};
				try {
					cb_qc=Double.valueOf(check_result[8]).doubleValue();										
					d_tmp = Double.valueOf(check_result[8]);
					s_cb_qc = df.format(d_tmp);
				} catch (Exception e) {};
				try {
					sy_qc=Double.valueOf(check_result[9]).doubleValue();										
					d_tmp = Double.valueOf(check_result[9]);
					s_sy_qc = df.format(d_tmp);
				} catch (Exception e) {};

				try {
					ljjf=Double.valueOf(check_result[10]).doubleValue();										
					d_tmp = Double.valueOf(check_result[10]);
					s_ljjf = df.format(d_tmp);
				} catch (Exception e) {};

				try {
					ljdf=Double.valueOf(check_result[11]).doubleValue();										
					d_tmp = Double.valueOf(check_result[11]);
					s_ljdf = df.format(d_tmp);
				} catch (Exception e) {};

				String message="";
				if (zc_nc!=fz_nc+qy_nc) {
					message="没有通过试算平衡，请核对期初余额设置。不符合公式：[年初资产=年初负债+年初所有者权益]";
				} else  if (zc_qc!=fz_qc+qy_qc) {
					message="没有通过试算平衡，请核对期初余额设置。不符合公式：[期初资产=期初负债+期初所有者权益]";
				} else  if (ljjf!=ljdf) {
					message="没有通过试算平衡，请核对期初余额设置。不符合公式：[借方金额合计=贷方金额合计]";
				} else  if (cb_nc!=0) {
					message="没有通过试算平衡，请核对期初余额设置。不符合公式：[年初成本=0]";
				} else  if (cb_qc!=0) {
					message="没有通过试算平衡，请核对期初余额设置。不符合公式：[期初成本=0]";
				} else  if (sy_nc!=0) {
					message="没有通过试算平衡，请核对期初余额设置。不符合公式：[年初损益=0]";
				} else  if (sy_qc!=0) {
					message="没有通过试算平衡，请核对期初余额设置。不符合公式：[期初损益=0]";
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
			<!-- 标题区 --> 
			<td height="" align="left" valign="middle" id="center_head_bg">
					<span class="center_title" style="width:100%;">
						&nbsp;&nbsp;&nbsp;<%=Serve.getModulName( request )%>
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
		  <!-- 内容区 -->
					<form name="inputForm" method="post" action="cw_init.jsp" >
					<input type="hidden" name="modul_id" value="<%=modulId%>">
					<input name="kj_qsrq" type="hidden" id="kj_qsrq" value="<%=Util.getDate()%>">

					<table  width="100%"   border="1" cellpadding="20" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
						<tr  align="center" >
								<td  align="center" class="tabletitle" colspan="6">试算报告</td>
						</tr>

						<tr >
						<td align = right  class="tabletitle">合计（借）：</td>
						<td align = right  class="tabletitle"><%=s_ljjf%></td>
						<td align = right  class="tabletitle">合计（贷）：</td>
						<td align = right  class="tabletitle"><%=s_ljdf%></td>
						<td align = right  class="tabletitle">&nbsp;&nbsp;</td>
						<td align = right  class="tabletitle">&nbsp;&nbsp;</td>
						</tr>

						<tr >
						<td align = right  class="tabletitle">&nbsp;&nbsp;</td>
						<td align = right  class="tabletitle">&nbsp;&nbsp;</td>
						<td align = right  class="tabletitle">&nbsp;&nbsp;</td>
						<td align = right  class="tabletitle">&nbsp;&nbsp;</td>
						<td align = right  class="tabletitle">&nbsp;&nbsp;</td>
						<td align = right  class="tabletitle">&nbsp;&nbsp;</td>
						</tr>

						<tr >
						<td class="tabletitle">&nbsp;&nbsp;</td>
						<td class="tabletitle">资产(借)</td>
						<td class="tabletitle">负债(贷)</td>
						<td class="tabletitle">所有者权益(贷)</td>
						<td class="tabletitle">成本</td>
						<td class="tabletitle">损益</td>
						</tr>
			

						<tr >
						<td align = right  class="tabletitle">年初：</td>
						<td align = right  class="tabletitle"><%=s_zc_nc%></td>
						<td align = right  class="tabletitle"><%=s_fz_nc%></td>
						<td align = right  class="tabletitle"><%=s_qy_nc%></td>
						<td align = right  class="tabletitle"><%=s_cb_nc%></td>
						<td align = right  class="tabletitle"><%=s_sy_nc%></td>
						</tr>
						<tr >
						<td align = right  class="tabletitle">期初：</td>
						<td align = right  class="tabletitle"><%=s_zc_qc%></td>
						<td align = right  class="tabletitle"><%=s_fz_qc%></td>
						<td align = right  class="tabletitle"><%=s_qy_qc%></td>
						<td align = right  class="tabletitle"><%=s_cb_qc%></td>
						<td align = right  class="tabletitle"><%=s_sy_qc%></td>
						</tr>


					  </table>

			<% if (message.equals("")) {%>
					<br><br>
					<table  width="100%"   border="1" cellpadding="20" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
						<tr  align="center" >
								<td  align="center" class="tabletitle" colspan="4">财务启用</td>
						</tr>
						<tr >
						<td class="tabletitle">&nbsp;&nbsp;<font color="#ff0000">警告！</font><br>
							&nbsp;&nbsp;财务启用&nbsp;<%=ndyf%><br><br>
							&nbsp;&nbsp;1、财务启用将建立期初会计帐，建帐后期初余额将不可修改。<br>
							&nbsp;&nbsp;2、只有准备正式使用财务系统，并录入了正确的期初余额后，才能执行本操作。<br>
							&nbsp;&nbsp;3、财务启用将删除已存在的会计帐数据，并且不可恢复。<br>
							&nbsp;&nbsp;4、你确定继续吗？<br><br>
							
						</td>
						</tr>

						<tr > <td colspan="4" height="30"> 
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="确定建帐并启用财务系统" onClick="_click_button(inputForm)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
						</tr>
					  </table>
			<% } else {%>
					<table  width="100%"   border="1" cellpadding="20" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
						<tr  align="center" >
								<td  align="center" class="tabletitle" ><font color="#ff0000"><%=message%></font></td>
						</tr>
					  </table>
			<% }%>
					</form>
			
			<!-- 内容区 -->
</body>
</html>
