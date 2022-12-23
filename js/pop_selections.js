	var myDialog = new Object;
	function doSelectPerson(objName) {
		var obj1=document.getElementsByName(objName+"_id");
		var obj2=document.getElementsByName(objName+"_no");
		var obj3=document.getElementsByName(objName+"_name");
		var obj4=document.getElementsByName(objName+"_dep_dm");
		var obj5=document.getElementsByName(objName+"_dep_name");
		var obj6=document.getElementsByName(objName+"_nickname");
		myDialog.id = obj1[0].value;
		result=window.open("/emadmin/shared/selectPerson.jsp", myDialog)
		if (result!=true)
			return;    // user canceled select
		else {
			if (obj1[0]!=null) obj1[0].value=myDialog.id;
			if (obj2[0]!=null) obj2[0].value=myDialog.no;
			if (obj3[0]!=null) obj3[0].value=myDialog.name;
			if (obj4[0]!=null) obj4[0].value=myDialog.dep_dm;
			if (obj5[0]!=null) obj5[0].value=myDialog.dep_name;
			if (obj6[0]!=null) obj6[0].value=myDialog.nickname;
		} 
	}
	function doSelectProduct(objName) {
		var obj1=document.getElementsByName(objName+"_id");
		var obj2=document.getElementsByName(objName+"_name");
		var obj3=document.getElementsByName(objName+"_category");
		var obj4=document.getElementsByName(objName+"_spec");
		var obj5=document.getElementsByName(objName+"_unit");
		var obj6=document.getElementsByName(objName+"_unit_price");
		myDialog.id = obj1[0].value;
		result=window.open("/emadmin/shared/selectProduct.jsp", myDialog)
		if (result!=true)
			return;    // user canceled select
		else {
			if (obj1[0]!=null) obj1[0].value=myDialog.id;
			if (obj2[0]!=null) obj2[0].value=myDialog.name;
			if (obj3[0]!=null) obj3[0].value=myDialog.category;
			if (obj4[0]!=null) obj4[0].value=myDialog.spec;
			if (obj5[0]!=null) obj5[0].value=myDialog.unit;
			if (obj6[0]!=null) obj6[0].value=myDialog.unit_price;
		}
	}
	function doSelectClient(objName) {
		var obj1=document.getElementsByName(objName+"_id");
		var obj2=document.getElementsByName(objName+"_name");
		myDialog.id = obj1[0].value;
		result=window.open("/emadmin/shared/selectClient.jsp", myDialog)
		if (result!=true)
			return;    // user canceled select
		else {
			if (obj1[0]!=null) obj1[0].value=myDialog.id;
			if (obj2[0]!=null) obj2[0].value=myDialog.name;
		}
	}
	function doSelectFYApply(objName) {
		var obj1=document.getElementsByName(objName+"_id");
		var obj2=document.getElementsByName(objName+"_name");
		var obj3=document.getElementsByName(objName+"_client_id");
		var obj4=document.getElementsByName(objName+"_client_name");
		var obj5=document.getElementsByName(objName+"_purpose");
		myDialog.id = obj1[0].value;
		result=window.open("/emadmin/shared/selectFYApply.jsp", myDialog)
		if (result!=true)
			return;    // user canceled select
		else {
			if (obj1[0]!=null) obj1[0].value=myDialog.id;
			if (obj2[0]!=null) obj2[0].value=myDialog.client_name+myDialog.purpose;
			if (obj3[0]!=null) obj3[0].value=myDialog.client_id;
			if (obj4[0]!=null) obj4[0].value=myDialog.client_name;
			if (obj5[0]!=null) obj5[0].value=myDialog.purpose;
		}
	}

	function doSelectDepartment(objName) {
		var obj1=document.getElementsByName(objName+"_id");
		var obj2=document.getElementsByName(objName+"_name");
		myDialog.id = obj1[0].value;
		result=window.open("/emadmin/shared/selectDepartment.jsp", myDialog)
		if (result!=true)
			return;    // user canceled select
		else {
			if (obj1[0]!=null) obj1[0].value=myDialog.id;
			if (obj2[0]!=null) obj2[0].value=myDialog.name;
		}
	}
	function doSelectEmployee(objName) {
		var obj1=document.getElementsByName(objName+"_id");
		var obj2=document.getElementsByName(objName+"_name");
		var obj3=document.getElementsByName(objName+"_dep_id");
		var obj4=document.getElementsByName(objName+"_dep_name");
		myDialog.id = obj1[0].value;
		result=window.open("/emadmin/shared/selectEmployee.jsp", myDialog)
		if (result!=true)
			return;    // user canceled select
		else {
			if (obj1[0]!=null) obj1[0].value=myDialog.id;
			if (obj2[0]!=null) obj2[0].value=myDialog.name;
			if (obj3[0]!=null) obj3[0].value=myDialog.dep_id;
			if (obj4[0]!=null) obj4[0].value=myDialog.dep_name;
		}
	}
	function doSelectCalendar(objName) {
		var obj1=document.getElementsByName(objName);
		myDialog.id = obj1[0].value;
		result=window.open("/emadmin/shared/calendar.jsp", myDialog,"dialogHeight:300px;dialogLeft:400px;dialogTop:200px;dialogWidth:400px;center:yes;scroll:no;resizable:no;status:no" );
		if (result!=true)
			return;    // user canceled select
		else {
			if (obj1[0]!=null) obj1[0].value=myDialog.id;
		}
	}

	function doSelectCalendarAndTime(objName) {
		var obj1=document.getElementsByName(objName);
		var obj2=document.getElementsByName(objName+"_time");
		myDialog.id = obj1[0].value;
		result=window.open("/emadmin/shared/calendar.jsp", myDialog,"dialogHeight:300px;dialogLeft:400px;dialogTop:200px;dialogWidth:400px;center:yes;scroll:no;resizable:no;status:no" );
		if (result!=true)
			return;    // user canceled select
		else {
			if (obj1[0]!=null) obj1[0].value=myDialog.id;
			if (obj2[0]!=null) obj2[0].value="12:00";
		}
	}
