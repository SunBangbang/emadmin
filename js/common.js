String.prototype.trim=function(){
　　 return this.replace(/(^\s*)|(\s*$)/g, "");
　　}
String.prototype.ltrim=function(){
　　 return this.replace(/(^\s*)/g,"");
　　}
String.prototype.rtrim=function(){
　　 return this.replace(/(\s*$)/g,"");
　　}

 
 
 var _current_tds; //用于存放一行所有td的原css名称
 function _highlight_row(currentRow)
  {
		_current_tds=new Array(currentRow.cells.length);
		for (i=0;i<currentRow.cells.length;i++) 
	    {
				_current_tds[i]=currentRow.cells.item(i).className;
				currentRow.cells.item(i).className="mouse_over_td";
		
		}
  }
 function _un_highlight_row(currentRow)
  {
		for (i=0;i<currentRow.cells.length;i++) 
	    {
				currentRow.cells.item(i).className=_current_tds[i];
		
		}
  }

 function _list_result_click_row(currentRow)
  {
		for (i=0;i<currentRow.cells.length;i++) 
	    {
			if (currentRow.cells.item(i).className=="mouse_over_td")
			{
				_un_highlight_row(currentRow);
			} else {
				_highlight_row(currentRow)
			}
 		}
 }




///关于ajax的工具

function getAjaxResult (myinputName, url) {
	var ajaxRequest= _xt_getajaxRequest ();
	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function(){
		if(ajaxRequest.readyState == 4){
            if(ajaxRequest.status==200){
                var rs=ajaxRequest.responseText;
				if (rs.indexOf("!!!#$NotFound#$!!!")>=0) {
					_dr_refresh(myinputName,Array(0)); 
				} else {
					var rs1=rs.trim();
					_dr_refresh(myinputName ,rs1.split("$^#"));
				}
            }
		}
	}
	ajaxRequest.open("GET", url, true);
	ajaxRequest.send(null); 
}

	var _dp_result_store;
	var _dp_input_store="";

	function _dr_down_next(myinputName) {
			 if(event.srcElement.tagName.toLowerCase()   ==   "textarea")   {   
                return   false;   
             }
			 if (event.keyCode==13)  event.keyCode=9;
			 if(event.keyCode==9 )  //如果是Tab   则隐藏下拉 
			  document.getElementById("_dr_div_"+myinputName).style.display="none";
	}
	function _dr_down(myinputName,modul_id) {
		myinput=document.getElementById(myinputName);
		myinput_dr_id=document.getElementById(myinputName+"_dr_id");
		_dr_div=document.getElementById("_dr_div_"+myinputName);
		_dr_table=document.getElementById("_dr_table_"+myinputName);
		//下箭头 40
		//上箭头 38
		if ( (event.keyCode>=48 && event.keyCode<=90)	
			|| (event.keyCode>=186 && event.keyCode<=192)	
			|| (event.keyCode>=219 && event.keyCode<=222 )	
		|| event.keyCode==32){ 
			//window.status=_dp_input_store+" | "+myinput.value;
			if (_dp_input_store!=myinput.value  && myinput.value!="") {
				_dr_div.style.left=myinput.getBoundingClientRect().left;
				_dr_div.style.top=myinput.getBoundingClientRect().top+20;
				_dr_div.style.width=myinput.getBoundingClientRect().right-myinput.getBoundingClientRect().left;
				 _dp_input_store=myinput.value;
				 //根据这个值，取出符合条件的纪录
				 getAjaxResult(myinputName,"/emadmin/shared/xt_getAjaxResultForInput.jsp?keywords="+encodeURIComponent(myinput.value)+"&modul_id="+modul_id+"&item_name="+myinputName);
			}
			
		}else if(event.keyCode==8){  //如果是退格
			_dr_div.style.display="none";
		}else if(event.keyCode==9 ){  //如果是Tab   则隐藏下拉 
			_dr_div.style.display="none";
		}else if(event.keyCode==13){  //如果是Tab   则隐藏下拉 
			_dr_div.style.display="none";
		}else if (event.keyCode==27) {   //或者 Escape
			_dr_div.style.display="none";
			 _dp_input_store="";
			myinput.value="";
			myinput_dr_id.value="";

		} else if (event.keyCode==40)	{ //如果是下箭头
			//如果下拉是隐藏的，则显示
			if (_dr_div.style.display=="none")	 _dr_div.style.display="";
			//通过循环将已选中的行下移一行
			var find=-1;
			for (i=0;i<_dr_table.rows.length;i++)    {
				if (_dr_table.rows.item(i).className=="x_dr_table_tr_yes")   {
					find=i;
					_dr_table.rows.item(i).className="x_dr_table_tr_no";
				}
			}
			//如果是最后一行，则重新恢复刚录入的值
			if (find+1==_dr_table.rows.length)	{
				myinput.value=_dp_input_store;
				myinput_dr_id.value="";
			}
			//把find的下一行，置为选中,如果到了最后一行，则忽略
			if (find+1<_dr_table.rows.length)	{
				_dr_table.rows.item(find+1).className="x_dr_table_tr_yes";
				find=find+1;
				myinput.value=_dp_result_store[find*2+1];
				myinput_dr_id.value=_dp_result_store[find*2];
			}
			return;
		} else if (event.keyCode==38)	{ //如果是上箭头
			//如果下拉是隐藏的，则显示
			if (_dr_div.style.display=="none")	 _dr_div.style.display="";
			//通过循环将已选中的行下移一行
			var find=_dr_table.rows.length;
			for (i=0;i<_dr_table.rows.length;i++)    {
				if (_dr_table.rows.item(i).className=="x_dr_table_tr_yes")   {
					find=i;
					_dr_table.rows.item(i).className="x_dr_table_tr_no";
				}
			}
			//如果是第一行，则重新恢复刚录入的值
			if (find-1==-1)	{
				myinput.value=_dp_input_store;
				myinput_dr_id.value="";
			}
			//把find的下一行，置为选中,如果到了最后一行，则忽略
			if (find-1>-1)	{
				_dr_table.rows.item(find-1).className="x_dr_table_tr_yes";
				find=find-1;
				myinput.value=_dp_result_store[find*2+1];
				myinput_dr_id.value=_dp_result_store[find*2];
			}
			return;
		}
	 }
	 function _dr_click(myinputName,rowNumber) {
		myinput=document.getElementById(myinputName);
		myinput_dr_id=document.getElementById(myinputName+"_dr_id");
		_dr_div=document.getElementById("_dr_div_"+myinputName);
		_dr_table=document.getElementById("_dr_table_"+myinputName);

		myinput.value=_dp_result_store[rowNumber*2+1];
		myinput_dr_id.value=_dp_result_store[rowNumber*2];
		_dr_div.style.display="none";
		myinput.focus();
		myinput.value=myinput.value;
	 }
	 function 	_dr_refresh(myinputName,result) {		 //
			_dp_result_store=result;
			_dr_div=document.getElementById("_dr_div_"+myinputName);
			_dr_table=document.getElementById("_dr_table_"+myinputName);
			for (i=0;i<_dr_table.rows.length;i++)  _dr_table.deleteRow(i);

			 if (_dp_result_store.length>0) {
				 //先清空
				//开始插入行
				var tr;
				var html="";
				for (i=0;i<_dp_result_store.length;i+=2 ) {
					//html="<tr class='x_dr_table_tr_no' onMouseOver=\"this.className='x_dr_table_tr_yes'\"  onMouseOut=\"this.className='x_dr_table_tr_no'\" onclick='_dr_click(\""+myinputName+"\","+i+")'><td nowrap>"+result[i]+"<input type=hidden  id='_dr_tr_input_"+myinputName+"_"+i+"' value='"+result[i]+"'><input type=hidden  id='_dr_tr_input_id_"+myinputName+"_"+i+"' value='"+result[i]+"'></td></tr>";
					html="<td nowrap>"+_dp_result_store[i+1]+"</td>";
					tr = _dr_table.insertRow(i/2);
					myfunc="_dr_click('"+myinputName+"',"+i/2+")";
					td=tr.insertCell(0);
					td.innerHTML=html;
					tr.onclick=  new  Function(myfunc);
					tr.onmouseover= function(){this.className='x_dr_table_tr_yes';};
					tr.onmouseout=    function(){this.className='x_dr_table_tr_no';};
				}
				//显示表格
				_dr_div.style.display="";
			 } else {
				 //隐藏表格
				_dr_div.style.display="none";
			 }

	}


/////////////////////////////  以上是智能匹配功能 ///////////////////////////////

//得到一个ajaxRequest对象，此方法为公用方法

function _xt_getajaxRequest () {
	var ajaxRequest;  //定义ajax对象
	var resultText;  //返回的结果
	
	try{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	} catch (e){
		// Internet Explorer Browsers
		try{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e){
				// Something went wrong
				return null;
			}
		}
	}
	return ajaxRequest; 
}

// 检查唯一性，如果有重复的，则把对象的背景变成红色

function _xt_check_unique(table,col,object) {
	if (object.type!='text')  return;
	if (object.value=='') {
		object.style.backgroundColor="#ffffff";
		return; 
	}
	var ajaxRequest= _xt_getajaxRequest ();
	url="/emadmin/shared/xt_getAjaxResultForCheckUnique.jsp?table="+table+"&col="+col+"&value="+encodeURIComponent(object.value);
	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function(){
		if(ajaxRequest.readyState == 4){
            if(ajaxRequest.status==200){
                var rs=(ajaxRequest.responseText).trim();
				//如果发现了重复
				//alert(rs);
				if (rs.indexOf("!!!#$Found#$!!!")>=0) {
					object.style.backgroundColor="#ff0000";
				} else {
					object.style.backgroundColor="#ffffff";
				}
            }
		}
	}
	ajaxRequest.open("GET", url, true);
	ajaxRequest.send(null); 
}

