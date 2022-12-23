<%@page contentType="text/html;charset=UTF-8" %>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<script language="JavaScript">
<!--

function doInit() {
    
	if (window.dialogArguments != null && window.dialogArguments.old_file_name!="") {
		form1.old_file_name.value=window.dialogArguments.old_file_name;
    }
    window.returnValue = false;
}

function doOK(title,new_name) {
    window.returnValue = true;
    if (window.returnValue == true && window.dialogArguments != null) {
        window.dialogArguments.title =title;
        window.dialogArguments.new_name =new_name;
	}
	window.close();
}
function doCancel() {
    window.returnValue = false;
    window.close();
}

//-->
</script>
<%
		 if( request.getMethod().equalsIgnoreCase("post") )
         {

			 //处理提交的图片 String [] result=Upload.do(request);  //0:title  1:new_name
			 String [] result=new String[2];
			 result = Serve.uploadFile( request );


			 //result[0]="很好";
			 //result[1]="1.jpg";
			 if (result==null||result.length != 2) {
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
						doOK("<%=result[0]%>","<%=result[1]%>");
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
                var str = document.getElementsByName('file1')[0].value;
				
				var str2=str.toLowerCase(); 
				
				if (str2.indexOf(".jsp")>0){alert("不允许上传jsp类型文件！");return;}
				if (str2.indexOf(".ocx")>0){alert("不允许上传ocx类型文件！");return;}
				if (str2.indexOf(".war")>0){alert("不允许上传war类型文件！");return;}
				if (str2.indexOf(".js")>0){alert("不允许上传js类型文件！");return;}
				if (str2.indexOf(".dll")>0){alert("不允许上传dll类型文件！");return;}
				if (str2.indexOf(".exe")>0){alert("不允许上传exe类型文件！");return;}
				if (str2.indexOf(".com")>0){alert("不允许上传com类型文件！");return;}				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
   //-->
</SCRIPT>

<% 		 if( !request.getMethod().equalsIgnoreCase("post") ) { %>
<html>
<head>
<title>选择上传的文件</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/emadmin/shared/headres.jsp"%>
</head>

<BODY TOPMARGIN=0 LEFTMARGIN=0 BGPROPERTIES="FIXED"  LINK="#000000" VLINK="#808080" ALINK="#000000" >
<table width="100%"  border="0" align="center">
  <tr>
    <td align="center" valign="middle">
	<form name="form1" method="post" action=""  enctype="multipart/form-data" ><br/><br/>
     <div>请选择上传的文件：<input type=file name=file1></div>
     <input type=hidden name="old_file_name">
      <br>
							  	<div align="center" id="_button_area" style="display:block"><img src="/emadmin/images/c2/button/bill_save.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form1)"/></div>
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
