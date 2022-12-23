<%@page contentType="text/html;charset=utf-8" %>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*" %>
<%
      
      response.setHeader("Pragma","No-cache"); 
      response.setHeader("Cache-Control","no-cache"); 
      response.setDateHeader("Expires", 0); 
		   
%>
<html>
<head>
<title>添加单品码</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="/emadmin/css/c1/style_new.css">
<STYLE TYPE="text/css">
	td{padding-left:10px;}
	tr{
	background-color:expression('#ECF5FF,white'.split(',')[rowIndex%2]);
}
	.tr{
		background-color:white;
	}
	.tr1{
		background-color:#91c3fa;
	}
</STYLE>
</head>

<body  onload="init()">
	<table width="100%">
		<tr class="tr">
		<td width="230px;" align="right"><input type="hidden"  id="theValue"  value="">
		<font color='#60a9d8'>单品码：</font><input type="text" id="tm" value="" style="border:1px solid #51c1ff;"></td>
		<td width="60px;"><a href='#'><img src="/emadmin/images/c2/button/add.png" onclick="add()" border='0'></a></td>
		<td width="150px;"><font color='#60a9d8'>货品数量:</font><span id='hpsl' style="color:red;font-size:18px;font-weight:bold;"></span></td>
		<td ><font color='#60a9d8'>单品码数量:</font><span id='dpmsl' style="color:blue;font-size:18px;font-weight:bold;"></span></td>
		<td align="right" width="40px;"><a href='#'><img src="/emadmin/images/c2/button/bill_back.gif" onclick="doOK()" border='0'></a></td>
	</tr>
	</table>
    <table id="tmTable" style="BORDER-COLLAPSE: collapse" borderColor=#51c1ff cellSpacing=0 cellPadding=0 width="99%" border=1 align=center>
		<tr class="tr1">
				<td width="100px;" align="center">行号</td>
				<td style="padding-left:10px;">条码</td>
				<td  width="60px;" align="center">操作</td>
		</tr>
	</table>
</body>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
	function init() {
			theValue.value=window.dialogArguments[0];
			document.getElementById('hpsl').innerHTML=window.dialogArguments[1];
			show();
	}
	function show() {
			tmString=theValue.value;
			var tmArry=tmString.split(",");
			for (i=tmTable.rows.length-1;i>0;i-- ) {
				tmTable.deleteRow(i);
			}
			document.getElementById('dpmsl').innerHTML="0";
			for (i=0;i<tmArry.length;i++ ) {
		
				if (tmArry[i] !="") {
					tr = tmTable.insertRow(tmTable.rows.length);
					td=tr.insertCell(0);
					td.align="center";
					td.innerHTML=(i+1);
					td=tr.insertCell(1);
					td.innerHTML=tmArry[i];
					td=tr.insertCell(2);
					td.innerHTML="<a href='#'><img src='/emadmin/images/c2/button/a_delete.gif'  onclick='deleterow(\""+tmArry[i]+"\")' border='0'></a>";
					document.getElementById('dpmsl').innerHTML=parseInt(document.getElementById('dpmsl').innerHTML)+1;
				}
			}
			//开始生成行
	}
	function add() {
				var is_add=false;
				if((theValue.value+',').indexOf(tm.value+',')==-1)
				{
					if (theValue.value.length=="") {
						theValue.value=tm.value;
					} else {
						theValue.value=theValue.value+','+tm.value;
					}
					show();
					is_add=true;
				}
				if(theValue.value.indexOf(tm.value)!=-1&&tm.value.length!=0&&!is_add){
					alert('已经存在单品码为['+tm.value+']的记录,请确认！');
				}
				tm.value="";
				tm.focus();
		}
	function deleterow(tm) {
				if (theValue.value==tm) {
					theValue.value="";
				} else if (theValue.value.indexOf(tm+',')>=0) {
						temp=theValue.value;
						theValue.value=temp.replace(tm+',','');
				} else if (theValue.value.indexOf(','+tm)>=0) {
						temp=theValue.value;
						theValue.value=temp.replace(','+tm,'');
				}
				show();
		}
    // 取消操作
	function doCancel() {
			window.returnValue = false;
			window.close();
	}
	//确定
	function doOK() {
		if(document.getElementById('dpmsl').innerHTML!=document.getElementById('hpsl').innerHTML)
		{
			if(!confirm("当前的【单品码数量】和【货品数量】不符,确定您的操作吗？")) return;
		}
		window.returnValue = true;
		window.dialogArguments[0] = theValue.value;
		window.close();
	}
    //新增条码回车自动添加
	tm.onkeydown= function(){ _onAddInput() };
	function _onAddInput (){
		 if (event.keyCode==13) {   //回车
				add();
                return;
		}
	}
	//热键：ctl+s确定 esc 取消
	document.onkeydown = function(){ _onDocumenthotkey() };
	 function _onDocumenthotkey (){
		 if (event.keyCode==83 &&   event.ctrlKey) {   //回车
				 doOK();
                return;
		 }
		 if (event.keyCode==27) {   //或者 Escape
				doCancel();
				return;
		 }

	}
    //-->
</SCRIPT> 
</HTML>