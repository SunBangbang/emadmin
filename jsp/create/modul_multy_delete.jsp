<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%

	 String modul_id="multi_delete_modul";

	try
	{
		if( !Serve.checkMkQx( request ) )
		{
			response.sendRedirect("/emadmin/shared/gotologin.jsp");
			return ;
		}


	     if( request.getMethod().equalsIgnoreCase("post") )
         { 
			 Serve.MultyModulDelete( request );
			 
			 String url ="success.htm";
			 response.sendRedirect(url);
			 return; 
         }


	 }
	 catch( Exception e)
	 {
			response.sendRedirect("/emadmin/shared/usererror.jsp?id=error102");
			return;
	 }

     
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<script language="javascript">
<!--
      function selectAll0(sender, name)	  
	  {
			for(i=0; i<form1.lc.value; i++)
			{
		        document.getElementsByName( name + i )[0].checked = sender.checked;
		    }
	  }
      function selectAll1()	  
	  {
	        if( !form1.cb3.checked )
			     return;
			for(i=0; i<form1.lc.value; i++)
			{
		        document.getElementsByName( "delete_define_" + i )[0].selectedIndex = form1.delete_define_0.selectedIndex;
		    }
	  }
-->
</script>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>

<body>
<form action="modul_multy_delete.jsp" method="post" name="form1">
<table width="100%"  border="1" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
  <tr align="center">
    <td width="6%"class="tabletitle">&nbsp;</td>
    <td class="tabletitle"><input name="cb1" type="checkbox" id="cb1" value="checkbox" onClick="selectAll0( this, 'mid_')"> 批量选择      </td>
    <td class="tabletitle" colspan = 2 ><input name="cb3" type="checkbox" id="cb3" value="checkbox" onClick="selectAll1()">采用相同处理设置     </td>
    
  </tr>
  <tr align="center">
    <td  class="tabletitle">序号</td>
    <td  class="tabletitle">表单中文名称 </td>
    <td  class="tabletitle">表单英文名称</td>
    <td  class="tabletitle">是否删除表的定义</td>
  </tr>
  <%= Serve.getMulityModulDeleteTemplate(request) %>
      
  <input type="hidden" name="lc" value="<%= Serve.getMulityModulDeleteLine() %>">
  <input type="hidden" name="modul_id" value="<%=modul_id%>">
</table>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><input type="submit" name="Submit" value="保存"></td>
    </tr>
</table>
</form>
</body>
</html>
