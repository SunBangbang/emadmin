<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*"%>

<%@include file="/emadmin/version.jsp"%>
<% 
    response.setHeader("Pragma","No-cache"); 
    response.setHeader("Cache-Control","no-cache"); 
    response.setDateHeader("Expires", 0); 
    String is_ukey=Api.getXtPreferenceValueByName("is_ukey");
      if (Util.isBlankString(is_ukey)) is_ukey="0";
     String zhanghao;
	 String password;
	 String code;
	 String type;
     String _is_ukey="1";
	 zhanghao = request.getParameter("zhanghao"); //用户名
	 password = request.getParameter("pwd");      //密  码
	 if(null==zhanghao) {
       if (_versionString.indexOf("试用")>0) 
	 	    zhanghao = "admin";  
       else 
	 	    zhanghao = "";  
     }
	 if(null==password) {
            if (_versionString.indexOf("试用")>0) 
	 	    password = "111111";  
       else 
	 	    password = "";  
     }
     type = request.getParameter("type");
	 String rand="";                              //验证码
	 if(null!=session.getAttribute("rand"))
	 	rand = (String) session.getAttribute("rand");  
     String input = request.getParameter("code");
     if (type==null) type="login";
	 String errorCode="";
	 
	 if( type.equals("login"))
	 {			
	    if(request.getMethod().equalsIgnoreCase("post") )  {
				 if(zhanghao.length()==0&&errorCode.length()==0)      //如果用户未输入用户名
						errorCode="请输入您的用户名!";
				 if(password.length()==0&&errorCode.length()==0)      //如果用户未输入密码
						errorCode="请输入您的密码!";
				 if (!rand.equals(input)&&errorCode.length()==0){     //如果用户输入正确的验证码，则把用户名和密码请求发回后台进行核对

	 					errorCode="验证码核对失败，请重试！"; 

				  }
				  if (rand.equals(input)&&errorCode.length()==0){     //如果用户输入的验证码正确且也输入了用户名和密码则将消息发回后台进行核对

						errorCode = Serve.userVerify(request,response);    //核对失败后，返回错误消息提示用户“用户名密码不匹配”
						
				  }
	     } 
    } else	 {
                 session.invalidate();
				 response.sendRedirect("/emadmin/shared/gotologin.jsp");
	}
%>
<% if (is_ukey.equals("1")) {%>
    <OBJECT id="ePass" style="LEFT: 0px; TOP: 0px" height="0" width="0" classid="clsid:C7672410-309E-4318-8B34-016EE77D6B58" name="ePass" VIEWASTEXT>
    </OBJECT>
<%}%>
<html>
	<head>
		<title>北京安创明圣科技发展有限公司
		</title>
				<META http-equiv="Page-Enter"
			CONTENT="RevealTrans(Duration=4,Transition=13)">
		<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" /> 
		<link href="css/c1/style_new.css" rel="stylesheet" type="text/css">
		<script type="text/javascript">
			function load(){
				document.form1.zhanghao.focus();
                <% if (is_ukey.equals("1")) {%>
                    ReadKey();
                <%}%>
			}
		</script>
<% if (is_ukey.equals("1")) {%>

       <script language="vbscript">
                     function ReadKey()
                  On Error Resume Next
                  ePass.GetLibVersion
                 '判断是否正确驱动
                  If Err.number = &H1B6 Then
                      MsgBox "V盾安全锁驱动程序未安装或安装不正确!"
                      document.Form1.ukeyid1.value=""
                      Exit function
                  end if
                  ePass.OpenDevice 1, ""
                 '打开USBKEY 判读是否插入KEY
                  If Err then
                      MsgBox " 请插入V盾安全锁 ! "
                      document.Form1.ukeyid1.value=""
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
                  ePass.OpenFile 0,1
                  filesize = ePass.GetFileInfo(0,3,1,0)
                  filecontent =ePass.Read (0,0,0,filesize)
                   filecontent = left(filecontent,filesize)
                  ePass.CloseFile
                  ePass.CloseDevice
                  document.form1.ukeyid1.value=results
                  document.form1.ukeyid2.value=filecontent
              End Function
		</script>
<%}%>
	</head>
	<body bgcolor="#e3e1d5" style="overflow:hidden;margin: 0px;padding: 0px;" onload=" load();">
		<!--登陆页面总体框架-->
		<table  cellpadding="0" cellspacing="0" width="100%" height="100%" >
		 	<!--左边可拉伸的框架-->
			<tr>
				<td class="x_index_left">&nbsp;</td>
			<!--中间登陆区域-->
				<td valign="top" width="1024"  height="765px;">
					<table  cellpadding="0" cellspacing="0">
						<tr>
							<td class="x_index_top_bg"></td>
						</tr>
						<tr>
							<td class="x_index_middle">
								
							</td>
						</tr>
						<tr>
							<td class="x_index_middle_bottom">
								<!--中间放入控件-->
								<form name="form1" method="post" action="index.jsp" style="padding: 0px;margin: 0px;">
								<table width="1024px;" height="216px">
                                        <input type="hidden"  name="ukeyid1" value="">
                                        <input type="hidden"  name="ukeyid2" value="">
									<tr>
										<!-- 首先是用户名控件 -->
										<td valign="top" style="padding-left: 412px;padding-top: 37px;" height="40px;">
											<input type="text" maxlength="100" name="zhanghao" value="<%=zhanghao%>" class="x_index_input" >
										</td>
									</tr>
									<tr>
										<!-- 其次是密码控件 -->
										<td valign="top" style="padding-left: 412px;padding-top: 13px;" height="40px;">
											<input type="password" maxlength="100" name="pwd" value="<%=password%>" class="x_index_input" style="font-family:Arial">
										</td>
									</tr>
									<tr>
										<!-- 第三是验证码控件 -->
										<td valign="top" style="padding-left: 417px;padding-top: 3px;" height="40px;">
											<input type="text" maxlength="14" name="code" value="" class="x_index_input_yz">
											<img border=0 src="image.jsp" id='888' width=43 height="17px;"  style="vertical-align:top;cursor:hand" onclick="javascript:this.src='image.jsp?ID='+new Date();" title="点击刷新验证码" >
										</td>
									</tr>
									<tr>
										<!-- 最后是登陆按钮和退出按钮 -->
										<td  valign="top" style="padding-left: 600px;padding-top: 3px;" valign="middle">
											<div style="display:block;" id="loginbtn">
												<input type="image" name="submit" src="/emadmin/images/c3/login.png" onclick="javascript:document.getElementById('loginbtn').style.display='none';document.getElementById('logining').style.display='block';">
												&nbsp;&nbsp;
												<input type="image" name="exit" src="/emadmin/images/c3/exit.png" onclick="window.close();">
											</div>
											<div style="display:none;" id="logining">
												    <font color="#035dc4">正在登录系统中,请稍候....</font>
											</div>
										</td>
									</tr>
								</table>
								</form>
							</td>
						</tr>
						<tr>
							<td class="x_index_bottom"></td>
						</tr>
					</table>
				</td>
			<!--右边可拉伸的框架-->
				<td class="x_index_right">&nbsp;</td>
			</tr>
			<tr>
				<!--页面底部需要向左和向下拉伸的左下角框架-->
				<td class="x_index_bottoms_left"></td>
				<!--页面底部需要向下拉伸的中间框架-->
				<td class="x_index_bottoms"></td>
				<!--页面底部需要向右和向下拉伸的右下角框架-->
				<td class="x_index_bottoms_right"></td>
			</tr>
		</table>
		
		
		<%
		if (errorCode.length() != 0) { //如果消息字符串里面有错误消息的话 ，执行下面的JS脚本，提示用户相应的错误信息
		%>
		<script language="javaScript">
				
		alert(<%="'" + errorCode.toString() + "'"%>);
				
	</script>
		<%
		}
		%>
	</body>
</html>
