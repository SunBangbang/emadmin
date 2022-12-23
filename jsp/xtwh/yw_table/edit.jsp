<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*,java.net.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%! public String getChecked(String x1,String x2) {
			if (x1==null || x2==null) return "";
			if (x1.equals(x2)) {
				return "checked"; 
			} else {
				return "";
			}
		}
%>
<%! public String colume_type_title(String x1) {
			if (x1.equals("1")) return "文本";
			if (x1.equals("2")) return "实数";
			if (x1.equals("3")) return "日期";
			if (x1.equals("4")) return "大文本";
			if (x1.equals("5")) return "整数";
            return "";
		}
%>

<%

    if( !Serve.checkMkQx( request ) )	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}
	String _productCode=Api.getXtPreferenceValueByName("productCode");
	String levelType="standard";
 
 		if (_productCode.equals("kcs") || _productCode.equals("jxcs")   )    
 		 {
              levelType="simple";
         } else if (_productCode.equals("crma") || _productCode.equals("crmfa")  || _productCode.equals("erp")  || _productCode.equals("erpc") || _productCode.equals("kca") || _productCode.equals("jxca"))     
         {
              levelType="advance";
         }
	String modul_id = request.getParameter("modul_id");

	String table_name = request.getParameter("_mainCN");

    if( request.getMethod().equalsIgnoreCase("post") )   {
			DefineService.updateItem(request);

			response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功 ！","UTF-8"));
			return ;

	  }


    String sql="select distinct b.table_name,b.display_name from xt_bill_area a, xt_tables b ";
                sql+=" where a.table_name=b.table_name";
                sql+=" and a.bill_id in (select bill_id from xt_bill_area where table_name='"+table_name+"')";

    String r[]=Api.sb(sql);
    if (r==null || r.length==0) throw new  LFException("未能找到需要设置的表单定义，请联系系统管理员！");

    String rr[][]=new String[r.length/2][];
    
    for (int i=0;i<r.length;i+=2) {
            sql="select id,table_name,display_name,colume_type,row_index,is_required,is_required_sum,is_hidden,default_value,is_list_filter,is_add,is_update,is_detail,is_print,is_list  from xt_tables_define  where is_list_filter<>'0' and table_name='"+r[i]+"' order by row_index";
            rr[i/2]=Api.sb(sql);
    }


%>
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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
<%if(levelType.equals("standard")) {%>
<SCRIPT LANGUAGE='JavaScript'> 
 		window.onload=function(){ 
 			<%for (int i=0;i<r.length;i+=2) {%>
				document.getElementById('div_bl_td<%=i%>').style.display='none';
				document.getElementById('div_sum_td<%=i%>').style.display='none';
				document.getElementById('div_hidn_td<%=i%>').style.display='none';
				document.getElementById('div_op_td<%=i%>').style.display='none';
			<% for (int j=0;j<rr[i/2].length;j+=15) {%>
				document.getElementById('div_bl<%=i%>_<%=j%>').style.display='none';
				document.getElementById('div_sum<%=i%>_<%=j%>').style.display='none';
				document.getElementById('div_hidn<%=i%>_<%=j%>').style.display='none';
				document.getElementById('div_op<%=i%>_<%=j%>').style.display='none';
			<%}}%>
		}
</SCRIPT>
<%} %>
</head>

<body >
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
 		 <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						维护表单项目
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
		
          <!-- 按扭区 -->
        <%@include file="menu.jsp"%>

		  <!-- 内容区 -->
					<table class="x_bill_outer_table" cellspacing="0" align="center">
						  <tr>
							<td align="left">	
						  <form action="edit.jsp" method="post" name="form1" >
            						<input type="hidden" name="modul_id" value="<%=modul_id%>">
            						<input type="hidden" name="table_name" value="<%=table_name%>">

             <% for (int i=0;i<r.length;i+=2) {%>
                    <div><%=r[i+1]%></div>
                    <table>
                            <tr>
                                    <td>项目名称</td>
                                    <td>顺序号</td>
                                    <td>项目类型</td>
                                    <td><div id='div_bl_td<%=i%>'>是否必须录入</div></td>
                                    <td><div id='div_sum_td<%=i%>'>是否需要合计</div></td>
                                    <td><div id='div_hidn_td<%=i%>'>是否隐藏</div></td>
                                    <td align="center"><div id='div_op_td<%=i%>'>界面设置</div></td>
                            </tr>
                        <% for (int j=0;j<rr[i/2].length;j+=15) {%>
                            <tr>
            						<input type="hidden" name="id$<%=rr[i/2][j]%>" value="">
                                    <td><input type="text" size=20 name="<%=rr[i/2][j]%>_display_name" value="<%=rr[i/2][j+2]%>"></td>
                                    <td><input type="text" size=6 name="<%=rr[i/2][j]%>_row_index" value="<%=rr[i/2][j+4]%>"></td>
                                    <td align="center"> <%=colume_type_title(rr[i/2][j+3])%></td>
                                    <td><div id='div_bl<%=i%>_<%=j%>'><input type="checkbox" name="<%=rr[i/2][j]%>_is_required" value="1" <%=getChecked("1",rr[i/2][j+5])%>>必录</div></td>
                                    <td><div id='div_sum<%=i%>_<%=j%>'>
                                    <% if (rr[i/2][j+3].equals("2") || rr[i/2][j+3].equals("6")) {%>
                                            <input type="checkbox" name="<%=rr[i/2][j]%>_is_required_sum" value="1" <%=getChecked("1",rr[i/2][j+6])%>>合计
                                     <%} else {%>
                                              <input type="hidden" name="<%=rr[i/2][j]%>_is_required_sum"  value="1">
                                     <%} %></div>
                                    </td>
                                    <td><div id='div_hidn<%=i%>_<%=j%>'><input type="checkbox" name="<%=rr[i/2][j]%>_is_hidden" value="1" <%=getChecked("1",rr[i/2][j+7])%>>隐藏</div></td>
                                    <td><span id='div_op<%=i%>_<%=j%>'><input type="checkbox" name="<%=rr[i/2][j]%>_is_add" value="1" <%=getChecked("1",rr[i/2][j+10])%>>新增
                                    <input type="checkbox" name="<%=rr[i/2][j]%>_is_update" value="1" <%=getChecked("1",rr[i/2][j+11])%>>修改
                                    <input type="checkbox" name="<%=rr[i/2][j]%>_is_detail" value="1" <%=getChecked("1",rr[i/2][j+12])%>>详情
                                    <input type="checkbox" name="<%=rr[i/2][j]%>_is_list" value="1" <%=getChecked("1",rr[i/2][j+14])%>>列表查询
                                    </span> <input type="checkbox" name="<%=rr[i/2][j]%>_is_print" value="1" <%=getChecked("1",rr[i/2][j+13])%>>打印 </td>
                            </tr>
                        <% } %>
                    </table>
             <% } %>



                                <div align="center" id="_button_area" style="display:block; padding-top:10px;vertical-align:bottom;">
								<img src="/emadmin/images/c2/button/bill_save.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form1)"/> &nbsp;&nbsp;&nbsp;&nbsp;
                                <% String is_new_window=request.getParameter("is_new_window");
                                    if ((is_new_window!=null && is_new_window.equals("1")) || (request.getParameter("back_item_value")!=null)){%>
                                    <img src="/emadmin/images/c2/button/bill_close.gif" onMouseOver="this.style.cursor='hand'"   onclick='window.close();'/>
                                <%} else {%>
                                    <img src="/emadmin/images/c2/button/bill_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);'/> 
                                <%} %>
                                </div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
						  </form>
						   </td>
						  </tr>
						</table>
			
			<!-- 内容区 -->

</body>
</html>
