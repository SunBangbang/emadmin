

function selectMultiAll0(sender, name)	  
{
	for(i=0; i<document.getElementsByName(name+ "MaxLen")[0].value/2; i++)
	{
		document.getElementsByName( name + i*2 )[0].checked = sender.checked;
	}
}

function abselectMultiAll0(sender, name)	  
{
	for(i=0; i<document.getElementsByName(name+ "MaxLen")[0].value/2; i++)
	{
		
		document.getElementsByName(name+ i*2)[0].checked = !document.getElementsByName(name+ i*2)[0].checked;

	}
}



function selmem(form)
{
 for (var i = 0; i < form.nongrantrole.options.length; i++)
    form.nongrantrole.options[i].selected = 1;
 return true ;
}

function deleteSelectItemOption(object,index) {
   object.options[index] = null;
}

function addSelectOption(object,text,value) {
   var optionName = new Option(text,value);
   object.options[object.length] = optionName;
}

function checkNewValueInOption(fromObject,value) {	
    for (var i=0, l=fromObject.options.length;i<l;i++) {
        if (fromObject.options[i].value == value){           
              return true;
            }
    }
	return false;
}

function addSelectOptionAndHidSameTime(object,HideObject,text,value) {
   if(!checkNewValueInOption(object,value)){
	   var optionName = new Option(text,value);
	   object.options[object.length] = optionName;
	   optionName = new Option(text,text);
	   HideObject.options[HideObject.length] = optionName;
   }
}



function deleteSelectItemOptionAndHidSameTime(fromObject,HideObject) {
    for (var i=fromObject.options.length-1;i>-1;i--) {
        if (fromObject.options[i].selected)
		{
			deleteSelectItemOption(fromObject,i);
			deleteSelectItemOption(HideObject,i);
		}
           
    }
}



function copySelectedListItem(fromObject,toObject) {

    for (var i=0, l=fromObject.options.length;i<l;i++) {
        if (fromObject.options[i].selected)
           {
              addSelectOption(toObject,fromObject.options[i].text,fromObject.options[i].value);
            }
    }
    for (var i=fromObject.options.length-1;i>-1;i--) {
        if (fromObject.options[i].selected)
           deleteSelectItemOption(fromObject,i);
    }
}


function selectedListItemMove(sel,t) 
{ 

	node = sel.options[sel.selectedIndex]; 
	var i;
	if( t == 1 ) //下移
	{ 
		i = sel.selectedIndex+1;
		if( sel.selectedIndex == sel.length-1 ) 
			nextNode = null; 
		else 
			nextNode = sel.options[sel.selectedIndex+1]; 


	} 
	else //上移
	{ 
		i = sel.selectedIndex - 1;
		if( sel.selectedIndex == 0 ) 
			nextNode = null; 
		else 
			nextNode = sel.options[sel.selectedIndex-1]; 
	} 

	if( nextNode ) 
	{
		
		
		node.swapNode(nextNode); //移动
		sel.focus();
		sel.options[i].selected = true;

	}



} 




function formSearchsubmit()
{
	multiOptionSetSelect();

	for (var i = 0; i < form1.selectitem.options.length; i++)
	     form1.selectitem.options[i].selected = true;

	document.form1.isstandardlist.value = 'yes';	
	document.form1.submit();
}


function formCountSearchsubmit()
{
	multiOptionSetSelect();
	
	     
	for (var i = 0; i < form1.selectleftgroup.options.length; i++)
	     form1.selectleftgroup.options[i].selected = true;
	     
	for (var i = 0; i < form1.selecttarget.options.length; i++)
	     form1.selecttarget.options[i].selected = true;
	     
	     	     
		
	document.form1.submit();
}

function formUserOrdersubmit(i,value)
{
	multiOptionSetSelect();

	for (var i = 0; i < document.form1.selectitem.options.length; i++)
	     document.form1.selectitem.options[i].selected = true;

	document.form1.userSelectOrder.value = value;
	document.form1.isstandardlist.value = 'yes';

	document.form1.submit();
}

function do_add_to_filter_collection() { 
	
 			var  dialogArguments=new Object;
				
			result=window.open('/emadmin/shared/popwindow_add_collection.jsp', dialogArguments,"resizable:Yes;dialogHeight:250px;dialogWidth:300px;");                                                                  
			 if (result==true) {                                                                                                                  
				 document.getElementsByName('collection_title')[0].value=dialogArguments.collection_title;            
				 document.getElementsByName('is_share')[0].value=dialogArguments.is_share;  
				 document.getElementsByName('is_hot')[0].value=dialogArguments.is_hot;  

				for (var i = 0; i < form1.selectitem.options.length; i++)
					 form1.selectitem.options[i].selected = true;				 
				 document.form1.isstandardlist.value = 'yes';	
				 document.form1.submit();

			 } 
				                                                                                                                                                                                                
 }                                                                                                                                                

function do_add_to_count_collection() { 
	
 			var  dialogArguments=new Object;
				
			result=window.open('/emadmin/shared/popwindow_add_count_collection.jsp', dialogArguments,"resizable:Yes;dialogHeight:250px;dialogWidth:300px;");                                                                  
			 if (result==true) {                                                                                                                  
				 document.getElementsByName('count_collection_title')[0].value=dialogArguments.collection_title;            
				 document.getElementsByName('is_share')[0].value=dialogArguments.is_share;  
				 document.getElementsByName('is_hot')[0].value=dialogArguments.is_hot;  
				 formCountSearchsubmit();
			 } 
				                                                                                                                                                                                                
 }                                                                                                                                                


//该方法用于实现字段的关联控制
function getNewSelectContent(controlItem,beControledItem,optionsourceid,controltablecol,controltype)
{
	
    selectName=beControledItem;

	controlvalue = controlItem.options[controlItem.selectedIndex].value;	
	m_url = "/emadmin/shared/getcontrolselectcontent.jsp?controlvalue="+ controlvalue 
		+ "&optionsourceid=" +optionsourceid
		+"&controltablecol=" +controltablecol
		+"&controltype=" +controltype;

	replaceSelect(selectName,m_url);

}

// 用URL返回内容替换指定Select控件内的option内容
function replaceSelect(selectName,strUrl)
{

   var newText = loadContent(strUrl);
   var oldText = selectName.innerHTML;
   var newSelect = selectName.outerHTML.replace(oldText,newText);
   //alert("--newSelect--"+newSelect+"---");
   //alert("----- "+selectName.outerHTML);
   selectName.outerHTML = newSelect;
   //alert("----- selectName.outerHTML="+selectName.outerHTML);
   return true;
}


// 从一个URL中获得其请求结果内容
function loadContent(strURL)
{
	var strContent = "";
	if (typeof strURL != "string" || strURL == "")return strContent;
	try
	{
		var oProxy = new ActiveXObject("Microsoft.XMLHTTP");

		oProxy["Open"]("GET", strURL, false);
		oProxy["Send"]();
		strContent = oProxy["responseText"];
	}
	catch(e){status = e.description}
	return strContent;
}



function segmentStringNum(str,delim)
{
	var num = 0;
	if (str=='' || delim =='')
	{
		
		return  num;
	}

	var bakstr = str;
	
	var pos = 1;
	num=0;
	while(pos>=0)
	{
		pos=str.indexOf(delim);
		if(pos<0)
		{
			num++;
			break;
		}
		else
		{
			
			str = str.substr(pos+delim.length,str.length);			
			num++;
		}

	}


	return num;

}

function segmentString(str,delim,retarray)
{


	if (str=='' || delim =='')
	{
		return;
	}

	pos=1;	

	num=0;
	while(pos>=0)
	{
		pos=str.indexOf(delim);


		if(pos<0)
		{
			retarray[num] = str;
			break;
		}
		else
		{

			retarray[num] = str.substr(0,pos);
			str = str.substr(pos+delim.length,str.length);
			num++;

		}

	}

}

function callsegmentStringExample(){

	var str = '11nn,nn22nn,nn33nn,nn44';
	var fgstr='nn,nn';

	var num= segmentStringNum(str,fgstr) ;	
	
	
	var retarray = 	new Array(num);
	for (var i=0;i<retarray.length;i++)
	{
		retarray[i]=''
	}
	segmentString(str,fgstr,retarray) ;	
	alert('father_retarray111:'+retarray);


}



function do_set_filter_item() {
	var obj1=document.getElementsByName('filtertemplateid');
	pop_upload_myDialog.filtertemplateid = obj1[0].value;

    //alert(obj1[0].value);

	//调用弹出窗口
	result=window.open("/emadmin/shared/popwindow_set_filter_item.jsp?filtertemplateid="+obj1[0].value, pop_upload_myDialog,"resizable:Yes;status:no;dialogHeight:650px;dialogWidth:750px;");
	

	if (result!=true)
		return;    // user pop_upload_canceled select
	else {
				 document.getElementsByName('filtertemplateid')[0].value=pop_upload_myDialog.filtertemplateid;            

				 //multiOptionSetSelect();

				 document.form1.isstandardlist.value = 'yes';	
				 document.form1.submit();


	} 
}
