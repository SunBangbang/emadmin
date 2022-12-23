<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*,java.sql.*,java.util.*"%>  
<%@ include file="/emadmin/shared/checkPermission1.jsp"%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="css/main.css">
</head>
		<%
				 	String message="";
					String cid="";
					String seachers ="";
					String nullValue="";
					 nullValue=request.getParameter("searchName");
					String category[]=null;
					String result[]=null;
				
					seachers = request.getParameter("backParm");
					String 	title="";
					String  author="";
					String publish_time="";
					String click_count="";
					String reply_count="";
					String  char_count="";
					 ObjPageBean p=null; 
					  cid = request.getParameter("cid");
					String zhangh[]=Api.sb("select id from xt_yh where zhanghao='"+session.getAttribute ("zhanghao")+"'");
						 //valueXsdb=((String[])session.getAttribute("userInfo"))[1];    //取当前yh_id
       
                     String  bm=((String[])session.getAttribute("userInfo"))[3];    //
                     String   bm_mc=Api.getValueName("000", bm);

				if (seachers==null || "".equals(nullValue) ){
				  
					
					
				    
						
							try {						
									p=ForumService.getPasteTitleList(request,"20");					
									category=ForumService.getCategoryNode(request);
									 if( p.r == null ||p.r.length == 0 ) {
										 message="没有文章！";
									 } else {
										result=(String[])p.r;
									 }
								} catch (Exception e) {
									message="在访问数据库的时候发现错误，错误信息如下：<br>"+e.getMessage();
								}

								

							
				}
				if (seachers!=null &&!"".equals(nullValue)){
						  if(seachers.equals("BACK")){

									    p=ForumService.getPasteTitleList(request,"20");					
										category=ForumService.getCategoryNode(request);
										String sql="";
									
										 sql="select '1',m.id,m.title,m.author,m.publish_time,m.clicked,(select count(b.publish_time) from oa_forum_paste a ,oa_forum_paste b where b.father=a.id and a.cid='"+cid+"' ) replycount,(select top 1 b.publish_time from oa_forum_paste a ,oa_forum_paste b where b.father=a.id and a.cid='"+cid+"' order by b.publish_time desc) father ,(select top 1 len(convert(varchar(7500),b.content)) from oa_forum_paste a ,oa_forum_paste b where (b.father=a.id and a.cid='"+cid+"' ) or(b.father='0' and a.cid='"+cid+"') order by b.publish_time desc) char_count,'1' from view_oa_forum m,oa_forum_category n  where  m.autokeyword  like '%"+request.getParameter("searchName")+"%'  and m.cid='"+cid+"'  and ((m.user_id=n.admin or m.user_id=n.admin1) or ( (','+'"+bm+"'+'%') like n.departments )	or ( (','+'"+zhangh[0]+"') like n.users)   or n.is_qx='0' ) and m.cid=n.cid";
									
										 result=(String[])Api.sb(sql);
										
										if( result == null ||result.length == 0 ) {
											 message="没有相关的文章！";
										 } else {
											message="";
										 }								
										
									
						  }
				}		 

		%>           

<body>

<table width="100%"  border="0" align="center" cellSpacing="0" cellPadding="0">
  <tr>
    <td align="center" valign="top">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr class="qiangdiaotd">
     <td height="28" align="left" nowrap style="background-image: url(/emadmin/images/c3/jsb.gif); background-repeat: repeat-x;font: 12px; font-weight: bold; color:#2e6dce;">&nbsp;&nbsp;&nbsp;&nbsp;<%=category[3]%></td> 
	  <%if(category[9].equals(session.getAttribute ("zhanghao")) || category[10].equals(session.getAttribute ("zhanghao"))|| 
	  (category[11].equals("1")) ){%>
	 <td align="right" nowrap height="20px;" style="padding-top:6px; margin: 0px; vertical-align: middle;background-image: url(/emadmin/images/c3/jsb.gif); background-repeat: repeat-x; "><a href="lt_newpaste.jsp?cid=<%=cid%>" class="linkline"><img src="/emadmin/images/c2/button/new_ati.gif" border="0"></a>&nbsp;&nbsp;</td>
      <%}%>     
	 </tr>
	 </table>
<tr>
<td  align="center" vAlign="top" colspan="2">
<% if (message.equals("")) {%>
		<table width="100%"  border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff>
          <tr class="qiangdiaotd1">
            <td width="33%" nowrap colspan="2"><div align="center" style="font-size: 12px;font-weight: bold;color: #2e6dce;">主题</div></td>
            <td width="10%" nowrap><div align="center" style="font-size: 12px;font-weight: bold;color: #2e6dce;">作者</div></td>
            <td width="23%" nowrap><div align="center" style="font-size: 12px;font-weight: bold;color: #2e6dce;">发表时间</div></td>
            <td width="5%" nowrap><div align="center" style="font-size: 12px;font-weight: bold;color: #2e6dce;">点击数</div></td>
            <td width="5%" nowrap><div align="center" style="font-size: 12px;font-weight: bold;color: #2e6dce;">回复数</div></td>
            <td width="19%" nowrap><div align="center" style="font-size: 12px;font-weight: bold;color: #2e6dce;">最后回复</div></td>
            <td width="5%" nowrap><div align="center" style="font-size: 12px;font-weight: bold;color: #2e6dce;">字数</div></td>
          </tr>
	  <% for (int i=0;i<result.length;i+=10) { %>
      <tr>
      	<td width="15px;"><img src="/emadmin/images/c2/icon/ati_left.gif"></td>
        <td><div style="font-size: 12px;">&nbsp;&nbsp;<a href="lt_pastelist.jsp?id=<%=result[i+1]%>&cid=<%=cid%>" class="newslink"><%=result[i+2]%>&nbsp;</a></div></td>
        <td><div align="center" style="font-size: 12px;"><%=result[i+3]%>&nbsp;</div></td>
        <td><div align="center" style="font-size: 12px;"><%=result[i+4]%>&nbsp;</div></td>
        <td><div align="center" style="font-size: 12px;"><%=result[i+5]%>&nbsp;</div></td>
        <td><div align="center" style="font-size: 12px;"><%=result[i+6]%>&nbsp;</div></td>
        <td><div align="center" style="font-size: 12px;"><%=result[i+7]%>&nbsp;</div></td>
        <td><div align="center" style="font-size: 12px;"><%=result[i+8]%>&nbsp;</div></td>
      </tr>
	  <%}%>
    </table>
		<%=p.getBar(request)%>
<% } else { %>
<div align="center"><%=message%></div>
<%}%>
	</td>
  </tr>
    </table>
	</td>
  </tr>
</table>
</body>
</html>
