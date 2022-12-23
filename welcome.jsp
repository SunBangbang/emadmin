<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*"%>
<%@include file="/emadmin/shared/checkPermission1.jsp"%>
<%@include file="/emadmin/version.jsp"%>
<%
               response.setHeader("Pragma","No-cache"); 
                response.setHeader("Cache-Control","no-cache"); 
                response.setDateHeader("Expires", 0); 
                String _systemState=Api.getXtPreferenceValueByName("isystemenabled");
                String _productCode=Api.getXtPreferenceValueByName("productCode");
                String _prodcutModul=Api.getXtPreferenceValueByName("prodcutModul");
        if (_productCode.equals("xs")) {
            response.sendRedirect("/emadmin/navigation/xs/main.jsp");
            return;
        } else if (_productCode.equals("kc")) {
            response.sendRedirect("/emadmin/navigation/kc/main.jsp");
            return;
        } else if (_productCode.equals("cg")) {
            response.sendRedirect("/emadmin/navigation/cg/main.jsp");
            return;
        } else if (_productCode.equals("jxc")) {
            response.sendRedirect("/emadmin/navigation/jxc/main.jsp");
            return;
        } else if (_productCode.equals("jxcs")) {
            response.sendRedirect("/emadmin/navigation/jxcs/main.jsp");
            return;
        } else if (_productCode.equals("jxca")) {
            response.sendRedirect("/emadmin/navigation/jxca/main.jsp");
            return;
        } else if (_productCode.equals("kcs")) {
            response.sendRedirect("/emadmin/navigation/kcs/main.jsp");
            return;
        } else if (_productCode.equals("kca")) {
            response.sendRedirect("/emadmin/navigation/kca/main.jsp");
            return;
        } else if (_productCode.equals("sc")) {
            response.sendRedirect("/emadmin/navigation/sc/main.jsp");
            return;
        }      
            response.sendRedirect("/emadmin/shared/desktop.jsp");
%>


