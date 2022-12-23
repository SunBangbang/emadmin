<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="com.lf.lfbase.util.*,com.lf.lfbase.service.*,com.lf.lfbase.product.*,java.util.*,java.text.DecimalFormat"%>
<%
            SendHtmlMail x=new SendHtmlMail("panzehui@vip.sina.com","jackie@lingfei.net","mail.lingfei.net","jackie@lingfei.net","configyt","²âÊÔ","<html>sdfsdf <IMG  src=\"\\emadmin\\images\\message2.gif\" ></html>");
            x.setAttach("\\upload\\20090331001421790.gif,\\upload\\20090331001320123.bmp");
           x.sendMail();
%>

ok