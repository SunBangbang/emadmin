<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
			String result;
			result = Serve.getAllBusinessTemplate( request );
			String keyword = request.getParameter("keyword");
			String modul_id = request.getParameter("modul_id");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<link rel="stylesheet" href="/emadmin/css/c1/style_new.css">
<style type="text/css">
<!--
* {
	margin:0px;
	padding:0px;

	}
body {
	FONT-FAMILY: "宋体";
	font-size: 14px;
    }
/*  ---------------------------- 智能搜索 --------------------------------- */
.x_all_search_notfound {
	font-size:25px; 
	text-align:center; 
	margin-top:150px;
	font-family:"楷体_GB2312";
	
}

/*默认的链接*/
A:link {
	FONT-WEIGHT: normal;
	FONT-SIZE: 12px;
	COLOR:#000000;				/*没有点过的颜色*/
	FONT-STYLE: normal;
	FONT-FAMILY: "宋体";
	text-decoration: none;
	padding-left: 15px;
}
A:visited {
	FONT-WEIGHT: normal;
	FONT-SIZE: 12px;
	COLOR: #000000;
	FONT-STYLE: normal;
	FONT-FAMILY: "宋体";
	text-decoration: none;
}
A:hover {
	FONT-WEIGHT: normal;
	FONT-SIZE: 12px;
	COLOR:#000000;
	FONT-STYLE: normal;
	FONT-FAMILY: "宋体";
	text-decoration: none;
		padding-left: 15px;
}
/*结果标题的连接*/
A.all_search_title_link:link {
	FONT-WEIGHT: bold;
	FONT-SIZE: 12px;
	COLOR:#0000ff;				/*没有点过的颜色*/
	FONT-STYLE: normal;
	FONT-FAMILY: "宋体";
	text-decoration: none;
   	padding-left: 15px; 

}
A.all_search_title_link:visited {
	FONT-WEIGHT: bold;
	FONT-SIZE: 12px;
	COLOR: #0000ff;
	FONT-STYLE: normal;
	FONT-FAMILY: "宋体";
	text-decoration: none;
		padding-left: 15px;
}
A.all_search_title_link:hover {
	FONT-WEIGHT: bold;
	FONT-SIZE: 12px;
	color:red;
	FONT-STYLE: normal;
	FONT-FAMILY: "宋体";
	padding-left: 15px;
}

all_search_title_td {
	FONT-FAMILY: "宋体";
	font-size: 40px;
	padding-left: 15px;
    }
.all_search_content_td {
	FONT-FAMILY: "宋体";
	font-size: 12px;
	text-align:left;
	padding-left: 15px;
    }
.all_search_end_td {
	FONT-FAMILY: "宋体";
	font-size: 12px;
	text-align:left;
	padding-left: 15px;
	background-color: #e8f6ff;
    }



-->
</style>

</head>
<body>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
 		function _click_button(form1) { 
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
		}
   //-->
</SCRIPT>
<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						智能搜索
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
<form name="form1" action="all_yw_list.jsp" method="get" style="padding: 0px;margin: 0px;">
<table width="98%"  border="0" cellspacing="0" cellpadding="0" align="center" style="border: 1px solid #55a5d6;border-bottom: none;">
    <tr><input name=modul_id value="<%=modul_id%>" type = hidden>
          <td width="13%" height="14" align="right" nowrap style="background-color: #c5d5eb;"><div style="font-size:12px;font-weight: bold;color: #2c405b;">&nbsp;&nbsp;请输入关键字:&nbsp;&nbsp;</div></td>
      <td width="31%" align="left" valign="middle" style="background-color: #c5d5eb;"><input name=keyword type = text  value="<%=null==keyword?"":keyword%>" size="40" style="border:1px solid #7f9db9;"></td>
          <td width="56%" align="left" valign="middle" style="background-color: #c5d5eb;">
		  <span align="left" id="_button_area" style="display:block">
			<img src="/emadmin/images/c2/button/zhineng.gif" onclick="_click_button(form1)"  name="B1"></span>
		  <span align="left" id="_button_area_message" style="display:none;color: #2c405b;">正在处理，请稍等...</span>
	  </td>
    </tr>

</table>
<table width="98%"  border="0" cellspacing="0" cellpadding="15" align="center" style="border: 1px solid #55a5d6;border-top: none;">
<%=result%>
</table>
</form>  
</body>
</html>
