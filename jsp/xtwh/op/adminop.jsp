<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.lfbase.service.*,java.util.prefs.Preferences"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
			if( !Serve.checkMkQx( request ) )
			{
				response.sendRedirect("/emadmin/shared/gotologin.jsp");
				return ;
			}
			String message=request.getParameter("message");
			if(null!=message)
			{
				String execSql="";
				String operater=request.getParameter("operater");
				Boolean	flag=false;
				String br="\r\n \r\n";
				if(operater.equals("net restart jdl")) {
					execSql="exec master.dbo.xp_cmdshell 'net stop jdl' ";
					execSql="exec master.dbo.xp_cmdshell 'net start jdl' ";
					message+=br+"执行操作:重启金动力服务成功...";
				}
				if(operater.equals("net stop jdl")) {
					execSql="exec master.dbo.xp_cmdshell '"+operater+"'";
					message+=br+"执行操作:停止金动力服务成功...";
				}
				if(operater.equals("backup database")) {
					String installDir[]=Api.sb("exec master.dbo.xp_regread 'HKEY_LOCAL_MACHINE','SOFTWARE\\lingfei\\jdl','installDir'");
					execSql="exec master.dbo.xp_cmdshell 'del \""+installDir[1]+"\\webapps\\ROOT\\emadmin\\jdl.bak\"'";
					Api.sb(execSql);
					execSql=operater+" jdl to disk='"+installDir[1]+"/webapps/ROOT/emadmin/jdl.bak'";
					message+=br+"执行操作:备份金动力数据库成功...";
					message+=br+"温馨提示:数据库已成功备份在["+installDir[1]+"\\webapps\\ROOT\\emadmin]目录下...";
					flag=true;
				}
				if(null!=operater){
					if(flag) Api.ub(execSql); else  Api.sb(execSql);
				}
			}
			else{
				message="执行操作:系统初始化成功...";
			}
			
			
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title>远程维护</title>
<%@include file="/emadmin/shared/headres.jsp"%>

<style type="text/css">
	.bottonFldsubmit{_display:inline; width:39px; height:18px; margin:5px 11px 0 6px; font-size:12px; color:#4B4B4B; cursor:pointer; border:none; BACKGROUND-IMAGE: url(\emadmin\images\c3\button\op_btn.png);}
</style>
<script language=javascript>
 		function _click_button(op) { 
				document.getElementById("operater").value=op;
				form1.submit();
		}
		window.onload=function () { 
			document.getElementById("message").verticalScrollPosition=document.getElementById("message").maxVerticalScrollPosition ;
			document.getElementById('message').scrollTop = document.getElementById('message').scrollHeight;
		}
		function  openfile(url)
        {     
			try{
				window.frames["hrong"].location.href   =   url;   
				sa();
			}catch(e){
				alert("下载出错！");
			}
        }
		function   sa()   
		{   
			if(window.frames["hrong"].document.readyState!="complete")   
			  setTimeout("sa()",   100);   
			else   
			  window.frames["hrong"].document.execCommand('SaveAs');   
		}   

</script>
</head>
<body>

		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					<span class="index1_font" >
							&nbsp;&nbsp;	&nbsp;&nbsp;<%=Serve.getModulName( request )%>
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
		<form action="adminop.jsp" method="post" name="form1">
		  <!-- 显示区 -->
			 <div style="width:  100%; " align="center"><textarea id='message' name="message" style="width:  98%; " align="center"  rows="10" readonly><%=message%></textarea><input type="hidden" name='operater' ><input type="hidden" name='modul_id' value="<%=request.getParameter("modul_id")%>" ></div>
			 <!-- 内容区 -->
			 <table width="98%" border ="1" cellpadding="0" cellspacing="0" borderColor=#dee7f6 align="center">
			  <tr>
				<td style="padding-left:50px;">
					重启金动力服务<input type="button" class="bottonFldsubmit" value="执行" align="absmiddle" onclick="_click_button('net restart jdl');"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					停止金动力服务<input type="button" class="bottonFldsubmit" value="执行" align="absmiddle" onclick="_click_button('net stop jdl');"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					备份客户数据库<input type="button" class="bottonFldsubmit" value="执行" align="absmiddle" onclick="_click_button('backup database');"/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					下载数据库到本地<input type="button" class="bottonFldsubmit" value="执行" align="absmiddle" onclick="openfile('/emadmin/jdl.bak');"/>
				</td>
			  </tr>
			  <tr>
				<td style="padding-left:30px;">
					<!--<input type="button" class="bottonFldsubmit" value="执行" align="absmiddle"/>
					<input type="button" class="bottonFldsubmit" value="执行" align="absmiddle"/>
					<input type="button" class="bottonFldsubmit" value="执行" align="absmiddle"/>-->&nbsp;
				</td>
			  </tr>
			</table>
		</form>
		 <iframe   width=0   height=0   frameborder=0   name=hrong   style="display:   none"></iframe>  
</body>
</html>
