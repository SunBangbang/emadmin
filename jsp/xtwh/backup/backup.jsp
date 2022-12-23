<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.io.*,org.apache.commons.io.*,java.net.*"%>
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
			BackupService.save(request);
			Api.ub("update xt_xszn set state=1 where modul_id='backup_Mod'");
            response.sendRedirect("/emadmin/shared/message.jsp?back=&message="+URLEncoder.encode("操作已成功 ！","UTF-8"));
			return ;

         }
         String r[]=BackupService.read();
		 String backupPath=r[1];
		 String backupType=r[2];
		 String backupTime=r[3];
%>
<%! public String getSelected(String x1,String x2) {
			if (x1==null || x2==null) return "";
			if (x1.equals(x2)) {
				return "selected"; 
			} else {
				return "";
			}
		}
%>

<script language=javascript>
<!--
 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
 		function click_manu() { 
			document.getElementById('manu_area' ).style.display='';
			document.getElementById('auto_area').style.display='none';
		}
 		function click_auto() { 
			document.getElementById('manu_area' ).style.display='none';
			document.getElementById('auto_area').style.display='';
		}
		function do_click() {
			if (form1.backuptype[0].checked) {
				click_manu();
			} else {
				click_auto();
			}
		}
		
//-->
</script>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>
<body onLoad="do_click()">

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
					<table width="99%"  border="0" cellspacing="0" cellpadding="0" align="center">
							<form name="form1" method="post" action="backup.jsp">
							  <tr>
								<td align="left">
									<table  cellspacing="0" class="x_list_result_table">
										<tr>
										  <td height="40"   class="x_list_result_title_td" ><p>指定备份文件存放的目录：
								            <input name="path" type="text" value="<%=backupPath%>" size="40">
									      </p>									      </td>
									  </tr>
										<tr >
                                          <td   class="x_list_result_td00" >&nbsp;&nbsp;<input type="radio" name="backuptype" <%=backupType.equals("manu")?"checked":""%> value="manu" onClick="click_manu()">                                            
                                            <strong>手工备份</strong><br>
                                            <div id="manu_area" style="display:none; ">&nbsp;&nbsp;&nbsp;&nbsp;点击“保存”按钮后立即进行备份。</div></td>
									  </tr>
									   <tr>
                                          <td   class="x_list_result_td00" >&nbsp;&nbsp;<input type="radio" name="backuptype" <%=backupType.equals("auto")?"checked":""%> value="auto" onClick="click_auto()">
                                            <strong>自动备份</strong><br>
											<div id="auto_area" style="display:none;" >&nbsp;&nbsp;&nbsp;&nbsp;在每天
											<select name="time" >
											  <option value="00" <%=getSelected("00",backupTime)%>>00</option>
											  <option value="01" <%=getSelected("01",backupTime)%>>01</option>
											  <option value="02" <%=getSelected("02",backupTime)%>>02</option>
											  <option value="03" <%=getSelected("03",backupTime)%>>03</option>
											  <option value="04" <%=getSelected("04",backupTime)%>>04</option>
											  <option value="05" <%=getSelected("05",backupTime)%>>05</option>
											  <option value="06" <%=getSelected("06",backupTime)%>>06</option>
											  <option value="07" <%=getSelected("07",backupTime)%>>07</option>
											  <option value="08" <%=getSelected("08",backupTime)%>>08</option>
											  <option value="09" <%=getSelected("09",backupTime)%>>09</option>
											  <option value="10" <%=getSelected("10",backupTime)%>>10</option>
											  <option value="11" <%=getSelected("11",backupTime)%>>11</option>
											  <option value="12" <%=getSelected("12",backupTime)%>>12</option>
											  <option value="13" <%=getSelected("13",backupTime)%>>13</option>
											  <option value="14" <%=getSelected("14",backupTime)%>>14</option>
											  <option value="15" <%=getSelected("15",backupTime)%>>15</option>
											  <option value="16" <%=getSelected("16",backupTime)%>>16</option>
											  <option value="17" <%=getSelected("17",backupTime)%>>17</option>
											  <option value="18" <%=getSelected("18",backupTime)%>>18</option>
											  <option value="19" <%=getSelected("19",backupTime)%>>19</option>
											  <option value="20" <%=getSelected("20",backupTime)%>>20</option>
											  <option value="21" <%=getSelected("21",backupTime)%>>21</option>
											  <option value="22" <%=getSelected("22",backupTime)%>>22</option>
											  <option value="23" <%=getSelected("23",backupTime)%>>23</option>
										    </select>
											时进行自动备份。</div>										 </td>
									  </tr>
								  </table>	
								 <input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
	
                                  <br/>
                                <div align="center" id="_button_area" style="display:block; padding-top:10px;vertical-align:bottom;">
								<img src="/emadmin/images/c2/button/bill_save.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form1)"/> &nbsp;&nbsp;&nbsp;&nbsp;
                                </div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
								</td>
							  </tr>
							</form>
						</table>
			
			<!-- 内容区 -->

</body>
</html>
