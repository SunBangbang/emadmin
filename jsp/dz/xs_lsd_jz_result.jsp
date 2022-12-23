<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.net.*"%>
<%
	String result[];
		
	
	String ids = request.getParameter( "ids" );
	String isstandardlist = request.getParameter( "isstandardlist" );
	String rs[] =Api.sb("select convert(numeric(18,3),sum(yingshouje)) from xs_lsd where '"+ids+"' like '%'+id+'%'");
	if(("").equals(rs[0]))
	{
		rs= new String[1]; rs[0] = "0.000"; 
	}
	String bmmc[] =Api.sb("select name from xt_bm where id='"+((String[])session.getAttribute("userInfo"))[3].trim()+"'");
	String id="";
		 if( isstandardlist!=null  )
         { 
			 /**
				1.批量选择状态为为结帐的零售单  \/
				2.系统提示金额总计，跟用户再次确认操作   \/
				3.如果客户选择确定，系统将反写零售单的结帐状态，结帐人，结帐部门，结帐日期，应收单号。\/
				4.自动生成一张应收单并且强制审核。\/
				5.自动生成一张未审核的收款单
			 */
			 String sql="  declare @djh varchar(200)  ";
			 sql+=" exec getDJH  '11690308500020771', @djh output ";
			 id = Util.getSequence();
			 sql+=" insert into cw_ysd (id,ysdh,djrq,kh,khbh,kh_id,ydzffs,skqx,is_kp,je,ysje,wsje,ykpje,wkpje,bz,czbm,ywy_mc,ywy_id,ywbm_mc,ywbm_id,lrr,lrrq,lrbm) values (";
			 sql+="'"+id+"',";//id
			 sql+="@djh,";//单据号
			 sql+="convert(varchar(10),getdate(),121),";//单据日期
			 sql+="'零售客户',";//客户名
			 sql+="'00000000',";//客户编号
			 sql+="'00000000',";//客户ID
			 sql+="'001',";//约定支付方式
			 sql+="convert(varchar(10),getdate(),121),";//收款期限
		     sql+="0,";//是否开票
			 sql+=""+rs[0]+",";//金额
			 sql+="0.00000000,";//已收金额
			 sql+=""+rs[0]+",";//未收金额
			 sql+="0.00000000,";//已开票金额
			 sql+=""+rs[0]+",";//未开票金额
			 sql+="'',";//备注
			 sql+="'xs_lsd',";//参照表名
			 sql+="'"+((String[])session.getAttribute("userInfo"))[2].trim()+"',";//业务员名称
			 sql+="'"+((String[])session.getAttribute("userInfo"))[0].trim()+"',";//业务员ID
			 sql+="'"+bmmc[0]+"',";//业务部门名称
			 sql+="'"+((String[])session.getAttribute("userInfo"))[3].trim()+"',";//业务部门ID
			 sql+="'"+((String[])session.getAttribute("userInfo"))[0].trim()+"',";//录入人
			 sql+="convert(varchar(10),getdate(),121),";//录入日期
			 sql+="'"+((String[])session.getAttribute("userInfo"))[3].trim()+"')";//录入部门
			 //审核应收单
			 sql+=" update cw_ysd set shzt='1' , shr='"+((String[])session.getAttribute("userInfo"))[0].trim()+"',shrq=convert(varchar(10),getdate(),121) where id='"+id+"'";
		     //返填零售单
			 sql+=" update xs_lsd set jiezhangzt='1' ,jiezhangren='"+((String[])session.getAttribute("userInfo"))[0].trim()+"',jiezhangrq=convert(varchar(10),getdate(),121),jiezhangbm='"+((String[])session.getAttribute("userInfo"))[3].trim()+"',ysdh=@djh where '"+ids+"' like '%'+id+'%'";
			 //生成未审核的收款单
			 String skid= Util.getSequence();
			 //先插入收款单子表
			 sql+=" insert into xs_skd_sub(id,ys_id,ysdh,jshj,bz,wskje,jsje,fid) values(";
			 sql+="'"+id+"',";//ID
			 sql+="'"+id+"',";//应收单ID
			 sql+="@djh,";//应收单号
			 sql+=""+rs[0]+",";//总金额
			 sql+="'',";//备注
			 sql+=""+rs[0]+",";//未收款金额
			 sql+=""+rs[0]+",";//结算金额
			 sql+="'"+skid+"')";//外键ID
			 sql+=" exec getDJH  '11690325915660003', @djh output ";
			 //再插入收款单主表
			 sql+=" insert into xs_skd(id,skdh,skrq,kh,khbh,kh_id,zffs,ssje,bz,ywy_mc,ywy_id,ywbm_mc,ywbm_id,lrr,lrrq,lrbm,jsje,jmje,zh,zh_dm) values(";
			 sql+="'"+skid+"',";//ID
			 sql+="@djh,";//收款单号
			 sql+="convert(varchar(10),getdate(),121),";//收款日期
			 sql+="'零售客户',";//客户名称
			 sql+="'00000000',";//客户编号
			 sql+="'00000000',";//客户ID
			 sql+="'001',";//支付方式
			 sql+=""+rs[0]+",";//实收金额
			 sql+="'',";//备注
			 sql+="'"+((String[])session.getAttribute("userInfo"))[2].trim()+"',";//业务员名称
			 sql+="'"+((String[])session.getAttribute("userInfo"))[0].trim()+"',";//业务员ID
			 sql+="'"+bmmc[0]+"',";//业务部门名称
			 sql+="'"+((String[])session.getAttribute("userInfo"))[3].trim()+"',";//业务部门ID
			 sql+="'"+((String[])session.getAttribute("userInfo"))[0].trim()+"',";//录入人
			 sql+="convert(varchar(10),getdate(),121),";//录入日期
			 sql+="'"+((String[])session.getAttribute("userInfo"))[3].trim()+"',";//录入部门
			 sql+=""+rs[0]+",";//结算金额
			 sql+="0, ";//减免金额
			 sql+="'现金',";//减免名称
			 sql+="'1001') ";//账户代码
			 Api.ub(sql);
			 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("恭喜您，结帐成功 ！","UTF-8"));
			 return; 
         }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>

<%@include file="/emadmin/shared/headres.jsp"%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
 		function _click_button() { 
			var ids=	document.getElementById('ids').value;
			if (ids==',') {
				alert("请先选择您要结帐的零售单！");
				return false;
			}
			if(!confirm("确定执行结帐操作吗？")){
				return false;
			}
			document.getElementById('_button_area' ).style.display="none";
			document.getElementById('_button_area_message' ).style.display="block";
			return true;
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
						结帐
				</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
			<!-- 内容区 -->

		 <form name="form1" action="xs_lsd_jz_result.jsp" method="get" onsubmit="return  _click_button();">
		 <table width="99%"  border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff align="center">
			  	<tr style="background-color:#d8e2f4;">
			  		<td width="99%" align="center" height="200px;">
			  			<font size="5px;"><strong>您正在执行<font color=red>结帐</font>操作，当前总金额<font color=red><%=rs[0]%></font>元</strong></font>
						<br><br><br>
							<div align="center" id="_button_area" style="display:block"><input type="image" name="Submit" src="/emadmin/images/c2/button/bill_ok.gif"></div>
							<div align="center" id="_button_area_message" style="display:none;font-size:12px;">正在处理，请稍等...</div>
			  		</td>
				</tr>
		  </table>						

		 <input type="hidden" name="isstandardlist" value="isstandardlist">  
		 <input id="ids" name="ids" value= "<%=ids%>" type=hidden>
		  <input name="je" value= "<%=rs[0]%>" type=hidden>
		</form>  										
</body>
</html>
