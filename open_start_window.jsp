<%@page import="com.lf.lfbase.service.*"%>
<% 
       String _productType=Api.getXtPreferenceValueByName("productType");
       String _systemState=Api.getXtPreferenceValueByName("isystemenabled");
       String _isFirstRun=Api.getXtPreferenceValueByName("isFirstRun");
       if (false && _productType.equals("trial") && _systemState.equals("1") && _isFirstRun.equals("1")) { %>
              <SCRIPT language=JavaScript>
              <!-- 
                    window.open('/emadmin/start_window.jsp','','status=yes,left=250,top=100,height=500,width=680,status=no,directories=no,resizable=no,scrollbars=yes');
                --> 
              </SCRIPT>
       <% } %>

