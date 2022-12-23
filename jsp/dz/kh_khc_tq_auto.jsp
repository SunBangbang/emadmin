<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.io.*,com.lf.util.*,java.text.SimpleDateFormat,com.lf.lfbase.service.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,javax.servlet.http.HttpServletRequest,java.net.*,java.text.*"%>
<%
	String is_new=request.getParameter("is_new");
	String tqkhsl=request.getParameter("tqkhsl");//用户提取的客户数量
	String khcsl=request.getParameter("khcsl");//未提取客户的总数量
	String seqId=Util.getSequence();//得到ID
	String result[]=null;
	if(null==is_new){
			result=Api.sb("select case when (select count(*) from kh_khc where zt='002' and  lqrq=convert(varchar(10),getdate(),121) and lqr='"+((String[])session.getAttribute("userInfo"))[0].trim()+"'   group by lqr,lqrq) is null then 0 else (select count(*) from kh_khc where zt='002' and  lqrq=convert(varchar(10),getdate(),121) and lqr='"+((String[])session.getAttribute("userInfo"))[0].trim()+"'   group by lqr,lqrq)  end,mrtqsx-(case when (select count(*) from kh_khc where zt='002' and  lqrq=convert(varchar(10),getdate(),121) and lqr='"+((String[])session.getAttribute("userInfo"))[0].trim()+"'   group by lqr,lqrq) is null then 0 else (select count(*) from kh_khc where zt='002' and  lqrq=convert(varchar(10),getdate(),121) and lqr='"+((String[])session.getAttribute("userInfo"))[0].trim()+"'   group by lqr,lqrq)  end),mrtqsx,(select count(*) from kh_khc where zt='001') from xt_khccs");
	}else{
		String sql="insert into kh_yxkh (id,khbh,khjc,lxdh,zczj,gsgm,gsxz,hy,zyyw,email,gscz,gswz,dq,gsdz,yb,khh,gszh,sh,kynf,khly,fddbr,jlrq,  khlx,khxq,dfnr,zxbj,khjb,xydj,yskye,jf,sfzdgz,gzzt,lxcs,xclxrq,zjlxrq,zjlxzt,zjlxnr,zjlxr,lxr,xb,bm,zw,sj,msn,lqr,lqbm,lqrq,bz,lrr,lrrq,lrbm,enabled,autokeyword,ywy_mc,ywy_id,ywbm_mc,ywbm_id,cz_id,czbh,czbm,czlx)";
		//客户
		sql+="select top "+tqkhsl+" '"+seqId+"'+substring(id,len(id)-4,len(id)) ,gsbh,gsmc,gsdh,zczj,gsgm,gsxz,hy,zyyw,gsyx,gscz,gswz,dq,dz,yb,khyh,yhzh,sh,kynf,khly,fddbr,khjlrq,khlx,khxq,dfnr,zxbj,khjb,xydj,yskye,jf,sfzdgz,gzzt,lxcs,xclxrq,zjlxrq,zjlxzt,zjlxnr,zjlxr,lxr,xb,bm,zw,sj,msn,'"+((String[])session.getAttribute("userInfo"))[0].trim()+"','"+((String[])session.getAttribute("userInfo"))[3].trim()+"',convert(varchar(10),getdate(),121),bz,'"+((String[])session.getAttribute("userInfo"))[0].trim()+"',convert(varchar(10),getdate(),121),'"+((String[])session.getAttribute("userInfo"))[3].trim()+"',enabled,autokeyword,'"+((String[])session.getAttribute("userInfo"))[2].trim()+"','"+((String[])session.getAttribute("userInfo"))[0].trim()+"','"+Api.getValueName("000", ((String[])session.getAttribute("userInfo"))[3].trim())+"','"+((String[])session.getAttribute("userInfo"))[3].trim()+"',id,gsbh,'kh_khc','2' from kh_khc where zt='001'";
		//联系人
		sql+="insert into kh_yxkh_lxr(id,khmc,xm,xb,szbm,zw,fzyw,gzdh,yddh,jtdh,jtzz,cz,email,msn,sr,aihao,bz,khbh,lrr,lrrq,lrbm,enabled,autokeyword,kh_yxkh_id) select id,gsmc,xm,xb,szbm,zw,fzyw,gzdh,yddh,jtdh,jtzz,cz,yx,msn,sr,ah,bz,gsbh,'"+((String[])session.getAttribute("userInfo"))[0].trim()+"',convert(varchar(10),getdate(),121),'"+((String[])session.getAttribute("userInfo"))[3].trim()+"',enabled,autokeyword,'"+seqId+"'+substring(kh_khc_id,len(kh_khc_id)-4,len(kh_khc_id))  from kh_khc_lxr where kh_khc_id in(select top "+tqkhsl+" id from kh_khc where zt='001')";
		//联系记录
		sql+="insert into kh_yxkh_lxjl(id,yxkh,khbh,lxr,zxbj,xclxrq,lxzt,lxnr,gzzt,sfzdgz,lxrq,fj,lrr,lrrq,lrbm,autokeyword,cz_id,czbh,czbm,czlx,kh_yxkh_id) select id,gsmc,gsbh,lxr,zxbj,xclxrq,lxzt,lxnr,gzzt,sfzdgz,lxrq,fj,'"+((String[])session.getAttribute("userInfo"))[0].trim()+"',convert(varchar(10),getdate(),121),'"+((String[])session.getAttribute("userInfo"))[3].trim()+"',autokeyword,cz_id,czbh,czbm,czlx,'"+seqId+"'+substring(kh_khc_id,len(kh_khc_id)-4,len(kh_khc_id))  from kh_khc_lxjl where kh_khc_id in(select top 10 id from kh_khc where zt='001')";
		//更改该客户的状态
		sql+="update kh_khc set zt='002',lqr='"+((String[])session.getAttribute("userInfo"))[0].trim()+"',lqbm='"+((String[])session.getAttribute("userInfo"))[3].trim()+"',lqrq=convert(varchar(10),getdate(),121) where id in(select top "+tqkhsl+" id from kh_khc where zt='001')";
		Api.ub(sql);
		int intTqkhsl=Util.intValue(tqkhsl);
		int intKhcsl=Util.intValue(khcsl);
		String message="恭喜您,本次已成功提取"+tqkhsl+"个客户 ！";
		if(intTqkhsl>intKhcsl){//如果客户提取的小于客户池实存的数量
			message="由于<font color=red>客户池现存数量不足</font>,本次仅提取到"+khcsl+"个客户 ！";
		}

		response.sendRedirect("/emadmin/shared/message.jsp?message="+URLEncoder.encode(message,"UTF-8"));
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
<style>
.x_message_table {
	FONT-SIZE: 12px; 
	LINE-HEIGHT: 28px; 
	FONT-FAMILY: "宋体";
	border-style:solid;
	border-width:1px;
	border-color:#55a5d6;
	margin-top:30px;
	width:400px;
}
.x_message_message_td {
	BACKGROUND-COLOR: #e8f6ff;
	padding:5px;
	font-size:14px; 
	margin-top:20px;
	font-family:"宋体";
	line-height:20px;
	color:#000000;
	font-weight:bold;

}
</style>
<script>
	function formsub(){
		var jrktqsl= document.getElementById("jrktqsl").value //还可提取客户数
		var tqkhsl= document.getElementById("tqkhsl").value  //用户输入的客户数
		if(tqkhsl.length==0)
		{
			alert("请输入要提取的客户数量!");
			return false;
		}
		if(isNaN(tqkhsl)){
			alert("很抱歉,您输入的不是数字!");
			return false;
		}
		if(parseInt(tqkhsl)>parseInt(jrktqsl)){
			alert("很抱歉,你今天只能再提取"+jrktqsl+"个客户!");
			return false;
		}
		return true;
	}
</script>
</head>
<body>
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						<%=Serve.getModulName( request )%>
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
			<!-- 内容区 -->
			<!-- 内容区 -->

				<form name="form2" action="kh_khc_tq_auto.jsp" method="post" onsubmit="return formsub();">
          			<table class="x_message_table" cellspacing="0" align="center">
						  <tr>
							<td align="center"  class="x_message_title_td">&nbsp;</td>
							<td align="center"  class="x_message_title_td">&nbsp;<input type="hidden" name="is_new" value="1"><input type="hidden" id="jrktqsl" value="<%=Util.intValue(result[1])%>"><input type="hidden" name="khcsl" value="<%=Util.intValue(result[3])%>"></td>
						  </tr>
						  <tr>
							<td align="center"   class="x_message_message_td" rowspan="3"><img src="/emadmin/images/c2/icon/message.gif" align="center"/></td>
							<td  class="x_message_message_td">
								每日提取客户上限:&nbsp;<font color=red><b><%=Util.intValue(result[2])%></b></font>&nbsp;个
							</td>
						  </tr>
						   <tr>
							<td  class="x_message_message_td">
								今日已提取客户数:&nbsp;<font color=red><b><%=Util.intValue(result[0])%></b></font>&nbsp;个
							</td>
						  </tr>
						   <tr>
							<td  class="x_message_message_td">
								今日还可提取客户:&nbsp;<font color=red><b><%=Util.intValue(result[1])%></b></font>&nbsp;个
							</td>
						  </tr>
						  <tr>
							<td align="center"  class="x_message_title_td">&nbsp;</td>
							<td align="center"  class="x_message_title_td">&nbsp;</td>
						  </tr>
						</table>
						<table class="x_message_table" cellspacing="0" align="center">
							 <tr>
							<td align="center"   class="x_message_message_td" colspan=2 style="vertical-align:top">
								您要提取<input type='text' name='tqkhsl' id='tqkhsl' style="border:0px; border-bottom:1px solid black;background-color:#e8f6ff;text-align:center;" size=5>个客户&nbsp;&nbsp;<input type="image" src="/emadmin/images/c2/button/makesure_tq.gif" style="vertical-align:top">
							</td>
						  </tr>
						</table>
				</form>													
						
											
			<!-- 内容区 -->

</body>
</html>

