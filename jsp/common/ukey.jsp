<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}

        if(session.getAttribute("userId")==null || !((String)session.getAttribute("userId")).equalsIgnoreCase("admin"))  { %>
                <SCRIPT LANGUAGE="JavaScript">
                <!--
                alert("不具有该功能的操作权限或登录信息已经失效，请以系统管理员身份登录！");
                history.back(-1);
                //-->
                </SCRIPT>
        <% 
		        return;
         }
        String message="";
         if( request.getMethod().equalsIgnoreCase("post") )   {
               String r[]=Api.sb("select zhanghao from xt_yh where ukey<>''  and  ukey='"+request.getParameter("ukeyid1")+"'");
               if (r==null || r.length==0) {
                   message="没有找到绑定的帐号";
               } else {
                   message+="该V盾已经绑定到如下帐号：</br>";
                   for (int i=0;i<r.length;i++)   message+=r[i]+"</br>";
               }
         }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
   //

 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
			
		}
   //-->
</SCRIPT>

    <OBJECT id="ePass" style="LEFT: 0px; TOP: 0px" height="0" width="0" classid="clsid:C7672410-309E-4318-8B34-016EE77D6B58" name="ePass" VIEWASTEXT>
    </OBJECT>

       <script language="vbscript">
         function bind_ukey()
                  On Error Resume Next
                  ePass.GetLibVersion
                 '判断是否正确驱动
                  If Err.number = &H1B6 Then
                      MsgBox "V盾安全锁驱动程序未安装或安装不正确!"
                      Exit function
                  end if
                  ePass.OpenDevice 1, ""
                 '打开USBKEY 判读是否插入KEY
                  If Err then
                      MsgBox " 请插入V盾安全锁 ! "
                      ePass.CloseDevice
                      Exit function
                  End if
                  dim results
                  dim filesize
                  dim filecontent 
                  filecontent = ""
                  filesize = 0
                  results = ""
                  results = ePass.GetStrProperty(7,0,0)
                  ePass.CloseFile
                  ePass.CloseDevice
                  document.form1.ukeyid1.value=results
                  'MsgBox " V盾绑定成功 ! "
              End Function

		</script>


</head>
<body onload="bind_ukey()">
					<table class="x_bill_outer_table" cellspacing="0" align="center">
					  <tr>
						<td align="left">
    <% if (message.length()>0) {%>
                            <%=message%>
    <%} else {%>
                               请插入要查询的V盾
    <%} %>
						      <form action="" method="post" name="form1" >
                                        <input type="hidden"  name="ukeyid1" value="">
                                </form >
                                   <div align="center" id="_button_area" style="display:block; padding-top:10px;vertical-align:bottom; clear:both;">
								<input type='button'  value="查询绑定账号"  onClick="_click_button(form1)"/> &nbsp;&nbsp;&nbsp;&nbsp;
                                    <img src="/emadmin/images/c2/button/bill_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);'/> 
                                </div>
								<div align="center" id="_button_area_message" style="display:none;clear:both;">正在处理，请稍等...</div>

                               </form>
                        </td>
					  </tr>
					</table>
</body>
</html>




