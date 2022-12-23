<jsp:useBean id="qx" class="com.lf.crm.Module" scope="page"/>
<%  if(session.getAttribute("userId")==null)  { %>
<SCRIPT LANGUAGE="JavaScript">
<!--
			window.top.location.href='/emadmin/index.jsp';
//-->
</SCRIPT>
 <% }%>
<% 
    String qx_data[]=qx.checkPermiton((String)session.getAttribute("userId"),moduleId);
	if (qx_data==null || qx_data.length != 4) 
    {
        response.sendRedirect("/denied.jsp");
        return;
    }
	session.setAttribute("moduleId",moduleId);
	session.setAttribute("qxDepartment",qx_data[2]);
	session.setAttribute("qxIsLimit",qx_data[3]);
	session.setAttribute("userIp",request.getRemoteAddr());
%>

