<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.lfbase.service.*,java.util.*,com.lf.util.*"%>
<%
	  String userInfo[]= (String[])session.getAttribute("userInfo"); 
      String nId="";
      if (userInfo==null||userInfo.length<1)
      {
         response.sendRedirect("/emadmin/shared/gotologin.jsp");
         return ;
      }
	  nId = userInfo[0];
	  String _productCode=Api.getXtPreferenceValueByName("productCode");
	  String xtMenu = Serve.getXtMenuString(request);
	  
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/emadmin/css/c1/style_new.css" rel="stylesheet" type="text/css">
<title></title>
<style>
BODY {
	MARGIN: 0px;
	margin-bottom: 0px;
	FONT-SIZE: 12px; 
	background-color: #d5e5f0; 
}
TD {

	FONT-SIZE: 12px;
	color:#3971aa;
	LINE-HEIGHT: 25px;
	
	text-decoration: none;
}
A:link {
	FONT-WEIGHT: normal;
	FONT-SIZE: 12px;
	COLOR:#3971aa;				/*没有点过的颜色*/
	FONT-STYLE: normal;
	FONT-FAMILY: "宋体";
	text-decoration: none;
	LINE-HEIGHT: 25px;
}
A:visited {
	FONT-WEIGHT: normal;
	FONT-SIZE: 12px;
	COLOR: #3971aa;
	FONT-STYLE: normal;
	FONT-FAMILY: "宋体";
	text-decoration: none;
	LINE-HEIGHT: 25px;
}
A:hover {
	FONT-WEIGHT: normal;
	FONT-SIZE: 12px;
	COLOR:green;
	FONT-STYLE: normal;
	FONT-FAMILY: "宋体";
	text-decoration: none;
	LINE-HEIGHT: 25px;
}
.left_tree_head_bg {
	background-image: url(/emadmin/images/c1/left_tree_head_bg.jpg);
	background-repeat: repeat-x;
	background-position: left top;
	height:23px;
	LINE-HEIGHT: 25px;
}


</style>

<!-- NO CHANGES PAST THIS LINE -->


<!-- Code for browser detection -->
<script src="/emadmin/shared/treeview/js/ua.js"></script>

<!-- Infrastructure code for the tree -->
<script src="/emadmin/shared/treeview/js/treecontrol.js"></script>
<script LANGUAGE="javascript">
<!--

// You can find instructions for this file here:
// http://www.treeview.net

// Decide if the names are links or just the icons
USETEXTLINKS = 1  //replace 0 with 1 for hyperlinks
USEFRAMES= 1
// Decide if the tree is to start all open or just showing the root folders
STARTALLOPEN = 0 //replace 0 with 1 to show the whole tree

ICONPATH = "/emadmin/shared/treeview/skin/original/" //change if the gif's folder is a subfolder, for example: 'images/'

<%=xtMenu%>
//如果是库存简单版
<%if(_productCode.equals("kcs")){%>
	<% if (!Util.isBlankString(xtMenu) && xtMenu.indexOf("入库单列表")>0) { %>
			top.menu_rkd.style.display="";
	 <%}%>
	<% if (!Util.isBlankString(xtMenu) && xtMenu.indexOf("出库单列表")>0) { %>
			top.menu_ckd.style.display="";
	 <%}%>
	 <% if (!Util.isBlankString(xtMenu) && xtMenu.indexOf("库存实存数")>0) { %>
			top.menu_kcscs.style.display="";
	 <%}%>
	 <% if (!Util.isBlankString(xtMenu) && xtMenu.indexOf("库存明细账")>0) { %>
			top.menu_kcmxz.style.display="";
	 <%}%>
	 <% if (!Util.isBlankString(xtMenu) && xtMenu.indexOf("收发存汇总表")>0) { %>
			top.menu_kcsfc.style.display="";
	 <%}%>	 
	 <% if (!Util.isBlankString(xtMenu) && xtMenu.indexOf("货品档案")>0) { %>
			top.menu_chda.style.display="";
	 <%}%>	 
<%}else{%>
	<% if (!Util.isBlankString(xtMenu) && xtMenu.indexOf("客户管理")>0) { %>
			top.menu_khgl.style.display="";
	 <%}%>
	<% if (!Util.isBlankString(xtMenu) && xtMenu.indexOf("采购管理")>0) { %>
			top.menu_cggl.style.display="";
	 <%}%>
	<% if (!Util.isBlankString(xtMenu) && xtMenu.indexOf("销售管理")>0) { %>
			top.menu_xsgl.style.display="";
	 <%}%>
	<% if (!Util.isBlankString(xtMenu) && xtMenu.indexOf("库存管理")>0) { %>
			top.menu_kcgl.style.display="";
	<%}%>
	<% if (!Util.isBlankString(xtMenu) && xtMenu.indexOf("财务管理")>0) { %>
			top.menu_cwgl.style.display="";
	 <%}%>
	<% if (!Util.isBlankString(xtMenu) && xtMenu.indexOf("智能搜索")>0) { %>
			top.menu_znss.style.display="";
	 <%}%>
 <%}%>
function doAlert(message){//触发短消息
		eval(unescape(message));
		window.parent.alertMessage.value="";
		document.getElementById('menu_dxxs').innerHTML="<img src='/emadmin/images/c3/tree_top_message_m.gif' border='0'>&nbsp;<font class='tree_font'>您没有新短消息</font>";
	}
//-->
</script>


</head>

<body onload="document.getElementById('folder0').style.display='none'">
<table width="100%" border ="0" cellpadding="0" cellspacing="0">
		<tr>
			<td class="x_tree_top_left">
				&nbsp;
			</td>
			<td class="x_tree_top_middle">&nbsp;
				<span id="menu_dxxs" style="width:68">
					 <%if(Api.getXtPreferenceValueByName("is_support_warning").equals("1")){%>
					<img src="/emadmin/images/c3/tree_top_message_m.gif">
					<font class="tree_font">您没有新短消息</font>
					<%}%>
				</span>
			</td>
			<td class="x_tree_top_right">
				&nbsp;
			</td>
		</tr>
	</table>
	<!--表头显示-->
<table width="94%" border="0" cellspacing="0" cellpadding="0" style="margin-left: 8px;" style="padding-top:0px;">
	 <tr>
    <td class="tree_bg_top_left">&nbsp;</td>
    <td class="tree_bg_top_center" >&nbsp;</td>
	<td class="tree_bg_top_right" >&nbsp;</td>
  </tr>
</table>
<!--操作菜单开始显示-->

<table width="94%" height="100%" border="0" cellspacing="0" cellpadding="0" style="margin-left: 8px;">
	 <tr>
    <td class="tree_bg_left"></td>
    <td style="padding-left:0px;">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" style="position:relative;top:0;left:20;margin-top:-1px;margin-bottom:0px" bgcolor="#eaf2f8">

      <tr height="1400" valign="top">
        <td ><!-- By making any changes to this code you are violating your user agreement.
     Corporate users or any others that want to remove the link should check 
	 the online FAQ for instructions on how to obtain a version without the link -->
            <!-- Removing this link will make the script stop from working -->
            <div style="position:absolute; top:0; left:0; ">
              <table border=0>
                <tr>
                  <td ><font size=-2><a style="font-size:7pt;text-decoration:none;color:silver" href="http://www.treemenu.net/" target=_blank></a></font></td>
                </tr>
              </table>
            </div>
          <!-- Build the browser's objects and display default view of the 
     tree. -->
            <script>initializeDocument()</script>
            <noscript>
            </noscript>
        </td>
      </tr>
    </table></td>
	<td class="tree_bg_right"></td>
  </tr>
</table>
</body>
</html>
