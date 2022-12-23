<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.net.*"%>
<%
	String result[];
		
	
	String ids = request.getParameter( "ids" );
	String hsyy = request.getParameter( "hsyy" );//回收原因
	String isstandardlist = request.getParameter( "isstandardlist" );
	 String rs[] =null;
		 if( isstandardlist!=null  )
         { 
			 /**
				1.将用户选中要回收的客户,联系人,联系记录从意向客户中转移到客户池
				2.删除意向客户中用户所选客户的所有信息
				3.返填本次回收客户的回收人和回收部门和回收日期，并且更改状态为“已回收”
				4.将领取人，领取部门，领取日期，分配人，分配部门和分配日期重置为空
			 */
			 String sql="";
			 //将用户选中要回收的客户从意向客户中转移到客户池
			 sql+=" update kh_khc  set  gsdh=b.lxdh,zczj=b.zczj,gsgm=b.gsgm,gsxz=b.gsxz,hy=b.hy,zyyw=b.zyyw,gsyx=b.email,gscz=b.gscz,gswz=b.gswz,dq=b.dq,dz=b.gsdz,yb=b.yb,khyh=b.khh,yhzh=b.gszh,sh=b.sh,kynf=b.kynf,khly=b.khly,fddbr=b.fddbr,khjlrq=b.jlrq,khlx=b.khlx,khxq=b.khxq,dfnr=b.dfnr,zxbj=b.zxbj,khjb=b.khjb,xydj=b.xydj,yskye=b.yskye,jf=b.jf,sfzdgz=b.sfzdgz,gzzt=b.gzzt,lxcs=b.lxcs,xclxrq=b.xclxrq,zjlxrq=b.zjlxrq,zjlxzt=b.zjlxzt,zjlxnr=b.zjlxnr,zjlxr=b.zjlxr,lxr=b.lxr,xb=b.xb,bm=b.bm,zw=b.zw,sj=b.sj,msn=b.msn,bz=b.bz,autokeyword=b.autokeyword,lqr='',lqbm='',lqrq='',fpr='',fpbm='',fprq='',zt='003',hsr='"+((String[])session.getAttribute("userInfo"))[0].trim()+"',hsbm='"+((String[])session.getAttribute("userInfo"))[3].trim()+"',hsrq=convert(varchar(10),getdate(),121),hsyy='"+hsyy+"'  from kh_yxkh b where kh_khc.id=b.cz_id and '"+ ids +"' like '%,'+ b.cz_id +',%' ";

			 //将用户选中要回收的联系人从意向客户中转移到客户池
			 sql+=" delete from  kh_khc_lxr where  '"+ ids +"' like '%,'+ kh_khc_id +',%' ";//先将原来的删除掉
			 sql+=" insert into kh_khc_lxr (id,gsmc,xm,xb,szbm,zw,fzyw,gzdh,yddh,jtdh,jtzz,cz,yx,msn,sr,ah,bz,gsbh,lrr,lrrq,lrbm,autokeyword,kh_khc_id) select a.id,a.khmc,a.xm,a.xb,a.szbm,a.zw,a.fzyw,a.gzdh,a.yddh,a.jtdh,a.jtzz,a.cz,a.email,a.msn,a.sr,a.aihao,a.bz,a.khbh,a.lrr,a.lrrq,a.lrbm,a.autokeyword,c.id from kh_yxkh_lxr a,kh_yxkh b,kh_khc c where a.kh_yxkh_id=b.id and b.cz_id=c.id and '"+ ids +"' like '%,'+ c.id +',%' ";

			 //将用户选中要回收的联系记录从意向客户中转移到客户池
			 sql+=" delete from  kh_khc_lxjl where  '"+ ids +"' like '%,'+ kh_khc_id +',%' ";//先将原来的删除掉
			 sql+="insert into kh_khc_lxjl(id,gsmc,gsbh,lxr,zxbj,xclxrq,lxzt,lxnr,gzzt,sfzdgz,lxrq,fj,lrr,lrrq,lrbm,autokeyword,cz_id,czbh,czbm,czlx,kh_khc_id) select a.id,a.yxkh,a.khbh,a.lxr,a.zxbj,a.xclxrq,a.lxzt,a.lxnr,a.gzzt,a.sfzdgz,a.lxrq,a.fj,a.lrr,a.lrrq,a.lrbm,a.autokeyword,a.cz_id,a.czbh,a.czbm,a.czlx,c.id from kh_yxkh_lxjl a,kh_yxkh b,kh_khc c  where a.kh_yxkh_id=b.id and b.cz_id=c.id and '"+ ids +"' like '%,'+ c.id +',%' ";
			 //最后将意向客户相关信息统统删除
			 sql+=" delete from  kh_yxkh_lxr where  kh_yxkh_id in (select kh_yxkh.id from kh_yxkh where '"+ids+"' like '%,'+ kh_yxkh.cz_id +',%')";//删除意向客户联系人
			 sql+=" delete from  kh_yxkh_lxjl where  kh_yxkh_id in (select kh_yxkh.id from kh_yxkh where '"+ids+"' like '%,'+ kh_yxkh.cz_id +',%')";//删除意向客户联系记录
			 sql+=" delete from  kh_yxkh where  '"+ ids +"' like '%,'+ cz_id +',%' ";//删除意向客户档案
		     Api.ub(sql);
			 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功 ！","UTF-8"));
			 return; 
         }
		 else
		 {
			      rs=Api.sb("select gsbh,gsmc,gsdh,case when (select name from xt_yh where id=lqr) is null then '无' else (select name from xt_yh where id=lqr) end ,case when (select name from xt_bm where id=lqbm) is null then '无' else (select name from xt_bm where id=lqbm) end,lrrq from kh_khc where   '"+ ids +"' like '%,'+ id +',%' order by id desc");

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
				alert("请选择您要回收的客户！");
				return false;
			}
			if(!confirm("您确定回收所选的客户吗？")){
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
						客户回收
				</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
			<!-- 内容区 -->

		 <form name="form1" action="kh_khc_hs_result.jsp" method="get" onsubmit="return  _click_button();">
		 <!--日程信息循环显示开始 -->
		 <table width="99%"  border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff align="center">
			  	<tr style="background-color:#d8e2f4;">
			  		<td width="100px;" align="center">
			  			公司编号
			  		</td>
			  		<td  align="center">
			  			公司名称
			  		</td>
			  		<td align="center" width="100">
			  			公司电话
			  		</td>
					<td width="100px;" align="center">
			  			领取人
			  		</td>
					<td width="100px;" align="center">
			  			领取部门
			  		</td>
					<td width="100px;" align="center">
			  			领取时间
			  		</td>
			  	</tr>
				 <% if(rs.length!=0){
					 for (int i=0;i<rs.length;i+=6) {%>
								<tr>
									<td align="center"><%=rs[i+0]%></td>
									<td >&nbsp;<%=rs[i+1]%></td>
									<td >&nbsp;<%=rs[i+2]%></td>
									<td align="center">&nbsp;<%=rs[i+3]%></td>
									<td align="center">&nbsp;<%=rs[i+4]%></td>
									<td align="center">&nbsp;<%=rs[i+5]%></td>
								</tr>		  	
			  	<%}}else{%>
			  	<tr>
			  		<td colspan="6" align="center">您暂时没有选择客户</td>
			  	</tr>
			  	<%} %>
		  </table>						

		<hr style="width:99%;color:#d8e2f4">	
		<table  border="1" cellpadding="0" cellspacing="0" borderColorLight=#B3C3D0 borderColorDark=#ffffff align="center" width="99%">
		 <tr> 
					 <td   width="80px;" align="right"><b>回收原因:</b></td> 
					 <td   align="left"><textarea name="hsyy" cols="80" rows="10"></textarea></td>   
		 </tr> 
		</table> <br>
		 <input type="hidden" name="isstandardlist" value="isstandardlist">  
		 <input id="ids" name="ids" value= "<%=ids%>" type=hidden>
		<div align="center" id="_button_area" style="display:block"><input type="image" name="Submit" src="/emadmin/images/c2/button/bill_ok.gif"></div>
		<div align="center" id="_button_area_message" style="display:none;font-size:12px;">正在处理，请稍等...</div>
		</form>  										
</body>
</html>
