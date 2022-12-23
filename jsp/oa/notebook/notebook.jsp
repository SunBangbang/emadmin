<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*"%>
<%@ include file="/emadmin/shared/checkPermission1.jsp"%>

		<%
				
                response.setHeader("Pragma","No-cache"); 
                response.setHeader("Cache-Control","no-cache"); 
                response.setDateHeader("Expires", 0); 
                session.setMaxInactiveInterval(60*60*2);
				String userid=(String)session.getAttribute("userId");
				String rid=request.getParameter("rid");
				String group_id=request.getParameter("group_id");
				ObjPageBean p=null;
				if (rid!=null) {
					OaService.delete(rid,userid);
				}
				String[] group=OaService.getList_group(userid);
				if (group_id==null) {
					group_id=group[0];
				}
				String groupDetail[]=OaService.getDetail_group(group_id,userid);
				 p=OaService.getList(request,"10");	
				 String result[]=null;

				 if(p.r == null ||p.r.length == 0 ) {
						 result=new String[0];
				 } else {
						result=(String[])p.r;
				 }

%>         
<html>
<head>
<title>crm</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/emadmin/css/c1/style_new.css">
<style type="text/css">
<!--
.style2 {
	font-size: 16px;
	font-weight: bold;
}
.style5 {color: #FF0000}
.style6 {font-size: 16px}
div{
white-space:nowrap;
}
.dotline { 
BORDER-BOTTOM-STYLE: dotted; BORDER-LEFT-STYLE: dotted; BORDER-RIGHT-STYLE: dotted; BORDER-TOP-STYLE: dotted 
} 
-->
</style></head>
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
	<div style="z-index:100;">
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						记事本
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
<table cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr ><td width=70% nowrap><div class=x_jsb_banner_left></div></td><td width=30%><table border=0 width=100%><tr><td><div class=x_jsb_banner_right><form method=get>
        
            <input type=text name="keywords" value="" >
        <input type="submit"   name="keywords2"  value="搜索" >
            <input type="hidden" name="group_id" value="<%=group_id%>">
      </form></div></td></tr></table></td></tr> </table>
 </div>     
<font>
 
<table cellSpacing="0" cellPadding="0" width="98%" border="0" bgcolor=#F3F3F3 style="margin-top:0px;">
<tr><td><table border="0" width=100% cellpadding="0" cellspacing="0"><tr><td nowrap><div  class=x_jsb_search_left  style="display:inline;" ></div><div  class=x_jsb_search_middle style="display:inline;"  ></div><div  class=x_jsb_search_right style="display:inline;"  ></div></td></tr></table></td></tr>
  <tr>
    <td align="center" valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center" valign="top"><table width="98%"  border="0" cellspacing="0" cellpadding="0" style="margin-left:1px;margin-right:1px;">
          <tr>
            <td><table width="100%"  border="0" cellspacing="0" cellpadding="10" bgcolor=#ffffff>
            	<tr><td align=right><a title="可随意增加、修改文章" href="notebook.jsp#addcontent" nowrap class="linkline"><img src="/emadmin/images/c2/button/list_add.gif" border=0 style="vertical-align:middle;"></img></a>&nbsp;&nbsp;&nbsp;<a title="可随意增加、修改及删除标签栏目" href="notebookeditgroup.jsp" nowrap class="linkline"><img src="/emadmin/images/c2/jeimian_icon2.jpg" border=0 style="vertical-align:middle;"></img></a></td>
</tr></table><table width="100%"  border="0" cellspacing="0" cellpadding="0" bgcolor=#ffffff>
              <tr bgcolor=#ffffff align=center>
                <% for (int i=0;i<group.length;i+=3) {%>
           		 <td class=x_jsb_button_left></td><td class=x_jsb_button_middle nowrap align="center" ><a href="notebook.jsp?group_id=<%=group[i]%>&group_color=<%=group[i+2]%>"  ><%=group[i+1]%></a></td><td class=x_jsb_button_right></td>
                <% }%> 
                 </tr>
                             
            </table> <hr></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td align="center" valign="middle" bgcolor=#F3F3F3 >
              <table width="98%"  border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
                <tr>
                  <td height="28" align="center" valign="top"><% if (result!=null && result.length>0 ) { %>
                      <table width="100%" height="136" border="0" cellpadding="5" cellspacing="0" >
                        <tr>
                          <td height="136" align="center" valign="middle" class="listbg">
                              <table  borderColorLight=#B3C3D0 borderColorDark=#ffffff width="95%" height="100" border="0" cellpadding="5" cellspacing="0">
                                <% for (int i=0;i<result.length;i+=p.resultCols) { %>
                                <tr >
                                  <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="2">
                                      <tr valign="middle" >
                                        <td width="60%" align="center"><div align="left"><img src="/emadmin/images/c2/jeimian_icon3.jpg"></img>&nbsp;<span >时间<%=result[i+7]%></span></br><hr class=dotline color=#111111 size=1></div></td>
                                        <td width="20%" align="center"><div align="right"><a href="notebookdelete.jsp?id=<%=result[i+1]%>" ><img src="/emadmin/images/c2/jeimian_btn1.jpg" border=0 style="vertical-align:middle;"></img></a> &nbsp;&nbsp;<a href="notebookchange.jsp?id=<%=result[i+1]%>" ><img src="/emadmin/images/c2/jeimian_btn2.jpg" border=0 style="vertical-align:middle;"></img></a></div></td>
                                      </tr>
                                      <tr>
                                        <td colspan="2" align="left"><br>
                                            <strong><%=(result[i+4])%></strong><br>
                                          <br>
                                          <%=Util.getChangeLine(result[i+5])%><br></td>
                                      </tr>
                                  </table></td>
                                </tr>
                                <% } %>
                            </table></td>
                        </tr>
                      </table>
                    <%=p.getBar(request)%>
                      <% } else { %>
                      <table width="98%" height="49" border="0" cellpadding="0" cellspacing="0" class="mainbarbg">
                        <tr>
                          <td height="49" align="center" valign="middle" class="listbg"><div class="listft"><span style="font-size: 12px;"><Strong><%=groupDetail[2]%></Strong>中暂时没有内容</span>。</div></td>
                        </tr>
                      </table>
                    <% } %>
                  </td>
                </tr>
                <tr>
                  <td  align="center" valign="top"><form name="form1" method="post" action="notebookadd.jsp">
                      <table width="100%" height="204"  border="0" name='addcontent'>
                        <tr>
                          <input type="hidden" name="group_id" value="<%=group_id%>">
                          <td width="22%" height="27"><img src="/emadmin/images/c2/jeimian_icon6.jpg"></img>&nbsp;<strong>添加内容</strong></td>
                          <td width="78%"><div align="left"></div></td>
                        </tr>
                        <tr>
                          <td  colspan="2"><div align="center">标题:
                            <input type="text" name="title" value="" size="80" maxlength="80" style=" border-top:none; border-left:none; border-right:none;border-bottom-style:solid;border-bottom-color:#E6E6E6">
                          </div></td>
                        </tr>
                        <tr valign="top">
                          <td height="171" colspan="2"><div align="center">
                          		<br>
                          		
                              <textarea name="content" cols="82" rows="15" class=x_jsb_addcontent></textarea>
                              <br>
							        </select> <br><br>
							  	<div align="center" id="_button_area" style="display:block"><img src="/emadmin/images/c2/jeimian_btn3.jpg"  onClick="_click_button(form1)"  onMouseOver="this.style.cursor='hand'" ></img> </div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
                              <br>
                          
                           <p style="text-align:left;margin-left:10px;"><strong>注意：请不要将银行密码，信用卡号码等重要个人信息保存在记事本中。</strong></p> </div></td>
                        </tr>
                      </table>
                  </form></td>
                </tr>
              </table>
          <br>
        </td>
      </tr>
    </table></td>
  </tr>
</table>

</font>

</body>
</html>
