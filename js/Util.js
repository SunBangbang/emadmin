

function doCount(obj1,obj2,obj3){
	if(parseFloat(obj1.value)!=0){
		obj3.value=formatFloat(parseFloat(obj2.value)/parseFloat(obj1.value)*100,0);
	}
	else
		obj3.value=0;
}



function doCount0(obj1,obj2,obj3){
	if(parseFloat(obj1.value)!=0){
		obj3.value=formatFloat(parseFloat(obj2.value)/parseFloat(obj1.value)*1000,0);
	}
	else
		obj3.value=0;
}


function doCount1(obj1,obj2,obj3){
	doCount(obj1,obj2,obj3);
	var obj;
	var obj4;
	var obj5;
	var obj6;
	var temp;
	var sum=0;
	var number=12;
	for(i=1;i<number;i++){
		if(i<10) 
			temp="document.form1.ID0"+i+"_4";
		else
			temp="document.form1.ID"+i+"_4";
		obj=eval(temp);
		sum+=parseFloat(obj.value)
	}
	temp="document.form1.ID12_4";
	obj4=eval(temp);
	obj4.value=sum;
	temp="document.form1.ID12_5";
	obj5=eval(temp);
	temp="document.form1.ID12_6";
	obj6=eval(temp);
	doCount(obj4,obj5,obj6);
}




function doCount2(obj1,obj2,obj3){
	doCount(obj1,obj2,obj3);
	var obj;
	var obj4;
	var obj5;
	var obj6;
	var temp;
	var sum=0;
	var number=12;
	for(i=1;i<number;i++){
		if(i<10) 
			temp="document.form1.ID0"+i+"_5";
		else
			temp="document.form1.ID"+i+"_5";
		obj=eval(temp);
		sum+=parseFloat(obj.value)
	}
	temp="document.form1.ID12_4";
	obj4=eval(temp);
	temp="document.form1.ID12_5";
	obj5=eval(temp);
	obj5.value=sum;
	temp="document.form1.ID12_6";
	obj6=eval(temp);
	doCount(obj4,obj5,obj6);
}


function doCount3(obj1,obj2,obj3){
	doCount0(obj1,obj2,obj3);
	var obj;
	var obj4;
	var obj5;
	var obj6;
	var temp;
	var sum=0;
	var number=9;
	for(i=1;i<number;i++){
		if(i<10) 
			temp="document.form1.ID0"+i+"_4";
		else
			temp="document.form1.ID"+i+"_4";
		obj=eval(temp);
		sum+=parseFloat(obj.value)
	}
	temp="document.form1.ID09_4";
	obj4=eval(temp);
	obj4.value=sum;
	temp="document.form1.ID09_5";
	obj5=eval(temp);
	temp="document.form1.ID09_6";
	obj6=eval(temp);
	doCount0(obj4,obj5,obj6);
}




function doCount4(obj1,obj2,obj3){
	doCount0(obj1,obj2,obj3);
	var obj;
	var obj4;
	var obj5;
	var obj6;
	var temp;
	var sum=0;
	var number=9;
	for(i=1;i<number;i++){
		if(i<10) 
			temp="document.form1.ID0"+i+"_5";
		else
			temp="document.form1.ID"+i+"_5";
		obj=eval(temp);
		sum+=parseFloat(obj.value)
	}
	temp="document.form1.ID09_4";
	obj4=eval(temp);
	temp="document.form1.ID09_5";
	obj5=eval(temp);
	obj5.value=sum;
	temp="document.form1.ID09_6";
	obj6=eval(temp);
	doCount0(obj4,obj5,obj6);
}

function doCount5(k){
	var temp;
	var sum=0;
	var number=12;
	for(i=1;i<number;i++){
		if(i<10) 
			temp="document.form1.ID0"+i+"_"+k;
		else
			temp="document.form1.ID"+i+"_"+k;
		obj=eval(temp);
		sum+=parseFloat(obj.value)
	}
	temp="document.form1.ID12_"+k;
	obj4=eval(temp);
	obj4.value=sum;
}



function formatFloat(src, pos)
{
    return Math.round(src*Math.pow(10, pos))/Math.pow(10, pos);
}


// 用电统计表中用到的公式

       //场用电量＝总用电量－转供电量  生产电量＝场用电量－居民电量
function doCount6_1(obj1,obj2,obj3){
		obj3.value=formatFloat((parseFloat(obj1.value)-parseFloat(obj2.value)),0);
}
		//综合单价＝总电费/场用电量
function doCount6_2(obj1,obj2,obj3){
		if(obj1.value!=0){
			obj3.value=formatFloat((parseFloat(obj2.value)/parseFloat(obj1.value)),3);
		}
		else
		{
			obj3.value=formatFloat(0,3);
		}
}

		//计算合计行数据的通用公式 
function doCount6_3(){
	var obj;
	var obj_tmp1;
	var obj_tmp2;
	var obj_tmp3;
	var temp;
	for(j=4;j<21;j++){
		if(j!=13&&j!=14){
			var sum=0;
			for(i=1;i<13;i++){
				if(i<10) 
					temp="document.form1.ID0"+i+"_"+j;
				else
					temp="document.form1.ID"+i+"_"+j;
				obj=eval(temp);
				sum+=parseFloat(obj.value);
			}
			temp="document.form1.ID13_"+j;
			obj_tmp1=eval(temp);
			obj_tmp1.value=sum;
		}
	}
	temp="document.form1.ID13_6";
	obj_tmp1=eval(temp);  //合计行场用电量
	temp="document.form1.ID13_20";
	obj_tmp2=eval(temp);  //合计行总电费
	temp="document.form1.ID13_21";
	obj_tmp3=eval(temp);  //合计行综合单价	
	doCount6_2(obj_tmp1,obj_tmp2,obj_tmp3);
}
				//计算某行总电费的公式
function doCount6_4(obj1,obj2,obj3,obj4,obj5,obj6,obj7,obj8,obj9){
		obj9.value=formatFloat((parseFloat(obj1.value)+parseFloat(obj2.value)+parseFloat(obj3.value)+parseFloat(obj4.value)+parseFloat(obj5.value)+parseFloat(obj6.value)+parseFloat(obj7.value)+parseFloat(obj8.value)),0);
}

                //和电量相关的行和列的计算公式  
                //obj1＝总用电量,obj2＝转供电量,obj3＝场用电量,obj4＝居民电量,obj5＝生产电量,obj6＝总电费,obj7＝综合单价
function doCount7(obj1,obj2,obj3,obj4,obj5,obj6,obj7){
	doCount6_1(obj1,obj2,obj3); //计算场用电量
	doCount6_1(obj3,obj4,obj5); //计算生产电量
	doCount6_2(obj3,obj6,obj7); //计算综合单价
	doCount6_3();               //计算合计行数据
	
}

                //和电费相关的行和列的计算公式  
                //obj1＝居民电费,obj2＝生产电费,obj3＝基本电费,obj4＝力调增减电费,obj5＝中央水库电费,obj6＝综合差价,obj7＝新机平滩,obj8平滩,obj9总电费,obj10场用电量,obj11综合单价
function doCount8(obj1,obj2,obj3,obj4,obj5,obj6,obj7,obj8,obj9,obj10,obj11){
	doCount6_4(obj1,obj2,obj3,obj4,obj5,obj6,obj7,obj8,obj9); //计算总电费
	doCount6_2(obj10,obj9,obj11); //计算综合单价
	doCount6_3();               //计算合计行数据
	
}

	//--- 设备台帐计提折旧时用到的4个公式
	// 计算年折旧额的公式  obj1 为耐用年限 obj2 为设备原值 obj3 为年折旧额 
	// 调用方法为 onBlur="countNZJE(form1.nynx,form1.sbyz,form1.nzje)"
function countNZJE(obj1,obj2,obj3){
	if(obj1.value==0)
	    obj3.value=0;
	else{
		obj3.value=formatFloat((parseFloat(obj2.value)-parseFloat(obj2.value)*0.03)/parseInt(obj1.value),2);
	}
}

	// 计算已提折旧额的公式  time1为当前年份的int值 time2为投产日期年份的int值 obj1 为耐用年限 obj2 为设备原值 obj3 已提折旧额 
	// 调用方法为 onBlur="countYTZJE(time1,time2,form1.nynx,form1.sbyz,form1.ytzje)"
function countYTZJE(time1,time2,obj1,obj2,obj3){
	if(obj1.value==0 )
		obj3.value=0;
	else{
		ysynx=time1-time2;                           //ysynx 为已使用年限
		if(ysynx >= parseInt(obj1.value)){
			obj3.value=formatFloat((parseFloat(obj2.value)-parseFloat(obj2.value)*0.03),2);
		}
		else{
			obj3.value=formatFloat((parseFloat(obj2.value)-parseFloat(obj2.value)*0.03)/parseInt(obj1.value) * ysynx,2);
		}
	}
}


	// 计算净值的公式  time1为当前年份的int值 time2为投产日期年份的int值 obj1 为耐用年限 obj2 为设备原值 obj3 净值 
	// 调用方法为 onBlur="countYTZJE(time1,time2,form1.nynx,form1.sbyz,form1.jz)"
function countJZ(time1,time2,obj1,obj2,obj3){
	if(obj1.value==0)
		obj3.value=formatFloat(parseFloat(obj2.value),2);
	else{
		ysynx=time1-time2;                           //ysynx 为已使用年限
		if(ysynx >= parseInt(obj1.value)){
			obj3.value=formatFloat(parseFloat(obj2.value)*0.03,2);
		}
		else{
			obj3.value=formatFloat((parseFloat(obj2.value)-(parseFloat(obj2.value)-parseFloat(obj2.value)*0.03)/parseInt(obj1.value) * ysynx),2);
		}
	}
}
 
 	// 在投产日期处调用的函数的方式为
	//   onChange="countZJ(time1,time2,form1.nynx,form1.sbyz,form1.nzje,form1.ytzje,form1.jz)"
	// 在耐用年限和设备原值处调用的函数的方式为
	//   onBlur="countZJ(time1,time2,form1.nynx,form1.sbyz,form1.nzje,form1.ytzje,form1.jz)"

function countZJ(time1,obj0,obj1,obj2,obj3,obj4,obj5){
	temp=""+obj0.value+"";
	time2=temp.substring(0,4);
	countNZJE(obj1,obj2,obj3);
	countYTZJE(time1,time2,obj1,obj2,obj4);
	countJZ(time1,time2,obj1,obj2,obj5);
}

