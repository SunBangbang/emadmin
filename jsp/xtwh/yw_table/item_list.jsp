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

	String modul_id = request.getParameter("modul_id");

	String table_name = request.getParameter("_mainCN");


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
</head>

<body >
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区 --> 
			<td height=""  valign="middle" class='x_center_head_bg'>
					<span class="x_center_title" >
						
					</span>
			</td>
			<!-- 标题区 --> 
		  </tr>
		  </table>
          <!-- 按扭区 -->
        <%@include file="menu.jsp"%>

		  <!-- 内容区 -->
					<table class="x_bill_outer_table" cellspacing="0" align="center">
						  <tr>
							<td align="left">	
						  <form action="add.jsp" method="post" name="form1" >
            						<input type="hidden" name="modul_id" value="<%=modul_id%>">

             <% for (int i=0;i<r.length;i+=2) {%>
                    <div><%=r[i+1]%></div>
                    <table>
                            <tr>
                                    <td>项目名称</td>
                                    <td>顺序号</td>
                                    <td>项目类型</td>
                                    <td>是否必须录入</td>
                                    <td>是否需要合计</td>
                                    <td>是否隐藏</td>
                                    <td>界面设置</td>
                            </tr>
                        <% for (int j=0;j<rr[i/2].length;j+=15) {%>
                            <tr>
                                    <td><input type="text" size=20 name="display_name" value="<%=rr[i/2][j+2]%>"></td>
                                    <td><input type="text" size=6 name="row_index" value="<%=rr[i/2][j+4]%>"></td>
                                    <td align="center"> <%=colume_type_title(rr[i/2][j+3])%></td>
                                    <td><input type="checkbox" name="is_required" value="1" <%=getChecked("1",rr[i/2][j+5])%>>必录</td>
                                    <td><input type="checkbox" name="is_required_sum" value="1" <%=getChecked("1",rr[i/2][j+6])%>>合计</td>
                                    <td><input type="checkbox" name="is_hidden" value="1" <%=getChecked("1",rr[i/2][j+7])%>>隐藏</td>
                                    <td><input type="checkbox" name="is_add" value="1" <%=getChecked("1",rr[i/2][j+10])%>>新增
                                    <input type="checkbox" name="is_update" value="1" <%=getChecked("1",rr[i/2][j+11])%>>修改
                                    <input type="checkbox" name="is_detail" value="1" <%=getChecked("1",rr[i/2][j+12])%>>详情
                                    <input type="checkbox" name="is_print" value="1" <%=getChecked("1",rr[i/2][j+13])%>>打印 
                                    <input type="checkbox" name="is_list" value="1" <%=getChecked("1",rr[i/2][j+14])%>>列表查询
                                    </td>
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
