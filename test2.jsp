<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.product.*,java.util.*"%>
<% 
%>

<html>
<head>
<style  type="text/css">
	.x_dr_table_tr_yes {
		background:#0000ff;
	}
	.x_dr_table_tr_no {
		background:#ffffff;
	}
</style>

</head>

<script language="javascript" type="text/javascript">
	var _dr_store_xm=new Array();
	_dr_store_xm[0]="1";
	_dr_store_xm[1]="内容1";
	_dr_store_xm[2]="2";
	_dr_store_xm[3]="内容2";
	_dr_store_xm[4]="3";
	_dr_store_xm[5]="内容3";
	_dr_store_xm[6]="4";
	_dr_store_xm[7]="内容4";
	_dr_store_xm[8]="5";
	_dr_store_xm[9]="内容5";
	
    var  _dr_store_xm_input="";
	function _dr_down(myinputName,_dr_divName,_dr_tableName,modul_id) {
		myinput=document.getElementById(myinputName);
		_dr_div=document.getElementById(_dr_divName);
		_dr_table=document.getElementById(_dr_tableName);
		xxx.value+=(event.keyCode)+" | ";
		//下箭头 40
		//上箭头 38
		
		if ( (event.keyCode>=48 && event.keyCode<=90)	
			|| (event.keyCode>=186 && event.keyCode<=192)	
			|| (event.keyCode>=219 && event.keyCode<=222)	
		){
			 _dr_store_xm_input=myinput.value;
		}else if(event.keyCode==8){  //如果是退格
			_dr_div.style.display="none";
		}else if(event.keyCode==9){  //如果是Tab   则隐藏下拉 
			_dr_div.style.display="none";
		}else if (event.keyCode==27) {   //或者 Escape
			_dr_div.style.display="none";
			 _dr_store_xm_input="";
			xm.value="";
			xm_dr_id.value="";

		} else if (event.keyCode==40)	{ //如果是下箭头
			//如果下拉是隐藏的，则显示
			if (_dr_div.style.display=="none")	 _dr_div.style.display="";
			//通过循环将已选中的行下移一行
			var find=-1;
			for (i=0;i<_dr_table.rows.length;i++)    {
				if (_dr_table.rows.item(i).className=="dr_table_tr_yes")   {
					find=i;
					_dr_table.rows.item(i).className="dr_table_tr_no";
				}
			}
			//如果是最后一行，则重新恢复刚录入的值
			if (find+1==_dr_table.rows.length)	{
				xm.value=_dr_store_xm_input;
				xm_dr_id.value="";
			}
			//把find的下一行，置为选中,如果到了最后一行，则忽略
			if (find+1<_dr_table.rows.length)	{
				_dr_table.rows.item(find+1).className="dr_table_tr_yes";
				xm.value=_dr_store_xm[(find+1)*2+1];
				xm_dr_id.value=_dr_store_xm[(find+1)*2];
			}
			return;
		} else if (event.keyCode==38)	{ //如果是下箭头
			//如果下拉是隐藏的，则显示
			if (_dr_div.style.display=="none")	 _dr_div.style.display="";
			//通过循环将已选中的行下移一行
			var find=_dr_table.rows.length;
			for (i=0;i<_dr_table.rows.length;i++)    {
				if (_dr_table.rows.item(i).className=="dr_table_tr_yes")   {
					find=i;
					_dr_table.rows.item(i).className="dr_table_tr_no";
				}
			}
			//如果是第一行，则重新恢复刚录入的值
			if (find-1==-1)	{
				xm.value=_dr_store_xm_input;
				xm_dr_id.value="";
			}
			//把find的下一行，置为选中,如果到了最后一行，则忽略
			if (find-1>-1)	{
				_dr_table.rows.item(find-1).className="dr_table_tr_yes";
				xm.value=_dr_store_xm[(find-1)*2+1];
				xm_dr_id.value=_dr_store_xm[(find-1)*2];
			}
			return;
		}
	 }
	 function _dr_click(myinputName,_dr_divName,_dr_tableName,rowNumber) {
		myinput=document.getElementById(myinputName);
		_dr_div=document.getElementById(_dr_divName);
		_dr_table=document.getElementById(_dr_tableName);
	
		xm.value=_dr_store_xm[rowNumber*2+1];
		xm_dr_id.value=_dr_store_xm[rowNumber*2];
		_dr_div.style.display="none";
		myinput.focus();
		myinput.value=myinput.value;
	 }

</script>
<body>

<input name='xm' value='' onkeyUp='_dr_down("xm","_dr_div_xm","_dr_table_xm")'>
<input name='xm_dr_id' value='' >
<div id='_dr_div_xm' style='display:;width:358px;top:28px'>
	<table id='_dr_table_xm' cellspacing='0' cellpadding='0'>
			<tr class='dr_table_tr_no' onMouseOver="this.className='dr_table_tr_yes'"  onMouseOut="this.className='dr_table_tr_no'" onclick='_dr_click("xm","_dr_div_xm","_dr_table_xm",0)'><td >内容1<input type=hidden  id="_dr_tr_input_xm_0" value='内容1'><input type=hidden  id="_dr_tr_input_id_xm_0" value='1'></td></tr>
			<tr class='dr_table_tr_no' onMouseOver="this.className='dr_table_tr_yes'"  onMouseOut="this.className='dr_table_tr_no'" onclick='_dr_click("xm","_dr_div_xm","_dr_table_xm",1)'><td >内容2</td></tr>
			<tr class='dr_table_tr_no' onMouseOver="this.className='dr_table_tr_yes'"  onMouseOut="this.className='dr_table_tr_no'" onclick='_dr_click("xm","_dr_div_xm","_dr_table_xm",2)'><td>内容3</td></tr>
			<tr class='dr_table_tr_no' onMouseOver="this.className='dr_table_tr_yes'"  onMouseOut="this.className='dr_table_tr_no'" onclick='_dr_click("xm","_dr_div_xm","_dr_table_xm",3)'><td>内容4</td></tr>
			<tr class='dr_table_tr_no' onMouseOver="this.className='dr_table_tr_yes'"  onMouseOut="this.className='dr_table_tr_no'" onclick='_dr_click("xm","_dr_div_xm","_dr_table_xm",4)'><td>内容5</td></tr>
	</table>
	<textarea name=xxx rows='10' cols='70'></textarea>
</div>
</body></html>

 

  


 
