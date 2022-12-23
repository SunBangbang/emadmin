<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/emadmin/shared/checkPermission1.jsp"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*"%>
<%
	  String nId =request.getParameter("nid");
	  
	  String treeResult="";
     try
	 {
		  treeResult = Serve.getYhBmTreeleft( request );
  
	 }
	 catch( SQLException sqle)
	 {
		  // System.out.println("SQL State :" + sqle.getSQLState());
		  // System.out.println("Error Code :" + sqle.getErrorCode());
		  sqle.printStackTrace();
          response.sendRedirect("/emadmin/shared/usererror.jsp?id=error102");
		  return ;
		  }
	 catch( Exception e)
	 {
		  e.printStackTrace();
          response.sendRedirect("/emadmin/shared/usererror.jsp?id=error102");
		  return ;
	 }
	  
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<!-- if you want black backgound, remove this style block -->
<style>
   TD {font-size: 10pt; 
       font-family: verdana,helvetica; 
	   text-decoration: none;
	   white-space:nowrap;}
   A  {text-decoration: none;
       color: black}
   
    .specialClass {font-family:garamond; font-size:12pt;color:green;font-weight:bold;text-decoration:underline}
</style>

<!-- if you want black backgound, remove this line and the one marked XXXX and keep the style block below 

<style>
   BODY {background-color: black}
   TD {font-size: 10pt; 
       font-family: verdana,helvetica 
	   text-decoration: none;
	   white-space:nowrap;}
   A  {text-decoration: none;
       color: white}
</style>

XXXX -->


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
STARTALLOPEN = 1 //replace 0 with 1 to show the whole tree

ICONPATH = "/emadmin/shared/treeview/skin/original/" //change if the gif's folder is a subfolder, for example: 'images/'


<%=treeResult%>


//-->
</script>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>

<body onload="document.getElementById('folder0').style.display='none'">
<!-- By making any changes to this code you are violating your user agreement.
     Corporate users or any others that want to remove the link should check 
	 the online FAQ for instructions on how to obtain a version without the link -->
<!-- Removing this link will make the script stop from working -->
<div style="position:absolute; top:0; left:0; "><table border=0><tr><td><font size=-2><a style="font-size:7pt;text-decoration:none;color:silver" href="http://www.treemenu.net/" target=_blank></a></font></td></tr></table></div>

<!-- Build the browser's objects and display default view of the 
     tree. -->
<script>initializeDocument()</script>
<noscript>

</noscript>


</body>
<SCRIPT language=JavaScript>
<!-- 
function openFolderInTree(linkID) 
{
	var folderObj;
	folderObj = findObj(linkID);
	folderObj.forceOpeningOfAncestorFolders();
	if (!folderObj.isOpen)
		clickOnNodeObj(folderObj);
}   
//-->
</SCRIPT>
<SCRIPT language=JavaScript>
<% if( nId != null && nId.trim().length() > 0 ){%>
   openFolderInTree("<%=nId%>");
<%}%>
</SCRIPT>
</html>
