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
		String xszn[]=Api.sb("select state from xt_xszn");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
<style type="text/css">
body {padding:0px;margin:0px;}
font{ size:12px;}

</style>
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
			<td  class='x_import_kh_right'>&nbsp;
				
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
		  <!-- 内容区 -->
		 <table width="98%" border ="1" cellpadding="0" cellspacing="0" borderColor=#dee7f6 align="center">
		  <tr>
			<td style="padding-left:100px;height:40px;">第一步：进行系统启用，清空演示数据&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/emadmin/jsp/xtwh/system/system_start.jsp?modul_id=sys_start_Mod" target="_blank"><img src="/emadmin/images/c3/kaishi.png" border=0>&nbsp;开始操作</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/emadmin/images/c3/caozuo.png">&nbsp;<a href="/emadmin/resource/swf/demo.jsp?id=1"  target="_blank">操作演示</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=xszn[0].equals("1")?"<font color='green'>已完成</font>":"<font color='red'>未完成</font>"%></td>
		  </tr>
		  <tr>
			<td style="padding-left:100px;height:40px;">第二步：设置首选参数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/emadmin/jsp/xtwh/system/system_preference.jsp?modul_id=xt_preference_modul" target="_blank"><img src="/emadmin/images/c3/kaishi.png" border=0>&nbsp;开始操作</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/emadmin/images/c3/caozuo.png">&nbsp;<a href="/emadmin/resource/swf/demo.jsp?id=2"  target="_blank">操作演示</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=xszn[1].equals("1")?"<font color='green'>已完成</font>":"<font color='red'>未完成</font>"%></td>
		  </tr>
		  <tr>
			<td style="padding-left:100px;height:40px;">第三步：设置部门信息&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/emadmin/jsp/xtwh/bm/mainframe.jsp?modul_id=xt_000000" target="_blank"><img src="/emadmin/images/c3/kaishi.png" border=0>&nbsp;开始操作</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/emadmin/images/c3/caozuo.png">&nbsp;<a href="/emadmin/resource/swf/demo.jsp?id=3"  target="_blank">操作演示</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=xszn[2].equals("1")?"<font color='green'>已完成</font>":"<font color='red'>未完成</font>"%></td>
		  </tr>
		  <tr>
			<td style="padding-left:100px;height:40px;">第四步：设置用户帐号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/emadmin/jsp/xtwh/yh/mainframe.jsp?modul_id=xt_000001" target="_blank"><img src="/emadmin/images/c3/kaishi.png" border=0>&nbsp;开始操作</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/emadmin/images/c3/caozuo.png">&nbsp;<a href="/emadmin/resource/swf/demo.jsp?id=4"  target="_blank">操作演示</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=xszn[3].equals("1")?"<font color='green'>已完成</font>":"<font color='red'>未完成</font>"%></td>
		  </tr>
		  <tr>
			<td style="padding-left:100px;height:40px;">第五步：设置货品分类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/emadmin/jsp/tree/mainframe.jsp?modul_id=jc_hpfl_treeModul" target="_blank"><img src="/emadmin/images/c3/kaishi.png" border=0>&nbsp;开始操作</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/emadmin/images/c3/caozuo.png">&nbsp;<a href="/emadmin/resource/swf/demo.jsp?id=5"  target="_blank">操作演示</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=xszn[4].equals("1")?"<font color='green'>已完成</font>":"<font color='red'>未完成</font>"%></td>
		  </tr>
		   <tr>
			<td style="padding-left:100px;height:40px;">第六步：初始化导入&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/emadmin/jsp/dz/import_kc_xtcsh.jsp?modul_id=kc_kcqc_import_Modul" target="_blank"><img src="/emadmin/images/c3/kaishi.png" border=0>&nbsp;开始操作</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/emadmin/images/c3/caozuo.png">&nbsp;<a href="/emadmin/resource/swf/demo.jsp?id=6"  target="_blank">操作演示</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=xszn[7].equals("1")?"<font color='green'>已完成</font>":"<font color='red'>未完成</font>"%></td>
		  </tr>
		     <tr>
			<td style="padding-left:100px;height:40px;">第七步：进行一次数据备份&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/emadmin/jsp/xtwh/backup/backup.jsp?modul_id=backup_Mod" target="_blank"><img src="/emadmin/images/c3/kaishi.png" border=0>&nbsp;开始操作</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/emadmin/images/c3/caozuo.png">&nbsp;<a href="/emadmin/resource/swf/demo.jsp?id=7"  target="_blank">操作演示</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=xszn[8].equals("1")?"<font color='green'>已完成</font>":"<font color='red'>未完成</font>"%></td>
		  </tr>
</table>	
		  <br> 
		  <div align="left" style="padding-left:20px;"><font size="2px;"><strong>新手指南示意图:</strong></font><br><br></div>
		  <div align="left" style="padding-left:100px;"><img src="/emadmin/images/c3/xsznlct.png" border="0" usemap="#Map">
<map name="Map">
<area shape="rect" coords="6,4,65,60" href="/emadmin/jsp/xtwh/system/system_start.jsp?modul_id=sys_start_Mod"  target="_blank">
<area shape="rect" coords="95,2,154,61" href="/emadmin/jsp/xtwh/system/system_preference.jsp?modul_id=xt_preference_modul"  target="_blank">
<area shape="rect" coords="177,2,251,60" href="/emadmin/jsp/xtwh/bm/mainframe.jsp?modul_id=xt_000000"  target="_blank">
<area shape="rect" coords="274,2,332,60" href="/emadmin/jsp/xtwh/yh/mainframe.jsp?modul_id=xt_000001"  target="_blank">
<area shape="rect" coords="353,4,430,60" href="/emadmin/jsp/tree/mainframe.jsp?modul_id=jc_hpfl_treeModul"  target="_blank">
<area shape="rect" coords="451,3,508,61" href="/emadmin/jsp/dz/import_kc_xtcsh.jsp?modul_id=kc_kcqc_import_Modul"  target="_blank">
<area shape="rect" coords="537,3,598,61" href="/emadmin/jsp/xtwh/backup/backup.jsp?modul_id=backup_Mod"  target="_blank"></map></div>
</body>
</html>
