function doCheck()
{
	return doCheck(document.form1)
}
function doCheck(myform)
{ 
    
		

		//对子区域的特殊检查---开始--------------------------------	
		if (_subArea_num = document.getElementsByName('_subArea_num').length>0)
		{
				_subArea_num = document.getElementsByName('_subArea_num')[0].value; //子表的数量
				//alert("_subArea_num："+_subArea_num);
				if (_subArea_num !=null && _subArea_num != "")
				{
						for (var j = 0; j < _subArea_num ; j++)
						{			
								_subArea_name = document.getElementsByName('_subArea_area_id'+j)[0].value;
								//alert("_subArea_name:"+_subArea_name);
								//所有的子区域检查 填写在下边

								//记帐平整 检查 借贷平衡
								if (_subArea_name!= null && _subArea_name !="" && _subArea_name =='sub_cw_jzpz_cw_jzpz_sub')
								{

												if (!_haveSumRow()) 
												{
													alert("借方合计必须等于贷方合计!");
													return false;
												}

												//借方合计
												var td;

												td = currentTable.rows.item(currentTable.rows.length-1).cells.item(3);				

												jfhj = td.all.item(0).value;
												//alert("jfhj:"+jfhj);
												td = currentTable.rows.item(currentTable.rows.length-1).cells.item(4);
												dfhj = td.all.item(0).value;

												if (jfhj != dfhj)
												{
													alert("借方合计必须等于贷方合计!");
													return false;

												}

									}

							}
					}
		}


		//对子区域的特殊检查---结束--------------------------------
		
	

	for (var i = 0; i < myform.elements.length; i++) 
	{

		thisItem=myform.elements.elements[i];


		//如果是select选项，并且是树型，而且选择了某个项目，则控制必须选择叶子节点
		//要排除多选的情况，否则报错
		if (thisItem.tagName=="SELECT" && thisItem.multiple==false && thisItem.options[thisItem.selectedIndex].value.length>0) {
			//如果所有选项中有一项有√，则说明是树型
			var isTree=false;
			for (j=0;j<thisItem.options.length ;j++ ) {
				if (thisItem.options[j].text.indexOf("√",0)>-1) isTree=true;
			}
			// 如果是树型结构，但没有选择叶子，则报错
			if (isTree && thisItem.multiple==false && thisItem.options[thisItem.selectedIndex].value!="" && thisItem.options[thisItem.selectedIndex].text.indexOf("√",0)<0) {
					alert("["+thisItem.regName+"]  只能选择末级（含有 \"√\" 的选项），请重新选择！");
					thisItem.focus();
					return false;
			}
		}

		//如果 存在辅助核算控制字段 为1 并且 相关属性没有录入 则提示 选择录入 --开始----		
		fzchkId = "_sub_xt_cpfz_sfpcgl_"; //辅助检查的标志
		fzchkPos = thisItem.name.indexOf(fzchkId); //辅助检查的位置
		if (fzchkPos>-1 && thisItem.value == '1')
		{
			fzjcline = thisItem.name.substr(fzchkPos +fzchkId.length ,thisItem.name.length);//辅助检查行
			//alert ("fzjcline:"+fzjcline);

			xgsxName = thisItem.name.substr(0,fzchkPos) + "_sub_xt_cpfz_xgsx_" + fzjcline ;			
			chmcName = thisItem.name.substr(0,fzchkPos) + "_sub_chmc_" + fzjcline ;			
			
			chmcValue = document.getElementsByName(chmcName)[0].value
			//alert("相关属性："+xgsxName);
			//alert("产品名称："+chmcName);
			//alert("产品名称的值："+chmcValue);

			if (document.getElementsByName(xgsxName)[0].value.length<1)
			{
				alert (chmcValue +  "的批次相关属性必须录入！");
				return false;
				
			}
			
		}

		fzchkId = "_sub_xt_cpfz_sfbzqgl_"; //辅助检查的标志
		fzchkPos = thisItem.name.indexOf(fzchkId); //辅助检查的位置
		if (fzchkPos>-1 && thisItem.value == '1')
		{
			fzjcline = thisItem.name.substr(fzchkPos +fzchkId.length ,thisItem.name.length);//辅助检查行
			//alert ("fzjcline:"+fzjcline);

			xgsxName = thisItem.name.substr(0,fzchkPos) + "_sub_xt_cpfz_xgsx_" + fzjcline ;			
			chmcName = thisItem.name.substr(0,fzchkPos) + "_sub_chmc_" + fzjcline ;			
			
			chmcValue = document.getElementsByName(chmcName)[0].value;
			//alert("相关属性："+xgsxName);
			//alert("产品名称："+chmcName);
			//alert("产品名称的值："+chmcValue);

			if (document.getElementsByName(xgsxName)[0].value.length<1)
			{
				alert (chmcValue +  "的有效期相关属性必须录入！");
				return false;
				
			}
			
		}
		
		//如果 存在辅助核算控制字段 为1 并且 相关属性没有录入 则提示 选择录入 --结束----


		//如果 存在科目 辅助核算控制字段 为1 并且 相关属性没有录入 则提示 选择录入 --开始----		
					
		fzchkId = "_subarea_sub_cw_jzpz_cw_jzpz_sub_kmmc_"; //辅助检查的标志: 记帐凭证 的科目
		fzchkPos = thisItem.name.indexOf(fzchkId); //辅助检查的位置
		
		if (fzchkPos >= 0 ) //是凭证的科目字段
		{
			kmmc = thisItem.value ;
			

			fzjcline = thisItem.name.substr( fzchkId.length ,thisItem.name.length);//辅助检查行
			
			//alert ("fzjcline:"+fzjcline);

			xgsxName = "_subarea_sub_cw_jzpz_cw_jzpz_sub_xgsx_" + fzjcline ;									
			
			
			//alert("相关属性："+xgsxName);
			//alert("科目名称："+kmmc);
			
			
			

			if (document.getElementsByName(xgsxName)[0].value.length<1)
			{

				if (document.getElementsByName("_subarea_sub_cw_jzpz_cw_jzpz_sub_biz_"+fzjcline)[0].value.length>0 || 
					document.getElementsByName("_subarea_sub_cw_jzpz_cw_jzpz_sub_sfbmhs_"+fzjcline)[0].value == '1' ||
					document.getElementsByName("_subarea_sub_cw_jzpz_cw_jzpz_sub_sfgrwl_"+fzjcline)[0].value == '1' ||
					document.getElementsByName("_subarea_sub_cw_jzpz_cw_jzpz_sub_sfkhwl_"+fzjcline)[0].value == '1' ||
					document.getElementsByName("_subarea_sub_cw_jzpz_cw_jzpz_sub_sfgyswl_"+fzjcline)[0].value == '1' ||
					document.getElementsByName("_subarea_sub_cw_jzpz_cw_jzpz_sub_sfxmhs_"+fzjcline)[0].value == '1' ||
					document.getElementsByName("_subarea_sub_cw_jzpz_cw_jzpz_sub_sfyhz_"+fzjcline)[0].value == '1' 
					)
				{
					alert (kmmc +  "的相关属性必须录入！");
					return false;
				}
				
			}
			
		}
		//如果 存在科目 辅助核算控制字段 为1 并且 相关属性没有录入 则提示 选择录入 --结束----		
   



		



		myName=thisItem.reg;
		if (myName!=null) 
		{
		   if (myName.indexOf("_r_",0)>-1 && thisItem.value.length<1) 
		   {
					alert("["+thisItem.regName+"] 为必录项，请重新输入数据");
					thisItem.focus();
					return false;
		   }
		   // _rs_表示select对象的必选项目检查
		   if (myName.indexOf("_rs_",0)>-1 && thisItem.options[myform.elements[i].selectedIndex].value.length<1) 
		   {
					alert("["+thisItem.regName+"] 为必选项，请选择一个项目");		    
					thisItem.focus();
					return false;
		   }

		   if (myName.indexOf("_rms_",0)>-1 ) 
		   {
			    var haveselect = false; 
			   for (var i = 0; i < thisItem.options.length; i++)
			   {
					if (thisItem.options[i].selected == true)
					{
						haveselect = true;
						break;
					}
			   }

			   if (haveselect == false)
			   {
				   	alert("["+thisItem.regName+"] 为必选项，请选择一个项目");		    
					thisItem.focus();
					return false;

			   }
			   else
			   {
				   return true;
			   }
		   }


		   if ( thisItem.value!=null && thisItem.value.length>0)
		   {
				if (myName.indexOf("_%_",0)>-1 &&!checkbaifenbi(thisItem.value)) 
				{
					alert("百分比如78%的格式");
					thisItem.focus();
					thisItem.value="";
					return false;
				}

				if (myName.indexOf("_date_",0)>-1 && !checkDate(thisItem.value.substr(0,10))) 
				{
					alert("["+thisItem.regName+"] 项目格式不对，请输入（如1981-02-23）的格式");
					thisItem.focus();
					thisItem.value="";
					return false;
				}

				if (myName.indexOf("_time_",0)>-1 && !checkTime(thisItem.value)) 
				{
					alert("["+thisItem.regName+"] 项目格式不对，请输入（如08:30）的格式");
					thisItem.focus();
					thisItem.value="";
					return false;
				}

				if (myName.indexOf("_time_",0)>-1 && thisItem.value.length==4)
				{
					
					
					thisItem.value=thisItem.value.substr(0,2) +":"+thisItem.value.substr(2,3);
					

				}


				

				if (myName.indexOf("_month_",0)>-1 && !checkMonth(thisItem.value)) 
				{
					alert("["+thisItem.regName+"] 项目格式不对，请输入（如1981-02）的格式");
					thisItem.focus();
					thisItem.value="";
					return false;
				}


				if (myName.indexOf("_int_",0)>-1 && !checkInt(thisItem.value)) 
				{
					alert("该项目格式不对或超过10位，请输入10位以内（如56或-34）整数的格式");
					thisItem.focus();
					thisItem.value="";
					return false;   	    		
				}
				if (myName.indexOf("_real_",0)>-1 && !checkReal(thisItem.value)) 
				{
					alert("该项目格式不对，请输入（如45或-34.23）实数的格式");
					thisItem.focus();
					thisItem.value="";
					return false;
				}
			 }
		 }     
	} 
	return true;
}

function checkDate(myString)
{
	var reg1 = RegExp(/^[1-2][0-9][0-9][0-9][-][0][0-9][-][0-3][0-9]$/);
	var reg2 = RegExp(/^[1-2][0-9][0-9][0-9][-][1][0-2][-][0-3][0-9]$/);
	if (!(reg1.test(myString) || reg2.test(myString) ))  return false;
	
	return isdate(myString);

}

function checkTime(myString)
{
	var reg1 = RegExp(/^[0-1][0-9][:][0-5][0-9]$/);
	var reg2 =   RegExp(/^[2][0-3][:][0-5][0-9]$/);

	var reg3 = RegExp(/^[0-1][0-9][0-5][0-9]$/);
	var reg4 =   RegExp(/^[2][0-3][0-5][0-9]$/);
	

	if (reg1.test(myString) || reg2.test(myString)|| reg3.test(myString) || reg4.test(myString) ) return true;
	else return false;


}


function checkMonth(myString)
{
	var reg1 = RegExp(/^[1-2][0-9][0-9][0-9][-][0][0-9]$/);
	var reg2 = RegExp(/^[1-2][0-9][0-9][0-9][-][1][0-2]$/);
	if (reg1.test(myString) || reg2.test(myString) ) return true;
	else return false;

}
function checkYMD(myString)
{
	var reg1 = RegExp(/^[1-2][0-9][0-9][0-9]$/);
	var reg2 = RegExp(/^[1-2][0-9][0-9][0-9][.][0-1][0-9]$/);
	var reg3 = RegExp(/^[1-2][0-9][0-9][0-9][.][0-1][0-9][.][0-3][0-9]$/);
	if (reg1.test(myString) || reg2.test(myString) || reg3.test(myString)) return true;
	else return false;
}
function checkYear(myString)
{
	var reg = RegExp(/^[1-2][0-9][0-9][0-9]$/);
	return reg.test(myString);
}
function checkInt(myString)
{  
	 if (myString.length>10) return false;
	 var reg = RegExp(/^[0-9]*$/);
	 if (reg.test(myString)) return true;
	 var reg = RegExp(/^[-][0-9]*$/);
	 if (reg.test(myString))  return true;

	 return false;
}
function checkReal(myString)
{
     var reg = RegExp(/^[0-9]+[.][0-9]+$/);
	 if (reg.test(myString)) return true;
	 var reg = RegExp(/^[-][0-9]+[.][0-9]+$/);
	 if (reg.test(myString)) return true;
	 var reg = RegExp(/^[0-9]+$/);
	 if (reg.test(myString)) return true;
	 var reg = RegExp(/^[-][0-9]+$/);
	 if (reg.test(myString)) return true;
	  return false;
} 
function checkPassWord(myString)
{
	var reg = RegExp(/^[0-9a-zA-Z]*$/);
	 if( reg.test(myString)) return true;
	return false;
}
function checkAccunt(myString)
{
	var reg = RegExp(/^[0-9a-zA-Z]*$/);
	 if( reg.test(myString)) return true;
	return false;
}
function checkIp(myString)
{ 
   var reg = RegExp(/^([0-9]{1,3})[.]([0-9]{1,3})[.]([0-9]{1,3})[.]([0-9]{1,3})$/);
	 if( reg.test(myString)) return true;
	return false;
} 
function checkName(myString)
{
	var reg = RegExp(/^[^ -~]+$/);
	 if( reg.test(myString)) return true;
	return false;
}
function checkIdName(myString)
{
	var reg = RegExp(/^[a-zA-Z0-9#]+$/);
	 if( reg.test(myString)) return true;
	return false;
}
function checkbaifenbi(myString)
{
	var reg = RegExp(/^[0-9]+[%]$/);
	return reg.test(myString);
}
function confirmDelete(value)
{
	  return confirm("您确定要删除 "+ value +"的记录吗？删除后数据不可恢复！");
}

function confirmZuoFei(value)
{
	  return confirm("您确定要作废 "+ value +"的记录吗？作废后数据不可恢复！");
}

function confirmhfmm()
{
	  return confirm("您确定要恢复用户的密码吗？");
}

function isdate(strDate){ 
   var strSeparator = "-"; //日期分隔符 
   var strDateArray; 
   var intYear; 
   var intMonth; 
   var intDay; 
   var boolLeapYear; 
    
   strDateArray = strDate.split(strSeparator); 
    
   if(strDateArray.length!=3) return false; 

    
   intYear = parseInt(strDateArray[0],10); 
   intMonth = parseInt(strDateArray[1],10); 
   intDay = parseInt(strDateArray[2],10); 
    
   if(intMonth>12||intMonth<1) return false; 
    
   if((intMonth==1||intMonth==3||intMonth==5||intMonth==7||intMonth==8||intMonth==10||intMonth==12)&&(intDay>31||intDay<1)) return false; 
    
   if((intMonth==4||intMonth==6||intMonth==9||intMonth==11)&&(intDay>30||intDay<1)) return false; 
    
   if(intMonth==2){ 
      if(intDay<1) return false; 
       
      boolLeapYear = false; 
      if((intYear%100)==0){ 
         if((intYear%400)==0) boolLeapYear = true; 
      } 
      else{ 
         if((intYear%4)==0) boolLeapYear = true; 
      } 
       
      if(boolLeapYear){ 
         if(intDay>29) return false; 
      } 
      else{ 
         if(intDay>28) return false; 
      } 
   } 
    
   return true; 
} 