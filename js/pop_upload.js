
	var pop_upload_myDialog = new Object;
	function do_upload(objName) {
		var obj1=document.getElementsByName(objName);
		var obj2=document.getElementsByName(objName+"_div");
		var obj3=document.getElementsByName(objName+"_old_file");
		pop_upload_myDialog.old_file_name = obj3[0].value;

		//调用弹出窗口
		result=window.open("/emadmin/shared/popwindow_upload.jsp", pop_upload_myDialog,"resizable:Yes;status:no;dialogHeight:250px;dialogWidth:550px;");
		//alert(result);

		if (result!=true)
			return;    // user pop_upload_canceled select
		else {
			if (obj1[0]!=null) obj1[0].value=pop_upload_myDialog.new_name;
			var myName=pop_upload_myDialog.new_name;
			var innerString="<a href='/upload/"+pop_upload_myDialog.new_name+"' target=_blank>"+pop_upload_myDialog.title+"</a>"; 
			var kzm;
			var i=myName.indexOf(".");
			if (i>0) {
				kzm=myName.substring(i+1);
				if (kzm=="swf") {
					innerString="<a href='/upload/"+pop_upload_myDialog.new_name+"' target=_blank>"+pop_upload_myDialog.title+"</a>";
					innerString+='<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="30" height="30">';
                    innerString+='<param name="movie" value="/upload/'+pop_upload_myDialog.new_name+'" />';
                    innerString+='<param name="quality" value="high" />';
                    innerString+='<embed src="/upload/'+pop_upload_myDialog.new_name+'" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="30" height="30"></embed>';
					innerString+='</object>';
				}else if (kzm=="gif" || kzm=="jpg" || kzm=="bmp" || kzm=="tif") {
					innerString="<a href='/upload/"+pop_upload_myDialog.new_name+"' target=_blank><img src='/upload/"+pop_upload_myDialog.new_name+"' width=30 height=30 border=0/></a>";
					
				}

				innerString+="<img src=\"/emadmin/images/quxiao.jpg\"   onMouseOver=\"this.style.cursor='hand'\"  onclick='pop_upload_cancel(\""+objName+"\")'>";

				//alert(innerString);


			}
			//alert(kzm);
			if (obj2[0]!=null) obj2[0].innerHTML=innerString;
			if (obj3[0]!=null) obj3[0].value=pop_upload_myDialog.new_name;
		} 
	}
	function pop_upload_cancel(objName) {
		var obj1=document.getElementsByName(objName);
		var obj2=document.getElementsByName(objName+"_div");
		var obj3=document.getElementsByName(objName+"_old_file");
		if (obj1[0]!=null) obj1[0].value="";
		if (obj2[0]!=null) obj2[0].innerHTML="";
		if (obj3[0]!=null) obj3[0].value="";
	}

