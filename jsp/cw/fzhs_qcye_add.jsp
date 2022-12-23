<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%

	String id = "";
	String result[] = new String [2];
	if( !Serve.checkMkQx( request ) )	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}
	 if( request.getMethod().equalsIgnoreCase("post") )   {
             id=Serve.billActionInsert( request );
        	 if (Serve.checkErrorString(id))  {
				response.sendRedirect("/emadmin/shared/usererror.jsp?id="+id);
				return;
			 } else {
				 String url =Serve.getDMBEditNextUrl( request );
				 response.sendRedirect(url);
				 return;
			 }
      } else {
			 result = Serve.commonGetSheetForModify( request );
	  }
%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
		function _after_load() { 
			//根据页面上的辅助核算属性，隐藏相关辅助核算项目
			if (document.getElementsByName('sfgyswl' )[0].value!='1') {
                isgys.style.display="none";
                document.getElementsByName('gys' )[0].reg="";
            }
			if (document.getElementsByName('sfkhwl' )[0].value!='1') {
                iskh.style.display="none";
                document.getElementsByName('kh' )[0].reg="";
            }
			if (document.getElementsByName('sfxmhs' )[0].value!='1') {
                isxm.style.display="none";
                document.getElementsByName('xm' )[0].reg="";
            }
			if (document.getElementsByName('sfgrwl' )[0].value!='1') {
                isgr.style.display="none";
                document.getElementsByName('gr' )[0].reg="";
            }
			if (document.getElementsByName('sfbmhs' )[0].value!='1') {
                isbm.style.display="none";
                document.getElementsByName('bm_id' )[0].reg="";
           }
			if (document.getElementsByName('biz' )[0].value=='')  iswb.style.display="none";
           // 把期初余额设为只读，只能计算不能录入
			document.getElementsByName('qcye' )[0].readonly=true;
			document.getElementsByName('wbqcye' )[0].readonly=true;

		}
		function recount() { 
			    fx=document.getElementsByName("yefx")[0].value;
				r1=parseFloat(document.getElementsByName("ncye")[0].value);
				r2=parseFloat(document.getElementsByName("jfje")[0].value);
				r3=parseFloat(document.getElementsByName("dfje")[0].value);
				r5=parseFloat(document.getElementsByName("wbncye")[0].value);
				r6=parseFloat(document.getElementsByName("wbjfje")[0].value);
				r7=parseFloat(document.getElementsByName("wbdfje")[0].value);
			if (fx=='1') {   //方向借
				document.getElementsByName("qcye")[0].value=r1+r2-r3;
				document.getElementsByName("wbqcye")[0].value=r5+r6-r7;
			} else {
				document.getElementsByName("qcye")[0].value=r1-r2+r3;
				document.getElementsByName("wbqcye")[0].value=r5-r6+r7;
			}
			return;

		}

 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
   //-->
</SCRIPT>
<html>
<head>
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>

<body onload="_after_load();">
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
		  <%=result[0]%>&nbsp;<!-- 按扭区 -->
		  <!-- 内容区 -->
					<table width="90%"  border="0" cellspacing="0" cellpadding="0" align="center">
						  <form action="fzhs_qcye_add.jsp" method="post" name="form1" >
						  <tr>
							<td align="left">	
								  <%=result[1]%>							
							  	<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="保存" onclick="_click_button(form1)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
						   </td>
						  </tr>
						  </form>
						</table>
			
			<!-- 内容区 -->

</body>
</html>
