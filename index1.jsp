<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*,java.net.*"%>
<%@include file="/emadmin/shared/checkPermission1.jsp"%>
<%@include file="/emadmin/version.jsp"%>
<%
				/*
					设置为不缓存
				*/
                response.setHeader("Pragma","No-cache"); 
                response.setHeader("Cache-Control","no-cache"); 
                response.setDateHeader("Expires", 0); 
				/*
					将用户的Session信息储存时间设置为2小时
				*/
                session.setMaxInactiveInterval(60*60*2);
				String isPopAlert=Server.getPreference("001",(String)session.getAttribute("userId"));
                String _productCode=Api.getXtPreferenceValueByName("productCode");
                String _is_support_warning=Api.getXtPreferenceValueByName("is_support_warning");
                String gsjc[]=Api.sb("select top 1  gsjc from xt_gs_da");
				   String productModuls=Api.getXtPreferenceValueByName("prodcutModul");
				   if ("".equals(productModuls)){
							productModuls="oa";
				   }
				   productModuls=productModuls.toLowerCase(); 
				String time=Util.getDate(); //获得服务器系统时间
				String[] week =Util.getCalendar(time);//取得当前第几周
				if(week[4].equals("0"))
					week[4]="星期日";
				if(week[4].equals("1"))
					week[4]="星期一";
				if(week[4].equals("2"))
					week[4]="星期二";
				if(week[4].equals("3"))
					week[4]="星期三";
				if(week[4].equals("4"))
					week[4]="星期四";
				if(week[4].equals("5"))
					week[4]="星期五";
				if(week[4].equals("6"))
					week[4]="星期六";
%>
<html>
<head>
<title>北京安创明圣科技发展有限公司 企业管理软件</title>
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META http-equiv="Page-Enter"
			CONTENT="RevealTrans(Duration=4,Transition=14)">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" /> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/c1/style_new.css" rel="stylesheet" type="text/css">
<STYLE type="text/css"> 
body {
	padding: 0px;
	margin-top:0px;
	margin-left:0px;
	margin-right:0px;
	margin-bottom:0px;
	overflow:hidden;
}
a:link { color:black;}
a:visited { color:black;text-decoration:none; }
a:hover { color:white; }

.spanCSS{
	width:100;vertical-align:top;line-height:44px;height:44px;
}
.spanCSS1{
	width:70;vertical-align:top;line-height:44px;height:44px;
}
</STYLE>
<script language="javascript" type="text/javascript" src="/emadmin/js/TmA4drv.js"></script>
<script type="text/javascript"> 
 
 window.onunload = onunload_handler;   
 function onunload_handler(){   
		if(window.screenLeft>=10000 && window.screenTop>=10000){
				//点击工具栏上的[X]按钮、或ALT+F4关闭时触发 
				var xmlhttp   =   new   ActiveXObject("Microsoft.XMLHTTP");   
				xmlhttp.open("GET",   "/emadmin/index.jsp?type=logoff",   false);   
				xmlhttp.send();    
				closewindow.close();
		}
    } 
	function setTarget(){
		main_area.style.height=parseInt(document.body.clientHeight)-29-47-44-31+"px";
		main_area.style.top=29+47+44+"px";

		document.all.left_border_div.style.height=parseInt(document.body.clientHeight)-29-47-44-31+"px"; //设置左边的细边框
		
		document.all.left_frame.style.height=parseInt(document.body.clientHeight)-29-47-44-31+"px"; //设置左边导航树
		document.all.left_frame.style.left=5+"px"; //设置左边导航树

		document.all.right_frame.style.height=parseInt(document.body.clientHeight)-29-47-44-31+"px"; //设置右边主页面
		document.all.right_frame.style.width=parseInt(document.body.clientWidth)-(parseInt(document.body.clientWidth)*0.2)-4+"px"; //设置右边主页面

		document.all.hide_doc_div.style.height=parseInt(document.body.clientHeight)-29-47-44-31+"px"; //设置隐藏边框
		document.all.hide_doc_div.style.left=(parseInt(document.body.clientWidth)*0.2)+"px";


		document.all.right_border_div.style.height=parseInt(document.body.clientHeight)-29-47-44-31+"px"; //设置右边的细边框
		document.all.right_border_div.style.left=parseInt(document.body.clientWidth)-5+"px";

		footer_area.style.top=parseInt(document.body.clientHeight)-31+"px";
		 <%if(_is_support_warning.equals("1")){%>
			window.setInterval("getAlert()",10000);//每隔10秒定时查看提醒
		<%}%>
		TV_Initialize();
	}
	
	function showmenu(id,liid,showtype){
		var obj = document.getElementById(id);
		var liobj = document.getElementById(liid);
		var xpos = liobj.offsetLeft;
		var ypos = liobj.offsetTop;
		obj.style.position="absolute";
		obj.style.left = parseInt(xpos)+700+"px";
		obj.style.top = parseInt(ypos)+10+"px";
		obj.style.display=showtype;
	}
    function show_menu_window (img) {
           if (img.alt=="隐藏菜单") {
               img.alt="显示菜单";
                img.src="images/c3/hide-ok.gif";
                document.all.left_doc_div.style.width="0%";
                document.all.right_doc_div.style.width=parseInt(document.body.clientWidth)-5+"px";
				document.all.right_frame.style.width=parseInt(document.body.clientWidth)-5+"px";
				document.all.hide_doc_div.style.left="4px";
          } else {
               img.alt="隐藏菜单";
               img.src="images/c3/hide-no.gif";
			    document.all.left_doc_div.style.width="20%";
				document.all.left_frame.style.left=5+"px";
				document.all.right_frame.style.width=parseInt(document.body.clientWidth)-(parseInt(document.body.clientWidth)*0.2)-4+"px";
				document.all.hide_doc_div.style.left=(parseInt(document.body.clientWidth)*0.2)+"px";
				document.all.right_border_div.style.left=parseInt(document.body.clientWidth)-5+"px";
           }
    }
</script>
<script language="javascript" type="text/javascript">
<!-- 
//开始取最新提醒  by ajax
function getAlert(){
	var ajaxRequest;  //定义ajax对象
	var resultText;  //返回的结果
	try{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	} catch (e){
		// Internet Explorer Browsers
		try{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e){
				// Something went wrong
				// alert("你的浏览器有问题，不支持自动提醒!");
				return false;
			}
		}
	}
	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function(){
		if(ajaxRequest.readyState == 4){
            if(ajaxRequest.status==200){
            	var is_sound=document.getElementById("alertMessage").value;//判断是否要发出提示音
                document.getElementById("alertMessage").value=ajaxRequest.responseText;
                if (document.getElementById("alertMessage").value.length>19) {  //没有trim,返回的空串长度是19
                    if(is_sound.length==0||(is_sound!=document.getElementById("alertMessage").value))//如果是第一次则提示
                   		document.getElementById('messagesound').play();
                    if (document.getElementById("isPopAlert").value=="1") {
                        doAlert();
                        left.menu_dxxs.innerHTML="<img src='/emadmin/images/c3/tree_top_message_m.gif' border='0'>&nbsp;<font class='tree_font'>您没有新短消息</font>";
                    } else {
                    	var count=document.getElementById("alertMessage").value.split('window.open').length-1;
                    	var message=document.getElementById("alertMessage").value;
                        left.menu_dxxs.innerHTML="<span style=\"cursor:hand\" onclick=doAlert(\""+escape(message)+"\")><img src='/emadmin/images/c3/tree_top_message_yd.gif' border='0'>&nbsp;<font class='tree_font'>您有<font color='red'>"+count+"</font>条短消息</font></span>";
                    }
                }
            }
		}
	}

	ajaxRequest.open("GET", "/emadmin/jsp/oa/xt_getAlertForAjax.jsp", true);
	ajaxRequest.send(null); 
}
function doAlert(){
	if (document.getElementById("alertMessage").value.length>19) {
		eval(document.getElementById("alertMessage").value);
		document.getElementById("alertMessage").value="";
	}
}

//设置提醒的弹出类型,用ajax提交
function setPopAlert(){
	//首先先把界面的信息变过来
	
	var isPopAlert=document.getElementById("isPopAlert").value;
	if (isPopAlert=="1") {
		document.getElementById("isPopAlert").value="0";
		document.getElementById("checkPopAlert").checked=false;
	} else {
		document.getElementById("isPopAlert").value="1";
		document.getElementById("checkPopAlert").checked=true;
	}
	//开始提交更新数据库中的用户参数
	var ajaxRequest;  //定义ajax对象
	var resultText;  //返回的结果
	
	try{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	} catch (e){
		// Internet Explorer Browsers
		try{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e){
				// Something went wrong
				alert("你的浏览器有问题，不支持自动提醒!");
				return false;
			}
		}
	}
	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function(){
		if(ajaxRequest.readyState == 4){
			//提交成功！
		}
	}
	ajaxRequest.open("POST", "/emadmin/jsp/oa/xt_setPopAlertForAjax.jsp", false);
	ajaxRequest.setRequestHeader("CONTENT-TYPE","application/x-www-form-urlencoded");
	ajaxRequest.send("type="+document.getElementById("isPopAlert").value); 
}

//-->
</script>
<script language="javascript"> 
//从服务器上获取初始时间 
var currentDate = new Date(<%=new java.util.Date().getTime()%>); 
function run() 
{ 
currentDate.setSeconds(currentDate.getSeconds()+1); 
document.getElementById("dt").innerHTML ="【安创明圣提醒你】现在时间是："+ currentDate.toLocaleString().substring(currentDate.toLocaleString().lastIndexOf(" ")+1,currentDate.toLocaleString().length); 
} 
window.setInterval("run();", 1000); 

window.onresize=setTarget;
</script> 


</head>
<body onLoad="setTarget();">
<!--整个页面的顶部-->
<div id="main_logo" >
	<table width="100%" border ="0" cellpadding="0" cellspacing="0">
		<tr>
			<td class="x_index1_top_left">
				<input type="hidden" id="_global_save" value="">
			</td>
			<td class="x_index1_top_middle">
				&nbsp;
			</td>
		 	<td class="x_index1_top_right">
		    <% if (productModuls.indexOf("oa")>-1) {%>
				<a href="/emadmin/jsp/forum/web/index.jsp" target="base"><font class="index1_font">▪&nbsp;知识管理</font></a>&nbsp;&nbsp;
				<a href="/emadmin/jsp/oa/notebook/notebook.jsp?group_id=01&group_color=DEB887" target="base"><font class="index1_font">▪&nbsp;记事本</font></a>&nbsp;&nbsp;
            <%}%>
			<%if (productModuls.indexOf("oa")>-1) {%>
				<a href="/emadmin/jsp/common/list.jsp?modul_id=oa_txl_gg_listModul" target="base"><font class="index1_font">▪&nbsp;通讯录</font></a>&nbsp;
		    <%}%>
     		<%if(_is_support_warning.equals("1")){%>
				<a href="#" onclick="window.open('/emadmin/jsp/oa/xt_alert_add.jsp','','status=yes,left=250,top=100,height=509,width=650,status=no,directories=no,resizable=yes,scrollbars=no')"><font class="index1_font">▪&nbsp;发送提醒</font></a>&nbsp;&nbsp;
				<a href="/emadmin/jsp/common/list.jsp?modul_id=oa_alert_listModul" target="base"><font class="index1_font">▪&nbsp;查看提醒</font></a>&nbsp;

				<input type="hidden" id="alertMessage" value="">
                <input type="hidden" id="isPopAlert"  value="<%=isPopAlert%>">
            <%}if(_is_support_warning.equals("1")){
     			 %><font class="index1_font">▪&nbsp;<input  id='checkPopAlert' type='checkbox' value='1'  <%=isPopAlert.equals("1")?"checked":""%>  onclick="setPopAlert()" >
				自动弹出消息</font>
			<%} %>&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
	</table>
	<table width="100%" border ="0" cellpadding="0" cellspacing="0">
		<tr>
			<td class="x_index1_banner_left">
			</td>
			<td class="x_index1_banner_middle">
				&nbsp;
			</td>
			<td class="x_index1_banner_right" >
				<font color="white"><%=time%>&nbsp;&nbsp;<%=week[4]%></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<br>
				
			</td>
		</tr>
	</table>
	<table width="100%" border ="0" cellpadding="0" cellspacing="0">
		<tr>
			<td class="x_index1_bar_left">
				&nbsp;
			</td>
			<td class="x_index1_bar_middle">
				<!--后退按钮-->
            <span  class="spanCSS1">
				<a href="#" onClick="history.back(-1)"><img src="/emadmin/images/c3/index1_banner_prew.png" border="0" onMouseOver="this.src='images/c3/index1_banner_prew-1.png'" onMouseOut="this.src='images/c3/index1_banner_prew.png'" style="vertical-align:middle;"></a>
            </span>
				<!--前进按钮-->
            <span   class="spanCSS1">
				<a href="#"  onClick="history.go(+1)"><img src="/emadmin/images/c3/index1_banner_next.png" border="0" onMouseOver="this.src='images/c3/index1_banner_next-1.png'" onMouseOut="this.src='images/c3/index1_banner_next.png'" style="vertical-align:middle;"></a>
            </span>
			<%if(_productCode.equals("kcs")){%>
				<!--库存简单版-->
				  <span id="menu_rkd" style="display:none;" class="spanCSS" style="width:90;">
					<a href="/emadmin/jsp/common/list.jsp?modul_id=kc_rkd_listModul"  target="base"><img src="/emadmin/images/c3/crm.gif" border="0" onMouseOver="this.src='images/c3/crm-1.gif'" onMouseOut="this.src='images/c3/crm.gif'" style="vertical-align:middle;">入库单</a>&nbsp;&nbsp;
				 </span>
				 <span id="menu_ckd" style="display:none;" class="spanCSS"  style="width:90;">
					<a href="/emadmin/jsp/common/list.jsp?modul_id=kc_ckd_listModul"  target="base"><img src="/emadmin/images/c3/cg.gif" border="0" onMouseOver="this.src='images/c3/cg-1.gif'" onMouseOut="this.src='images/c3/cg.gif'" style="vertical-align:middle;">出库单</a>&nbsp;&nbsp;
				 </span>
				 <span id="menu_kcscs" style="display:none;" class="spanCSS" style="width:120;">
					<a href="/emadmin/jsp/common/list.jsp?modul_id=view_kc_scs_listModul"  target="base"><img src="/emadmin/images/c3/xs.gif" border="0" onMouseOver="this.src='images/c3/xs-1.gif'" onMouseOut="this.src='images/c3/xs.gif'" style="vertical-align:middle;">库存实存数</a>&nbsp;&nbsp;
				 </span>
				 <span id="menu_kcmxz" style="display:none;" class="spanCSS" style="width:120;">
					<a href="/emadmin/jsp/common/list.jsp?modul_id=kc_kcspz_listModul"  target="base"><img src="/emadmin/images/c3/kc.gif" border="0" onMouseOver="this.src='images/c3/kc-1.gif'" onMouseOut="this.src='images/c3/kc.gif'" style="vertical-align:middle;">库存明细账</a>&nbsp;&nbsp;
				 </span>
				 <span id="menu_kcsfc" style="display:none;" class="spanCSS" style="width:120;">
					<a href="/emadmin/jsp/common/list.jsp?modul_id=view_kc_slhz_listModul"  target="base"><img src="/emadmin/images/c3/cw.gif" border="0" onMouseOver="this.src='images/c3/cw-1.gif'" onMouseOut="this.src='images/c3/cw.gif'" style="vertical-align:middle;">收发存汇总</a>&nbsp;&nbsp;
				 </span>
				 <span id="menu_chda" style="display:none;" class="spanCSS" style="width:100;">
					<a href="/emadmin/jsp/common/list.jsp?modul_id=jc_chda_listModul"  target="base"><img src="/emadmin/images/c3/rw.gif" border="0" onMouseOver="this.src='images/c3/rw-1.gif'" onMouseOut="this.src='images/c3/rw.gif'" style="vertical-align:middle;">货品档案</a>&nbsp;&nbsp;
				 </span>
			<%}else{%>
			<span class="spanCSS">
				<!--首页
				如果后面的字显示不全，可调整样式特定的spanCSS样式里面的width属性
				-->
				<% if(_productCode.equals("crm") || _productCode.equals("crma") || _productCode.equals("crmf") || _productCode.equals("crmfa") || _productCode.equals("em") || _productCode.equals("emc") || _productCode.equals("erp") || _productCode.equals("erpc") ){ %>
				<a href="/emadmin/shared/desktop.jsp"  target="base"><img src="/emadmin/images/c3/index.gif" border="0" onMouseOver="this.src='images/c3/index-1.gif'" onMouseOut="this.src='images/c3/index.gif'" style="vertical-align:middle;">首&nbsp;&nbsp;页</a>&nbsp;&nbsp;
          		<%}else{%>
          		<a href="/emadmin/navigation/<%=_productCode %>/main.jsp"  target="base"><img src="/emadmin/images/c3/index.gif" border="0" onMouseOver="this.src='images/c3/index-1.gif'" onMouseOut="this.src='images/c3/index.gif'" style="vertical-align:middle;">首&nbsp;&nbsp;页</a>&nbsp;&nbsp;
          		<%} %>
            </span>
            <span id="menu_khgl" style="display:none;" class="spanCSS">
				<!--客户管理-->
				<a href="/emadmin/navigation/<%=_productCode %>/crm.jsp"  target="base"><img src="/emadmin/images/c3/crm.gif" border="0" onMouseOver="this.src='images/c3/crm-1.gif'" onMouseOut="this.src='images/c3/crm.gif'" style="vertical-align:middle;">客户管理</a>&nbsp;&nbsp;
            </span>

				<!--采购管理-->
            <span id="menu_cggl" style="display:none;"  class="spanCSS">
				<a href="/emadmin/navigation/<%=_productCode %>/cg.jsp"  target="base"><img src="/emadmin/images/c3/cg.gif" border="0" onMouseOver="this.src='images/c3/cg-1.gif'" onMouseOut="this.src='images/c3/cg.gif'" style="vertical-align:middle;">采购管理</a>&nbsp;&nbsp;
            </span>

				<!--销售管理-->
            <span id="menu_xsgl" style="display:none;"   class="spanCSS">
				<a href="/emadmin/navigation/<%=_productCode %>/xs.jsp"  target="base"><img src="/emadmin/images/c3/xs.gif" border="0" onMouseOver="this.src='images/c3/xs-1.gif'" onMouseOut="this.src='images/c3/xs.gif'" style="vertical-align:middle;">销售管理</a>&nbsp;&nbsp;
            </span>

				<!--库存管理-->
	        <span id="menu_kcgl" style="display:none;"  class="spanCSS">
				<a href="/emadmin/navigation/<%=_productCode %>/kc.jsp"  target="base"><img src="/emadmin/images/c3/kc.gif" border="0" onMouseOver="this.src='images/c3/kc-1.gif'" onMouseOut="this.src='images/c3/kc.gif'" style="vertical-align:middle;">库存管理</a>&nbsp;&nbsp;
            </span>

				<!--财务管理-->
            <span id="menu_cwgl" style="display:none;"  class="spanCSS">
				<a href="/emadmin/navigation/<%=_productCode %>/cw.jsp"  target="base"><img src="/emadmin/images/c3/cw.gif" border="0" onMouseOver="this.src='images/c3/cw-1.gif'" onMouseOut="this.src='images/c3/cw.gif'" style="vertical-align:middle;">财务管理</a>&nbsp;&nbsp;
            </span>
			
			<!--智能搜索-->
            <span id="menu_znss" style="display:none;" class="spanCSS">
				<a href="/emadmin/jsp/common/all_yw_list.jsp?modul_id=allBusinessSearch_modul"  target="base"><img src="/emadmin/images/c3/znss.gif" border="0" onMouseOver="this.src='images/c3/znss-1.gif'" onMouseOut="this.src='images/c3/znss.gif'" style="vertical-align:middle;">智能搜索</a>&nbsp;&nbsp;
            </span>
			<%}%>
            <span  class="spanCSS">
				<!--安全退出-->
				<a href="/emadmin/index.jsp?type=logoff"  target="base"><img src="/emadmin/images/c3/exit.gif" border="0" onMouseOver="this.src='images/c3/exit-1.gif'" onMouseOut="this.src='images/c3/exit.gif'" style="vertical-align:middle;">安全退出</a>
			</span>
			</td>
			<td class="x_index1_bar_right">
				&nbsp;
			</td>
		</tr>
	</table>
</div>


<!--页面中间部分-->
<div id="main_area"  style="width:100%; height:100px; position:absolute; top:133px; left:0;z-index:4">
    <!--最左边的小细边框-->
	<div id="left_border_div" style="width:5px; position:absolute;  height:300px; z-index:9;background:url('/emadmin/images/c3/index1_border_left.gif');" ></div>

	 <!--导航树-->
	<div id="left_doc_div" style="width:20%; position:absolute; left:0; top:0; height:300px; z-index:7;" >
        <iframe id="left_frame" name="left"  src="/emadmin/shared/tree.jsp" frameborder=0  style="width:100%; height:400px;  float:left ; z-index:3; " scrolling=yes></iframe>
	</div>

	 <!--隐藏显示菜单-->
	<div id="hide_doc_div" style="width:4px; position:absolute;  height:355px; z-index:80;background:url('/emadmin/images/c3/hidden-bar.gif');" >
		<img src="/emadmin/images/c3/hide-no.gif"  alt="隐藏菜单" onclick="show_menu_window(this);" border="0">
	</div>

	<!--右边的主页面-->
    <div  id="right_doc_div" style="width:800px; float:right; height:300px; z-index:30;">
        <iframe id="right_frame" name="base"  src="/emadmin/welcome.jsp" frameborder=0  style="width:100%; height:400px;  float:right;z-index:1000;" scrolling=yes></iframe>
	</div>

	<!--最右边的小细边框-->
	<div id="right_border_div" style="width:5px; position:absolute;  height:300px; z-index:19;background:url('/emadmin/images/c3/index1_border_right.gif');" ></div>
</div>

<!--整个页面底部-->
<div id="footer_area" style="width:100%;height:29px;z-index:1; position:absolute; left:0; top:580px; ">
	<table width="100%" border ="0" cellpadding="0" cellspacing="0">
		<tr>
			<td class="x_index1_footer_left">
				&nbsp;&nbsp;&nbsp;
				<font class="index1_font">
					当前登录：<%=session.getAttribute("userInfo")!=null?((String[])session.getAttribute("userInfo"))[2]:"未知"%> 
				</font>
			</td>
			<td class="x_index1_footer_middle">
				&nbsp;<marquee scrollamount="2" direction="left" style="color:red;">尊敬的客户：您好，我是安创小精灵，在这里提醒您安创企管网站：<a href='http://acms.jindongli.net' style="blue">http://acms.jindongli.net</a>，如您有任何疑问请致电公司办公室电话：010-80128580，感谢您对公司的支持！</marquee>
			</td>
			<td class="x_index1_footer_right">
				<span id='dt' style="color:#3971aa;"></span>
			</td>
		</tr>
	</table>  
</div>
<embed src="/emadmin/media/system.wav" loop="0" autostart="false" hidden="true" id="messagesound"></embed>
<span style="display:none;"><object classid="clsid:BAC89969-F687-4B43-8519-CD87E4DC691E" id="TmA4drvmOle" width="100" height="100"></object> </span>
</body>
</html>


