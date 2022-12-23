<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*"%>
<%@ include file="/emadmin/shared/checkPermission1.jsp"%>
<script language=javascript src="/emadmin/js/do_check.js"></script>
<%
				String userid=(String)session.getAttribute("userId");
				String id=(String)request.getParameter("id");
				String name=(String)request.getParameter("name");
				String color=(String)request.getParameter("color");

%>           
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/main.css" rel="stylesheet" type="text/css">
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
<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0" borderColor="#cccccc" borderColorDark="#ffffff">
  <tr> 
    
    <td  align="center" valign="top"><table width="100%" border="0" cellspacing="5" cellpadding="0">
      <tr>
        <td valign="top"><font class="textNormal">
            <table class="newsListbody" cellSpacing="10" cellPadding="0" width="100%" border="0">
              <tr>
                <td align="left" valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="5">
  <tr> 
    <td  align="left" valign="top"><form name="form1" method="post" action="notebookgroupchange1.jsp">
                        <table width="100%" height="204"  border="0">
                          <tr>
                            <td width="22%" height="27"><div align="right"><font class="textNormal">&nbsp;&nbsp;<a href="notebook.jsp" class="link_rc">记事本</a></font> &gt;&gt;修改标签内容</div></td>
                            <td width="78%"><div align="left"></div></td>
                          </tr>
                          <tr valign="middle">
                            <td height="100" colspan="2"><div align="center">标签编号
                            <input class="share" name="id" type="text" size="4" maxlength="2" value="<%=id%>">
								标签名称
							<input class="share"  name="name" type="text" size="20" maxlength="20"  value="<%=name%>"> 
							<input type="hidden" name="oldid" value="<%=id%>">
								颜色设置
								<select name="color">
									 <option value="D2691E">红色</option>
									<option value="6B8E23">绿色</option>
									<option value="483D8B">暗灰蓝色</option>
									<option value="9ACD32">黄绿色</option>
									 <option value="DEB887">实木色</option>
									<option value="D8BFD8">紫色</option>
									<option value="FFB6C1">亮粉红色</option>
									<option value="F4A460">沙褐色</option>
								</select> <br/> <br/>
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="保存" onclick="_click_button(form1)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
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
