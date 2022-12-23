<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*,java.io.*,org.apache.commons.io.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%


		if( !Serve.checkMkQx( request ) )
			{
				response.sendRedirect("/emadmin/shared/gotologin.jsp");
				return ;
			}

	     if( request.getMethod().equalsIgnoreCase("post") )
         {
			ENetIpService.update(request);
            if (request.getParameter("status").equals("1")) {
                ENetIpService.startServer();

            } else {
                ENetIpService.stopServer();
            }
         }
         String r[]=ENetIpService.getStatus();
%>

<script language=javascript>
<!--
 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
//-->
</script>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
<style type="text/css">

 td {color:#3d7298;}

</style>
</head>
<body>

		<table width="100%" border="0" cellpadding="0" cellspacing="0" >
			<tr>
				<!-- 标题区开始-->
				<td class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="index1_font"> E网精灵 </span>
				</td>
				<td class='x_import_kh_right'>
					&nbsp;
				</td>
				<!-- 标题区结束 -->
			</tr>
		</table>
		  &nbsp;<!-- 按扭区 -->
		  <!-- 内容区 -->
					<table class="x_bill_outer_table" cellspacing="0" align="center">
						  <tr>
							<td align="left">	
							<form name="form1" method="post" action="">
                            <table width="95%"  align="center"  border ="1" cellpadding="0" cellspacing="0" borderColor=#dee7f6>
                                    <tr>
                                        <td height="30">
                                            &nbsp;&nbsp;E网精灵帐号
                                        </td>
                                        <td height="30">
                                            &nbsp;&nbsp;<input type="text" name="zhanghao" value="<%=r[2]%>">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="30">
                                            &nbsp;&nbsp;E网精灵密码：
                                        </td>
                                        <td height="30">
                                            &nbsp;&nbsp;<input type="password" name="passwd" value="<%=r[3]%>">
                                        </td>
                                    </tr>
                                <tr>
                                    <td height="30">
                                        &nbsp;&nbsp;E网精灵刷新频率：
                                    </td>
                                    <td height="30">&nbsp;&nbsp;
                                        每隔 <input type="text" name="flush" size=4 value="<%=r[4]%>"> 秒刷新一次
                                    </td>
                                </tr>
                                <tr>
                                    <td height="30">
                                        &nbsp;&nbsp;服务器端口号
                                    </td>
                                    <td height="30">&nbsp;&nbsp;
                                        <%=r[7]%>
                                    </td>
                                </tr>
                                        <input type="hidden" name="addr1"  value="<%=r[5]%>">
                                         <input type="hidden" name="addr2"  value="<%=r[6]%>">
                              </table>
									<table width="93%" border="0" align="center">
										<tr>
										  <td height="40"><p>目前E网精灵状态为： <%=r[0].equals("1")?"已启动":"已停止"%>
									      </p> </td>
									  </tr>
								  </table>	
								 <input type="hidden" name="status" value="<%=r[0].equals("1")?"0":"1"%>">
	
							  	<div align="center" id="_button_area" style="display:block"><input type="Submit" name="Submit" value="<%=r[0].equals("1")?"停止服务":"启动服务"%>"></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
							</form>
								</td>
							  </tr>
					</table>
					<table width="93%"  align="center"  border ="0" cellpadding="0" cellspacing="0" borderColor=#dee7f6>
					<tr>
						 <td><b>E网精灵</b>简介:</td>
					</tr>
					<tr>
						 <td >&nbsp;&nbsp;&nbsp;&nbsp;众所周知，无论是作为一台访问资源的客户端还是作为一台被访问的资源提供服务器，您的计算机必须都分配有一个合法的IP地址，这个地址通常由互联网服务商提供给您（在中国通常是电信部门）。如果需要为互联网上的客户端提供服务，试想，如果一台服务器的IP是动态的，地址每天变换，那又有哪个用户可以记住服务器的地址呢？ 而一个固定IP地址的租用费用是十分昂贵的，往往超出个人、中小企业的承受能力，因此就有了现在的DNS服务（域名解析服务），它可以用一串容易记忆并富有含义的字符代替枯燥的IP地址。动态DNS（域名解析）服务，也就是可以将固定的互联网域名和动态（非固定）IP地址实时对应（解析）的服务。它可以将一个固定的域名解析到一个动态的IP地址，简单的说，不管用户何时上网、以何种方式上网、得到一个什么样的IP地址、IP地址是否会变化，他都能保证通过一个固定的域名就能访问到用户的服务器。</td>
					</tr>
					</table>
					
			<!-- 内容区 -->

</body>
</html>
