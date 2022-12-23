<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.net.*"%>
<%
	String result[];
		
	
	String ids = request.getParameter( "ids" );
	String khStr = "";
	String isstandardlist = request.getParameter( "isstandardlist" );
		 if( isstandardlist!=null  )
         { 
			 String bm=request.getParameter( "ywbm_mc" );
			 		 String bm_id=request.getParameter( "ywbm_id" );
			 String ywy=request.getParameter( "ywy_mc" );
			 String ywy_id=request.getParameter( "ywy_id" );
			 String sql="";
			 sql+=" update kh_yxkh set ywy_mc='"+ywy+"',ywy_id='"+ywy_id+"',ywbm_mc='"+bm+"',ywbm_id='"+bm_id+"' where '"+ids+"' like '%,'+ id +',%' " ;
		     sql+=" update kh_khc set lqr='"+ywy_id+"',lqbm='"+bm_id+"',lqrq=convert(varchar(10),getdate(),121) from kh_yxkh where kh_khc.id=kh_yxkh.cz_id and '"+ids+"' like '%,'+ kh_yxkh.id +',%' ";
			 Api.ub(sql);
			 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功 ！","UTF-8"));
			 return; 
         }
		 else
		 {
			     String rs[]=Api.sb("select khjc from kh_yxkh where   '"+ ids +"' like '%,'+ id +',%'");

				 for (int i=0;i<rs.length ;i++)
				 {

					khStr +=rs[i] + "<br>";

				 }
				  
			

		 }


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<script language="javascript">
<!--
       function _doSelect_mainarea_ywy_mc() {  
                 var  mySubDialog = new Array(1); 
                 var  idValue=''; 
                 result=window.open('/emadmin/shared/popwindow.jsp?bringinitems=bm_mc,yh_mc,bm_id,yh_id,id&popid=win_yh_detail&modul_id=kh_yxkh_yjp_Modul&keywords=' + idValue, mySubDialog,"resizable:Yes;status:no;dialogHeight:500px;dialogWidth:700px;"); 
                 if (result!=true) { 
                           return; 
                 } else { 
                           document.getElementsByName('ywbm_mc' )[0].value=mySubDialog[0][1]; 
                           document.getElementsByName('ywy_mc' )[0].value=mySubDialog[0][2]; 
                           document.getElementsByName('ywbm_id' )[0].value=mySubDialog[0][3]; 
                           document.getElementsByName('ywy_id' )[0].value=mySubDialog[0][4]; 
                 }  
		} 



-->
</script>

<%@include file="/emadmin/shared/headres.jsp"%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
 		function _click_button(form1) { 
			if (true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
   //-->
</SCRIPT>
</head>
<body>
		  <table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						意向客户移交
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
			<!-- 内容区 -->

							<form name="form1" action="kh_yxkh_yj.jsp" method="get">
								


<table   id="bill_main_table" border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff align="center" width="98%">
 
   <tr> 
     <td  class="bill_td_10" width="20%" align="right">移交客户:</td> 
     <td  class="bill_td_11" width="30%" align="left"><%=khStr%> </td>   

     <td  class="bill_td_10" width="20%" align="right">&nbsp;</td> 
     <td  class="bill_td_11" width="30%" align="left"> &nbsp; </td>   


   </tr> 

   <tr> 
     <td  class="bill_td_10" width="20%" align="right">接&nbsp;收&nbsp;人:</td> 
     <td  class="bill_td_11" width="30%" align="left"><input name="ywy_mc"  type=text regName ="业务员" value=""  readonly    class="input_normal"> <a href="#" onClick="_doSelect_mainarea_ywy_mc()">选择</a></td>   
     <td  class="bill_td_10" width="20%" align="right">接收部门:</td> 
     <td  class="bill_td_11" width="30%" align="left"><input onFocus="this.select()"  name="ywbm_mc"  type="text" regName ="业务部门" value="" class="input_normal"></td>   
   </tr> 
   
   
   <input name="ywy_id" value= "" type=hidden>
   <input name="ywbm_id" value= "" type=hidden>
   <input name="ids" value= "<%=ids%>" type=hidden>

 </table> 

	<br>
							 <input type="hidden" name="isstandardlist" value="isstandardlist">  
							 <div align="center" id="_button_area" style="display:block"><input type="image" name="Submit" src="/emadmin/images/c2/button/bill_ok.gif"  onclick="_click_button(form1)"></div>
								<div align="center" id="_button_area_message" style="display:none">正在处理，请稍等...</div>

							</form>  
											

</body>
</html>
