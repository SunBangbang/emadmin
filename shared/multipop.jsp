<%@page contentType="text/html;charset=UTF-8" %>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*" %>
<%
      
      String popResult[]  = new String[2];
	  
      popResult = Serve.getMultiPopResult( request );
%>
<html>
<head>
<title>选择</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Pragma" content="no-cache">

<style type="text/css">
	td{font-size:12px; }
</style>
</head>

<BODY>
<%=popResult[0]%>

      <table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="30" align="right"><img src="/emadmin/images/c2/button/pop_ok.gif" onMouseOver="this.style.cursor='hand'"   onClick="doOK();"/></td>
          <td width="15" height="30">&nbsp;</td>
          <td height="30" align="left"><img src="/emadmin/images/c2/button/pop_cancel.gif" onMouseOver="this.style.cursor='hand'"   onClick="doCancel();"/></td>
        </tr>
      </table>
	</td>
  </tr>
</table>
<%--=pb.resultCols--%>
</BODY>

<%=popResult[1]%> 

<script language="JavaScript">
<!--

function selectAll0(sender)	  
{
	for(i=0; i<form1.alllinenum.value; i++)
	{
		document.getElementsByName( 'ln' + i )[0].checked = sender.checked;
	}
}

function abselectAll0(sender)	  
{
	for(i=0; i<form1.alllinenum.value; i++)
	{
		
		document.getElementsByName('ln' + i)[0].checked = !document.getElementsByName('ln' + i)[0].checked;

	}
}



function doOK() {
    window.returnValue = true;


    if (window.returnValue == true && window.dialogArguments != null) {

		var linenum = 0;
		
		for(i=0; i<form1.alllinenum.value; i++)
		{
			if (document.getElementsByName( 'ln' + i )[0].checked == true)
			{
				linenum = linenum + 1;
			}
			
		}

		//alert('linenum:'+linenum);

		var retValues= new Array(linenum * (pop_col_num-1) +1);

		//alert('retlength:'+ retValues.length);

		linenum = 0;
		for(i=0; i<form1.alllinenum.value; i++)
		{
			if (document.getElementsByName( 'ln' + i )[0].checked == true)
			{
				for (j=1;j<pop_col_num;j++)
				{
					retValues[linenum*(pop_col_num-1) +j] = myValues[i][j];
				}
				linenum = linenum + 1;
			}
			
		}
		
		retValues [0] = linenum;
		window.dialogArguments[0] = retValues;

		/*
		alert('retvalues');

		for (i=0;i<retValues [0];i++)
		{
			for (j=1;j<pop_col_num;j++)
			{
				alert (retValues[i*(pop_col_num-1) +j])	;
			}
		}


		alert('win_dialog');
		for (i=0;i<window.dialogArguments[0].length;i++)
		{
			alert (window.dialogArguments[0][i]);
		}
		*/

	}
    window.close();
}
function doCancel() {
		window.returnValue = false;
		window.close();
}
function selectrow( tr ){
    var selectedTr = document.getElementById('_tr_' + clicked_index);
    if( selectedTr != null )
         selectedTr.style.backgroundColor="#ffffff";
    tr.style.backgroundColor="#FFCCCC";
    clicked_index = tr.rowIndex - 1;
}
-->
</script>
</HTML>