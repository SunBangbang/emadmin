<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*" %>
<%  if(session.getAttribute("userId")==null)  { %>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
		window.returnValue = false;
		window.dialogArguments.relogin=1;
		window.dialogArguments.url='/emadmin/index.jsp';
		window.close();
	//-->
	</SCRIPT>
<%}%>
<%


		
		String result  = Serve.getCwKmXgsxTemplate( request ); 


%>

<html>
<head>
<title><%=Serve.popGetTitle(request.getParameter("popid"))%></title>
<%@include file="/emadmin/shared/headres.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/emadmin/css/main.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Pragma" content="no-cache">
</head>


<BODY>
<table width="100%"  border="0" align="center">
  <tr>
    <td align="center" valign="middle">
	<form name='form1' >
		<%=result%>
		
		      <br>
     <img src="/emadmin/images/c2/button/pop_ok.gif" onMouseOver="this.style.cursor='hand'"   onClick="doOK();"/>

	</form>	
	</td>
  </tr>
</table>
</BODY>
<script language="JavaScript">
<!--

function _doSelect_mainarea_kh() {  
                 var  mySubDialog = new Array(1); 
                 var  idValue=''; 
                 result=window.open('/emadmin/shared/popwindow.jsp?bringinitems=id,khjc&popid=win_khda&modul_id=cw_jzpz_addModul&keywords=' + idValue, mySubDialog,"resizable:Yes;status:no;dialogHeight:500px;dialogWidth:700px;"); 
                 if (result!=true) { 
                           return; 
                 } else { 
                           document.getElementsByName('kh_id' )[0].value=mySubDialog[0][1]; 
                           document.getElementsByName('kh' )[0].value=mySubDialog[0][2];                            
                 }  
} 




function _doSelect_mainarea_gr() {  
                 var  mySubDialog = new Array(1); 
                 var  idValue=''; 
                 result=window.open('/emadmin/shared/popwindow.jsp?bringinitems=yh_id,yh_mc&popid=win_yh_detail&modul_id=cw_jzpz_addModul&keywords=' + idValue, mySubDialog,"resizable:Yes;status:no;dialogHeight:500px;dialogWidth:700px;"); 
                 if (result!=true) { 
                           return; 
                 } else { 
                           document.getElementsByName('gr_id' )[0].value=mySubDialog[0][1]; 
                           document.getElementsByName('gr' )[0].value=mySubDialog[0][2]; 
                 }  
} 


function _doSelect_mainarea_xm() {  
                 var  mySubDialog = new Array(1); 
                 var  idValue=''; 
                 result=window.open('/emadmin/shared/popwindow.jsp?bringinitems=id,xmmc&popid=win_cw_xmxx&modul_id=cw_jzpz_addModul&keywords=' + idValue, mySubDialog,"resizable:Yes;status:no;dialogHeight:500px;dialogWidth:700px;"); 
                 if (result!=true) { 
                           return; 
                 } else { 
                           document.getElementsByName('xm_id' )[0].value=mySubDialog[0][1]; 
                           document.getElementsByName('xm' )[0].value=mySubDialog[0][2]; 
                 }  
} 



function _doSelect_mainarea_gys() {  
                 var  mySubDialog = new Array(1); 
                 var  idValue=''; 
                 result=window.open('/emadmin/shared/popwindow.jsp?bringinitems=id,gysjc&popid=win_gysda&modul_id=cw_jzpz_addModul&keywords=' + idValue, mySubDialog,"resizable:Yes;status:no;dialogHeight:500px;dialogWidth:700px;"); 
                 if (result!=true) { 
                           return; 
                 } else { 
                           document.getElementsByName('gys_id' )[0].value=mySubDialog[0][1]; 
                           document.getElementsByName('gys' )[0].value=mySubDialog[0][2]; 
                 }  
} 



function doOK() {
	if( doCheck( document.form1 ) )	
	{
		window.returnValue = true;
		if (window.returnValue == true && window.dialogArguments != null) {

			bmselect =form1.bmselect.value;
			if (bmselect != null && bmselect !="")
			{
				bmPos = bmselect.indexOf('fg'); //分割符号的位置

				window.dialogArguments.bm = bmselect.substr(bmPos+2,bmselect.length);
				window.dialogArguments.bm_id = bmselect.substr(0,bmPos);
			}
			else
			{
				window.dialogArguments.bm ="";
				window.dialogArguments.bm_id ="";

			}

			jsfsselect = form1.jsfsselect.value;
			if (jsfsselect != null && jsfsselect !="")
			{
				jsfsPos = jsfsselect.indexOf('fg'); //分割符号的位置

				window.dialogArguments.jsfsmc = jsfsselect.substr(jsfsPos+2,jsfsPos.length);
				window.dialogArguments.jsfs   = jsfsselect.substr(0,jsfsPos);
			}
			else
			{
				window.dialogArguments.jsfsmc ="";
				window.dialogArguments.jsfs   ="";

			}



			window.dialogArguments.kh =form1.kh.value;
			window.dialogArguments.kh_id =form1.kh_id.value;

			window.dialogArguments.gys =form1.gys.value;
			window.dialogArguments.gys_id =form1.gys_id.value;

			window.dialogArguments.xm =form1.xm.value;
			window.dialogArguments.xm_id =form1.xm_id.value;

			window.dialogArguments.gr =form1.gr.value;
			window.dialogArguments.gr_id =form1.gr_id.value;


			window.dialogArguments.biz =form1.biz.value;
			window.dialogArguments.huil =form1.huil.value;
			window.dialogArguments.wbdfje =form1.wbdfje.value;
			window.dialogArguments.wbjfje =form1.wbjfje.value;

			window.dialogArguments.zsfs =form1.zsfs.value;
			window.dialogArguments.dfje ="";
			window.dialogArguments.jfje ="";

			window.dialogArguments.ph =form1.ph.value;
			window.dialogArguments.fsrq =form1.fsrq.value;


			 

			if (window.dialogArguments.biz != null && window.dialogArguments.biz !="")
			{
				if (window.dialogArguments.huil == null || window.dialogArguments.huil <= 0) 
				{
					alert("请输入汇率!");
					form1.huil.focus();
				}

				if (window.dialogArguments.wbdfje != null && window.dialogArguments.wbdfje !="") //借方 和贷方 只保留一个
				{
					window.dialogArguments.wbjfje = "";
					if (window.dialogArguments.zsfs!=null && window.dialogArguments.zsfs == "1")
						window.dialogArguments.dfje  = window.dialogArguments.wbdfje /window.dialogArguments.huil;
					else
						window.dialogArguments.dfje  = window.dialogArguments.wbdfje * window.dialogArguments.huil;

					window.dialogArguments.dfje = Math.round(window.dialogArguments.dfje*100)/100;
					

				}
				else  // 计算 借方金额
				{

					window.dialogArguments.wbdfje = "";

					if (window.dialogArguments.wbjfje == null || window.dialogArguments.wbjfje =="")
						window.dialogArguments.wbjfje = 0;


					if (window.dialogArguments.zsfs!=null && window.dialogArguments.zsfs == "1")
						window.dialogArguments.jfje  = window.dialogArguments.wbjfje /window.dialogArguments.huil;
					else
						window.dialogArguments.jfje  = window.dialogArguments.wbjfje * window.dialogArguments.huil;

					window.dialogArguments.jfje = Math.round(window.dialogArguments.jfje*100)/100;

				}
					

			}



			window.dialogArguments.xgsx ="";
			if (jsfsselect != null && jsfsselect !="")
			{
				window.dialogArguments.xgsx += " 结算方式:" +window.dialogArguments.jsfsmc;
				window.dialogArguments.xgsx += " 票号:" +window.dialogArguments.ph;
				window.dialogArguments.xgsx += " 发生日期:" +window.dialogArguments.fsrq;
			}


			if (window.dialogArguments.biz != null && window.dialogArguments.biz !="")
			{
				window.dialogArguments.xgsx += " 币种:" +window.dialogArguments.biz;
				window.dialogArguments.xgsx += " 汇率:" +window.dialogArguments.huil;

				if (window.dialogArguments.wbdfje != null && window.dialogArguments.wbdfje !="")
					window.dialogArguments.xgsx += " 外币贷方金额:" +window.dialogArguments.wbdfje;
				else
					window.dialogArguments.xgsx += " 外币借方金额:" +window.dialogArguments.wbjfje;

			}

			

			if (bmselect != null && bmselect !="")
				window.dialogArguments.xgsx += "  部门:" +window.dialogArguments.bm;

			if (window.dialogArguments.kh !=null && window.dialogArguments.kh !=""){
				window.dialogArguments.xgsx += "  客户:" + window.dialogArguments.kh;
				
			}

			if (window.dialogArguments.gys !=null && window.dialogArguments.gys !=""){
				window.dialogArguments.xgsx += "  供应商:" + window.dialogArguments.gys;
				
			}

			if (window.dialogArguments.xm !=null && window.dialogArguments.xm !=""){
				window.dialogArguments.xgsx += "  项目:" + window.dialogArguments.xm;
				
			}

			if (window.dialogArguments.gr !=null && window.dialogArguments.gr !=""){
				window.dialogArguments.xgsx += "  个人:" + window.dialogArguments.gr;
				
			}


			
		}
		window.close();
	}

}
//-->
</script>

</HTML>