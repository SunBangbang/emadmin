<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*"%>
<%@ include file="/emadmin/shared/checkPermission1.jsp"%>
<html>
<head>
<title>crm</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/main.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style2 {
	font-size: 16px;
	font-weight: bold;
}
.style5 {color: #FF0000}
.style6 {font-size: 16px}
-->
</style></head>

<%! public String getSelected(String x1,String x2) {
			if (x1==null || x2==null) return "";
			if (x1.equals(x2)) {
				return "selected"; 
			} else {
				return "";
			}
		}
%>
		<%
				String userid=(String)session.getAttribute("userId");
				String id=(String)request.getParameter("id");
				String group[]=OaService.getList_group(userid);
				String[] result=OaService.getDetail(userid,id);

%>           
<script language=javascript>
<!--
 		function _click_button(form1) { 
			if (form1.content.value.length>2048) {
				alert('记事本每条内容不能超过1000个汉字，请精简！');
				form1.content.focus();
				return false;
			}
			if (form1.content.value.length<3) {
				alert('请输入记事本内容！');
				form1.content.focus();
				return false;
			}
			if (true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
//-->
</script>
<body>
<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0" borderColor="#cccccc" borderColorDark="#ffffff">
  <tr> 
    
    <td  align="center" valign="top"><table width="100%" border="0" cellspacing="5" cellpadding="0">
      <tr>
        <td valign="top"><font class="textNormal">
            <table class="newsListbody" cellSpacing="10" cellPadding="0" width="100%" border="0">
              <tr>
                <td align="left" valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td  align="left" valign="top">
				<form name="form1" method="post" action="notebookchange1.jsp">
                        <table width="100%" height="204"  border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
                          <tr class="tabletitle">
                            <td>&nbsp;&nbsp;<a href="notebook.jsp" class="link_rc">记事本</a> &gt;&gt; 修改内容
							  <input type="hidden" name="id" value="<%=id%>">
							<input type="hidden" name="old_group_id" value="<%=result[2]%>">							</td>
                            </tr>
                          <tr valign="middle">
                            <td height="171"><div align="center">&nbsp;&nbsp;&nbsp;
                              <p>标题
                                  <input type="text" name="title"  size="120" maxlength="80" value="<%=result[3]%>">
                                  <br>
                                  </p>
                              <p>
                                    <textarea name="content" cols="120" rows="10"><%=result[4]%></textarea>
                                    <br>
                                    该信息所属的标签
								    <select name="group_id">
							          <% for(int i=0;i<group.length;i+=3) {%>
								          <option value="<%=group[i]%>" <%=getSelected(group[i],result[2])%>><%=group[i+1]%></option>
						              <% } %>
							        </select> <br><br>
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="保存" onclick="_click_button(form1)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
                                    <br>
                                    <br>
                    注意请不要将银行密码，信用卡号码等重要个人信息保存在记事本中。 </p>
                            </div></td>
                          </tr>
                        </table>
                    </form>
	</td>
  </tr>
                </table></td>
              </tr>
            </table>
        </font></td>
      </tr>
    </table></td>
  </tr>
  <tr> 
    <td height="25" colspan="2" align="center" valign="top">
</td>
  </tr>
</table>
</body>
</html>
