<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
	String result[];
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}
		result = CWService.getQC( request );


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<style type="text/css">
.readonly_input {
	height:18px;
	font-size: 12px;
	border:#7F9DB9 solid 0PX;
	margin:1px 2px 1px 2px;
    FONT-WEIGHT: normal;
    FONT-FAMILY: "宋体"
}

</style>
<%@include file="/emadmin/shared/headres.jsp"%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
		function recount(km,sons) {
			r1=0;
			r2=0;
			r3=0;
			r4=0;
			r5=0;
			r6=0;
			r7=0;
			r8=0;
			var ss=sons.split("-");
			for (i=1;i<ss.length;i++) {  //从1开始是跳过第一个“-”引起的空格
				r1+=parseFloat(document.getElementsByName("ncye_"+ss[i])[0].value);
				r2+=parseFloat(document.getElementsByName("ljjf_"+ss[i])[0].value);
				r3+=parseFloat(document.getElementsByName("ljdf_"+ss[i])[0].value);
				r4+=parseFloat(document.getElementsByName("qcye_"+ss[i])[0].value);
                if (document.getElementsByName("wbncye_"+ss[i]).length>0)
				r5+=parseFloat(document.getElementsByName("wbncye_"+ss[i])[0].value);
                if (document.getElementsByName("wbljjf_"+ss[i]).length>0)
				r6+=parseFloat(document.getElementsByName("wbljjf_"+ss[i])[0].value);
                if (document.getElementsByName("wbljdf_"+ss[i]).length>0)
				r7+=parseFloat(document.getElementsByName("wbljdf_"+ss[i])[0].value);
                if (document.getElementsByName("wbqcye_"+ss[i]).length>0)
				r8+=parseFloat(document.getElementsByName("wbqcye_"+ss[i])[0].value);
			}
			
			document.getElementsByName("ncye_"+km)[0].value =Math.round(r1*100)/100;
			document.getElementsByName("ljjf_"+km)[0].value =Math.round(r2*100)/100;
			document.getElementsByName("ljdf_"+km)[0].value=Math.round(r3*100)/100;
			document.getElementsByName("qcye_"+km)[0].value=Math.round(r4*100)/100;
            if (document.getElementsByName("wbncye_"+km).length>0)
			document.getElementsByName("wbncye_"+km)[0].value = Math.round(r5*100)/100;
            if (document.getElementsByName("wbljjf_"+km).length>0)
			document.getElementsByName("wbljjf_"+km)[0].value= Math.round(r6*100)/100;
            if (document.getElementsByName("wbljdf_"+km).length>0)
			document.getElementsByName("wbljdf_"+km)[0].value= Math.round(r7*100)/100;
            if (document.getElementsByName("wbqcye_"+km).length>0)
			document.getElementsByName("wbqcye_"+km)[0].value= Math.round(r8*100)/100;
			document.getElementsByName("ncye_"+km)[0].fireEvent("onchange");

			return;
		}
		function recountye(km,fx) {
			r1=0;
			r2=0;
			r3=0;
			r4=0;
			r5=0;
			r6=0;
			r7=0;
			r8=0;
				r1=parseFloat(document.getElementsByName("ncye_"+km)[0].value);
				r2=parseFloat(document.getElementsByName("ljjf_"+km)[0].value);
				r3=parseFloat(document.getElementsByName("ljdf_"+km)[0].value);
                if (document.getElementsByName("wbncye_"+km).length>0)
				r5=parseFloat(document.getElementsByName("wbncye_"+km)[0].value);
                if (document.getElementsByName("wbljjf_"+km).length>0)
				r6=parseFloat(document.getElementsByName("wbljjf_"+km)[0].value);
                if (document.getElementsByName("wbljdf_"+km).length>0)
				r7=parseFloat(document.getElementsByName("wbljdf_"+km)[0].value);
			if (fx=='1') {   //方向借
				document.getElementsByName("qcye_"+km)[0].value = Math.round((r1+r2-r3)*100)/100;
                if (document.getElementsByName("wbqcye_"+km).length>0)
				document.getElementsByName("wbqcye_"+km)[0].value= Math.round((r5+r6-r7)*100)/100;
			} else {
				document.getElementsByName("qcye_"+km)[0].value=Math.round((r1-r2+r3)*100)/100;
                if (document.getElementsByName("wbqcye_"+km).length>0)
				document.getElementsByName("wbqcye_"+km)[0].value=Math.round((r5-r6+r7)*100)/100;
			}
			return;
		}

   //-->
</SCRIPT>
</head>
<body >
		  <table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区 --> 
			<td height="" align="left" valign="middle" id="center_head_bg">
					<span class="center_title" style="width:100%;">
						&nbsp;&nbsp;&nbsp;<%=Serve.getModulName( request )%>
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
			<!-- 内容区 -->

				<form name="form1" action="cw_qcsz.jsp" method="get">
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
					  <tr>
						<td align="left" height="25">
								<%=result[0]%>&nbsp;
							  <input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
							  <input type="hidden" name="is_reopen" value="1">
						</td>
					  </tr>
					</table>
				</form>													
				<form name="form2" action="cw_qcsz_edit.jsp" method="post" onSubmit="return doCheck(this)">
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
					  <tr>
						<td align="left"><br/>
								<%=result[1]%>&nbsp;
							  <input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
							  <input type="hidden" name="is_reopen" value="1">
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="保存" onclick="_click_button(form2)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>

						</td>
					  </tr>
					</table>
				</form>													
							 
											
			<!-- 内容区 -->

</body>
</html>
