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
