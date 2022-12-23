<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/emadmin/css/c1/style_new.css">
<%@include file="/emadmin/js/functions.jsp"%>
<%@ include file="/emadmin/shared/checkPermission1.jsp"%>
<script language=javascript src="/emadmin/js/do_check.js"></script>
<script language=javascript src="/emadmin/js/pop_selections.js"></script>
<script language=javascript src="/emadmin/js/pop_upload.js"></script>
</head>
<% 
	String[] result_dm=null; 
	String[] result_dep=Server.getOptionList("000",request); 
	String[] result_user=Server.getOptionList("have_qx_yh",request);
	String[] result_qxz=Server.getOptionList("101",request);
	String alert_time1="";
	String alert_time2="";
	String is_dx_yj=Api.getXtPreferenceValueByName("is_dx_yj");
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
	function showQxz() {
		window.resizeTo("663","640");
		if(persion.style.display==""){
			persion.style.display="none";
			form1.display.value="none";
		}		
		if(department.style.display==""){
			department.style.display="none";
			form1.display.value="none";
		}
			qxz.style.display="";
			form1.display.value="";
	}
	function showDeparment() {
		window.resizeTo("663","640");
		if(persion.style.display==""){
			persion.style.display="none";
			form1.display.value="none";
		}		
		if(qxz.style.display==""){
			qxz.style.display="none";
			form1.display.value="none";
		}		
			department.style.display="";
			form1.display.value="";
	}
	function showPersion() {
		window.resizeTo("663","640");
		if(department.style.display==""){
			department.style.display="none";
			form1.display.value="none";
		}
		if(qxz.style.display==""){
			qxz.style.display="none";
			form1.display.value="none";
		}		
			persion.style.display="";
			form1.display.value="";
	}
	function showNone() {
			 window.resizeTo("663","548");
	         department.style.display="none";
	         qxz.style.display="none";
			 form1.display.value="none";
		     persion.style.display="none";
		     form1.display.value="none";
	}	
	function hidePreset() {
			preset.style.display="none";
	}
	function showPreset() {
			preset.style.display="";
	}
	
//-->
</SCRIPT>
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

<body>
	<!--页面顶部-->
	<table width="100%" border ="0" cellpadding="0" cellspacing="0">
		<tr>
			<td class="x_xt_alert_bar_left">
				&nbsp;<font class="x_tixing_font"><b>预设/发送消息</b></font>
			</td>
			<td class="x_xt_alert_bar_middle">
				&nbsp;
			</td>
			<td class="x_xt_alert_bar_right">
				&nbsp;
			</td>
		</tr>
	</table>

	<!--页面顶部图片-->
	<table width="100%" border ="0" cellpadding="0" cellspacing="0">
		<tr>
			<td class="x_xt_alert_top_left">
				&nbsp;
			</td>
			<td class="x_xt_alert_top_middle">
				&nbsp;
			</td>
			<td class="x_xt_alert_top_right">
				&nbsp;
			</td>
		</tr>
	</table>
	
	<!--页面中部主要内容-->
	<table width="100%" border ="0" cellpadding="0" cellspacing="0">
		<tr>
			<td class="x_xt_alert_left">
				&nbsp;
			</td>
			<td height="200px;">
				<!--页面的主要内容在此操作-->

				 <table width="100%"  border="0" cellpadding="0" cellspacing="0" height="100%">
				<tr>
					<td height="51" valign="top">
						<div align="center">
						  <form name="form1" method="post" action="xt_alert_add1.jsp">
							<table width="100%"  border="0" align=center>
							 <tr>
								<td width="8%" class="share" nowrap>
								  <div align="center" class=x_tixing_font>消息类型:&nbsp;</div></td>	
									<td  nowrap width="92%">
									<select name="alert_type_dm">
									  <% result_dm=Server.getOptionList("224",request); %>
									  <% for (int i=0;i<result_dm.length;i+=2) { %>
									  <% if (!result_dm[i].equals("001")) { %>
										<option value="<%=result_dm[i]%>"><%=result_dm[i+1]%></option>
									  <% } %>
									  <% } %>
									</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span class=x_tixing_font>需要回执：<input type="checkbox" name="receipt" value="1">&nbsp;&nbsp;</span>
								<input type="radio" name="send_type" value="001" checked>&nbsp;<span class=x_tixing_font>信息&nbsp;&nbsp;</span>
								 <%
     								if(is_dx_yj.equals("1")){
     							 %>
								<input type="radio" name="send_type" value="002">&nbsp;<span class=x_tixing_font>短信&nbsp;&nbsp;</span>
								<input type="radio" name="send_type" value="003">&nbsp;<span class=x_tixing_font>邮件&nbsp;&nbsp;</span>
								<%} %>
								</td>
							</tr>
						<tr>
            <td class="share" nowrap><div align="center" class=x_tixing_font>提醒时间:&nbsp;</div></td>
            <td nowrap><input type="radio" name="is_timer" checked value="0" onclick="hidePreset()">
              立刻 
              <input type="radio" name="is_timer" value="1" onclick="showPreset()">
              定时:
  		  <span id="preset" style="display:none" class=x_tixing_font>
              <input type="text" name="alert_date" reg="_date_" regName="定时"
               onclick="doSelectCalendar('alert_date');">&nbsp;日&nbsp;<select name="alert_time1">
                <option value="00" <%=getSelected("00",alert_time1)%>>00</option>
                <option value="01" <%=getSelected("01",alert_time1)%>>01</option>
                <option value="02" <%=getSelected("02",alert_time1)%>>02</option>
                <option value="03" <%=getSelected("03",alert_time1)%>>03</option>
                <option value="04" <%=getSelected("04",alert_time1)%>>04</option>
                <option value="05" <%=getSelected("05",alert_time1)%>>05</option>
                <option value="06" <%=getSelected("06",alert_time1)%>>06</option>
                <option value="07" <%=getSelected("07",alert_time1)%>>07</option>
                <option value="08" <%=getSelected("08",alert_time1)%>>08</option>
                <option value="09" <%=getSelected("09",alert_time1)%>>09</option>
                <option value="10" <%=getSelected("10",alert_time1)%>>10</option>
                <option value="11" <%=getSelected("11",alert_time1)%>>11</option>
                <option value="12" <%=getSelected("12",alert_time1)%>>12</option>
                <option value="13" <%=getSelected("13",alert_time1)%>>13</option>
                <option value="14" <%=getSelected("14",alert_time1)%>>14</option>
                <option value="15" <%=getSelected("15",alert_time1)%>>15</option>
                <option value="16" <%=getSelected("16",alert_time1)%>>16</option>
                <option value="17" <%=getSelected("17",alert_time1)%>>17</option>
                <option value="18" <%=getSelected("18",alert_time1)%>>18</option>
                <option value="19" <%=getSelected("19",alert_time1)%>>19</option>
                <option value="20" <%=getSelected("20",alert_time1)%>>20</option>
                <option value="21" <%=getSelected("21",alert_time1)%>>21</option>
                <option value="22" <%=getSelected("22",alert_time1)%>>22</option>
                <option value="23" <%=getSelected("23",alert_time1)%>>23</option>
              </select>&nbsp;时&nbsp;
			  <select name="alert_time2">
				  <option value="01" <%=getSelected("01",alert_time2)%>>01</option>
				  <option value="02" <%=getSelected("02",alert_time2)%>>02</option>
				  <option value="03" <%=getSelected("03",alert_time2)%>>03</option>
				  <option value="04" <%=getSelected("04",alert_time2)%>>04</option>
				  <option value="05" <%=getSelected("05",alert_time2)%>>05</option>
				  <option value="06" <%=getSelected("06",alert_time2)%>>06</option>
				  <option value="07" <%=getSelected("07",alert_time2)%>>07</option>
				  <option value="08" <%=getSelected("08",alert_time2)%>>08</option>
				  <option value="09" <%=getSelected("09",alert_time2)%>>09</option>
				  <option value="10" <%=getSelected("10",alert_time2)%>>10</option>
				  <option value="11" <%=getSelected("11",alert_time2)%>>11</option>
				  <option value="12" <%=getSelected("12",alert_time2)%>>12</option>
				  <option value="13" <%=getSelected("13",alert_time2)%>>13</option>
				  <option value="14" <%=getSelected("14",alert_time2)%>>14</option>
				  <option value="15" <%=getSelected("15",alert_time2)%>>15</option>
				  <option value="16" <%=getSelected("16",alert_time2)%>>16</option>
				  <option value="17" <%=getSelected("17",alert_time2)%>>17</option>
				  <option value="18" <%=getSelected("18",alert_time2)%>>18</option>
				  <option value="19" <%=getSelected("19",alert_time2)%>>19</option>
				  <option value="20" <%=getSelected("20",alert_time2)%>>20</option>
				  <option value="21" <%=getSelected("21",alert_time2)%>>21</option>
				  <option value="22" <%=getSelected("22",alert_time2)%>>22</option>
				  <option value="23" <%=getSelected("23",alert_time2)%>>23</option>
				  <option value="24" <%=getSelected("24",alert_time2)%>>24</option>
				  <option value="25" <%=getSelected("25",alert_time2)%>>25</option>
				  <option value="26" <%=getSelected("26",alert_time2)%>>26</option>
				  <option value="27" <%=getSelected("27",alert_time2)%>>27</option>
				  <option value="28" <%=getSelected("28",alert_time2)%>>28</option>
				  <option value="29" <%=getSelected("29",alert_time2)%>>29</option>
				  <option value="30" <%=getSelected("30",alert_time2)%>>30</option>
				  <option value="31" <%=getSelected("31",alert_time2)%>>31</option>
				  <option value="32" <%=getSelected("32",alert_time2)%>>32</option>
				  <option value="33" <%=getSelected("33",alert_time2)%>>33</option>
				  <option value="34" <%=getSelected("34",alert_time2)%>>34</option>
				  <option value="35" <%=getSelected("35",alert_time2)%>>35</option>
				  <option value="36" <%=getSelected("36",alert_time2)%>>36</option>
				  <option value="37" <%=getSelected("37",alert_time2)%>>37</option>
				  <option value="38" <%=getSelected("38",alert_time2)%>>38</option>
				  <option value="39" <%=getSelected("39",alert_time2)%>>39</option>
				  <option value="40" <%=getSelected("40",alert_time2)%>>40</option>
				  <option value="41" <%=getSelected("41",alert_time2)%>>41</option>
				  <option value="42" <%=getSelected("42",alert_time2)%>>42</option>
				  <option value="43" <%=getSelected("43",alert_time2)%>>43</option>
				  <option value="44" <%=getSelected("44",alert_time2)%>>44</option>
				  <option value="45" <%=getSelected("45",alert_time2)%>>45</option>
				  <option value="46" <%=getSelected("46",alert_time2)%>>46</option>
				  <option value="47" <%=getSelected("47",alert_time2)%>>47</option>
				  <option value="48" <%=getSelected("48",alert_time2)%>>48</option>
				  <option value="49" <%=getSelected("49",alert_time2)%>>49</option>
				  <option value="50" <%=getSelected("50",alert_time2)%>>50</option>
				  <option value="51" <%=getSelected("51",alert_time2)%>>51</option>
				  <option value="52" <%=getSelected("52",alert_time2)%>>52</option>
				  <option value="53" <%=getSelected("53",alert_time2)%>>53</option>
				  <option value="54" <%=getSelected("54",alert_time2)%>>54</option>
				  <option value="55" <%=getSelected("55",alert_time2)%>>55</option>
				  <option value="56" <%=getSelected("56",alert_time2)%>>56</option>
				  <option value="57" <%=getSelected("57",alert_time2)%>>57</option>
				  <option value="58" <%=getSelected("58",alert_time2)%>>58</option>
				  <option value="59" <%=getSelected("59",alert_time2)%>>59</option>
			</select>&nbsp;分&nbsp;
			</span>
          </td>
          </tr>
          <tr>
            <td height="61" class="share"><div align="center" class=x_tixing_font>消息内容:&nbsp;</div></td>
            <td  ><textarea  name="alert_content" cols="63" rows="12"></textarea></td>
          </tr>
           <tr>
            <td height="30" class="share"><div align="left" class=x_tixing_font>附件:&nbsp;</div></td>
            <td  ><input name="fj"  type="text"   value="" readonly><img src="/emadmin/images/shangchuan.jpg" onclick="do_upload('fj')">  <span id="fj_div">  </span><input type="hidden" name="fj_old_file" value=""></td>
          </tr>
         <tr>
            <td class="share"><div align="left" class=x_tixing_font>接收人:</div></td>
            <td  align="left"><input type="radio" name="receiver_type" value="1" checked onclick="showNone()">
              本人
              <input type="radio" name="receiver_type" value="2" onclick="showNone()">
              所有人 
              <input type="radio" name="receiver_type" value="3" onclick="showNone()">
              本部门
              <input type="radio" name="receiver_type" value="6" onclick="showNone()">
              本部门及下级
              
              <input type="radio" name="receiver_type" value="4" onclick="showDeparment()">
              指定部门

               <input type="radio" name="receiver_type" value="7" onclick="showQxz()">
              指定岗位

              <input type="radio" name="receiver_type" value="5" onclick="showPersion()">
              指定人员
			  <input type="hidden" name="display" value="<%=request.getParameter("display")==null?"none":request.getParameter("display")%>"> 

             <div id="department" style="display:none;margin-top:5px;">
			  <select name="receiver_dep" size="6" multiple>
				  <% for (int i=0;i<result_dep.length;i+=2) { %>
						<option value="<%=result_dep[i]%>"><%=result_dep[i+1]%></option>
				  <% } %>
			  </select>
           </div>

             <div id="qxz" style="display:none;margin-top:5px;">
			  <select name="receiver_qxz" size="6" multiple>
				  <% for (int i=0;i<result_qxz.length;i+=2) { %>
						<option value="<%=result_qxz[i]%>"><%=result_qxz[i+1]%></option>
				  <% } %>
			  </select>
           </div>
          
  		  <div id="persion" style="display:none;margin-top:5px;">
           
			  <select name="receiver_user" size="6" multiple width="20">
				  <% for (int i=0;i<result_user.length;i+=2) { %>
						<option value="<%=result_user[i]%>"><%=result_user[i+1]%>&nbsp;&nbsp;&nbsp;</option>
				  <% } %>
			  </select>
           </div>
			  </td>
          </tr>
          <tr>
            <td  colspan=2 align=center>
             		<div align="right" id="_button_area" style="display:block;margin-right:10px;"><img src="/emadmin/images/c2/btn_tixing.jpg" onclick="_click_button(form1)"></img></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>
			</td>
          </tr>
        </table>
      </form>
    </div>
    </td>
  </tr>
</table>
			</td>
			<td class="x_xt_alert_right">
				&nbsp;
			</td>
		</tr>
	</table>

	<!--页面底部-->
	<table width="100%" border ="0" cellpadding="0" cellspacing="0">
		<tr>
			<td class="x_xt_alert_bottom_left">
				&nbsp;
			</td>
			<td class="x_xt_alert_bottom_middle">
				&nbsp;
			</td>
			<td class="x_xt_alert_bottom_right">
				&nbsp;
			</td>
		</tr>
	</table>
</body>
<SCRIPT LANGUAGE="JavaScript">
<!--
	department.style.display=form1.display.value;
	persion.style.display=form1.display.value;
//-->
</SCRIPT>
</html>