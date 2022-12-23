<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*" %>
<%@include file="/emadmin/shared/checkPermission1.jsp"%>

<html>

<head>

<!-- if you want black backgound, remove this style block -->
<style>
   BODY {background-color: white;margin: 0px;padding: 0px;}
   TD {font-size: 12px; LINE-HEIGHT: 25px;
       font-family: verdana,helvetica; 
	   text-decoration: none;
	   white-space:nowrap;}
   A  {text-decoration: none;
       color: black}
   
    .specialClass {font-family:garamond; font-size:12pt;color:green;font-weight:bold;text-decoration:underline}
</style>


<!-- Code for browser detection -->
<script src="../treeview/js/ua.js"></script>

<!-- Infrastructure code for the tree -->
<script src="../treeview/js/treecontrol.js"></script>
<script src="../treeview/js/treeopen.js"></script>
<script LANGUAGE="javascript">

<!--

// You can find instructions for this file here:
// http://www.treeview.net

// Decide if the names are links or just the icons
USETEXTLINKS = 1  //replace 0 with 1 for hyperlinks

// Decide if the tree is to start all open or just showing the root folders
STARTALLOPEN = 0 //replace 0 with 1 to show the whole tree
HIGHLIGHT = 1

ICONPATH = "../treeview/skin/original/" //change if the gif's folder is a subfolder, for example: 'images/'




    <%=ForumService.getTreeViewScriptForWeb(request)%>

//-->
</script>



</head>

<body >
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
     <td height="28" align="left" nowrap style="background-image: url(/emadmin/images/c3/jsb.gif); background-repeat: repeat-x; ">&nbsp;</td>      
	 </tr>
</table>
<div style="position:absolute; top:0; left:3px;; "><table border=0><tr><td><font size=-2><a style="font-size:7pt;text-decoration:none;color:silver" href="http://www.treemenu.net/" target=_blank></a></font></td></tr></table></div>

<!-- Build the browser's objects and display default view of the 
     tree. -->
<script>initializeDocument()</script>
<noscript>

</noscript>

</html>
