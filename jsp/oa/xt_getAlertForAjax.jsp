<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*"%>
<%              //以下3句话防止cache
                response.setHeader("Pragma","No-cache"); 
                response.setHeader("Cache-Control","no-cache"); 
                response.setDateHeader("Expires", 0); 

				String message="";
				String result[]=null;
				try {	
						result=OaService.getAlert(session);	
					} catch (Exception e) {
                        e.printStackTrace();
                        System.out.println(e.getMessage());
						message="在访问数据库的时候发现错误，错误信息如下：<br>"+e.getMessage();
					}
				String s="";
				for (int i=0;i<result.length;i+=13) { 
					s+="window.open('/emadmin/jsp/oa/xt_alert_message.jsp?id="+result[i]+"','','left=250,top=20,height=600,width=600,resizable=no,scrollbars=no,status=no,toolbar=no,menubar=no,location=no');";
				} 
                out.println(s);
		%>