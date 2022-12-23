<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}
        //读出采购单的条码
        String id=request.getParameter("id");
        String sql="select chbm,chmc,ggxh,sl from cg_cgd_sub where fid='"+id+"' order by id";
        String r[]=Api.sb(sql);
        String result="<table width='90%' border='1'  cellpadding='0' cellspacing='0' borderColorLight=#B3C3D0 borderColorDark=#ffffff><tr>";
        result+="<td align='center'>货品编码</td><td align='center'>货品名称</td><td align='center'>规格型号</td><td align='center'>打印数量</td>";
        result+="</tr>";
        for (int i=0;i<r.length;i+=4) {
            result+="<tr>";
            result+="<td align='center'>"+r[i]+"</td>";
            result+="<td align='center'>"+r[i+1]+"</td>";
            result+="<td align='center'>"+r[i+2]+"</td>";
            result+="<td align='center'><input type='text' name='"+r[i]+"_sl' value='"+String.valueOf(Double.valueOf(r[i+3]).intValue() )+"' style='text-align: right; '></td>";
            result+="</tr>";
        }
        result+="<tr><td colspan='4' align='center'> 每行打印 <input type='text' name='cols' value='3'  size='4'> 列";
        result+="&nbsp;&nbsp;每页打印 <input type='text' name='rows' value='10'  size='4'> 行";
        result+="</td></tr>";
        result+="</table>";



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
 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
   //-->
</SCRIPT>
</head>
<body>
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

				<form name="form1" action="cg_print_tm1.jsp" method="post" target="_blank">
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
					  <tr>
						<td align="left"><br/>
								<%=result%>&nbsp;
							  <input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
							  <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
							  	<div align="center" id="_button_area" style="display:block"><input type="Submit" name="Submit" value="确定"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>

						</td>
					  </tr>
					</table>
				</form>													
							 
											
			<!-- 内容区 -->

</body>
</html>
