<%@page contentType="text/html;charset=UTF-8" %>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*" %>
<%
      
      response.setHeader("Pragma","No-cache"); 
      response.setHeader("Cache-Control","no-cache"); 
      response.setDateHeader("Expires", 0); 
      String popResult[]  = new String[2];
	  
      popResult = Serve.getPopResult( request );
		   
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="/emadmin/css/c1/style_new.css">
<script language=javascript src="/emadmin/js/do_check.js"></script>
<script language=javascript src="/emadmin/js/pop_selections.js"></script>
<script language=javascript src="/emadmin/js/bi_sub_table.js"></script>
<script language=javascript src="/emadmin/js/print.js"></script>
<script language=javascript src="/emadmin/js/do_user_select_item.js"></script>
<script language=javascript src="/emadmin/js/pop_upload.js"></script>
<script language=javascript src="/emadmin/js/common.js"></script>
</head>

<BODY >
<%=popResult[0]%>  
      <br/>
      <table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="10%" height="50">&nbsp;</td>
          <td height="20%" align="center"><img src="/emadmin/images/c2/button/pop_ok.gif" onMouseOver="this.style.cursor='hand'"   onClick="doOK();"/></td>
          <td height="20%" align="center"><img src="/emadmin/images/c2/button/pop_clear.gif" onMouseOver="this.style.cursor='hand'"   onClick="doClearSelect();"/></td>
          <td height="20%" align="center"><img src="/emadmin/images/c2/button/pop_cancel.gif" onMouseOver="this.style.cursor='hand'"   onClick="doCancel();"/></td>
          <td height="20%" align="center">&nbsp;</td>
          <td width="10%" >&nbsp;</td>
        </tr>
      </table></td>
  </tr>
<%--=pb.resultCols--%>
</BODY>

<%=popResult[1]%> 

<script language="JavaScript">
<!--
String.prototype.replaceAll = replaceAll;

function replaceAll(oldText,replaceText){
regExp = new RegExp(oldText,"g");//g 全局
return this.replace(regExp ,replaceText)
}
function multiOptionSetSelect() {
	
}
function doInit() {
	if(clicked_index != -1 )
	    document.getElementById('_tr_' + clicked_index).style.backgroundColor="#FFCCCC";
	document.body.focus();
	form1.keywords.focus();
    form1.keywords.value=form1.keywords.value;
}
function doOK() {
    window.returnValue = true;
	if ((clicked_index)==-1) window.returnValue = false;
    if (window.returnValue == true && window.dialogArguments != null) {
		myValues[clicked_index][1]=myValues[clicked_index][1].replaceAll("#@","\n");
		window.dialogArguments[0] = myValues[clicked_index];
	}
    window.close();
}

<%=popResult[3]%>

function doClearSelect() {
    if ( window.dialogArguments != null && myValues != null) {
		if(myValues.length==0)
		{
			myValues= new Array(1);
			myValues[0] = new Array(pop_col_num);
		}

		window.returnValue = true;

		for (var i = 0; i < pop_col_num; i++) 
		{
			myValues[0][i] = ''
		}		

		window.dialogArguments[0] = myValues[0];
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
         selectedTr.className="x_pop_list_result_tr";
    tr.className="x_pop_list_result_tr_selected";
    clicked_index = tr.rowIndex - 1;
}
-->
</script>
<script>
     doInit();
     function _do_submit() {
				if (event.keyCode==32){ 
			        form1.submit();
		    }

	  }

	 document.onkeydown = function(){ _hotkey() };
	 function _hotkey (){
		 if	(event.keyCode==40) {  //下箭头
				_move_row_down() ;
				return;
		 }
		 if	(event.keyCode==38) {  //上箭头
				_move_row_up() ;
				return;
		 }
		 if (event.keyCode==13) {   //回车
				_key_do_enter();
                return;
		 }
		// if(event.keyCode==46){  //如果是删除
		//		doClearSelect();
		//		return;
		// }
		 if (event.keyCode==27) {   //或者 Escape
				doCancel();
				return;
		 }
		 if (event.keyCode==33 || event.keyCode==37) {   //pageup  或者 左箭头
            if (document.getElementsByName("_page_prepage_link").length>0) {
               link=_page_prepage_link.value;
               if (link!="") location.href=link;
            }
		 }
		 if (event.keyCode==34 || event.keyCode==39) {   //pageup  或者 左箭头
            if (document.getElementsByName("_page_nextpage_link").length>0) {
               link=_page_nextpage_link.value;
               if (link!="") location.href=link;
            }
		 }
	 }
	 function _key_do_enter (){
			_dr_table=document.getElementById("_result_table");
	 				//首先判断是否选中
				find=0;
                var tr;
				for (i=1;i<_dr_table.rows.length;i++) {
					if (_dr_table.rows.item(i).className=="x_pop_list_result_tr_selected")  {
									find=1;
                                    tr=_dr_table.rows.item(i);
									break;
					}
				}
				//如果找到，则返回
			if (find==1) {
                    selectrow(tr);
					doOK();
			}

	 }
	 function _move_row_down (){
			_dr_table=document.getElementById("_result_table");
			find=0;
			for (i=1;i<_dr_table.rows.length;i++) {
				if (_dr_table.rows.item(i).className=="x_pop_list_result_tr_selected")  {
						if (i==_dr_table.rows.length-1) {
								_dr_table.rows.item(1).className="x_pop_list_result_tr_selected";
								_dr_table.rows.item(i).className="x_pop_list_result_tr";
								find=1;
								break;
						} else {
								_dr_table.rows.item(i+1).className="x_pop_list_result_tr_selected";
								_dr_table.rows.item(i).className="x_pop_list_result_tr";
								find=1;
								break;
						}
				}
			}
			if (find==0) {
						_dr_table.rows.item(1).className="x_pop_list_result_tr_selected";
			}

	 }
	 function _move_row_up (){
			_dr_table=document.getElementById("_result_table");
			find=0;
			for (i=1;i<_dr_table.rows.length;i++) {
				if (_dr_table.rows.item(i).className=="x_pop_list_result_tr_selected")  {
						if (i==1) {
								_dr_table.rows.item(_dr_table.rows.length-1).className="x_pop_list_result_tr_selected";
								_dr_table.rows.item(1).className="x_pop_list_result_tr";
								find=1;
								break;
						} else {
								_dr_table.rows.item(i-1).className="x_pop_list_result_tr_selected";
								_dr_table.rows.item(i).className="x_pop_list_result_tr";
								find=1;
								break;
						}
				}
			}
			if (find==0) {
						_dr_table.rows.item(1).className="x_pop_list_result_tr_selected";
			}

	 }

</script>



</HTML>