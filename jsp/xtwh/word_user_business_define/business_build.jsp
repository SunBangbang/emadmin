<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.net.*"%>
<%


   String modulId = request.getParameter("modul_id");
   String id = request.getParameter("id");

	//读出标题
	String r_titel[]=Api.sb("select name from xt_uword_define where id = '"+ id +"'");
	String title = r_titel[0];

		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}

	     if( request.getMethod().equalsIgnoreCase("post") )
         {
             Serve.buildUserWordDefine( request );

			 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功 ！","UTF-8"));
			 return ;
         }
		 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>

<script language=javascript src="/emadmin/js/do_check.js"></script>
<script language=javascript src="/emadmin/js/pop_selections.js"></script>
<script language=javascript src="/emadmin/js/bi_sub_table.js"></script>
<script language=javascript src="/emadmin/js/print.js"></script>
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




		<%@include file="/emadmin/shared/content_1.jsp"%>
			<!-- 标题区 --> 
				<%=Serve.getModulName( request )%>
			<!-- 标题区 --> 
		<%@include file="/emadmin/shared/content_2.jsp"%>
			<!-- 按扭区 --> 
							&nbsp;
			<!-- 按扭区 --> 
		<%@include file="/emadmin/shared/content_3.jsp"%>
			<!-- 内容区 -->








	
<form name="inputForm" method="post" action="business_build.jsp"   onSubmit="return formBmQxsubmit()">
<input type="hidden" name="modul_id" value="<%=modulId%>">
<input type="hidden" name="id" value="<%=id%>">

<table  width="100%"   border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
	<tr  align="center" >
			<td  align="center" class="tabletitle" > [<%=title%>] --WORD自定义业务创建  </td>
    </tr>
    <tr >


	<td class="tabletitle">&nbsp;&nbsp;说明：<br>
		
		&nbsp;&nbsp;1、在项目类型中，选择审核、核准等信息，系统会为该业务自动生成多级审批流程。<br>
		&nbsp;&nbsp;2、如果存在系统未分析出的信息，请检查你“列名称”是否用西文"[]"进行的定义,例如"姓名"的定义方式为： [姓名]。<br>
		&nbsp;&nbsp;3、模板使用一段时间，如果需要变更，可以直接修改模板，再选择创建就可以了，但已创建的部分信息是不允许修改的。<br>
	</td>

    </tr>


  <tr>
    <td>	
       <%=Serve.getUserWordDefineSet( request )%>
    </td>
  </tr>


	<tr > <td colspan="4" height="30"> 
			<div align="center" id="_button_area" style="display:block"><input type="button" name="Submit" value="提交" onClick="_click_button(inputForm)"> <input type="button" name="cancel" value="取消"  onclick='javascript:history.back(-1);'></div>
			<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
	</tr>


  </table>

</form>
	
			<!-- 内容区 -->
		<%@include file="/emadmin/shared/content_4.jsp"%>


</body>
</html>
