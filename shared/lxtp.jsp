<%@page contentType="text/html;charset=UTF-8" %>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*" %>
<%
      
      response.setHeader("Pragma","No-cache"); 
      response.setHeader("Cache-Control","no-cache"); 
      response.setDateHeader("Expires", 0); 
	  String telno = request.getParameter("telno");      //获得电话号码
      String kh_id[]  = new String[2];
	  String sql="select top 1 id,lx from (select a.id,'khda' lx from kh_da a,kh_da_lxr b where a.id=b.kh_id  and (a.lxdh='"+telno+"' or b.yddh='"+telno+"' or b.gzdh='"+telno+"' or jtdh='"+telno+"') group by a.id union select a.id,'yxkh' lx from kh_yxkh a,kh_yxkh_lxr b where a.id=b.kh_yxkh_id  and (a.lxdh='"+telno+"' or b.yddh='"+telno+"' or b.gzdh='"+telno+"' or jtdh='"+telno+"') group by a.id) as y";
      kh_id=Api.sb(sql);
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="/emadmin/css/c1/style_new.css">
<script language=javascript>
	window.onload=function(){
			var height=window.screen.availHeight-10
			var width=document.body.clientWidth+10;
			var kh_id=document.getElementById("kh_id").value;
			var lx=document.getElementById("lx").value;
			if(kh_id!='1'){
					if(lx=='khda'){
						window.location.href="/emadmin/jsp/common/detail.jsp?modul_id=kh_da_detailModul&id="+kh_id;
					}else if(lx=='yxkh'){
						window.location.href="/emadmin/jsp/common/detail.jsp?modul_id=kh_yxkh_detailModul&id="+kh_id;
					}
			}
}
</script>

</head>

<BODY >
<%if(kh_id.length!=0){%>
<input type="hidden" id="kh_id" value="<%=kh_id[0]%>">
<input type="hidden" id="lx" value="<%=kh_id[1]%>">
<%}else{%>
<input type="hidden" id="kh_id" value="1">
<body>
						<table width="100%"  border="0" cellpadding="0" cellspacing="0">
					  		<tr>
								<!-- 标题区开始--> 
								<td  class='x_import_kh_left'>
										&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
										来电提示：
										</span>
								</td>
								<td  class='x_import_kh_right'>
									&nbsp;
								</td>
								<!-- 标题区结束 --> 
							  </tr>
						</table>

          			<table class="x_message_table" cellspacing="0" align="center">
						  <tr>
							<td align="center"  width="100"   class="x_message_message_td"><img src="/emadmin/images/c3/tel.gif"/> </td>
							<td  class="x_message_message_td">
                                     您有客户来电，来电号码为<font color=red><%=telno%></font>，但您的系统中尚无该客户的信息！
							</td>
						  </tr>
						</table>
<%}%>
</BODY>


</HTML>