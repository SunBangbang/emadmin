<%@page contentType="text/html;charset=gbk" %>
<%@page import="com.lf.lfbase.service.*"%>
<% 
		String id=request.getParameter("id");
		if (id!=null) {
			String r[]=Api.sb("select top 1 id from kh_da  ");
//			String r[]=Api.sb("select top 1 id from kh_da where mobile1 like '%"+id+"%' or phone like '%"+id+"%' or unitphone like '%"+id+"%' or familyphone like '%"+id+"%' ");
			if (r!=null && r.length>0) {  %>
				<script LANGUAGE="javascript">
				<!--

window.open("/emadmin/jsp/common/detail.jsp?modul_id=kh_da_detailModul&id=<%=r[0]%>&_mainCN=kh_da&_mainID=<%=r[0]%>&url=%2Femadmin%2Fjsp%2Fcommon%2Flist.jsp%3Fmodul_id%3Dkh_da_listModul","lfem","status=yes,left=1,top=1,height=80%,width=80%,menubar=no,status=no,toolbar =no,directories=no,resizable=yes");
				//-->
				</script>

			<%;
	//response.sendRedirect("/emadmin/jsp/common/memberdetail.jsp?modul_id=kh_da_detailModul&id="+r[0]+"&_mainCN=kh_da&_mainID="+r[0]+"&url=%2Femadmin%2Fjsp%2Fcommon%2Flist.jsp%3Fmodul_id%3Dkh_da_listModul");
				//return;
            }

		}
	
%>
