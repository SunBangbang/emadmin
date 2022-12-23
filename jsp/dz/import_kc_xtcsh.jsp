<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.io.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,java.net.*,java.lang.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
	String id = "";
	String result[] = new String [2];
	if( !Serve.checkMkQx( request ) )	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}
	String sql="";
	String sql2="";
	String sql3="";
	String sql4="";
	String[] rsql=null;
	String[] rsql2=null;
	String[] rsql3=null;
	String[] rsql4=null;
	int num1=0;
	int num2=0;
	int num3=0;
	int num4=0;
	/*
	sql="select count(*) from kc_ckd ";
	rsql=Api.sb(sql);
	if(rsql!=null || rsql.length>0){
			num1=Integer.parseInt(rsql[0]);
	}
	sql2="select count(*) from kc_rkd ";
	rsql2=Api.sb(sql2);
	if(rsql2!=null || rsql2.length>0){
			num2=Integer.parseInt(rsql2[0]);
	}

	sql3="select count(*) from jc_cksz";
	rsql3=Api.sb(sql3);
	if(rsql3!=null || rsql3.length>0){
			num3=Integer.parseInt(rsql3[0]);
	}

	sql4="select count(*) from jc_chda";
	rsql4=Api.sb(sql4);
	if(rsql4!=null || rsql4.length>0){
			num4=Integer.parseInt(rsql4[0]);
	}		*/

	/*if((rsql!=null || rsql2!=null)&&(num1>0 || num2>0) ){
		response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("本系统已有 出库单 或入库单,不能进行期初导入","UTF-8")+"");
		return ;
	}*/
%>
<html>
<head>
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
 		function _click_button(formx) { 
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				formx.submit();
		}
   //-->
</SCRIPT>

<body >
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
 		 <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						初始化导入
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
		  &nbsp;<!-- 按扭区 -->
        <table class="x_bill_outer_table" cellspacing="0" align="center">
		    <tr>
			    <td>
					    <div align="center">   
                                <table cellspacing="0" class="x_list_export_result_table"> 
   		                                <tr>
   			                                <td class="x_list_export_result_title_td">
                                            <br/>
                                                    <form name='form1' action="import_kc_xtcsh_add.jsp" method="post" enctype="multipart/form-data">
                                                            <div id='insert_title' class="x_excel_area_title_div">
                            										<input type="hidden" name="modul_id" value="<%=request.getParameter("modul_id")%>">
                                                                    <input type="hidden" name="is_pc" value="<%=Api.getXtPreferenceValueByName("is_pc")%>"> 
                                                                     <input type="hidden" name="delete"  value="nodelete">
                                                                    
                                                                   <span class="x_excel_alert_message">（提示: 通过Excel导入,批量向数据库中新增数据)</span>
                                                                    
                                                             </div>
                                                            <div id='insert_content' class="x_excel_area_content_div_disp">
                                                                        <div class="x_excel_content_line_div" >第一步：下载右边的Excel模板。&nbsp;&nbsp;&nbsp;&nbsp; <a href="/emadmin/resource/template/初始化导入模板<%=(Api.getXtPreferenceValueByName("is_pc").equals("1"))?"(有批次管理)":""%>.xls" target="_blank" class="x_list_result_title_link"><img src="/emadmin/images/c2/icon/excel.gif" border="0" style="vertical-align:middle"/> 初始化导入模板</a></div>
                                                                        <div  class="x_excel_content_line_div" >第二步：向Excel模板中添加数据。 <span class="x_excel_alert_message">(注意：不能改变模板中的栏目及格式) </span></div>
                                                                        <div  class="x_excel_content_line_div" >第三步：点击“浏览”，打开添加好数据的Excel文件，点击“开始导入”。</div>
                                                                        <div id="_button_area" class="x_excel_content_line_div" style="display:block">
                                                                                    <input type=file name="myfile" style="vertical-align:middle">
                                                                                    &nbsp;&nbsp;<img src="/emadmin/images/c2/button/excel_start_import.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form1)" style="vertical-align:middle"/> &nbsp;&nbsp;<img src="/emadmin/images/c2/button/excel_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:history.back(-1);' style="vertical-align:middle"/> 
                                                                        </div>
                                                                        <div align="center" id="_button_area_message" style="display:none;">正在处理，请稍等...</div>
                                                           </div>
                                                    </form>
                                                    
                                            </td>
                                        </tr>
   	                            </table>
                        </div>	
				</td>
			</tr>
		</table>

</body>
</html>
