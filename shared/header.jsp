<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/emadmin/shared/checkPermission1.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>无标题文档</title>

<style type="text/css">
<!--
* {
	margin: 0px;
	padding: 0px;
	}
	
body {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
    
}
#navigation {
	width: 1024px;
	height: 64px;
	background: url(../images/header/header_bg.gif) repeat-x;
	float:left;
	}
#navigation a {
	height: 60px;
	width: 59px;
	display: block;
	float: left;
	margin: 0px 3px 0px 3px;
	background: no-repeat center top;
}
#navigation li {
	display:inline;
	float: left;
	
}

#photo { width:200px;}
#photo div { 
	width:45px;
	height: 45px;
	float: left;
	border:1px solid #999;
	background:#FFFFFF;
	margin: 8px 0px 0px 10px;

	}
#photo dl { 
	width:120px;
	height: 40px;
	float: right;
    margin: 14px 2px 0px 0px;
	line-height: 26px;
	}

#line { 
	background: url(../images/header/header_01.gif) ;
	height: 64px;
	width: 2px;
	float: left;

}


#ht a {
	background: url(../images/header/header_button_ht01.gif) ;
	
}
#ht a:hover {
	background: url(../images/header/header_button_ht02.gif);
}
#qj a {
	background: url(../images/header/header_button_qj01.gif);
}
#qj a:hover {
	background: url(../images/header/header_button_qj02.gif);
}
#zm a {
	background: url(../images/header/header_button_zm01.gif);
}
#zm a:hover {
	background: url(../images/header/header_button_zm02.gif);
}
#zsgl a {
	background: url(../images/header/header_button_zsgl01.gif);
}
#zsgl a:hover {
	background: url(../images/header/header_button_zsgl02.gif);
}
#rwgl a {
	background: url(../images/header/header_button_rwgl01.gif) ;
}
#rwgl a:hover {
	background: url(../images/header/header_button_rwgl02.gif);
}
#dbsx a {
	background: url(../images/header/header_button_dbsx01.gif);
}
#dbsx a:hover {
	background: url(../images/header/header_button_dbsx02.gif);
}
#jsb a {
	background: url(../images/header/header_button_jsb01.gif);
}
#jsb a:hover {
	background: url(../images/header/header_button_jsb02.gif);
}
#txl a {
	background: url(../images/header/header_button_txl01.gif);
}
#txl a:hover {
	background: url(../images/header/header_button_txl02.gif);
}
#cktx a {
	background: url(../images/header/header_button_cktx01.gif);
}
#cktx a:hover {
	background: url(../images/header/header_button_cktx02.gif);
}
#tlq a {
	background: url(../images/header/header_button_tlq01.gif);
}
#tlq a:hover {
	background: url(../images/header/header_button_tlq02.gif);
}
#aqtc a {
	background: url(../images/header/header_button_aqtc01.gif);
}
#aqtc a:hover {
	background: url(../images/header/header_button_aqtc02.gif);
}
#menu {
	width:140px;
	height: 70px;
	border:1px solid #999;
	background:#FFF;
	display:none;
	}
#menu_ul {
	padding:1px;
	}
#menu_ul li {
	display:inline;
	float:left;
	}
#menu_right_ul li{
	width:90px;
	height:22px;
	padding:2px 0px 0px 4px; 

	}
#menu_left {
	background:#9cf;
	width:24px;
	height:68px;
	overflow: hidden;
	}
	
	



-->
</style>
<script type="text/javascript">
	function setTarget(){
		var ul = document.getElementById("navigation")	;
		var lis = ul.getElementsByTagName("li");
		for(var i=0;i<lis.length;i++){
			var li = lis[i];
			if(li.childNodes[0]!=null&&li.childNodes[0].nodeName=="A"){
				var a = li.childNodes[0];
				if(li.id!='ht' && li.id!='qj'){
					a.setAttribute("target","base");
				}
			}
		}	
	}
	
	function showmenu(id,liid,showtype){
		var obj = document.getElementById(id);
		var liobj = document.getElementById(liid);
		var xpos = liobj.offsetLeft;
		var ypos = liobj.offsetTop;
		obj.style.position="absolute";
		obj.style.left = parseInt(xpos)+4+"px";
		obj.style.top = parseInt(ypos)+60+"px";
		obj.style.display=showtype;
	}
</script>
</head>
<body onload="setTarget()">
<ul id="navigation">
   <li id="photo">
      <div></div>
	  <dl> 
		  <dd><%=session.getAttribute("userId")!=null?session.getAttribute("userId"):"未知"%>&nbsp;&nbsp;	技术部门<br />未查看提醒 <img src="../images/header/header_msn.gif" width="16" height="11" border="0"> (5)
          </dd>  
      </dl> 
   </li>
   <li id="line"></li>
   <li id="ht"><a href="#" onclick="history.back(-1)"></a></li>
   <li id="qj"><a href="#" onclick="history.go(+1)"></a></li>
   <li id="line"></li>
   <li id="zm"><a href="#"></a></li>
   <li id="zsgl"><a href="/emadmin/jsp/forum/web/index.jsp"></a></li>
   <li id="rwgl"><a href="/emadmin/jsp/common/list.jsp?modul_id=oa_rw_main__listModul" ></a></li>
   <li id="dbsx"><a href="/emadmin/jsp/common/daiban_shixiang.jsp?modul_id=jc_daibanshixiang_Modul"></a></li>
   <li id="jsb"><a href="/emadmin/jsp/oa/notebook/notebook.jsp"></a></li>
   <li id="txl"><a href="/emadmin/jsp/common/list.jsp?modul_id=rs_da_ygtxl_listModul"></a></li> 
   <li id="cktx"><a href="/emadmin/jsp/common/list.jsp?modul_id=oa_alert_listModul" onmousemove="showmenu('menu','cktx','block')" onmouseout="showmenu('menu','cktx','none')" onclick="return false();"></a></li>
   <li id="tlq"><a href="/emadmin/jsp/common/list.jsp?modul_id=rs_da_ygtxl_listModul"></a></li>
   <li id="aqtc"><a href="/emadmin/index.jsp?type=logoff"></a></li>
</ul>

<div id="menu" onmousemove="showmenu('menu','cktx','block')" onmouseout="showmenu('menu','cktx','none')">
<ul id="menu_ul">
	<li id="menu_left"></li>
	<li id="menu_right">
		<ul id="menu_right_ul">
			<li>查看提醒</li>
			<li>预存提醒</li>
			<li>自动弹出提醒<em>√</em></li>
		</ul>
	</li>
</ul>
</div>

</body>
</html>