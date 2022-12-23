<%@page contentType="text/html;charset=UTF-8" %>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<script language="JavaScript">
<!--

function doInit() {
    
	if (window.dialogArguments != null && window.dialogArguments.filtertemplateid!="") {
		form1.filtertemplateid.value=window.dialogArguments.filtertemplateid;
    }
    window.returnValue = false;
}

function doOK(filtertemplateid) {
    window.returnValue = true;
    if (window.returnValue == true && window.dialogArguments != null) {
        window.dialogArguments.filtertemplateid =filtertemplateid;
	}
	window.close();
}
function doCancel() {
    window.returnValue = false;
    window.close();
}

//-->
</script>

<script language="JavaScript" type="text/javascript">
<!--
//使表格行上移，接收参数为链接对象
function moveUp(_a){
 //通过链接对象获取表格行的引用
 var _row=_a.parentNode.parentNode;
 //如果不是第一行，则与上一行交换顺序
 if(_row.previousSibling)swapNode(_row,_row.previousSibling);
}
//使表格行下移，接收参数为链接对象
function moveDown(_a){
 //通过链接对象获取表格行的引用
 var _row=_a.parentNode.parentNode;
 //如果不是最后一行，则与下一行交换顺序
 if(_row.nextSibling)swapNode(_row,_row.nextSibling);
}
//定义通用的函数交换两个结点的位置
function swapNode(node1,node2){

	var nextvalue = node2.cells[1].childNodes[0].value;

	node2.cells[1].childNodes[0].value = node1.cells[1].childNodes[0].value;
	node1.cells[1].childNodes[0].value = nextvalue;
		



 //获取父结点
 var _parent=node1.parentNode;
 //获取两个结点的相对位置
 var _t1=node1.nextSibling;
 var _t2=node2.nextSibling;
 //将node2插入到原来node1的位置
 if(_t1)_parent.insertBefore(node2,_t1);
 else _parent.appendChild(node2);
 //将node1插入到原来node2的位置
 if(_t2)_parent.insertBefore(node1,_t2);
 else _parent.appendChild(node1);
}
//-->
</script>




<%
		 if( request.getMethod().equalsIgnoreCase("post") )
         {

			 String  result= Serve.saveNewFilterSetTemplate( request );


			 //result[0]="很好";
			 //result[1]="1.jpg";
			 if (result==null || result=="") {
				 %>
					<script language="JavaScript">
					<!--
						doCancel();
					//-->
					</script>
			      <%
			 } else {
				 %>
					<script language="JavaScript">
					<!--
						doOK("<%=result%>");
					//-->
					</script>
			      <%

			 }
         }
%>

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

<% 		 if( !request.getMethod().equalsIgnoreCase("post") ) { %>
<html>
<head>
<title>选择过滤项目</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/emadmin/shared/headres.jsp"%>
</head>

<BODY TOPMARGIN=0 LEFTMARGIN=0 BGPROPERTIES="FIXED"  LINK="#000000" VLINK="#808080" ALINK="#000000" >
<table width="100%"  border="0" align="center">
  <tr>
    <td align="center" valign="middle">
	<form name="form1" method="post" action=""  ><br/><br/>
     <div><%=Serve.getFilterSetTemplateJsp( request )%></div>
      <br>
                            <div align="center" id="_button_area" style="display:block; padding-top:10px;vertical-align:bottom;">
								<img src="/emadmin/images/c2/button/bill_save.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form1)"/> &nbsp;&nbsp;&nbsp;&nbsp;
                                    <img src="/emadmin/images/c2/button/bill_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='doCancel()'/> 
                                </div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
    </form></td>
  </tr>
</table>
					<script language="JavaScript">
					<!--
						doInit();
					//-->
					</script>
</BODY>
</HTML>
<%}%>
