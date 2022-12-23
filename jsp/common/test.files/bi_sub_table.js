  var maxCount;
  var currentTable;
  var newRowHtml;
  var sumRowHtml;
  
  // 选择一行
  function _selectRow(row_index, currentTable)
  {
		for (i=1;i<currentTable.rows.length;i++) 
	    {
			if (row_index==i) 
				currentTable.rows.item(i).className="x_sub_table_row_selected";
			else 
				currentTable.rows.item(i).className="x_sub_table_row_unselected";
		}
  }
  // 插入一行
  function _addRow() 
  {
		var td; 
		var tr;
		var last_index;
		
		last_index = currentTable.rows.length;

		//alert (last_index);

		if ( _haveSumRow() ) 
			last_index =last_index-1;

		tr = currentTable.insertRow(last_index);
		tr.onclick=   new Function("_selectRow(this.rowIndex,this. parentNode)");
		tr.onchange = new Function("_recountSumRow()");
		tr.className="x_sub_table_row_unselected";

		td=tr.insertCell(0);
		td.noWrap=true;
		td.align="center";
		td.className="x_sub_table_row_td_hh";
		td.innerHTML=tr.rowIndex ; 
		//td.innerHTML=tr.rowIndex - 1; 

		for (i=0;i<newRowHtml.length;i++) 
		{
			td=tr.insertCell(i+1);
			td.noWrap=true;
			td.className="x_sub_table_row_td";
			td.innerHTML=newRowHtml[i];
			
		}
		maxCount.value = parseInt(maxCount.value) + 1;

		//判断是否该加合计行
		var needSumRow=0;
		for (i=0;i<sumRowHtml.length;i++) 
		{
			if ((sumRowHtml[i].toLowerCase()).indexOf("input")>=0) {
				needSumRow=1;
				break;
			}
		}


		if ( currentTable.rows.length > 2 && !_haveSumRow( currentTable )  &&  needSumRow==1) 
		{
			_addSumRow() ;
		}
		_recountSumRow();

  }
  // 删除一行
  function _deleteRow() 
  {
		var x=0;
		var last_index=currentTable.rows.length;
		if (_haveSumRow()) last_index=currentTable.rows.length-1;
		for (i=1;i<last_index;i++) 
		{
			if (currentTable.rows.item(i).className=="x_sub_table_row_selected")
			{
				currentTable.deleteRow(i);
				x=1;
			}
		}
		if (x==0) {alert("请用鼠标点击选择要删除的行！");return false;}
		last_index=currentTable.rows.length;
		if (_haveSumRow()) last_index=currentTable.rows.length-1;
		for (i=1;i<last_index;i++) 
			currentTable.rows.item(i).cells.item(0).innerHTML=currentTable.rows.item(i).rowIndex;
		
        //maxCount.value = parseInt(maxCount.value) - 1;

		if (currentTable.rows.length<=3 && _haveSumRow())  _deleteSumRow();
		_recountSumRow(currentTable);
		return true;
  }
  // 加上一个合计行
  function _addSumRow() 
  {

		var td;
		var tr;

		tr = currentTable.insertRow(currentTable.rows.length);
		tr.id="sumrow";
		tr.className="x_sub_table_row_unselected";

		td=tr.insertCell(0);
		td.noWrap=true;
		td.align="center";
		td.className="x_bill_sub_bill_table_sumrow_td_hh";
		td.innerHTML="合 计";
		for (i=0;i<sumRowHtml.length;i++) 
		{
			td=tr.insertCell(i+1);
		    td.noWrap=true;
		    td.align="right";
		    td.className="x_bill_sub_bill_table_sumrow_td";
			td.innerHTML=sumRowHtml[i];
		}

  }
  //删除合计行
  function _deleteSumRow() 
  {
		currentTable.deleteRow(currentTable.rows.length-1);
  }
  // 重新计算合计行
  function _recountSumRow() 
  {
		var td; 
		var tdx;

		if (!_haveSumRow()) return;

		for (i=1;i<currentTable.rows.item(currentTable.rows.length-1).cells.length;i++) 
		{
		    td=currentTable.rows.item(currentTable.rows.length-1).cells.item(i);
			if (td.all.item(0)!=null && td.all.item(0).tagName=='INPUT') 
			{
				var colsum=0;
				for (j=1;j<currentTable.rows.length-1;j++) 
				{
					tdx=currentTable.rows.item(j).cells.item(i);
					if (tdx.all.item(0)!=null && tdx.all.item(0).tagName=='INPUT' && tdx.all.item(0).value !='') 
						colsum+=parseFloat(tdx.all.item(0).value);
				}
				td.all.item(0).value=Math.round(colsum*100)/100;
			}

		}

  }

  //////////////////////////////////////////////////////////////////////////////////

  // 判断是否有合计行
  function _haveSumRow() 
  {
		if (currentTable.rows.item(currentTable.rows.length-1).id=="sumrow") return true;
		return false;
  }
