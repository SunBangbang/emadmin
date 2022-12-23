<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.net.*"%>
<%
	String result[];
	String isstandardlist = request.getParameter( "isstandardlist" );
	String id= request.getParameter( "id" );
	if( isstandardlist!=null  )
    { 
		/**
		1.删除该应收单对应的收款单记录
		2.取消该应收单的审核并将其删除
		3.反写零售单的记账状态、记账人、记账部门、记账日期，应收单号。
		*/
	    String sql=" ";
		String sk_id[]=Api.sb("select fid from xs_skd_sub where ys_id='"+id+"'");
		String ysdh[]=Api.sb("select ysdh from cw_ysd where id='"+id+"'");
		//删除收款单子表
		sql+=" delete from xs_skd_sub where ys_id='"+id+"'";
		//删除收款单
		sql+=" delete from xs_skd where id='"+sk_id[0]+"'";
		//取消应收单审核
		sql+=" update cw_ysd set shr='',shrq='',shzt='' where id='"+id+"'";
		//删除应收单
		sql+=" delete from cw_ysd where id='"+id+"'";
		//反写零售单
		sql+=" update xs_lsd set jiezhangren='',jiezhangzt='0',jiezhangrq='',jiezhangbm='',ysdh='' where  ysdh='"+ysdh[0]+"'";
		Api.ub(sql);
		response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("恭喜您，取消结帐成功 ！","UTF-8"));
		return; 
    }else{
			 result=Api.sb("select djrq,ywy_mc from cw_ysd where id='"+id+"'");
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>

<%@include file="/emadmin/shared/headres.jsp"%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
 		function _click_button() { 
			if(!confirm("确定取消结帐吗？")){
				return false;
			}
			document.getElementById('_button_area' ).style.display="none";
			document.getElementById('_button_area_message' ).style.display="block";
			return true;
		}
   //-->
</SCRIPT>
</head>
<body>
		  <table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						取消结帐
				</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
			<!-- 内容区 -->

		 <form name="form1" action="xs_lsd_qxjz.jsp" method="get" onsubmit="return  _click_button();">
		 <table width="99%"  border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff align="center">
			  	<tr style="background-color:#d8e2f4;">
			  		<td width="99%" align="center" height="200px;">
			  			<font size="5px;"><strong>您正在取消记账人[<font color=red><%=result[1]%></font>]在日期[<font color=red><%=result[0]%></font>]的记账操作...</strong></font>
						<br><br><br>
							<div align="center" id="_button_area" style="display:block"><input type="image" name="Submit" src="/emadmin/images/c2/button/bill_ok.gif"></div>
							<div align="center" id="_button_area_message" style="display:none;font-size:12px;">正在处理，请稍等...</div>
			  		</td>
				</tr>
		  </table>						

		 <input type="hidden" name="isstandardlist" value="isstandardlist">  
		 <input id="id" name="id" value= "<%=id%>" type=hidden>
		</form>  										
</body>
</html>
