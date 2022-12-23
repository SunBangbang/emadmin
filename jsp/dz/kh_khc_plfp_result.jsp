<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.net.*"%>
<%
	String result[];
		
	
	String ids = request.getParameter( "ids" );
	String khStr = "";
	String seqId=Util.getSequence();//得到ID
	String isstandardlist = request.getParameter( "isstandardlist" );
	 String rs[] =null;
		 if( isstandardlist!=null  )
         { 
			 String bm=request.getParameter( "ywbm_mc" );
			 String bm_id=request.getParameter( "ywbm_id" );
			 String ywy=request.getParameter( "ywy_mc" );
			 String ywy_id=request.getParameter( "ywy_id" );
			 String sql="insert into kh_yxkh (id,khbh,khjc,lxdh,zczj,gsgm,gsxz,hy,zyyw,email,gscz,gswz,dq,gsdz,yb,khh,gszh,sh,kynf,khly,fddbr,jlrq,  khlx,khxq,dfnr,zxbj,khjb,xydj,yskye,jf,sfzdgz,gzzt,lxcs,xclxrq,zjlxrq,zjlxzt,zjlxnr,zjlxr,lxr,xb,bm,zw,sj,msn,lqr,lqbm,lqrq,bz,lrr,lrrq,lrbm,enabled,autokeyword,ywy_mc,ywy_id,ywbm_mc,ywbm_id,cz_id,czbh,czbm,czlx)";
			 //客户
			 sql+=" select '"+seqId+"'+substring(id,len(id)-4,len(id)),gsbh,gsmc,gsdh,zczj,gsgm,gsxz,hy,zyyw,gsyx,gscz,gswz,dq,dz,yb,khyh,yhzh,sh,kynf,khly,fddbr,khjlrq,khlx,khxq,dfnr,zxbj,khjb,xydj,yskye,jf,sfzdgz,gzzt,lxcs,xclxrq,zjlxrq,zjlxzt,zjlxnr,zjlxr,lxr,xb,bm,zw,sj,msn,'"+ywy_id+"','"+bm_id+"',convert(varchar(10),getdate(),121),bz,'"+ywy_id+"',convert(varchar(10),getdate(),121),'"+bm_id+"',enabled,autokeyword,'"+ywy+"','"+ywy_id+"','"+Api.getValueName("000", bm_id)+"','"+bm_id+"',id,gsbh,'kh_khc','2' from kh_khc where  '"+ ids +"' like '%,'+ id +',%' order by id desc";
			 //联系人
			 sql+=" insert into kh_yxkh_lxr(id,khmc,xm,xb,szbm,zw,fzyw,gzdh,yddh,jtdh,jtzz,cz,email,msn,sr,aihao,bz,khbh,lrr,lrrq,lrbm,enabled,autokeyword,kh_yxkh_id) select id,gsmc,xm,xb,szbm,zw,fzyw,gzdh,yddh,jtdh,jtzz,cz,yx,msn,sr,ah,bz,gsbh,'"+ywy_id+"',convert(varchar(10),getdate(),121),'"+bm_id+"',enabled,autokeyword,'"+seqId+"'+substring(kh_khc_id,len(kh_khc_id)-4,len(kh_khc_id)) from kh_khc_lxr where '"+ ids +"' like '%,'+ kh_khc_id +',%' ";
			 //联系记录
			 sql+=" insert into kh_yxkh_lxjl(id,yxkh,khbh,lxr,zxbj,xclxrq,lxzt,lxnr,gzzt,sfzdgz,lxrq,fj,lrr,lrrq,lrbm,autokeyword,cz_id,czbh,czbm,czlx,kh_yxkh_id) select id,gsmc,gsbh,lxr,zxbj,xclxrq,lxzt,lxnr,gzzt,sfzdgz,lxrq,fj,'"+ywy_id+"',convert(varchar(10),getdate(),121),'"+bm_id+"',autokeyword,cz_id,czbh,czbm,czlx,'"+seqId+"'+substring(kh_khc_id,len(kh_khc_id)-4,len(kh_khc_id))  from kh_khc_lxjl  where '"+ ids +"' like '%,'+ kh_khc_id +',%' ";
			 sql+=" update kh_khc set zt='002',lqr='"+ywy_id+"',lqbm='"+bm_id+"',lqrq=convert(varchar(10),getdate(),121),fpr='"+((String[])session.getAttribute("userInfo"))[0].trim()+"',fpbm='"+((String[])session.getAttribute("userInfo"))[3].trim()+"',fprq=convert(varchar(10),getdate(),121) where  '"+ ids +"' like '%,'+ id +',%' ";
			 Api.ub(sql);//执行SQL
			 response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode("操作已成功 ！","UTF-8"));
			 return; 
         }
		 else
		 {
			      rs=Api.sb("select gsbh,gsmc,gsdh,case when (select mc from dm_dq where dm=dq) is null then '无' else (select mc from dm_dq where dm=dq) end ,case when (select mc from dm_hy where dm=hy) is null then '无' else (select mc from dm_hy where dm=hy) end,lrrq from kh_khc where   '"+ ids +"' like '%,'+ id +',%' order by id desc");

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
                 result=window.open('/emadmin/shared/popwindow.jsp?bringinitems=bm_mc,yh_mc,bm_id,yh_id,id&popid=win_yh_detail&modul_id=kh_yxkh_yjp_Modul&keywords=' + idValue, mySubDialog,"resizable:Yes;status:no;dialogHeight:600px;dialogWidth:800px;"); 
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
 		function _click_button() { 
			var ids=	document.getElementById('ids').value;
			var ywy_id=	document.getElementById('ywy_id').value;
			if (ids==',') {
				alert("请选择您要分配的客户！");
				return false;
			}
			if (ywy_id=='') {
				alert("请先选择接收人！");
				return false;
			}
			if(!confirm("您确定分配所选的客户吗？")){
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
						客户分配
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
			<!-- 内容区 -->

		 <form name="form1" action="kh_khc_plfp_result.jsp" method="get" onsubmit="return  _click_button();">
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
			  			地&nbsp;&nbsp;区
			  		</td>
					<td width="100px;" align="center">
			  			行&nbsp;&nbsp;业
			  		</td>
					<td width="100px;" align="center">
			  			录入日期
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
					 <td   width="80px;" align="right"><b>接&nbsp;收&nbsp;人:</b></td> 
					 <td   align="left">&nbsp;&nbsp;<input name="ywy_mc"  type=text regName ="业务员" value=""  readonly    class="input_normal"> <a href="#" onClick="_doSelect_mainarea_ywy_mc()">选择</a></td>   
					 <td   width="80px;" align="right"><b>接收部门:</b></td> 
					 <td  align="left">&nbsp;&nbsp;<input onFocus="this.select()"  name="ywbm_mc"  readonly type="text" regName ="业务部门" value="" class="input_normal"></td>   
		 </tr> 
		   <input id="ywy_id" name="ywy_id" value= "" type=hidden>
		   <input name="ywbm_id" value= "" type=hidden>
		   <input id="ids" name="ids" value= "<%=ids%>" type=hidden>

		</table> <br>
		 <input type="hidden" name="isstandardlist" value="isstandardlist">  
		<div align="center" id="_button_area" style="display:block"><input type="image" name="Submit" src="/emadmin/images/c2/button/bill_ok.gif"></div>
		<div align="center" id="_button_area_message" style="display:none;font-size:12px;">正在处理，请稍等...</div>
		</form>  										
</body>
</html>
