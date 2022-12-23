<%@page contentType="text/html;charset=UTF-8" %>
<%      response.setHeader("Pragma","No-cache"); 
      response.setHeader("Cache-Control","no-cache"); 
      response.setDateHeader("Expires", 0); 
  %>
<HTML>
<HEAD>
		<title></title>
</HEAD>
<style>
body 
{
 font-size:18px;
 font-family:"Tahoma";
}
td
{
 font-size:18px;
 font-family:"Tahoma";
}
.inputdate
{
 border:1px solid #7287c6;
 text-align: center;
 font-size: 12px;
 font-style: normal;
 height: 16px;
}
</style>
<SCRIPT LANGUAGE="JavaScript">
<!--
/********************************************************************
 
参数：
说明：
1.输入框直接调用用以下代码
<Script>DateBox("InputName","DateValue")<\/Script>
其中:InputName 为输入日期的文本框.注:不能为空.
       DateValue  为输入日期的文本框默认日期值.格式为:YYYY-MM-DD.如2004-01-01
                       此值可以不填或为空.则默认值为当天日期.(客户端)
2.其它"按钮"调用用以下代码
CallDate("InputName")
其中:InputName 为输入日期的文本框.注:不能为空.


********************************************************************/

function doInit() {
    if (window.dialogArguments != null && window.dialogArguments.id!="") {
		window.document.all.date.value=window.dialogArguments.id;
    }
    window.returnValue = false;
}
function doOK() {
    window.returnValue = true;
    if (window.returnValue == true && window.dialogArguments != null) {
        window.dialogArguments.id =window.document.all.date.value;
	}
    window.close();
}
function doCancel() {
    window.returnValue = false; 
    window.close();
}

//////////////////////////////////////////////////////////////////////////////////////////
/*基本参数*/
var Frw=400; //日历宽度
var Frh=300; //日历高度
var Frs=4;   //影子大小
var Hid=false;//日历是否打开
/*创建框架*/
document.writeln('<Div align=center id=Calendar Author=smart  scrolling="no" frameborder=0 style="border:0px solid #EEEEEE ;position: absolute; width: '+Frw+'; height: '+Frh+'; z-index: 0; filter :\'progid:DXImageTransform.Microsoft.Shadow(direction=135,color=#AAAAAA,strength='+Frs+')\' ;display: none"></Div>');
/*输入今天日期*/
function SetTodayDate(InputBox)
{
  HiddenCalendar();
  InputBox.value=GetTodayDate();
  doOK();
}
function ClearDate(InputBox)
{
  HiddenCalendar();
  InputBox.value='';
  doOK();
}
/*输入框显示*/
function InputValue(InputBox,Year,Month,Day)
{
  if (Month<10)
  {
    Month='0'+Month
  }
  if (Day<10)
  {
    Day='0'+Day
  }
  InputBox.value=Year+"-"+Month+"-"+Day
  doOK();
}

/*取得今日日期*/
function GetTodayDate()
{
   today= new Date();
   y= today.getYear();
   m= (today.getMonth() + 1);
   if (m<10)
   {
     m='0'+m;
   }
   d= today.getDate();
   if (d<10)
   {
     d='0'+d;
   }
return y+'-'+m+'-'+d
}
/*取某年某月第一天的星期值(月份-1)*/
function GetFirstWeek(The_Year,The_Month)
{
  return (new Date(The_Year,The_Month-1,1)).getDay()
}
/*取某年某月中总天数*/
function GetThisDays(The_Year,The_Month)
{
  return (new Date(The_Year,The_Month,0)).getDate()
}
/*取某年某月上个月中总天数*/
function GetLastDays(The_Year,The_Month)
{
  return (new Date(The_Year,The_Month-1,0)).getDate()
}
/*判断是否是闰年*/
function RunNian(The_Year)
{
 if ((The_Year%400==0) || ((The_Year%4==0) && (The_Year%100!=0)))
  return true;
 else
  return false;
}
/* 判断日期(YYYY.MM.DD)的日期是否正确 */
function DateIsTrue(asDate){
 var lsDate  = asDate + "";
 var loDate  = lsDate.split("-");
 if (loDate.length!=3) return false; 
 var liYear  = parseFloat(loDate[0]);
 var liMonth = parseFloat(loDate[1]);
 var liDay   = parseFloat(loDate[2]);
 if ((loDate[0].length>4)||(loDate[1].length>2)||(loDate[2].length>2)) return false;
 if (isNaN(liYear)||isNaN(liMonth)||isNaN(liDay)) return false;
 if ((liYear<1800)||(liYear>2500)) return false;
 if ((liMonth>12)||(liMonth<=0))   return false;
 if (GetThisDays(liYear,liMonth)<liDay) return false;
 return !isNaN(Date.UTC(liYear,liMonth,liDay));
}
/*取某年某月的周值*/
function GetCountWeeks(The_Year,The_Month)
{
 var Allday;
 Allday = 0;
 if (The_Year>2000)
 {
  
  for (i=2000 ;i<The_Year; i++) 
   if (RunNian(i)) 
    Allday += 366;
   else
    Allday += 365;
  for (i=2; i<=The_Month; i++)
  {
   switch (i)
   {
      case 2 : 
       if (RunNian(The_Year))
        Allday += 29;
       else
        Allday += 28;
       break;
      case 3 : Allday += 31; break;
      case 4 : Allday += 30; break;
      case 5 : Allday += 31; break;
      case 6 : Allday += 30; break;
      case 7 : Allday += 31; break;
      case 8 : Allday += 31; break;
      case 9 : Allday += 30; break;
      case 10 : Allday += 31; break;
      case 11 : Allday += 30; break;
      case 12 :  Allday += 31; break;
   }
  }
 }
return (Allday+6)%7;
}
//上一月
function ForwardMonth(InputBox,Year,Month,Day)
{
    Month=Month-1;
    if (Month<1)
    {
        Month=12;
        Year=Year-1;
        if (Year<1800)
            Year=2500;
    }
  Day=((GetThisDays(Year,Month)<Day)?GetThisDays(Year,Month):Day)
  Hid=false;
  ShowCalendar(InputBox,Year,Month,Day)
}
//下一月
function NextMonth(InputBox,Year,Month,Day)
{
    Month=Month+1;
    if (Month>12)
    {
        Month=1;
        Year=Year+1;
        if (Year>2500)
            Year=1800;
    }
  Day=((GetThisDays(Year,Month)<Day)?GetThisDays(Year,Month):Day)
  Hid=false;
  ShowCalendar(InputBox,Year,Month,Day)
}
//上一年
function ForwardYear(InputBox,Year,Month,Day)
{
    Year=Year-1;
    if (Year<1800)
        Year=2500;
  Day=((GetThisDays(Year,Month)<Day)?GetThisDays(Year,Month):Day)
  Hid=false;
  ShowCalendar(InputBox,Year,Month,Day)
}
//下一年
function NextYear(InputBox,Year,Month,Day)
{
    Year=Year+1;
    if (Year>2500)
        Year=1800;
  Day=((GetThisDays(Year,Month)<Day)?GetThisDays(Year,Month):Day)
  Hid=false;
  ShowCalendar(InputBox,Year,Month,Day)
}
//选择年
function redirectYear(InputBox,Month,index,Day)
{
	Year=index.value;
    if (Year>2500)
        Year=1800;
  Day=((GetThisDays(Year,Month)<Day)?GetThisDays(Year,Month):Day)
  ShowCalendar(InputBox,Year,Month,Day)
}
//选择月
function redirectMonth(InputBox,Year,index,Day)
{
    Month=index.value;
  Day=((GetThisDays(Year,Month)<Day)?GetThisDays(Year,Month):Day)
  Hid=false;
  ShowCalendar(InputBox,Year,Month,Day)
}
/*根据输入框中的日期显示日历*/
function GetCalendar(where)
{
    Hid=false;
    var Box_Name=where.name;
    var Box_value=where.value;
    if (DateIsTrue(Box_value))
    {
    loDate  = Box_value.split("-");
    Y= parseFloat(loDate[0]);
    M= parseFloat(loDate[1]);
    D= parseFloat(loDate[2]);
    ShowCalendar(where,Y,M,D);
    }
  else
  {
    today= new Date();
    y= today.getYear();
    m= (today.getMonth() + 1);
    d=today.getDate();
    ShowCalendar(where,y,m,d);
  }
}

/*隐藏日历*/
function HiddenCalendar()
{
    document.all.Calendar.style.display="none";
}
function CloseCalendar()
{
    document.all.Calendar.style.display="none";
	doCancel();
}
/*显示日历*/
function ShowCalendar(InputBox,The_Year,The_Month,The_Day)
{
    var Now_Year=(The_Year==null?2004:The_Year);
    var Now_Month=(The_Month==null?1:The_Month);
    var Now_Day=(The_Day==null?1:The_Day);
    _current_year.value=Now_Year;
    _current_month.value=Now_Month;
    _current_day.value=Now_Day;

    var Box_Name='window.parent.document.all.'+InputBox.name;
    var fw=GetFirstWeek(Now_Year,Now_Month);
    var ld=GetLastDays(Now_Year,Now_Month);
    var td=GetThisDays(Now_Year,Now_Month);
    var isnd=false;//是否是下个月的日期
    var d=1,w=1;
    var FrameContent;
    var Frl,Frt,Winw,Winh;
/*显示的位置*/
Winw=document.body.offsetWidth;
Winh=document.body.offsetHeight;
Frl=InputBox.getBoundingClientRect().left-2;
Frt=InputBox.getBoundingClientRect().top+InputBox.clientHeight;
if (((Frl+Frw+Frs)>Winw)&&(Frw+Frs<Winw))
  Frl=Winw-Frw-Frs;
if ((Frt+Frh+Frs>Winh)&&(Frh+Frs<Winh))
  Frt=Winh-Frh-Frs;
document.all.Calendar.style.display="";
document.all.Calendar.style.left=Frl;
document.all.Calendar.style.top=Frt;
//显示日历内容
FrameContent="\n<table onselectstart=\"return false;\" border='0' cellpadding='0' cellspacing='0' bgcolor='#395592' width='99%' height='15' style=\"color:white;font-weight:bolder;border:0px solid\">"+"\n<tr>\n";
FrameContent+="<td align=right nowarp width=10%>";
FrameContent+="<img id='_down_year' src='/emadmin/images/c3/up.gif' height='12' border='0' alt='上一年' style='cursor:hand' onclick=\"parent.ForwardYear (window.parent.document.all."+InputBox.name+","+Now_Year+","+Now_Month+","+Now_Day+")\">";
FrameContent+="</td>\n";
FrameContent+="<td width=30% nowarp vAlign=middle align='center'><select  name=\"selectYear\"   onchange=\"parent.redirectYear(window.parent.document.all."+InputBox.name+","+Now_Month+",this.options[this.options.selectedIndex],"+Now_Day+")\">";
for (i=2049;i>1800;i--) {
	if (i==Now_Year) {
		FrameContent+="<option value="+i+" selected>"+i+"</option>";
	} else {
		FrameContent+="<option value="+i+">"+i+"</option>";
	}
}
FrameContent+="</select> 年";
FrameContent+="</td>\n";
FrameContent+="<td align=left width=10%>";
FrameContent+="<img  id='_up_year'  src='/emadmin/images/c3/down.gif' height='12' border='0' alt='下一年' style='cursor:hand' onclick=\"parent.NextYear (window.parent.document.all."+InputBox.name+","+Now_Year+","+Now_Month+","+Now_Day+")\">";
FrameContent+="</td>\n";
FrameContent+="<td vAlign=middle align='center' width='10%'>&nbsp;";
FrameContent+="</td>\n";
FrameContent+="<td  align=right width=10%>";
FrameContent+="<img  id='_up_month'   src='/emadmin/images/c3/up.gif' height='12' border='0' alt='上一月' style='cursor:hand' onclick=\"parent.ForwardMonth (window.parent.document.all."+InputBox.name+","+Now_Year+","+Now_Month+","+Now_Day+")\">";
FrameContent+="</td>\n";
FrameContent+="<td vAlign=middle align='center'  width=20% ><select name=\"selectMonth\"   onchange=\"parent.redirectMonth(window.parent.document.all."+InputBox.name+","+Now_Year+",this.options[this.options.selectedIndex],"+Now_Day+")\">";
for (i=1;i<=12;i++) {
	if (i==Now_Month) {
		FrameContent+="<option value="+i+" selected>"+i+"</option>";
	} else {
		FrameContent+="<option value="+i+">"+i+"</option>";
	}
}
FrameContent+="</select> 月 </td>\n";
FrameContent+="<td  align=left  width=10%>";
FrameContent+="<img id='_down_month'  src='/emadmin/images/c3/down.gif' height='12' border='0' alt='下一月' style='cursor:hand' onclick=\"parent.NextMonth (window.parent.document.all."+InputBox.name+","+Now_Year+","+Now_Month+","+Now_Day+")\">";
FrameContent+="</td>"+"\n";
FrameContent+="</tr>"+"\n";
FrameContent+="</table>"+"\n";
FrameContent+="<table onselectstart=\"return false;\" border='0' cellpadding='0' cellspacing='1' width='99%' bgcolor='#CCCCCC'>"+"\n";
FrameContent+="<tr bgcolor='#F5F5F5'>"+"\n";
FrameContent+="<td><center>一</center></td>"+"\n";
FrameContent+="<td><center>二</center></td>"+"\n";
FrameContent+="<td><center>三</center></td>"+"\n";
FrameContent+="<td><center>四</center></td>"+"\n";
FrameContent+="<td><center>五</center></td>"+"\n";
FrameContent+="<td><center>六</center></td>"+"\n";
FrameContent+="<td><center><font color='#FF0000'>日</font></center></td>"+"\n";
FrameContent+="</tr>"+"\n";
//如果本月第一天是星期一或星期天.应加上七.保证可以看到上个月的日期
    if (fw<2)
      tf=fw+7;
    else
      tf=fw;
      FrameContent+="<tr bgcolor='#FFFFFF'>"+"\n";
      //第一行上月日期
      for (l=(ld-tf+2);l<=ld;l++)
      {
        FrameContent+="<td  onclick=\"parent.ForwardMonth (window.parent.document.all."+InputBox.name+","+Now_Year+","+Now_Month+","+l+")\" style='cursor:hand'><center><font color='#BBBBBB'>"+l+"</font></center></td>"+"\n";
        w++;
      }
      //第一行本月日期
      for (f=tf;f<=7;f++)
      {
         //星期天但非输入日期
         if (((w%7)==0)&&(d!=Now_Day))
           FrameContent+="<td onMouseOver=\"this.style.background=\'#E1E1E1\'\" onMouseOut=\"this.style.background=\'#FFFFFF\'\" onclick=\"parent.InputValue(window.parent.document.all."+InputBox.name+","+Now_Year+","+Now_Month+","+d+");\" style='cursor:hand'><center><font color='#FF0000'>"+d+"</font></center></td>"+"\n";
         //日期为输入日期
         else if (d==Now_Day)
           FrameContent+="<td style=\"background:#420042;cursor:hand\" onclick=\"parent.InputValue(window.parent.document.all."+InputBox.name+","+Now_Year+","+Now_Month+","+d+");\"><center><font color='#FFFFFF'>"+d+"</font></center></td>"+"\n";
         //其它
         else
           FrameContent+="<td onMouseOver=\"this.style.background=\'#E1E1E1\'\" onMouseOut=\"this.style.background=\'#FFFFFF\'\" onclick=\"parent.InputValue(window.parent.document.all."+InputBox.name+","+Now_Year+","+Now_Month+","+d+");\" style='cursor:hand'><center>"+d+"</center></td>"+"\n";
        d++;
        w++;
      }
      FrameContent+="</tr>"+"\n";
    w=1;
    for (i=2;i<7;i++)
    {
      FrameContent+="<tr bgcolor='#FFFFFF'>"+"\n";
      for (j=1;j<8;j++)
      {
         if (isnd)//下个月的日期
         FrameContent+="<td style='cursor:hand' onclick=\"parent.NextMonth (window.parent.document.all."+InputBox.name+","+Now_Year+","+Now_Month+","+d+")\"><center><font color='#BBBBBB'>"+d+"</font></center></td>"+"\n";
         else//本月的日期
        {
           //星期天但非输入日期
           if (((w%7)==0)&&(d!=Now_Day))
             FrameContent+="<td onMouseOver=\"this.style.background=\'#E1E1E1\'\" onMouseOut=\"this.style.background=\'#FFFFFF\'\" onclick=\"parent.InputValue(window.parent.document.all."+InputBox.name+","+Now_Year+","+Now_Month+","+d+");parent.HiddenCalendar()\" style='cursor:hand'><center><font color='#FF0000'>"+d+"</font></center></td>"+"\n";
           //日期为输入日期
           else if (d==Now_Day)
             FrameContent+="<td style=\"background:#420042;cursor:hand\" onclick=\"parent.InputValue(window.parent.document.all."+InputBox.name+","+Now_Year+","+Now_Month+","+d+");\"><center><font color='#FFFFFF'>"+d+"</font></center></td>"+"\n";
           //其它
           else
             FrameContent+="<td onMouseOver=\"this.style.background=\'#E1E1E1\'\" onMouseOut=\"this.style.background=\'#FFFFFF\'\" onclick=\"parent.InputValue(window.parent.document.all."+InputBox.name+","+Now_Year+","+Now_Month+","+d+");\" style='cursor:hand'><center>"+d+"</center></td>"+"\n";
        }
        //判断是否为本月的日期
        if (d==td)
        {
          isnd=true;
          d=0;
        }
        w++;
        d++;
      }
      FrameContent+="</tr>"+"\n";
    }
FrameContent+="</table>"+"\n";
FrameContent+="<table onselectstart=\"return false;\" cellpadding='0' cellspacing='0' bgcolor='#F5F5F5' width='99%' height='15'>"+"\n<tr>\n";
FrameContent+="<td nowarp title=\"今日:"+GetTodayDate()+"\" style=\"cursor:hand\" onclick=\"parent.SetTodayDate(window.parent.document.all."+InputBox.name+")\">";
FrameContent+="<font color=red>今日:</font>"+GetTodayDate();
FrameContent+="</td>\n";
FrameContent+="<td>";
FrameContent+="<span  width='13' height='13' alt='清空日期' style='cursor:hand;color:blue;' onclick=\"parent.ClearDate(window.parent.document.all."+InputBox.name+")\"><b>清空日期</b></span>";
FrameContent+="</td>\n";
FrameContent+="</tr>\n";
document.all.Calendar.innerHTML=FrameContent;
document.all.Calendar.style.display="";
}
//-->
</SCRIPT>
<BODY onload="temp.focus();">
<input size='1' readonly type='text'   name='temp' value=''>
<input size='1' readonly   type='hidden'  name='date' value=''>
<input size='1' readonly   type='hidden'   name='_current_year' value=''>
<input size='1' readonly   type='hidden'   name='_current_month' value=''>
<input size='1'  readonly  type='hidden'   name='_current_day' value=''>
</BODY>
<SCRIPT LANGUAGE="JavaScript">
<!--
	doInit();
	GetCalendar(window.document.all.date);

    document.onkeyup = function(){ _hotkey() };

	function _hotkey (){

         if (event.keyCode==33 && event.ctrlKey) {  //如果是ctl+pageup 则上翻年
                _up_year.click();
                return;
         }
         if (event.keyCode==34 && event.ctrlKey) {  //如果是ctl+pagedown 则上翻年
                _down_year.click();
                return;
         }
         if (event.keyCode==33 ) {  //如果是ctl+pageup 则上翻年
                _up_month .click();
                return;
         }
         if (event.keyCode==34) {  //如果是ctl+pagedown 则上翻年
                _down_month .click();
                return;
         }
		 if	(event.keyCode==40) {  //下箭头
                var nextDay=new Date();
                nextDay.setTime(new Date(_current_year.value,_current_month.value,_current_day.value).getTime()+7*24*60*60*1000);
				ShowCalendar(window.document.all.date,nextDay.getYear(),nextDay.getMonth(),nextDay.getDate());
				return;
		 }
		 if	(event.keyCode==38) {  //上箭头
                var nextDay=new Date();
                nextDay.setTime(new Date(_current_year.value,_current_month.value,_current_day.value).getTime()-7*24*60*60*1000);
				ShowCalendar(window.document.all.date,nextDay.getYear(),nextDay.getMonth(),nextDay.getDate());
				return;
		 }
		 if	(event.keyCode==37) {  //左箭头
                var nextDay=new Date();
                nextDay.setTime(new Date(_current_year.value,_current_month.value,_current_day.value).getTime()-1*24*60*60*1000);
				ShowCalendar(window.document.all.date,nextDay.getYear(),nextDay.getMonth(),nextDay.getDate());
				return;
		 }
		 if	(event.keyCode==39) {  //右箭头
                var nextDay=new Date();
                nextDay.setTime(new Date(_current_year.value,_current_month.value,_current_day.value).getTime()+1*24*60*60*1000);
				ShowCalendar(window.document.all.date,nextDay.getYear(),nextDay.getMonth(),nextDay.getDate());
				return;
		 }
		 if (event.keyCode==13) {   //回车
				InputValue(window.document.all.date,_current_year.value,_current_month.value,_current_day.value);
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
	 }



//-->
</SCRIPT>
</HTML>

