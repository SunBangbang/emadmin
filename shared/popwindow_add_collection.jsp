<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*" %>
<%  if(session.getAttribute("userId")==null)  { %>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
		window.returnValue = false;
		window.dialogArguments.relogin=1;
		window.dialogArguments.url='/emadmin/index.jsp';
		window.close();
	//-->
	</SCRIPT>
<%}%>
<%



		String userid =(String) session.getAttribute("userId");

%>

<html>
<head>
<title>添加到常用查询</title>
<%@include file="/emadmin/shared/headres.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Pragma" content="no-cache">
</head>


<BODY>
<table width="100%"  border="0" align="center">
  <tr>
    <td align="center" valign="middle">
	<form name='form1' >	
		
      <table width="100%"  border="0" cellspacing="0" cellpadding="0">

		<input type="hidden" name="userid" value="<%=userid%>" >

		<tr>
		<td  align="left">&nbsp;&nbsp;&nbsp;</td>

		  <td width="15" height="30">&nbsp;</td>
		</tr>

		<tr>
		<td  align="left" nowrap>&nbsp;&nbsp;&nbsp;常用查询标题：
		<input type="text" name="filter_title" value=""  regName=";常用查询标题" reg = "_r_" class="x_bill_item_input_sub"></td>
		</tr>

        <tr>

		<td  align="left">&nbsp;&nbsp;&nbsp;<input type="checkbox" name="is_hot" value="1" >热点搜索</td>
		</tr>

        <tr>
		<%  if(userid.equalsIgnoreCase("admin"))  { %>
			<td align="left">&nbsp;&nbsp;&nbsp;<input type="checkbox" name="is_share" value="1" >是否他人共享</td>

		<%}%>

		</tr>
		<tr>
		<td  align="left">&nbsp;&nbsp;&nbsp;</td>
		</tr>
        <tr>
          <td height="30" align="center">&nbsp;&nbsp;&nbsp;<img src="/emadmin/images/c2/button/pop_ok.gif" onMouseOver="this.style.cursor='hand'"   onClick="doOK();"/>&nbsp;<img src="/emadmin/images/c2/button/pop_cancel.gif" onMouseOver="this.style.cursor='hand'"   onClick="doCancel();"/></td>
       
        </tr>
      </table>

	</form>	
	</td>
  </tr>
</table>
</BODY>
<script language="JavaScript">
<!--


function doOK() {

	if( doCheck( document.form1 ) )	
	{

		window.returnValue = true;
		if (window.returnValue == true && window.dialogArguments != null) {

			window.dialogArguments.collection_title =form1.filter_title.value;

			if (document.getElementsByName( 'is_hot')[0].checked == true)
				window.dialogArguments.is_hot ='1';
			else
				window.dialogArguments.is_hot ='0';

			


			if (form1.userid.value == 'admin'){
				if (document.getElementsByName( 'is_share')[0].checked == true){
					window.dialogArguments.is_share ='1';
					}else{
					window.dialogArguments.is_share ='0';
				}
				}else{
					window.dialogArguments.is_share ='0';
			}
			

			
		}
		

		window.close();
	}

}

function doCancel() {
		window.returnValue = false;
		window.close();
}




//-->
</script>

</HTML>