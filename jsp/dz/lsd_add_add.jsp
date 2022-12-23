<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*,java.net.*,com.lf.util.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%! public String getType(String num) {
			if (num==null) return "";
			if (num.equals("1")) {
				return "text"; 
			} else {
				return "hidden";
			}
		}
	public String getStyle(String num) {
			if (num==null) return "";
			if (num.equals("0")) {
				return "style='display:none;'"; 
			} else {
				return "";
			}
		}
%>
<%

	String id = "";
	String result[] = new String [2];
	String uid=((String[])session.getAttribute("userInfo"))[0];
	String uname=((String[])session.getAttribute("userInfo"))[2];
	String ubm=((String[])session.getAttribute("userInfo"))[3];
	String ubmname[]=Api.sb("select name from xt_bm where id='"+ubm+"'");
	String udate=Util.getDate();
    if( !Serve.checkMkQx( request ) )	{
		response.sendRedirect("/emadmin/shared/gotologin.jsp");
		return ;
	}
	String ck[]=Api.sb("select top 1 id from jc_cksz where kg like '%"+((String[])session.getAttribute("userInfo"))[0]+"%'");//定义仓库;
	String zffs[]=Api.sb("select is_add,display_name from xt_tables_define where table_name='xs_lsd' and colume_name in ('neika','waika','zhipiao','daijinquan','qt1','qt2','qt3','qt4','qt5')");//定义支付方式
	 if( request.getMethod().equalsIgnoreCase("post") )   {

         try {
             id=Serve.billActionInsert( request );
         }catch (Exception e) {
             if (request.getParameter("back_item_value")!=null){
                response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("出现了异常情况 ！错误信息如下: <br><br>"+e.getMessage()+" 请重新输入!","UTF-8")+"&back="+URLEncoder.encode(request.getParameter("_backurl"),"UTF-8"));
            } else {
                throw e;
            }
         }
             //判断是否是弹出窗口挂新增
        if (request.getParameter("back_item_value")!=null){  %>
            <SCRIPT LANGUAGE='JavaScript'>
                window.top.document.getElementById('_global_save').value="";
                window.returnValue = true;
                window.dialogArguments[0] = "<%=id%>";
                window.close();
            </SCRIPT>
			<% return;
        } else {
        	 if (Serve.checkErrorString(id))  {
				response.sendRedirect("/emadmin/shared/usererror.jsp?id="+id);
				return;
			 } else {
				 //response.sendRedirect("/emadmin/jsp/dz/xs_lsd_add_print_ready.jsp?id="+id); //response.sendRedirect("/emadmin/jsp/dz/lsd_add_add.jsp?modul_id=xs_lsd_add_Modul");
				//return;
			 }
        }
      } 
%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
   //设置网页打印的页眉页脚为空 

		function _after_load() {
			<%if( request.getMethod().equalsIgnoreCase("POST") )   {%>
				window.frames['prt'].focus();
				window.frames['prt'].print();
			<%}%>
            if (window.top.document.getElementById('_global_save')!=null && window.top.document.getElementById('_global_save').value.length>0) {
                document.body.innerHTML=window.top.document.getElementById('_global_save').value;
                window.top.document.getElementById('_global_save').value="";
 			    document.getElementById('_button_area' ).style.display="block";
			    document.getElementById('_button_area_message' ).style.display="none";
 			    reAttachSubAreaEvent();              
           }
          
			for (var i = 0; i <form1.elements.length ; i++) 
			{
				
				thisItem=form1.elements.elements[i]; 
				
				if(thisItem.name.indexOf('maxcount')>0)
				{

					var maxcount_i = parseInt(thisItem.value);


					if (maxcount_i <= 0 && (form1.all("_sys_txm")==null || form1.all("_sys_txm").type!='text')) {
                            if (document.getElementsByName('add' ).length>0) {
                                document.getElementsByName('add' )[0].click();
                            } else if  (document.getElementById('add' )!=null) {
						        document.getElementById('add' ).click();
                            }
                    }

				}
				
			}
			if (form1.all("_sys_txm")!=null && form1.all("_sys_txm").type=='text') {
                			//条形码
			        form1.all("_sys_txm").onkeydown = function(){ 
						_doTxmInput();
					};
			        form1.all("_sys_txm").focus();
            }
			<% if(ck.length==0){
				ck=new String[1];
			%>
				alert("请先让管理员为您分配仓库!");
				window.close();
			<%}%>
			
		}
		
 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				if(document.getElementById('zhaoling').value<0){
					alert("当前的实收合计小于金额合计，请确认后重试！");
					return;
				}
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
                if (window.top.document.getElementById('_global_save')!=null)  window.top.document.getElementById('_global_save').value= document.body.innerHTML
				form1.submit();
			}
			
		}
   //-->
</SCRIPT>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META name=save content=history >
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<base target="_self">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>

<body onLoad="_after_load();">
<%if( request.getMethod().equalsIgnoreCase("POST") )   {%>
<iframe   name="prt"   src="/emadmin/jsp/dz/xs_lsd_add_print.jsp?id=<%=id%>"   width="0"   height="0"></iframe> 
<%}%>
<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						开始零售
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
	<form action="lsd_add_add.jsp" method="post" name="form1" >
<!-- 
隐藏部分
-->
<input name="lsrq"  type=hidden  regName ="零售日期"  reg = "_r__date_" value="<%=Util.getDate()%>" >
<input name="ck" type=hidden value="<%=ck[0]%>">
<input name="ywy_mc"  type=hidden regName ="销售代表" value="<%=uname%>"  >

<input  name="ywbm_mc"  type=hidden regName ="销售部门" value="<%=ubmname[0]%>" >

<input  name="bz" type=hidden regName ="备注" value="">

<input type="hidden" name="modul_id" value="xs_lsd_addModul">

<input type="hidden" name="listretid" value="null">
								  
<table width="98%" border ="1" cellpadding="0" cellspacing="0" borderColor=#dee7f6 align="center" style="border:0px;">
  <tr>
    <td  style="padding-left:80px;"  width="50%">卡号:<input name="kahao"  type=text regName ="卡号" value=""  readonly="1"  onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"120")  onClick="_doSelect_mainarea_kahao()" > <img src="/emadmin/images/c2/button/choose.gif" border=0    onMouseOver=this.style.cursor="hand"  onClick="_doSelect_mainarea_kahao();"/></td>
    <td style="padding-left:80px;"  width="50%">条码:<input type=text name='_sys_txm' value=''></span></div><input type=hidden name=_subarea_xs_lsd_xs_lsd_sub_add_maxcount value="0"></td>
  </tr>
</table>
<table width="98%" border ="1" cellpadding="0" cellspacing="0" borderColor=#dee7f6 align="center">
  <tr>
    <td colspan="3" align="center">
	<!--子表货品开始-->
	<div id="_sub_bill_area_div" class='x_bill_sub_area_div' style="OVERFLOW-Y: auto;OVERFLOW: auto; WIDTH: 100%; HEIGHT: 250px;">
       <table width="100%" id='_subarea_xs_lsd_xs_lsd_sub_add'  class='x_bill_sub_bill_table'  cellpadding='0' cellspacing='0' align="center">
            <tr id='_subarea_xs_lsd_xs_lsd_sub_add_0' class='x_bill_sub_bill_table_header_tr'>
                <td nowrap align=center  class='x_bill_sub_bill_table_header_td_hh'>&nbsp;&nbsp;行 号&nbsp;&nbsp;</td>
                <td nowrap align=center   class='x_bill_sub_bill_table_header_td'>条码</td>
                <td nowrap align=center   class='x_bill_sub_bill_table_header_td'>品名</td>
                <td nowrap align=center   class='x_bill_sub_bill_table_header_td'>规格</td>
                <td nowrap align=center   class='x_bill_sub_bill_table_header_td'>数量</td>
                <td nowrap align=center   class='x_bill_sub_bill_table_header_td'>单价</td>
                <td nowrap align=center   class='x_bill_sub_bill_table_header_td'>折扣</td>
                <td nowrap align=center   class='x_bill_sub_bill_table_header_td'>金额</td>
                <td nowrap align=center   class='x_bill_sub_bill_table_header_td'>相关属性</td>
            </tr>
		</table>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
function _subarea_xs_lsd_xs_lsd_sub_add_add_new_row() {

                var maxcount_i =parseInt(document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_maxcount')[0].value);
                var row_html=new Array(8);
                row_html[0]='<input name="_subarea_xs_lsd_xs_lsd_sub_add_chbm_' + maxcount_i + '"  type=text regName ="条码"  reg = "_r_" size="10" value=""  readonly="1"   class="x_bill_item_input_sub" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"120");  onClick="_doSelect_subarea_xs_lsd_xs_lsd_sub_add_chbm(' + maxcount_i + ')"  > <img src="/emadmin/images/c2/button/choose.gif" border=0  onMouseOver=this.style.cursor="hand" onClick="_doSelect_subarea_xs_lsd_xs_lsd_sub_add_chbm(' + maxcount_i + ');"/>';
                row_html[1]='<input  name="_subarea_xs_lsd_xs_lsd_sub_add_chmc_' + maxcount_i + '"  type="text" regName ="品名" size="10" value="" readonly="1"  class="x_bill_item_input_readonly_sub" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020")>';
                row_html[2]='<input  name="_subarea_xs_lsd_xs_lsd_sub_add_ggxh_' + maxcount_i + '"  type="text" regName ="规格" size="10" value="" readonly="1"  class="x_bill_item_input_readonly_sub" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020")>';
                row_html[3]='<input  name="_subarea_xs_lsd_xs_lsd_sub_add_sl_' + maxcount_i + '"  type="text" regName ="数量"  reg = "_r__real_" size="10" value="0.000" onChange="_count_subarea_xs_lsd_xs_lsd_sub_add_jshj('+ maxcount_i +');_count_subarea_xs_lsd_xs_lsd_sub_add_je('+ maxcount_i +');_count_subarea_xs_lsd_xs_lsd_sub_add_se('+ maxcount_i +');" class="x_bill_item_input_sub" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020")>';
                row_html[4]='<input  name="_subarea_xs_lsd_xs_lsd_sub_add_hsdj_' + maxcount_i + '"  type="text" regName ="单价"  reg = "_r__real_" size="10" value="0.00" onChange="_count_subarea_xs_lsd_xs_lsd_sub_add_jshj('+ maxcount_i +');_count_subarea_xs_lsd_xs_lsd_sub_add_je('+ maxcount_i +');_count_subarea_xs_lsd_xs_lsd_sub_add_se('+ maxcount_i +');_count_subarea_xs_lsd_xs_lsd_sub_add_dj('+ maxcount_i +');" class="x_bill_item_input_sub" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020")>';
                row_html[5]='<input  name="_subarea_xs_lsd_xs_lsd_sub_add_zkl_' + maxcount_i + '"  type="text" regName ="折扣"  reg = "_real_" size="10" value="1.00" onChange="_count_subarea_xs_lsd_xs_lsd_sub_add_jshj('+ maxcount_i +');_count_subarea_xs_lsd_xs_lsd_sub_add_je('+ maxcount_i +');_count_subarea_xs_lsd_xs_lsd_sub_add_se('+ maxcount_i +');" class="x_bill_item_input_sub" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020")>';
                row_html[6]='<input  name="_subarea_xs_lsd_xs_lsd_sub_add_jshj_' + maxcount_i + '"  type="text" regName ="金额"  reg = "_real_" size="10" value="0.00" onChange="_count_subarea_xs_lsd_xs_lsd_sub_add_je('+ maxcount_i +');_count_subarea_xs_lsd_xs_lsd_sub_add_se('+ maxcount_i +');_count_subarea_xs_lsd_xs_lsd_sub_add_subUpdateMainItem_yingshouje();" class="x_bill_item_input_sub" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020")>';
                row_html[7]='<input name="_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx_' + maxcount_i + '"  type=text regName ="相关属性" size="10" value=""  readonly="1"   class="x_bill_item_input_sub" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"120");  onClick="_doSelect_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx(' + maxcount_i + ')"  > <img src="/emadmin/images/c2/button/choose.gif" border=0  onMouseOver=this.style.cursor="hand" onClick="_doSelect_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx(' + maxcount_i + ');"/>';
                row_html[7] += '<input name="_subarea_xs_lsd_xs_lsd_sub_add_id_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_fid_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_bzdw_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_hsl_' + maxcount_i + '" value= "1.00" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_bzsl_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_dw_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_suilv_' + maxcount_i + '" value= "0.17" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_dj_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_je_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_se_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_bz_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_ch_id_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_cbje_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_hpmlr_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_cbdj_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_ykdsl_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_wkdsl_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_ykpje_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_wkpje_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_pc_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_scrq_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sxrq_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_yxq_' + maxcount_i + '" value= "" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sfbzqgl_' + maxcount_i + '" value= "0" type=hidden><input name="_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sfpcgl_' + maxcount_i + '" value= "0" type=hidden>';
                maxCount = document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_maxcount')[0];
                currentTable = document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add')[0];
                newRowHtml = row_html;
                sumRowHtml = _subarea_xs_lsd_xs_lsd_sub_add_get_sum_row();
                _addRow();
 return maxcount_i;}
function _subarea_xs_lsd_xs_lsd_sub_add_delete_row() {
                maxCount = document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_maxcount')[0];
                currentTable = document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add')[0];
                _deleteRow();}

function _subarea_xs_lsd_xs_lsd_sub_add_get_sum_row() {
                var row_html=new Array(8);

                row_html[0]='&nbsp;';

                row_html[1]='&nbsp;';

                row_html[2]='&nbsp;';

				row_html[3]='<INPUT class="c_input_sum_sub" type="text" name="_sum_subarea_xs_lsd_xs_lsd_sub_add_sl" size="10" readonly="true">';

                row_html[4]='&nbsp;';

                row_html[5]='&nbsp;';

                row_html[6]='<INPUT class="c_input_sum_sub" type="text" name="_sum_subarea_xs_lsd_xs_lsd_sub_add_jshj" size="10" readonly="true">';

                row_html[7]='&nbsp;';
 
                return row_html;
}
function _count_subarea_xs_lsd_xs_lsd_sub_add_bzsl(my_maxcount_i) {  
                document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_bzsl_' + my_maxcount_i )[0].value=Math.round((parseFloat(document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_sl_' + my_maxcount_i)[0].value)/parseFloat(document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_hsl_' + my_maxcount_i)[0].value) )*1000)/1000
  if ( isNaN(   document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_bzsl_' + my_maxcount_i )[0].value))document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_bzsl_' + my_maxcount_i )[0].value =""  
                currentTable = document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add')[0]; 
                 _recountSumRow() 
                 _count_subarea_xs_lsd_xs_lsd_sub_add_subToMain_All()
}
function  _count_subarea_xs_lsd_xs_lsd_sub_add_subUpdateMainItem_yingshouje() 
 { 
 var  max_sub_line = document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_maxcount')[0].value;  
  var  sum_sub_to_main = 0;  
  if (max_sub_line==null) 
 		return; 
  for (i=0;i< max_sub_line ;i++) 
 { 
 	if ( document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_jshj_' + i).length>0 ) 
 	{ 
 		if ( document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_jshj_' + i)[0].value!=null) 
 		{ 
 			sum_sub_to_main +=  parseFloat (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_jshj_' + i)[0].value); 
 		} 
 	} 
 } 
  document.getElementsByName('yingshouje')[0].value = Math.round((sum_sub_to_main)*100)/100
  document.getElementsByName('yingshouje')[0].fireEvent('onchange');} 
 
function _count_subarea_xs_lsd_xs_lsd_sub_add_jshj(my_maxcount_i) {  
                document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_jshj_' + my_maxcount_i )[0].value=Math.round((parseFloat(document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_hsdj_' + my_maxcount_i)[0].value)*parseFloat(document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_sl_' + my_maxcount_i)[0].value)*parseFloat(document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_zkl_' + my_maxcount_i)[0].value) )*100)/100
  if ( isNaN(   document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_jshj_' + my_maxcount_i )[0].value))document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_jshj_' + my_maxcount_i )[0].value =""  
                currentTable = document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add')[0]; 
                 _recountSumRow() 
                 _count_subarea_xs_lsd_xs_lsd_sub_add_subToMain_All()
}
function _count_subarea_xs_lsd_xs_lsd_sub_add_dj(my_maxcount_i) {  
                document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_dj_' + my_maxcount_i )[0].value=Math.round((parseFloat(document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_hsdj_' + my_maxcount_i)[0].value)/(1+parseFloat(document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_suilv_' + my_maxcount_i)[0].value)) )*100)/100
  if ( isNaN(   document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_dj_' + my_maxcount_i )[0].value))document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_dj_' + my_maxcount_i )[0].value =""  
                currentTable = document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add')[0]; 
                 _recountSumRow() 
                 _count_subarea_xs_lsd_xs_lsd_sub_add_subToMain_All()
}
function _count_subarea_xs_lsd_xs_lsd_sub_add_je(my_maxcount_i) {  
                document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_je_' + my_maxcount_i )[0].value=Math.round((parseFloat(document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_jshj_' + my_maxcount_i)[0].value)/(1+parseFloat(document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_suilv_' + my_maxcount_i)[0].value)) )*100)/100
  if ( isNaN(   document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_je_' + my_maxcount_i )[0].value))document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_je_' + my_maxcount_i )[0].value =""  
                currentTable = document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add')[0]; 
                 _recountSumRow() 
                 _count_subarea_xs_lsd_xs_lsd_sub_add_subToMain_All()
}
function _count_subarea_xs_lsd_xs_lsd_sub_add_se(my_maxcount_i) {  
                document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_se_' + my_maxcount_i )[0].value=Math.round((parseFloat(document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_jshj_' + my_maxcount_i)[0].value)-parseFloat(document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_je_' + my_maxcount_i)[0].value) )*100)/100
  if ( isNaN(   document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_se_' + my_maxcount_i )[0].value))document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_se_' + my_maxcount_i )[0].value =""  
                currentTable = document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add')[0]; 
                 _recountSumRow() 
                 _count_subarea_xs_lsd_xs_lsd_sub_add_subToMain_All()
}
 function _count_subarea_xs_lsd_xs_lsd_sub_add_subToMain_All() {
  _count_subarea_xs_lsd_xs_lsd_sub_add_subUpdateMainItem_yingshouje(); }
 
function _doSelect_subarea_xs_lsd_xs_lsd_sub_add_chbm(my_maxcount_i) {  
                 var  mySubDialog = new Object; 
                 var  idValue = ''; 
                 var  ck_id; 
            ck_id = document.getElementsByName('ck')[0].value; if ( ck_id.length<1)
 {
alert("请先录入 仓库  信息");
document.getElementsByName('ck')[0].focus();return;  
 }
 
                 result=window.open('/emadmin/shared/popwindow.jsp?bringinitems=0.000,cklsj,chbm,ch_id,chmc,ggxh,bzdw,jldw,hsl,sl,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl,id&popid=win_ck_chda&keywords=' + idValue+'&ck_id='+ck_id, mySubDialog,"resizable:Yes;status:no;dialogHeight:600px;dialogWidth:800px;scroll:no"); 
                 if (result!=true) { 
                           return; 
                 } else { 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx_'+ my_maxcount_i )[0].value=""; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_sl_'+ my_maxcount_i )[0].value=mySubDialog[0][1]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_sl_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][1]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_sl_'+ my_maxcount_i )[0].size=(mySubDialog[0][1]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_sl_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_hsdj_'+ my_maxcount_i )[0].value=mySubDialog[0][2]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_hsdj_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][2]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_hsdj_'+ my_maxcount_i )[0].size=(mySubDialog[0][2]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_hsdj_'+ my_maxcount_i )[0].fireEvent('onchange') ; 

                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chbm_'+ my_maxcount_i )[0].value=mySubDialog[0][3]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chbm_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][3]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chbm_'+ my_maxcount_i )[0].size=(mySubDialog[0][3]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chbm_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_ch_id_'+ my_maxcount_i )[0].value=mySubDialog[0][4]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_ch_id_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][4]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_ch_id_'+ my_maxcount_i )[0].size=(mySubDialog[0][4]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_ch_id_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chmc_'+ my_maxcount_i )[0].value=mySubDialog[0][5]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chmc_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][5]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chmc_'+ my_maxcount_i )[0].size=(mySubDialog[0][5]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chmc_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_ggxh_'+ my_maxcount_i )[0].value=mySubDialog[0][6]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_ggxh_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][6]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_ggxh_'+ my_maxcount_i )[0].size=(mySubDialog[0][6]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_ggxh_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_bzdw_'+ my_maxcount_i )[0].value=mySubDialog[0][7]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_bzdw_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][7]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_bzdw_'+ my_maxcount_i )[0].size=(mySubDialog[0][7]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_bzdw_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_dw_'+ my_maxcount_i )[0].value=mySubDialog[0][8]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_dw_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][8]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_dw_'+ my_maxcount_i )[0].size=(mySubDialog[0][8]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_dw_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_hsl_'+ my_maxcount_i )[0].value=mySubDialog[0][9]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_hsl_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][9]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_hsl_'+ my_maxcount_i )[0].size=(mySubDialog[0][9]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_hsl_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_suilv_'+ my_maxcount_i )[0].value=mySubDialog[0][10]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_suilv_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][10]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_suilv_'+ my_maxcount_i )[0].size=(mySubDialog[0][10]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_suilv_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_pc_'+ my_maxcount_i )[0].value=mySubDialog[0][11]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_pc_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][11]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_pc_'+ my_maxcount_i )[0].size=(mySubDialog[0][11]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_pc_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_scrq_'+ my_maxcount_i )[0].value=mySubDialog[0][12]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_scrq_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][12]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_scrq_'+ my_maxcount_i )[0].size=(mySubDialog[0][12]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_scrq_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sxrq_'+ my_maxcount_i )[0].value=mySubDialog[0][13]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sxrq_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][13]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sxrq_'+ my_maxcount_i )[0].size=(mySubDialog[0][13]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sxrq_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_yxq_'+ my_maxcount_i )[0].value=mySubDialog[0][14]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_yxq_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][14]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_yxq_'+ my_maxcount_i )[0].size=(mySubDialog[0][14]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_yxq_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx_'+ my_maxcount_i )[0].value=mySubDialog[0][15]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][15]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx_'+ my_maxcount_i )[0].size=(mySubDialog[0][15]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sfbzqgl_'+ my_maxcount_i )[0].value=mySubDialog[0][16]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sfbzqgl_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][16]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sfbzqgl_'+ my_maxcount_i )[0].size=(mySubDialog[0][16]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sfbzqgl_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sfpcgl_'+ my_maxcount_i )[0].value=mySubDialog[0][17]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sfpcgl_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][17]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sfpcgl_'+ my_maxcount_i )[0].size=(mySubDialog[0][17]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sfpcgl_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_sl_'+ my_maxcount_i)[0].focus();  
 _recountSumRow()  
                 _count_subarea_xs_lsd_xs_lsd_sub_add_subToMain_All() 
                 }  
} 


function _doSelect_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx(my_maxcount_i) {  
                 var  mySubDialog = new Object; 
                 var  idValue = ''; 
                 var  chbm; 
            chbm = document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chbm_' + my_maxcount_i)[0].value; if ( chbm.length<1)
 {
alert("请先录入子表本行的 条码  信息");
document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chbm_' + my_maxcount_i)[0].focus();return;  
 }
 
                 var  ck_id; 
            ck_id = document.getElementsByName('ck')[0].value; if ( ck_id.length<1)
 {
alert("请先录入 仓库  信息");
document.getElementsByName('ck')[0].focus();return;  
 }
 
                 result=window.open('/emadmin/shared/popwindow.jsp?bringinitems=xt_cpfz_xgsx,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,id&popid=win_ck_chda_fzhs&keywords=' + idValue+'&chbm='+chbm+'&ck_id='+ck_id, mySubDialog,"resizable:Yes;status:no;dialogHeight:600px;dialogWidth:800px;scroll:no"); 
                 if (result!=true) { 
                           return; 
                 } else { 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx_'+ my_maxcount_i )[0].value=""; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx_'+ my_maxcount_i )[0].value=mySubDialog[0][1]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][1]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx_'+ my_maxcount_i )[0].size=(mySubDialog[0][1]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_pc_'+ my_maxcount_i )[0].value=mySubDialog[0][2]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_pc_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][2]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_pc_'+ my_maxcount_i )[0].size=(mySubDialog[0][2]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_pc_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_scrq_'+ my_maxcount_i )[0].value=mySubDialog[0][3]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_scrq_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][3]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_scrq_'+ my_maxcount_i )[0].size=(mySubDialog[0][3]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_scrq_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sxrq_'+ my_maxcount_i )[0].value=mySubDialog[0][4]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sxrq_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][4]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sxrq_'+ my_maxcount_i )[0].size=(mySubDialog[0][4]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sxrq_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_yxq_'+ my_maxcount_i )[0].value=mySubDialog[0][5]; 
 if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_yxq_'+ my_maxcount_i )[0].type=='text' && (mySubDialog[0][5]).length>0) document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_yxq_'+ my_maxcount_i )[0].size=(mySubDialog[0][5]).replace(/[^x00-xFF]/g,'**').length; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_yxq_'+ my_maxcount_i )[0].fireEvent('onchange') ; 
  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx_'+ my_maxcount_i)[0].focus();  
 _recountSumRow()  
                 _count_subarea_xs_lsd_xs_lsd_sub_add_subToMain_All() 
                 }  
} 


    //-->
</SCRIPT>
 </div>
<SCRIPT LANGUAGE='JavaScript'>
    <!--

       			function _doTxmInput()                                                                                                                                  
       			{                                                                                                                                                       
       				if( _verifyTMInput( form1.all("_sys_txm").value ) )                                                                                               
       				{                                                                                                                                                   
       					_getProductInfo(form1.all("_sys_txm").value,form1.all("ck").value);                                                                                                 
       				}                                                                                                                                                   
       			}                                                                                                                                                       
                                                                                                                                                                           
       			function _verifyTMInput(str){                                                                                                                           
       				//alert(event.keyCode);                                                                                                                             
       				if(event.keyCode==13 )                                                                                                                              
       				{                                                                                                                                                   
       					if(form1.all("ck").value==null || form1.all("ck").value=="")                                                                              
       					{                                                                                                                                               
       						alert("请先选择仓库！");                                                                                                                  
       						form1.all("ck").focus();                                                                                                                  
       						return false;                                                                                                                               
       					}                                                                                                                                               
       					return true;                                                                                                                                    
       				}                                                                                                                                                   
       				return false;                                                                                                                                       
       			}                                                                                                                                                       
       			function _getProductInfo(str,ck){                                                                                                                       
       				var ajaxRequest;  //定义ajax对象                                                                                                                    
       				var resultText;  //返回的结果                                                                                                                       
                                                                                                                                                                           
       				try{                                                                                                                                                
       					// Opera 8.0+, Firefox, Safari                                                                                                                  
       					ajaxRequest = new XMLHttpRequest();                                                                                                             
       				 } catch (e){                                                                                                                                       
       					// Internet Explorer Browsers                                                                                                                   
       						try{                                                                                                                                        
       							ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");                                                                                    
       						} catch (e) {                                                                                                                               
       						try{                                                                                                                                        
       							ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");                                                                                 
       						} catch (e){                                                                                                                                
       							// alert("你的浏览器有问题，不支持自动提醒!");                                                                                        
       							return false;                                                                                                                           
       						}                                                                                                                                           
       					}                                                                                                                                               
       				}                                                                                                                                                   
                                                                                                                                                                           
       				// Create a function that will receive data sent from the server                                                                                    
       				ajaxRequest.onreadystatechange = function(){                                                                                                        
       					if(ajaxRequest.readyState == 4){                                                                                                                
       						if(ajaxRequest.status==200){                                                                                                                
       							var _result = ajaxRequest.responseText;                                                                                                 
       							//alert("|"+_result+"|");                                                                                                             
       							if (_result.indexOf("TXM NotFound!")>=0){                                                                                             
       								alert("数据库中没有找到条码: ["+str+"] 对应的记录！");                                                                          
       							} else if (_result!="") {                                                                                                             
       								_putResultValues(_result);                                                                                                          
       							}                                                                                                                                       
                                                                                                                                                                           
       							form1.all("_sys_txm").value = "";                                                                                                   
       							if (form1.all("_sys_txm").type=='text') form1.all("_sys_txm").focus();                                                                                                        
       						}                                                                                                                                           
       					}                                                                                                                                               
       				}                                                                                                                                                   
                                                                                                                                                                           
       				ajaxRequest.open("GET", "/emadmin/jsp/common/get_product_info.jsp?ck="+ck+"&txm="+str+"&modul_id=xs_lsd_addModul", true);                      
       				ajaxRequest.send(null);                                                                                                                             
       			}                                                                                                                                                       
                                                                                                                                                                           
       			function _putResultValues(_result){                                                                                                                     
                                                                                                                                                                           
    var maxcount_i =parseInt(document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_maxcount')[0].value);  
    						var _isFound=0;  
    						for (i=0;i<=maxcount_i ; i++){  
    							if  (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chbm_'+ i )[0]!=null) {  
    								if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chbm_'+ i )[0].value==_result.split("$^#")[3])	{  
    									if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_sl_'+ i )[0]!=null)	{		  
    										_isFound=1;  
    										document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_sl_'+ i )[0].value=parseInt(document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_sl_'+ i )[0].value)+1;  
    										document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_sl_'+ i )[0].fireEvent('onchange') ;  
    									}  
    								}   
    							}  
    						}  
                            if (_isFound==0)     {  

       				           var	_my_maxcount=_subarea_xs_lsd_xs_lsd_sub_add_add_new_row();                                                                                       
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_sl_'+ _my_maxcount )[0].value=_result.split("$^#")[1]; 
  if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_sl_'+ _my_maxcount )[0].type=='text' && (_result.split("$^#")[1]).length>0)  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_sl_'+ _my_maxcount )[0].size=(_result.split("$^#")[1]).replace(/[^x00-xFF]/g,'**').length; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_hsdj_'+ _my_maxcount )[0].value=_result.split("$^#")[2]; 
  if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_hsdj_'+ _my_maxcount )[0].type=='text' && (_result.split("$^#")[2]).length>0)  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_hsdj_'+ _my_maxcount )[0].size=(_result.split("$^#")[2]).replace(/[^x00-xFF]/g,'**').length; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chbm_'+ _my_maxcount )[0].value=_result.split("$^#")[3]; 
  if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chbm_'+ _my_maxcount )[0].type=='text' && (_result.split("$^#")[3]).length>0)  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chbm_'+ _my_maxcount )[0].size=(_result.split("$^#")[3]).replace(/[^x00-xFF]/g,'**').length; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_ch_id_'+ _my_maxcount )[0].value=_result.split("$^#")[4]; 
  if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_ch_id_'+ _my_maxcount )[0].type=='text' && (_result.split("$^#")[4]).length>0)  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_ch_id_'+ _my_maxcount )[0].size=(_result.split("$^#")[4]).replace(/[^x00-xFF]/g,'**').length; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chmc_'+ _my_maxcount )[0].value=_result.split("$^#")[5]; 
  if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chmc_'+ _my_maxcount )[0].type=='text' && (_result.split("$^#")[5]).length>0)  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_chmc_'+ _my_maxcount )[0].size=(_result.split("$^#")[5]).replace(/[^x00-xFF]/g,'**').length; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_ggxh_'+ _my_maxcount )[0].value=_result.split("$^#")[6]; 
  if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_ggxh_'+ _my_maxcount )[0].type=='text' && (_result.split("$^#")[6]).length>0)  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_ggxh_'+ _my_maxcount )[0].size=(_result.split("$^#")[6]).replace(/[^x00-xFF]/g,'**').length; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_bzdw_'+ _my_maxcount )[0].value=_result.split("$^#")[7]; 
  if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_bzdw_'+ _my_maxcount )[0].type=='text' && (_result.split("$^#")[7]).length>0)  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_bzdw_'+ _my_maxcount )[0].size=(_result.split("$^#")[7]).replace(/[^x00-xFF]/g,'**').length; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_dw_'+ _my_maxcount )[0].value=_result.split("$^#")[8]; 
  if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_dw_'+ _my_maxcount )[0].type=='text' && (_result.split("$^#")[8]).length>0)  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_dw_'+ _my_maxcount )[0].size=(_result.split("$^#")[8]).replace(/[^x00-xFF]/g,'**').length; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_hsl_'+ _my_maxcount )[0].value=_result.split("$^#")[9]; 
  if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_hsl_'+ _my_maxcount )[0].type=='text' && (_result.split("$^#")[9]).length>0)  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_hsl_'+ _my_maxcount )[0].size=(_result.split("$^#")[9]).replace(/[^x00-xFF]/g,'**').length; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_suilv_'+ _my_maxcount )[0].value=_result.split("$^#")[10]; 
  if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_suilv_'+ _my_maxcount )[0].type=='text' && (_result.split("$^#")[10]).length>0)  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_suilv_'+ _my_maxcount )[0].size=(_result.split("$^#")[10]).replace(/[^x00-xFF]/g,'**').length; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_pc_'+ _my_maxcount )[0].value=_result.split("$^#")[11]; 
  if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_pc_'+ _my_maxcount )[0].type=='text' && (_result.split("$^#")[11]).length>0)  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_pc_'+ _my_maxcount )[0].size=(_result.split("$^#")[11]).replace(/[^x00-xFF]/g,'**').length; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_scrq_'+ _my_maxcount )[0].value=_result.split("$^#")[12]; 
  if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_scrq_'+ _my_maxcount )[0].type=='text' && (_result.split("$^#")[12]).length>0)  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_scrq_'+ _my_maxcount )[0].size=(_result.split("$^#")[12]).replace(/[^x00-xFF]/g,'**').length; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sxrq_'+ _my_maxcount )[0].value=_result.split("$^#")[13]; 
  if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sxrq_'+ _my_maxcount )[0].type=='text' && (_result.split("$^#")[13]).length>0)  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sxrq_'+ _my_maxcount )[0].size=(_result.split("$^#")[13]).replace(/[^x00-xFF]/g,'**').length; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_yxq_'+ _my_maxcount )[0].value=_result.split("$^#")[14]; 
  if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_yxq_'+ _my_maxcount )[0].type=='text' && (_result.split("$^#")[14]).length>0)  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_yxq_'+ _my_maxcount )[0].size=(_result.split("$^#")[14]).replace(/[^x00-xFF]/g,'**').length; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx_'+ _my_maxcount )[0].value=_result.split("$^#")[15]; 
  if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx_'+ _my_maxcount )[0].type=='text' && (_result.split("$^#")[15]).length>0)  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_xgsx_'+ _my_maxcount )[0].size=(_result.split("$^#")[15]).replace(/[^x00-xFF]/g,'**').length; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sfbzqgl_'+ _my_maxcount )[0].value=_result.split("$^#")[16]; 
  if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sfbzqgl_'+ _my_maxcount )[0].type=='text' && (_result.split("$^#")[16]).length>0)  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sfbzqgl_'+ _my_maxcount )[0].size=(_result.split("$^#")[16]).replace(/[^x00-xFF]/g,'**').length; 
                           document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sfpcgl_'+ _my_maxcount )[0].value=_result.split("$^#")[17]; 
  if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sfpcgl_'+ _my_maxcount )[0].type=='text' && (_result.split("$^#")[17]).length>0)  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_xt_cpfz_sfpcgl_'+ _my_maxcount )[0].size=(_result.split("$^#")[17]).replace(/[^x00-xFF]/g,'**').length;
    									if (document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_sl_'+ _my_maxcount )[0]!=null)	{		   
                                  document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_sl_'+ _my_maxcount )[0].value=1;
    										      document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add_sl_'+ _my_maxcount )[0].fireEvent('onchange') ;  
    						                 }  
   }  
 _recountSumRow(); 
   _count_subarea_xs_lsd_xs_lsd_sub_add_subToMain_All(); 
  
                            }           function doAddBill() { 
 	var  mySubDialog=new Array(1) ; 
 	result=window.open('/emadmin/shared/popwindow_addbill.jsp?add_bill_modul_id=jc_chda_addModul&linkaddr=/emadmin/jsp/common/add.jsp&back_item_value=chbm', mySubDialog,"resizable:Yes;status:no;dialogHeight:500;dialogWidth:700;"); 
 	if (result!=true) { 
 		return; 
 	} else { 
 		alert('保存成功！'); 
 	   _getProductInfo(mySubDialog[0],form1.all("ck").value);
 	}  
 }

    //-->
</SCRIPT>
	<!--子表货品结束-->
	
	</td>
  </tr>
  <tr>
    <td width="20%">&nbsp;&nbsp;会员:<input  name="huiyuan"  type="text" regName ="会员" value="" readonly="1"  class="x_bill_item_input_readonly" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020") style="width:80px;text-align:center;"></td>
    <td width="20%">&nbsp;&nbsp;积分:<input  name="jifen"  type="text" regName ="积分"  reg = "_real_" value="0.00" readonly="1"  class="x_bill_item_input_readonly" onF ocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020") style="width:80px;text-align:center;"></td>
    <td >&nbsp;&nbsp;<font size="12px;"><strong>金额合计:</strong></font><input id="yingshouje"  name="yingshouje"  type="text" regName ="金额合计"  reg = "_real_" value="0.00" onChange="_count_mainarea_zhaoling();_count_mainarea_jifen();" readonly="1"  class="x_bill_item_input_readonly" style="width:200px;font-weight:bold;color:red;font-size:50px;text-align:center;height:50px;line-height:50px;" > <font size="30px;"><strong>元</strong></font></td>
  </tr>
</table>
<table width="98%" border ="1" cellpadding="0" cellspacing="0" borderColor=#dee7f6 align="center">
  <tr>
    <td><strong>&nbsp;&nbsp;现金 :</strong><input  name="xianjin"  type="text" regName ="现金"  reg = "_real_" value="0.00" onChange="_count_mainarea_ssje();_count_mainarea_zhaoling();" class="x_bill_item_input" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020") style="width:120px;text-align:center;"> </td>
    <td><strong>&nbsp;<span <%=getStyle(zffs[0])%>>&nbsp;<%=zffs[1]%> :</span></strong><input  name="neika"  type="<%=getType(zffs[0])%>" regName ="内卡"  reg = "_real_" value="0.00" onChange="_count_mainarea_ssje();_count_mainarea_zhaoling();" class="x_bill_item_input" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020") style="width:120px;text-align:center;"></td>
    <td><strong>&nbsp;<span <%=getStyle(zffs[2])%>>&nbsp;<%=zffs[3]%> :</span></strong><input  name="waika"  type="<%=getType(zffs[2])%>" regName ="外卡"  reg = "_real_" value="0.00" onChange="_count_mainarea_ssje();_count_mainarea_zhaoling();" class="x_bill_item_input" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020") style="width:120px;text-align:center;"></td>
	<td><strong>&nbsp;<span <%=getStyle(zffs[4])%>>&nbsp;<%=zffs[5]%> :</span></strong><input  name="zhipiao"  type="<%=getType(zffs[4])%>" regName ="支票"  reg = "_real_" value="0.00" onChange="_count_mainarea_ssje();_count_mainarea_zhaoling();" class="x_bill_item_input" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020") style="width:120px;text-align:center;"> </td>
	<td><strong>&nbsp;<span <%=getStyle(zffs[6])%>>&nbsp;<%=zffs[7]%> :</span></strong><input  name="daijinquan"  type="<%=getType(zffs[6])%>" regName ="代金券"  reg = "_real_" value="0.00" onChange="_count_mainarea_ssje();_count_mainarea_zhaoling();" class="x_bill_item_input" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020") style="width:120px;text-align:center;"> </td>
  </tr>
  <tr>
    <td><strong>&nbsp;<span <%=getStyle(zffs[8])%>>&nbsp;<%=zffs[9]%> :</span></strong><input  name="qt1"  type="<%=getType(zffs[8])%>" regName ="其他1"  reg = "_real_" value="0.00" onChange="_count_mainarea_ssje();_count_mainarea_zhaoling();" class="x_bill_item_input" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020") style="width:120px;text-align:center;"></td>
	<td><strong>&nbsp;<span <%=getStyle(zffs[10])%>>&nbsp;<%=zffs[11]%> :</span></strong><input  name="qt2"  type="<%=getType(zffs[10])%>" regName ="其他2"  reg = "_real_" value="0.00" onChange="_count_mainarea_ssje();_count_mainarea_zhaoling();" class="x_bill_item_input" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020") style="width:120px;text-align:center;"></td>
    <td><strong>&nbsp;<span <%=getStyle(zffs[12])%>>&nbsp;<%=zffs[13]%> :</span></strong><input  name="qt3"  type="<%=getType(zffs[12])%>" regName ="其他3"  reg = "_real_" value="0.00" onChange="_count_mainarea_ssje();_count_mainarea_zhaoling();" class="x_bill_item_input" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020") style="width:120px;text-align:center;"></td>
    <td><strong>&nbsp;<span <%=getStyle(zffs[14])%>>&nbsp;<%=zffs[15]%> :</span></strong><input  name="qt4"  type="<%=getType(zffs[14])%>" regName ="其他4"  reg = "_real_" value="0.00" onChange="_count_mainarea_ssje();_count_mainarea_zhaoling();" class="x_bill_item_input" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020") style="width:120px;text-align:center;"></td>
	 <td><strong>&nbsp;<span <%=getStyle(zffs[16])%>>&nbsp;<%=zffs[17]%> :</span></strong><input  name="qt5"  type="<%=getType(zffs[16])%>" regName ="其他5"  reg = "_real_" value="0.00" onChange="_count_mainarea_ssje();_count_mainarea_zhaoling();" class="x_bill_item_input" onFocus="_bill_item_focus_bg(this)"  onBlur="_bill_item_nofocus_bg(this)"  onkeyDown=_bill_item_keypress(this,"020") style="width:120px;text-align:center;"></td>
  </tr>
<tr><td colspan="6">&nbsp;</td></tr>

   <tr>
    <td colspan="6"><font size="12px;"><strong>实收合计:</strong></font><input  name="ssje"  type="text" regName ="实收合计"  reg = "_real_" value="0.00" onChange="_count_mainarea_yingshouje();_count_mainarea_zhaoling();" readonly="1"  class="x_bill_item_input_readonly"  style="width:200px;font-weight:bold;color:red;font-size:50px;text-align:center;height:50px;line-height:50px;" ></td>
  </tr>
   <tr>
    <td colspan="6"><font size="12px;"><strong>找&nbsp;&nbsp;&nbsp;&nbsp;零:</strong></font><input  id="zhaoling" name="zhaoling"  type="text" regName ="找零"  reg = "_real_" value="0.00" onChange="_count_mainarea_ssje();_count_mainarea_yingshouje();" readonly="1"  class="x_bill_item_input_readonly" style="width:200px;font-weight:bold;color:blue;font-size:50px;text-align:center;height:50px;line-height:50px;" </td>
   </tr>
</table>
<input name="_subArea_num" value="1" type=hidden>
<input name="_subArea_area_id0" value="xs_lsd_xs_lsd_sub_add" type=hidden>
<input name=_control_bill_id_ value=xs_lsd_addBill type=hidden><input name="lfbaseprimarykey" value="null" type=hidden>
<input name="_control_modul_id" value="xs_lsd_addModul" type=hidden>
<input name="id" value= "" type=hidden><input name="lsdh" value= "" type=hidden><input name="kh" value= "" type=hidden><input name="khbh" value= "" type=hidden><input name="hyjb" value= "" type=hidden><input name="jfbl" value= "0.00" type=hidden><input name="ysje" value= "" type=hidden><input name="wsje" value= "" type=hidden><input name="cbze" value= "" type=hidden><input name="mlrze" value= "" type=hidden><input name="lxdh" value= "" type=hidden><input name="kh_id" value= "" type=hidden><input name="shdz" value= "" type=hidden><input name="shouhuoren" value= "" type=hidden><input name="jhrq" value= "" type=hidden><input name="zffs" value= "" type=hidden><input name="skqx" value= "" type=hidden><input name="hth" value= "" type=hidden><input name="xslx" value= "001" type=hidden><input name="ywy_id" value= "<%=uid%>" type=hidden><input name="ywbm_id" value= "<%=ubm%>" type=hidden><input name="lrr" value= "<%=uid%>" type=hidden><input name="lrrq" value= "<%=udate%>" type=hidden><input name="lrbm" value= "<%=ubm%>" type=hidden><input name="shr" value= "" type=hidden><input name="shrq" value= "" type=hidden><input name="shzt" value= "0" type=hidden><input name="autokeyword" value= "" type=hidden><input name="cz_id" value= "" type=hidden><input name="czbh" value= "" type=hidden><input name="czbm" value= "" type=hidden><input name="czlx" value= "" type=hidden><input name="czhxzd" value= "" type=hidden><input name="xt_is_red_status" value= "0" type=hidden>
<SCRIPT LANGUAGE='JavaScript'>
    <!--

function _count_mainarea_jifen() {  
                document.getElementsByName('jifen')[0].value=Math.round((parseFloat(document.getElementsByName('yingshouje')[0].value)*parseFloat(document.getElementsByName('jfbl')[0].value) )*100)/100
 
}
function _count_mainarea_ssje() {  
                document.getElementsByName('ssje')[0].value=Math.round((parseFloat(document.getElementsByName('xianjin')[0].value)+parseFloat(document.getElementsByName('neika')[0].value)+parseFloat(document.getElementsByName('waika')[0].value)+parseFloat(document.getElementsByName('zhipiao')[0].value)+parseFloat(document.getElementsByName('daijinquan')[0].value)+parseFloat(document.getElementsByName('qt1')[0].value)+parseFloat(document.getElementsByName('qt2')[0].value)+parseFloat(document.getElementsByName('qt3')[0].value)+parseFloat(document.getElementsByName('qt4')[0].value)+parseFloat(document.getElementsByName('qt5')[0].value) )*100)/100
 
}
function _count_mainarea_zhaoling() {  
                document.getElementsByName('zhaoling')[0].value=Math.round((parseFloat(document.getElementsByName('ssje')[0].value)-parseFloat(document.getElementsByName('yingshouje')[0].value) )*100)/100
 
}
function _doSelect_mainarea_kh() {  
                 var  mySubDialog = new Array(1); 
                 var  idValue=''; 
                 result=window.open('/emadmin/shared/popwindow.jsp?bringinitems=id,khjc,khbh,gsdz,lxdh&popid=win_khda&modul_id=xs_lsd_addModul&keywords=' + idValue, mySubDialog,"resizable:Yes;status:no;dialogHeight:600px;dialogWidth:800px;scroll:no"); 
                 if (result!=true) { 
                           return; 
                 } else { 
                           document.getElementsByName('kh_id' )[0].value=mySubDialog[0][1]; 
                           document.getElementsByName('kh_id' )[0].fireEvent('onchange') ; 
                           document.getElementsByName('kh' )[0].value=mySubDialog[0][2]; 
                           document.getElementsByName('kh' )[0].fireEvent('onchange') ; 
                           document.getElementsByName('khbh' )[0].value=mySubDialog[0][3]; 
                           document.getElementsByName('khbh' )[0].fireEvent('onchange') ; 
                           document.getElementsByName('shdz' )[0].value=mySubDialog[0][4]; 
                           document.getElementsByName('shdz' )[0].fireEvent('onchange') ; 
                           document.getElementsByName('lxdh' )[0].value=mySubDialog[0][5]; 
                           document.getElementsByName('lxdh' )[0].fireEvent('onchange') ; 
                 }  
} 


function _doSelect_mainarea_kahao() {  
                 var  mySubDialog = new Array(1); 
                 var  idValue=''; 
                 result=window.open('/emadmin/shared/popwindow.jsp?bringinitems=hykh,hymc,hyjb,jfbl,id&popid=win_ls_hyda&modul_id=xs_lsd_addModul&keywords=' + idValue, mySubDialog,"resizable:Yes;status:no;dialogHeight:600px;dialogWidth:800px;scroll:no"); 
                 if (result!=true) { 
                           return; 
                 } else { 
                           document.getElementsByName('kahao' )[0].value=mySubDialog[0][1]; 
                           document.getElementsByName('kahao' )[0].fireEvent('onchange') ; 
                           document.getElementsByName('huiyuan' )[0].value=mySubDialog[0][2]; 
                           document.getElementsByName('huiyuan' )[0].fireEvent('onchange') ; 
                           document.getElementsByName('hyjb' )[0].value=mySubDialog[0][3]; 
                           document.getElementsByName('hyjb' )[0].fireEvent('onchange') ; 
                           document.getElementsByName('jfbl' )[0].value=mySubDialog[0][4]; 
                           document.getElementsByName('jfbl' )[0].fireEvent('onchange') ; 
                 }  
} 


function _doSelect_mainarea_ywy_mc() {  
                 var  mySubDialog = new Array(1); 
                 var  idValue=''; 
                 result=window.open('/emadmin/shared/popwindow.jsp?bringinitems=bm_mc,yh_mc,bm_id,yh_id,id&popid=win_yh_detail&modul_id=xs_lsd_addModul&keywords=' + idValue, mySubDialog,"resizable:Yes;status:no;dialogHeight:600px;dialogWidth:800px;scroll:no"); 
                 if (result!=true) { 
                           return; 
                 } else { 
                           document.getElementsByName('ywbm_mc' )[0].value=mySubDialog[0][1]; 
                           document.getElementsByName('ywbm_mc' )[0].fireEvent('onchange') ; 
                           document.getElementsByName('ywy_mc' )[0].value=mySubDialog[0][2]; 
                           document.getElementsByName('ywy_mc' )[0].fireEvent('onchange') ; 
                           document.getElementsByName('ywbm_id' )[0].value=mySubDialog[0][3]; 
                           document.getElementsByName('ywbm_id' )[0].fireEvent('onchange') ; 
                           document.getElementsByName('ywy_id' )[0].value=mySubDialog[0][4]; 
                           document.getElementsByName('ywy_id' )[0].fireEvent('onchange') ; 
                 }  
} 


    //-->
</SCRIPT> 
<SCRIPT LANGUAGE='JavaScript'><!-- 
 function reAttachSubAreaEvent() {

                currentTable = document.getElementsByName('_subarea_xs_lsd_xs_lsd_sub_add')[0];
                _reAttachEvent(currentTable);
    }//--></SCRIPT>
   <div align="center" id="_button_area" style="display:block; padding-top:10px;vertical-align:bottom; clear:both;">
								<img src="/emadmin/images/c2/button/bill_save.gif" onMouseOver="this.style.cursor='hand'"   onClick="_click_button(form1)"/> 
								&nbsp;&nbsp;&nbsp;&nbsp;
                                 <img src="/emadmin/images/c2/button/bill_cancel.gif" onMouseOver="this.style.cursor='hand'"   onclick="window.close();"/> 
                                </div>
								<div align="center" id="_button_area_message" style="display:none;clear:both;">正在处理，请稍等...</div>
  </form>
</body>
</html>
