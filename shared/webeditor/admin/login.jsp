<%@ page contentType="text/html;charset=gb2312" pageEncoding="GB2312" session="true"%>
<%request.setCharacterEncoding("GB2312");%>
<%@ page import="java.util.*,java.util.regex.*,java.text.*,java.io.*" %>
<%!
/*
*######################################
* eWebEditor v4.00 - Advanced online web based WYSIWYG HTML editor.
* Copyright (c) 2003-2007 eWebSoft.com
*
* For further information go to http://www.ewebsoft.com/
* This copyright notice MUST stay intact for use.
*######################################
*/


static String dealNull(String str) {
	String returnstr = null;
	if (str == null) {
		returnstr = "";
	} else {
		returnstr = str;
	}
	return returnstr;
}

static Object dealNull(Object obj) {
	Object returnstr = null;
	if (obj == null){
		returnstr = (Object) ("");
	}else{
		returnstr = obj;
    }
	return returnstr;
}

static String ReadFile(String s_FileName){
	String s_Result = "";
	try {
		java.io.File objFile;
		java.io.FileReader objFileReader;
		char[] chrBuffer = new char[10];
		int intLength;

		objFile = new java.io.File(s_FileName);

		if(objFile.exists()){
			objFileReader = new java.io.FileReader(objFile);
			while((intLength=objFileReader.read(chrBuffer))!=-1){
				s_Result += String.valueOf(chrBuffer,0,intLength);
			}
			objFileReader.close();
		}
	} catch(IOException e) {
		System.out.println(e.getMessage());
	}
	return s_Result;
}

static String getConfigString(String s_Key, String s_Config){
	String s_Result = "";
	Pattern p = Pattern.compile(s_Key + " = \\\"(\\S*)\\\";");
	Matcher m = p.matcher(s_Config);
	while (m.find()) {
		s_Result = m.group(1);
	}
	return s_Result;
}

%>
<%

String sAction = dealNull(request.getParameter("action")).toUpperCase();

if (sAction.equals("LOGIN")){
	String eWebEditorPath = request.getServletPath();
	eWebEditorPath = eWebEditorPath.substring(0, eWebEditorPath.lastIndexOf("/"));
	eWebEditorPath = eWebEditorPath.substring(0, eWebEditorPath.lastIndexOf("/"));
	eWebEditorPath = application.getRealPath(eWebEditorPath);
	String sFileSeparator = File.separator;
	if (eWebEditorPath.substring(eWebEditorPath.length()-1,eWebEditorPath.length()) != sFileSeparator){
		eWebEditorPath += sFileSeparator;
	}
	String sConfig = ReadFile(eWebEditorPath+"jsp"+sFileSeparator+"config.jsp");

	String sUsername = getConfigString("sUsername", sConfig);
	String sPassword = getConfigString("sPassword", sConfig);

	String s_Usr = dealNull(request.getParameter("usr"));
	String s_Pwd = dealNull(request.getParameter("pwd"));
	if (s_Usr.equals(sUsername) && s_Pwd.equals(sPassword)) {
		session.putValue("eWebEditor_User", "OK");
		response.sendRedirect("default.jsp");
		return;
	}
} else if (sAction.equals("OUT")){
	session.putValue("eWebEditor_User", "");
}

%>

<HTML>
<HEAD>
<TITLE>eWebEditor?????????? - ????????</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<style>
body,td,a,p,input{font-size:9pt}
body {margin:0px;background-color:#d9ddf7}
.c92 {FONT-SIZE: 9pt; COLOR: #003366; LINE-HEIGHT: 150%}
A:hover {COLOR: #ff9900}
A:link {COLOR: #003366}
.input {BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-BOTTOM: #000000 1px solid}
</style>

<SCRIPT language=JavaScript>
function checkForm(){
	var frm = document.loginform
	if(frm.usr.value == ""){
		alert('????????????????');
		frm.usr.focus();
		return false;
	}
	if(frm.pwd.value == ""){
		alert('??????????????????');
		frm.pwd.focus();
		return false;
	}
	frm.submit()
}
</SCRIPT>

</head>
<BODY onload=document.loginform.usr.focus()>
<BR><BR>
<TABLE cellSpacing=0 cellPadding=0 width=500 align=center border=0>
  <TBODY>
  <TR>
    <TD height=60></TD></TR></TBODY></TABLE>
<TABLE cellSpacing=0 cellPadding=0 width=732 align=center border=0>
  <TBODY>
  <TR>
    <TD colSpan=7><IMG height=1 alt="" src="images/spacer.gif" width=718></TD>
    <TD rowSpan=6>&nbsp; </TD>
    <TD><IMG height=1 alt="" src="images/spacer.gif" width=1></TD></TR>
  <TR>
    <TD vAlign=bottom colSpan=3 rowSpan=2><IMG height=201 alt="" src="images/2_10.gif" width=341></TD>
    <TD vAlign=bottom colSpan=2><IMG height=108 alt="" src="images/2_11.gif" width=295></TD>
    <TD colSpan=2>&nbsp; </TD>
    <TD><IMG height=110 alt="" src="images/spacer.gif" width=1></TD></TR>
  <TR>
    <TD background=images/1_12.gif colSpan=4>
      <TABLE cellSpacing=0 cellPadding=3 width="50%" border=0>
        <FORM onkeydown="if(event.keyCode==13) return checkForm()" name=loginform action="?action=login" method=post>
        <TBODY>
        <TR>
          <TD class=c92 width="24%">??????</TD>
          <TD width="76%"><INPUT class=input size=16 name=usr> </TD></TR>
        <TR>
          <TD class=c92 width="24%">??????</TD>
          <TD width="76%"><INPUT class=input type=password size=16 name=pwd> </TD></TR>
        <TR>
          <TD width="24%">&nbsp;</TD>
          <TD width="76%">
            <DIV align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<IMG style="CURSOR: hand" onclick="return checkForm()" src="images/login.gif" border=0> 
        </DIV></TD></TR></FORM></TBODY></TABLE></TD>
    <TD><IMG height=93 alt="" src="images/spacer.gif" width=1></TD></TR>
  <TR>
    <TD width=254 background=images/1_13.gif colSpan=2 height=161><TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR>
          <TD height=50></TD></TR>
        <TR>
          <TD align=right></TD></TR>
        <TR>
          <TD height=20></TD></TR>
        <TR>
          <TD align=right></TD></TR></TBODY></TABLE></TD>
    <TD width=387 background=images/1_14.gif colSpan=4 height=212 
    rowSpan=2></TD>
    <TD rowSpan=3><IMG height=242 alt="" src="images/spacer.gif" width=77></TD>
    <TD><IMG height=161 alt="" src="images/spacer.gif" width=1></TD></TR>
  <TR>
    <TD colSpan=2 rowSpan=2><IMG height=81 alt="" src="images/spacer.gif" width=254></TD>
    <TD><IMG height=51 alt="" src="images/spacer.gif" width=1></TD></TR>
  <TR>
    <TD colSpan=4><IMG height=30 alt="" src="images/spacer.gif" width=387></TD>
    <TD><IMG height=30 alt="" src="images/spacer.gif" width=1></TD></TR>
  <TR>
    <TD><IMG height=1 alt="" src="images/spacer.gif" width=195></TD>
    <TD><IMG height=1 alt="" src="images/spacer.gif" width=59></TD>
    <TD><IMG height=1 alt="" src="images/spacer.gif" width=87></TD>
    <TD><IMG height=1 alt="" src="images/spacer.gif" width=214></TD>
    <TD><IMG height=1 alt="" src="images/spacer.gif" width=81></TD>
    <TD><IMG height=1 alt="" src="images/spacer.gif" width=5></TD>
    <TD><IMG height=1 alt="" src="images/spacer.gif" width=77></TD>
    <TD><IMG height=1 alt="" src="images/spacer.gif" width=14></TD>
    <TD></TD></TR></TBODY></TABLE>
</BODY></HTML>
