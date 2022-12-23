<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.lf.lfbase.service.*,com.lf.util.*,java.text.DecimalFormat,java.net.*"%>
<%@include file="/emadmin/shared/checkPermission1.jsp"%>
<%@include file="/emadmin/version.jsp"%>
<%! public String getSelected(String x1,String x2) {
			if (x1==null || x2==null) return "";
			if (x1.equals(x2)) {
				return "selected"; 
			} else {
				return "";
			}
		}
%>
<%
                response.setHeader("Pragma","No-cache"); 
                response.setHeader("Cache-Control","no-cache"); 
                response.setDateHeader("Expires", 0); 
                String _systemState=Api.getXtPreferenceValueByName("isystemenabled");
                String _productCode=Api.getXtPreferenceValueByName("productCode");
                String _prodcutModul=Api.getXtPreferenceValueByName("prodcutModul");

                DecimalFormat df_bl = new DecimalFormat("0.0");//这里是设定小数位数
                DecimalFormat df_je = new DecimalFormat("###,###");//这里是设定小数位数

                //1、取得当前用户对个人目标完成情况的访问权限v_xs_mb_wc_gr_listModul
                String qx[]=Serve.getDesktopMbqx(request);
                //2、如果request里没有参数值，则采用默认值   date=1  2  
                String date=request.getParameter("date");
                if (date==null) date="4";   //默认为月
                String bm=request.getParameter("bm");
                if (bm==null) {
                    //如果权限类型是全部，则部门为空，否则，默认本部门
                    if  (qx!=null && qx[2].equals("all")) {
                        bm="";
                    } else { 
                        bm=((String[])session.getAttribute("userInfo"))[3];
                    }
                }
                String yh=request.getParameter("yh");
                if (yh==null) {
                    //如果权限类型不是本人，则用户为空，否则，默认本人
                    if  (qx!=null && !qx[2].equals("person")) {
                        yh="";
                    } else { 
                        yh=((String[])session.getAttribute("userInfo"))[0];
                    }
                }

                String bms[]=Serve.getBmQxResultForDesktop("v_xs_mb_wc_gr_listModul",request);
                String yhs[]=new String[0];
                if (!bm.equals(""))  yhs=Serve.getYhQxResultForDesktop(bm,request);

                


                //3、开始取业绩的数据
               String dateName="";
               String nd=Util.getYear();
               String result1[]=null;
               String result2[]=null;
               //完成占目标比例             
                    float x1=0f;
                    float x2=0f;
                    float x3=0f;
                    float x4=0f;
                    float x5=0f;
               //状态条长度
                    int width11=0;
                    int width12=0;
                    int width21=0;
                    int width22=0;
                    int width31=0;
                    int width32=0;
                    int width41=0;
                    int width42=0;
                    int width51=0;
                    int width52=0;
                    int width= 450;

               if (qx!=null) {
                    String startdate="";
                    String enddate="";
                    String startyf="";
                    String endyf="";
                    if (date.equals("1")) {   //今日
                        startdate=Util.getDate();
                        enddate=Util.getDate();
                        dateName="今日";
                    }
                    if (date.equals("2")) {   //昨日
                        startdate=Util.getDate(-1);
                        enddate=Util.getDate(-1);
                        dateName="昨日";
                    }
                    if (date.equals("3")) {   //
                        startdate=Util.getWeekStart(Util.getDate());//取得周开始日期
                        enddate=Util.getDate();
                        dateName="本周";
                    }
                    if (date.equals("4")) {   //
                        startdate=Util.getFirstDay(Util.getDate());
                        enddate=Util.getDate();
                        startyf=Util.getMonth();
                        endyf=Util.getMonth();
                        dateName="本月";
                    }
                    if (date.equals("5")) {   //
                        enddate=Util.getDate();
                        endyf=Util.getMonth();
                        if (endyf.compareTo("03")<=0) {
                                startyf="01";
                                startdate=nd+"-"+startyf+"-01";
                        } else  if (endyf.compareTo("06")<=0) {
                                startyf="04";
                                startdate=nd+"-"+startyf+"-01";
                        } else  if (endyf.compareTo("09")<=0) {
                                startyf="07";
                                startdate=nd+"-"+startyf+"-01";
                        } else  {
                                startyf="10";
                                startdate=nd+"-"+startyf+"-01";
                        }
                        dateName="本季";
                    }
                     if (date.equals("6")) {   //
                        startdate=nd+"-01-01";
                        enddate=Util.getDate();
                        startyf="01";
                        endyf=Util.getMonth();
                        dateName="本年";
                    }
                   String sqlpart="";
                  if (!bm.equals("")) {
                        sqlpart+=" and ywbm_id like '"+bm+"%'";
                  }
                  if (!yh.equals("")) {
                        sqlpart+=" and ywy_id like '"+yh+"%'";
                  }

                    //取目标数
                  String sql1=" select sum(yxkhs),sum(xqykhs),sum(qds),sum(qde),sum(hke) from xs_mb_gr where nd='"+nd+"' and yf between '"+startyf+"' and '"+endyf+"'";
                  //取实际数
                  String sql2=" select";
                        sql2+="  (select count(*) from kh_yxkh where lrrq between '"+startdate+"' and '"+enddate+"' " ;
                        sql2+=sqlpart+") wc_yxkhs, ";
                        sql2+="    (select count(*) from kh_da where jlrq between '"+startdate+"' and '"+enddate+"' " ;
                         sql2+=sqlpart+")  wc_xqykhs, ";
                        sql2+="    ((select count(*) from xs_xsdd where xsrq between '"+startdate+"' and '"+enddate+"' " ;
                         sql2+=sqlpart+")+ (select count(*) from fw_ht where qyrq between '"+startdate+"' and '"+enddate+"' "+sqlpart+"))  wc_qds, ";
                         sql2+="  ( (select case when sum(sub_jshj) is null then 0 else sum(sub_jshj) end from xs_xsdd where xsrq between '"+startdate+"' and '"+enddate+"' " ;
                         sql2+=sqlpart+")+(select case when sum(htje) is null then 0 else sum(htje) end from fw_ht where qyrq between '"+startdate+"' and '"+enddate+"' "+sqlpart+"))  wc_qde ,";
                         sql2+="   (select case when sum(ssje) is null then 0 else sum(ssje) end from xs_skd where skrq between '"+startdate+"' and '"+enddate+"' " ;
                         sql2+=sqlpart+")  wc_hke ";
            
                    result1=Api.sb(sql1+sqlpart);
                    result2=Api.sb(sql2);

                    if (date.compareTo("4")>=0) {
                        //计算完成占目标比例
                        if (Util.intValue(result1[0])!=0) x1=Float.valueOf(Util.intValue(result2[0]))/Float.valueOf(Util.intValue(result1[0]))*100;
                        if (Util.intValue(result1[1])!=0) x2=Float.valueOf(Util.intValue(result2[1]))/Float.valueOf(Util.intValue(result1[1]))*100;
                        if (Util.intValue(result1[2])!=0) x3=Float.valueOf(Util.intValue(result2[2]))/Float.valueOf(Util.intValue(result1[2]))*100;
                        if (Util.intValue(result1[3])!=0) x4=Float.valueOf(Util.intValue(result2[3]))/Float.valueOf(Util.intValue(result1[3]))*100;
                        if (Util.intValue(result1[4])!=0) x5=Float.valueOf(Util.intValue(result2[4]))/Float.valueOf(Util.intValue(result1[4]))*100;


                        
                        //计算状态条长度
                        if (Util.intValue(result1[0])>Util.intValue(result2[0])) {
                            width11=width;
                            width12=width*(int)x1/100;
                        } else if (Util.intValue(result2[0])==0 ) {
                            width11=0;
                            width12=0;
                        } else {
                            width11=(x1!=0)?(width/(int)x1*100):0;
                            width12=width;
                        }
                        //计算状态条长度
                        if (Util.intValue(result1[1])>Util.intValue(result2[1])) {
                            width21=width;
                            width22=width*(int)x2/100;
                        } else if (Util.intValue(result2[1])==0 ) {
                            width21=0;
                            width22=0;
                        } else {
                            width21=(x2!=0)?(width/(int)x2*100):0;
                            width22=width;
                        }
                        //计算状态条长度
                        if (Util.intValue(result1[2])>Util.intValue(result2[2])) {
                            width31=width;
                            width32=width*(int)x3/100;
                         } else if (Util.intValue(result2[2])==0 ) {
                            width31=0;
                            width32=0;
                       } else {
                            width31=(x2!=0)?(width/(int)x2*100):0;
                            width32=width;
                        }
                        //计算状态条长度
                        if (Util.intValue(result1[3])>Util.intValue(result2[3])) {
                            width41=width;
                            width42=width*(int)x4/100;
                         } else if (Util.intValue(result2[3])==0 ) {
                            width41=0;
                            width42=0;
                        } else {
                            width41=(x4!=0)?(width/(int)x4*100):0;
                            width42=width;
                        }
                        //计算状态条长度
                        if (Util.intValue(result1[4])>Util.intValue(result2[4])) {
                            width51=width;
                            width52=width*(int)x5/100;
                         } else if (Util.intValue(result2[4])==0 ) {
                            width51=0;
                            width52=0;
                        } else {
                            width51=(x5!=0)?(width/(int)x5*100):0;
                            width52=width;
                        }
                    }
            }
                          
           String bmName=Api.getValueName("000",bm);
           String yhName=Api.getValueName("001",yh);

           if (bmName.equals("")) bmName="所有部门";
           if (yhName.equals("")) yhName="所有人员";

           //开始处理工作提示

                    String loginYh=((String[])session.getAttribute("userInfo"))[0];
                    String sql_ywts="";
                    sql_ywts+=" select  ";
                    sql_ywts+="   (select count(*) from kh_yxkh where ywy_id='"+loginYh+"' and xclxrq like '"+Util.getDate()+"%' and    ";
                    sql_ywts+="      (select count(*) from kh_yxkh_lxjl where kh_yxkh_lxjl.kh_yxkh_id=kh_yxkh.id and lxrq='"+Util.getDate()+"')=0   ";
                    sql_ywts+="    ) x1,   ";
                    sql_ywts+="   (select count(*) from kh_yxkh where ywy_id='"+loginYh+"' and xclxrq<>'' and xclxrq < '"+Util.getDate()+"%' and   ";
                    sql_ywts+="       (select count(*) from kh_yxkh_lxjl where kh_yxkh_lxjl.kh_yxkh_id=kh_yxkh.id and lxrq>=kh_yxkh.xclxrq)=0  ";
                    sql_ywts+="   ) x2,  ";
                    sql_ywts+="   (select count(*) from kh_da where ywy_id='"+loginYh+"' and xclxrq like '"+Util.getDate()+"%' and   ";
                    sql_ywts+="      (select count(*) from kh_da_lxjl where kh_da_lxjl.kh_id=kh_da.id and lxrq='"+Util.getDate()+"')=0  ";
                    sql_ywts+="   ) x3,  ";
                    sql_ywts+="   (select count(*) from kh_da where ywy_id='"+loginYh+"' and xclxrq<>'' and xclxrq < '"+Util.getDate()+"%' and   ";
                    sql_ywts+="       (select count(*) from kh_da_lxjl where kh_da_lxjl.kh_id=kh_da.id and lxrq>=kh_da.xclxrq)=0  ";
                    sql_ywts+="   ) x4,  ";
                    sql_ywts+="   (select count(*) from xs_xsd where shzt='1' and ywy_id='"+loginYh+"' and skqx<>'' and datediff(day,convert(datetime,skqx),getDate()) between -3 and 0 and   ";
                    sql_ywts+="       wsje>0  ";
                    sql_ywts+="   ) x5,  ";
                    sql_ywts+="   (select count(*) from xs_xsd where shzt='1' and ywy_id='"+loginYh+"' and skqx<>'' and datediff(day,convert(datetime,skqx),getDate())>0 and   ";
                    sql_ywts+="       wsje>0  ";
                    sql_ywts+="   ) x6  ";
                    String r_ywts[]=new String[0];
                    
                    //如果有“意向客户联系记录新增”的权限，kh_yxkh_lxjl_addModul，才显示“工作提示”，才真正去后台取数
                    //因为意向客户联系记录新增代表 该用户是销售人员
                     if (Serve.getModulUrlStr(request,"kh_yxkh_lxjl_addModul").length()>0)  r_ywts=Api.sb(sql_ywts);

                    String filter_ywts1=URLEncoder.encode("ywy_id='"+loginYh+"' and xclxrq like '"+Util.getDate()+"%' and  (select count(*) from kh_yxkh_lxjl where kh_yxkh_lxjl.kh_yxkh_id=kh_yxkh.id and lxrq='"+Util.getDate()+"')=0 ","UTF-8");
                    String filter_ywts_title1=URLEncoder.encode("今日需联系的意向客户","UTF-8");

                    String filter_ywts2=URLEncoder.encode("kh_yxkh.ywy_id='"+loginYh+"' and kh_yxkh.xclxrq<>'' and kh_yxkh.xclxrq < '"+Util.getDate()+"%' and  (select count(*) from kh_yxkh_lxjl where kh_yxkh_lxjl.kh_yxkh_id=kh_yxkh.id and lxrq>=kh_yxkh.xclxrq)=0   ","UTF-8");
                    String filter_ywts_title2=URLEncoder.encode("超期未联系意向客户","UTF-8");

                    String filter_ywts3=URLEncoder.encode("kh_da.ywy_id='"+loginYh+"' and kh_da.xclxrq like '"+Util.getDate()+"%' and  (select count(*) from kh_da_lxjl where kh_da_lxjl.kh_id=kh_da.id and lxrq='"+Util.getDate()+"')=0     ","UTF-8");
                    String filter_ywts_title3=URLEncoder.encode("今日需联系的正式客户","UTF-8");
                    
                    String filter_ywts4=URLEncoder.encode("kh_da.ywy_id='"+loginYh+"' and kh_da.xclxrq<>'' and kh_da.xclxrq < '"+Util.getDate()+"%' and   (select count(*) from kh_da_lxjl where kh_da_lxjl.kh_id=kh_da.id and lxrq>=kh_da.xclxrq)=0  ","UTF-8");
                    String filter_ywts_title4=URLEncoder.encode("超期未联系正式客户","UTF-8");
                    
                    String filter_ywts5=URLEncoder.encode("xs_xsd.shzt='1' and  xs_xsd.ywy_id='"+loginYh+"' and xs_xsd.skqx<>'' and datediff(day,convert(datetime,xs_xsd.skqx),getDate()) between -3 and 0 and   xs_xsd.wsje>0 ","UTF-8");
                    String filter_ywts_title5=URLEncoder.encode("欠款即将到期客户","UTF-8");
                    
                    String filter_ywts6=URLEncoder.encode("xs_xsd.shzt='1' and  xs_xsd.ywy_id='"+loginYh+"' and xs_xsd.skqx<>'' and datediff(day,convert(datetime,xs_xsd.skqx),getDate())>0 and  xs_xsd.wsje>0","UTF-8");
                    String filter_ywts_title6=URLEncoder.encode("欠款超期未回客户","UTF-8");

                    String wdgz_link1="/emadmin/jsp/common/list.jsp?modul_id=kh_yxkh_listModul&dfilter="+filter_ywts1+"&dfilter_title"+filter_ywts_title1;
                    String wdgz_link2="/emadmin/jsp/common/list.jsp?modul_id=kh_yxkh_listModul&dfilter="+filter_ywts2+"&dfilter_title"+filter_ywts_title2;
                    String wdgz_link3="/emadmin/jsp/common/list.jsp?modul_id=kh_da_listModul&dfilter="+filter_ywts3+"&dfilter_title"+filter_ywts_title3;
                    String wdgz_link4="/emadmin/jsp/common/list.jsp?modul_id=kh_da_listModul&dfilter="+filter_ywts4+"&dfilter_title"+filter_ywts_title4;
                    String wdgz_link5="/emadmin/jsp/common/list.jsp?modul_id=xs_xsd_listModul&dfilter="+filter_ywts5+"&dfilter_title"+filter_ywts_title5;
                    String wdgz_link6="/emadmin/jsp/common/list.jsp?modul_id=xs_xsd_listModul&dfilter="+filter_ywts6+"&dfilter_title"+filter_ywts_title6;
           //开始处理信息提醒
                    String r_xxtx[]=Api.sb("select top 3 id,alert_content,state,alert_time from oa_alert where  alert_time<'"+Util.getDateTime()+"' and receiver='"+loginYh+"' order by alert_time desc,id desc");
           //开始处理最新任务
                    String r_zxrw[]=Api.sb("select top 3 id,rwzt,ksrq,rw_zt from oa_rw where rw_zt in ('1','3') and (ywy_id='"+loginYh+"' or qtzxr like ',"+loginYh+"%') order by id desc");
           //开始处理我的日程
                    String r_wdrc[]=Api.sb("select top 3  a.id,sj,zt,b.mc from oa_rc a,dm_rczt b where a.rczt=b.dm and a.lrr='"+loginYh+"' and a.rq='"+Util.getDate()+"' order by sj");

           //开始处理最新通知
                    String r_zxtz[]=Api.sb("select top 3 id,title,publish_time from oa_forum_paste where cid='001' order by publish_time desc");

          //取得待办事项
                   String r_dbsx[]=Serve.getAllDaiBanShenHe(request,3);

%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<link rel="stylesheet" href="/emadmin/css/c1/style_new.css">
<style type="text/css">
body {padding:0px;margin:0px;}
table{
	margin: 0px;padding: 0px;
}
a:link {color:#3d7298; text-decoration:none:}
a:visited {color:#3d7298;}
a:hover {color:#f60; }

</style>

</head>
<body>
	<!--下面就是以上条件都不符合时候出现的默认界面 -->
	<!--外面是大体的框架开始-->

	<table width="100%;" border ="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="50%" valign="top">

        <% if (qx!=null) {%>
				<table width="100%" border ="0" cellpadding="0" cellspacing="0">
					<!--公司公告 -->
					<tr>
						<td class="x_welcome_top">&nbsp;业绩查询 -- <%=bmName%> <%=yhName%> <%=dateName%> 业绩</td>
					</tr>
					<tr>
						<td>
							<table width="100%" border ="0" cellpadding="0" cellspacing="0" borderColor=#dee7f6 >
								<tr>
									<td  class="x_welcome_td_1" ><form name='form1' method='get'>
                                    &nbsp;&nbsp;  <a href="/emadmin/shared/desktop.jsp?date=1&bm=<%=bm%>&yh=<%=yh%>">今日</a>&nbsp;&nbsp;  
                                    <a href="/emadmin/shared/desktop.jsp?date=2&bm=<%=bm%>&yh=<%=yh%>">昨日</a>&nbsp;&nbsp;   
                                    <a href="/emadmin/shared/desktop.jsp?date=3&bm=<%=bm%>&yh=<%=yh%>">本周</a>&nbsp;&nbsp;  
                                    <a href="/emadmin/shared/desktop.jsp?date=4&bm=<%=bm%>&yh=<%=yh%>">本月</a>&nbsp;&nbsp;    
                                    <a href="/emadmin/shared/desktop.jsp?date=5&bm=<%=bm%>&yh=<%=yh%>">本季</a>&nbsp;&nbsp;    
                                    <a href="/emadmin/shared/desktop.jsp?date=6&bm=<%=bm%>&yh=<%=yh%>">今年</a>&nbsp;&nbsp;    
                                    <select name="bm" onchange="location.href='/emadmin/shared/desktop.jsp?date=<%=date%>&bm='+this.options[this.selectedIndex].value+'&yh='">
                                        <% if (qx[2].equals("all")) { %>
                                            <option value="">选择部门</option>
                                        <%}%>
                                        <% for (int i=0;i<bms.length;i+=2) { %>
                                            <option value="<%=bms[i]%>" <%=getSelected(bms[i],bm)%>><%=bms[i+1]%></option>
                                        <%}%>
                                    </select>

                                           <span style="display:<%=(yhs.length==0)?("none"):("")%>">
                                                <select name="yh" onchange="location.href='/emadmin/shared/desktop.jsp?date=<%=date%>&yh='+this.options[this.selectedIndex].value+'&bm=<%=bm%>'">
                                                    <% if (yh.equals("")) { %>
                                                        <option value="">选择人员</option>
                                                    <%}%>
                                                    <% for (int i=0;i<yhs.length;i+=2) { %>
                                                        <option value="<%=yhs[i]%>" <%=getSelected(yhs[i],yh)%>><%=yhs[i+1]%></option>
                                                    <%}%>
                                                </select>
                                           </span>
                                    </td>
								</tr>
							</table>
							<table width="100%" border ="1" cellpadding="0" cellspacing="0" borderColor=#dee7f6 >
								<tr>
									<td  class="x_welcome_td_1"  width="80px;">意向客户数</td>
									<td  class="x_welcome_td_1" >
                                 <%if (date.compareTo("4")>=0) {%>   
                                        <font color="orange"><b>目&nbsp;标</b></font> <span style="background-image:url('/emadmin/images/c3/mubiao.gif');width:<%=width11%>px;line-height:16px;"></span>&nbsp;<%=Util.intValue(result1[0])%>个<br>
                                        <font color="green"><b>完&nbsp;成</b></font> <span style="background-image:url('/emadmin/images/c3/wancheng.gif');width:<%=width12%>px;line-height:16px;"></span>&nbsp;<%=Util.intValue(result2[0])%>个&nbsp;&nbsp;完成目标<%=df_bl.format(x1)%>%
                                 <%} else {%>   
                                        完成 <span style="background-image:url('/emadmin/images/c3/wancheng.gif');width:<%=width12%>px;line-height:14px;"></span>&nbsp;<%=Util.intValue(result2[0])%>个
                                 <%}%>   
                                    </td>
								</tr>
								<tr>
									<td  class="x_welcome_td_1" >新签约客户</td>
									<td  class="x_welcome_td_1" >
                                 <%if (date.compareTo("4")>=0) {%>   
                                        <font color="orange"><b>目&nbsp;标</b></font> <span style="background-image:url('/emadmin/images/c3/mubiao.gif');width:<%=width21%>px;line-height:14px;"></span>&nbsp;<%=Util.intValue(result1[1])%>个<br>
                                        <font color="green"><b>完&nbsp;成</b></font> <span style="background-image:url('/emadmin/images/c3/wancheng.gif');width:<%=width22%>px;line-height:14px;"></span>&nbsp;<%=Util.intValue(result2[1])%>个&nbsp;&nbsp;完成目标<%=df_bl.format(x2)%>%
                                 <%} else {%>   
                                        <font color="green"><b>完&nbsp;成</b></font> <span style="background-image:url('/emadmin/images/c3/wancheng.gif');width:<%=width22%>px;line-height:14px;"></span>&nbsp;<%=Util.intValue(result2[1])%>个
                                 <%}%>   
                                    </td>
								</tr>
								<tr>
									<td  class="x_welcome_td_1" >签单数</td>
									<td  class="x_welcome_td_1" >
                                 <%if (date.compareTo("4")>=0) {%>   
                                        <font color="orange"><b>目&nbsp;标</b></font> <span style="background-image:url('/emadmin/images/c3/mubiao.gif');width:<%=width31%>px;line-height:14px;"></span>&nbsp;<%=Util.intValue(result1[2])%>个<br>
                                        <font color="green"><b>完&nbsp;成</b></font> <span style="background-image:url('/emadmin/images/c3/wancheng.gif');width:<%=width32%>px;line-height:14px;"></span>&nbsp;<%=Util.intValue(result2[2])%>个&nbsp;&nbsp;完成目标<%=df_bl.format(x3)%>%
                                 <%} else {%>   
                                        <font color="green"><b>完&nbsp;成</b></font> <span style="background-image:url('/emadmin/images/c3/wancheng.gif');width:<%=width32%>px;line-height:14px;"></span>&nbsp;<%=Util.intValue(result2[2])%>个
                                 <%}%>   
                                    </td>
								</tr>
								<tr>
									<td  class="x_welcome_td_1" >签单额</td>
									<td  class="x_welcome_td_1" >
                                 <%if (date.compareTo("4")>=0) {%>   
                                        <font color="orange"><b>目&nbsp;标</b></font> <span style="background-image:url('/emadmin/images/c3/mubiao.gif');width:<%=width41%>px;line-height:14px;"></span>&nbsp;<%=df_je.format(Util.intValue(result1[3]))%>元<br>
                                        <font color="green"><b>完&nbsp;成</b></font> <span style="background-image:url('/emadmin/images/c3/wancheng.gif');width:<%=width42%>px;line-height:14px;"></span>&nbsp;<%=df_je.format(Util.intValue(result2[3]))%>元&nbsp;&nbsp;完成目标<%=df_bl.format(x4)%>%
                                 <%} else {%>   
                                        <font color="green"><b>完&nbsp;成</b></font> <span style="background-image:url('/emadmin/images/c3/wancheng.gif');width:<%=width42%>px;line-height:14px;"></span>&nbsp;<%=df_je.format(Util.intValue(result2[3]))%>元
                                 <%}%>   
                                    </td>
								</tr>
								<tr>
									<td  class="x_welcome_td_1" >回款额</td>
									<td  class="x_welcome_td_1" >
                                 <%if (date.compareTo("4")>=0) {%>   
                                        <font color="orange"><b>目&nbsp;标</b></font> <span style="background-image:url('/emadmin/images/c3/mubiao.gif');width:<%=width51%>px;line-height:14px;"></span>&nbsp;<%=df_je.format(Util.intValue(result1[4]))%>元<br>
                                        <font color="green"><b>完&nbsp;成</b></font> <span style="background-image:url('/emadmin/images/c3/wancheng.gif');width:<%=width52%>px;line-height:14px;"></span>&nbsp;<%=df_je.format(Util.intValue(result2[4]))%>元&nbsp;&nbsp;完成目标<%=df_bl.format(x5)%>%
                                 <%} else {%>   
                                        <font color="green"><b>完&nbsp;成</b></font> <span style="background-image:url('/emadmin/images/c3/wancheng.gif');width:<%=width52%>px;line-height:14px;"></span>&nbsp;<%=df_je.format(Util.intValue(result2[4]))%>元
                                 <%}%>   
                                    </td>
								</tr>
							</table>
						
						</td>
					</tr>
				</table>
        <% } //if (qx!=null) %>
			
			</td>
		</tr>
	</table>
	
	<table width="100%;" border ="0" cellpadding="0" cellspacing="0">
		<tr>
         <% if (Serve.getModulUrlStr(request,"kh_yxkh_lxjl_addModul").length()>0) {%>
			<td width="50%" valign="top">
				<table width="100%" cellpadding="0" cellspacing="0">
					<!--公司公告 -->
					<tr>
						<td class="x_welcome_top">&nbsp;业务提示</td>
					</tr>
					<tr>
						<td>
							<table width="100%" border ="1" cellpadding="0" cellspacing="0" borderColor=#dee7f6 >
								<tr>
									<td  class="x_welcome_td_1" >
                                            <div align="left">
                                             <a href="<%=wdgz_link1%>" target="_blank">今日需联系<%=r_ywts[0]%>个意向客户</a>
                                            </div>
                                    </td>
									<td  class="x_welcome_td_1">
                                            <div align="left">
                                            <a href="<%=wdgz_link2%>" target="_blank">有<%=r_ywts[1]%>个意向客户超期未联系</a>
                                            </div>
                                    </td>
								</tr>
								<tr>
									<td  class="x_welcome_td_1" >
                                            <div align="left">
                                             <a href="<%=wdgz_link3%>" target="_blank">今日需联系<%=r_ywts[2]%>个正式客户</a>
                                            </div>
                                    </td>
									<td  class="x_welcome_td_1">
                                            <div align="left">
                                             <a href="<%=wdgz_link4%>" target="_blank">有<%=r_ywts[3]%>个正式客户超期未联系</a>
                                            </div>
                                    </td>
								</tr>
								<tr>
									<td  class="x_welcome_td_1">
                                            <div align="left">
                                            <a href="<%=wdgz_link5%>" target="_blank">有<%=r_ywts[4]%>笔客户欠款即将到期
                                            </a></div>
                                    </td>
									<td  class="x_welcome_td_1">
                                            <div align="left">
                                            <a href="<%=wdgz_link6%>" target="_blank">有<%=r_ywts[5]%>笔客户欠款超期未回</a>
                                            </div>
                                    </td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
            <%}%>
         <% if (Serve.getModulUrlStr(request,"oa_alert_listModul").length()>0) {%>
			<td width="50%" valign="top">
				<table width="100%"  cellpadding="0" cellspacing="0">
					<!--公司公告 -->
					<tr>
						<td class="x_welcome_top">&nbsp;信息提醒</td>
						<td class="x_welcome_top" align="right"><a href="<%=Serve.getModulUrlStr(request,"oa_alert_listModul")%>" target="_blank"><img src="/emadmin/images/c3/more.gif" border=0></a>&nbsp;&nbsp;&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2">
							<table width="100%" border ="1" cellpadding="0" cellspacing="0" borderColor=#dee7f6 >
                            <%
					if(r_xxtx.length!=0){
								for (int i=0;i<r_xxtx.length;i+=4) {%>
								<tr>
									<td  class="x_welcome_td_1" colspan='2'><a href="/emadmin/jsp/oa/xt_alert_message.jsp?id=<%=r_xxtx[i]%>" target="_blank"><%=(r_xxtx[i+1].length()>20)?(r_xxtx[i+1].substring(0,20))+"...":(r_xxtx[i+1])%></a></td>
									<td  class="x_welcome_td_1" colspan='2'><%=(r_xxtx[i+3].length()>16)?(r_xxtx[i+3].substring(0,16))+"...":(r_xxtx[i+3])%></td>
								</tr>
                            <% }}else{
									for (int i=0;i<3;i++) {
							%>
								<tr>
									<td  class="x_welcome_td_1" colspan='2'>&nbsp;</td>
									<td  class="x_welcome_td_1" colspan='2'>&nbsp;</td>
								</tr>
							<%}}%>
							</table>
						
						</td>
					</tr>
				</table>
			
			</td>
            <%}%>
        </tr>
	</table>
	
	<table width="100%;" border ="0" cellpadding="0" cellspacing="0">
		<tr>
         <% if (Serve.getModulUrlStr(request,"oa_rw_listModul").length()>0) {%>
			<td width="50%" valign="top">
				<table width="100%"  cellpadding="0" cellspacing="0">
					<!--公司公告 -->
					<tr>
						<td class="x_welcome_top">&nbsp;最新任务</td>
						<td class="x_welcome_top" align="right"><a href="<%=Serve.getModulUrlStr(request,"oa_rw_listModul")%>" target="_blank"><img src="/emadmin/images/c3/more.gif" border=0></a>&nbsp;&nbsp;&nbsp;</td>
					</tr>
					<tr>
						<td colspan='2'>
							<table width="100%" border ="1" cellpadding="0" cellspacing="0" borderColor=#dee7f6 >
                            <%  if(r_zxrw.length!=0){
								for (int i=0;i<r_zxrw.length;i+=4) { %>
								<tr>
									<td  class="x_welcome_td_1" ><a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rw_detailModul&id=<%=r_zxrw[i]%>" target="_blank"><%=(r_zxrw[i+1].length()>20)?(r_zxrw[i+1].substring(0,20))+"...":(r_zxrw[i+1])%></a></td>
									<td  class="x_welcome_td_1" align="center"><%=(r_zxrw[i+2].length()>16)?(r_zxrw[i+2].substring(0,16))+"...":(r_zxrw[i+2])%></td>
									<td  class="x_welcome_td_1"  align="center"><a href="/emadmin/jsp/common/detail.jsp?modul_id=oa_rw_detailModul&id=<%=r_zxrw[i]%>" target="_blank"><%=r_zxrw[i+3].equals("1")?"未签收":"进行中"%></a></td>
								</tr>
                            <% }}else{
									for (int i=0;i<3;i++) {
							%>
								<tr>
									<td  class="x_welcome_td_1" colspan='2'>&nbsp;</td>
									<td  class="x_welcome_td_1" colspan='2'>&nbsp;</td>
									<td  class="x_welcome_td_1" colspan='2'>&nbsp;</td>
								</tr>
							<%}}%>
							</table>
						
						</td>
					</tr>
				</table>
			
			</td>
            <%}%>
         <% if (Serve.getModulUrlStr(request,"oa_rc_listModul").length()>0) {%>
			<td width="50%" valign="top">
				<table width="100%"  cellpadding="0" cellspacing="0">
					<!--公司公告 -->
					<tr>
						<td class="x_welcome_top">&nbsp;我的日程</td>
						<td class="x_welcome_top" align="right"><a href="<%=Serve.getModulUrlStr(request,"oa_rc_listModul")%>" target="_blank"><img src="/emadmin/images/c3/more.gif" border=0></a>&nbsp;&nbsp;&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2">
							<table width="100%" border ="1" cellpadding="0" cellspacing="0" borderColor=#dee7f6 >
                            <%  if(r_wdrc.length!=0){
								for (int i=0;i<r_wdrc.length;i+=4) { %>
								<tr>
									<td  class="x_welcome_td_1" align="center"><%=r_wdrc[i+1]%></td>
									<td  class="x_welcome_td_1" ><a href="/emadmin/jsp/oa/rc_shedule_day_list.jsp?date=<%=Util.getDate()%>" target="_blank"><%=(r_wdrc[i+2].length()>20)?(r_wdrc[i+2].substring(0,20))+"...":(r_wdrc[i+2])%></a></td>
									<td  class="x_welcome_td_1" align="center"><a href="/emadmin/jsp/oa/rc_shedule_day_list.jsp?date=<%=Util.getDate()%>" target="_blank"><%=r_wdrc[i+3]%></a></td>
								</tr>
                            <% }}else{
									for (int i=0;i<3;i++) {
							%>
								<tr>
									<td  class="x_welcome_td_1" colspan='2'>&nbsp;</td>
									<td  class="x_welcome_td_1" colspan='2'>&nbsp;</td>
									<td  class="x_welcome_td_1" colspan='2'>&nbsp;</td>
								</tr>
							<%}}%>
							</table>
						</td>
					</tr>
				</table>
            <%}%>
			</td>
		</tr>
	</table>
	<table width="100%;" border ="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="50%" valign="top">
				<table width="100%"  cellpadding="0" cellspacing="0">
					<!--公司公告 -->
					<tr>
						<td class="x_welcome_top">&nbsp;待处理单据</td>
						<td class="x_welcome_top" align="right"><a href="#" onclick="window.open('<%=Serve.getModulUrlStr(request,"oa_daiban_listModul")%>','','status=yes,scrollbars=yes,left=350,top=100,height=400,width=600,menubar=no,status=no,toolbar =no,directories=no,resizable=yes');" ><img src="/emadmin/images/c3/more.gif" border=0></a>&nbsp;&nbsp;&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2">
							<table width="100%" border ="1" cellpadding="0" cellspacing="0" borderColor=#dee7f6 >
                            <%  if(r_dbsx.length!=0){ 
								for (int i=0;i<r_dbsx.length;i+=6) {%>
								<tr>
									<td  class="x_welcome_td_1" colspan='2'><a href="<%=r_dbsx[i+1]%>?modul_id=<%=r_dbsx[i]%>&dfilter=<%=URLEncoder.encode(r_dbsx[i+4],"UTF-8")%>" target="_blank"><%=(r_dbsx[i+2].length()>20)?(r_dbsx[i+2].substring(0,20))+"...":(r_dbsx[i+2])%></a></td>
									<td  class="x_welcome_td_1" colspan='2'><a href="<%=r_dbsx[i+1]%>?modul_id=<%=r_dbsx[i]%>&dfilter=<%=URLEncoder.encode(r_dbsx[i+4],"UTF-8")%>" target="_blank"><%=r_dbsx[i+5]%></a></td>
									<td  class="x_welcome_td_1" colspan='2'><a href="<%=r_dbsx[i+1]%>?modul_id=<%=r_dbsx[i]%>&dfilter=<%=URLEncoder.encode(r_dbsx[i+4],"UTF-8")%>" target="_blank"><%=r_dbsx[i+3]%></a></td>
								</tr>
                             <% }}else{
									for (int i=0;i<3;i++) {
							%>
								<tr>
									<td  class="x_welcome_td_1" colspan='2'>&nbsp;</td>
									<td  class="x_welcome_td_1" colspan='2'>&nbsp;</td>
									<td  class="x_welcome_td_1" colspan='2'>&nbsp;</td>
								</tr>
							<%}}%>
							</table>
						
						</td>
					</tr>
				</table>
			</td>
			<td width="50%" valign="top">
				<table width="100%"  cellpadding="0" cellspacing="0">
					<!--公司公告 -->
					<tr>
						<td class="x_welcome_top">&nbsp;最新通知</td>
						<td class="x_welcome_top" align="right"><a href="/emadmin/jsp/forum/web/lt_titlelist.jsp?cid=001" target="_blank"><img src="/emadmin/images/c3/more.gif" border=0></a>&nbsp;&nbsp;&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2">
							<table width="100%" border ="1" cellpadding="0" cellspacing="0" borderColor=#dee7f6 >
                            <%  if(r_zxtz.length!=0){
								for (int i=0;i<r_zxtz.length;i+=3) {%>
								<tr>
									<td  class="x_welcome_td_1" colspan='2'><a href="/emadmin/jsp/forum/web/lt_pastelist.jsp?cid=001&id=<%=r_zxtz[i]%>" target="_blank"><%=(r_zxtz[i+1].length()>20)?(r_zxtz[i+1].substring(0,20))+"...":(r_zxtz[i+1])%></a></td>
									<td  class="x_welcome_td_1" colspan='2'><%=(r_zxtz[i+2].length()>16)?(r_zxtz[i+2].substring(0,16))+"...":(r_zxtz[i+2])%></td>
								</tr>
                             <% }}else{
									for (int i=0;i<3;i++) {
							%>
								<tr>
									<td  class="x_welcome_td_1" colspan='2'>&nbsp;</td>
									<td  class="x_welcome_td_1" colspan='2'>&nbsp;</td>
									<td  class="x_welcome_td_1" colspan='2'>&nbsp;</td>
								</tr>
							<%}}%>
							</table>
						
						</td>
					</tr>
				</table>
			
			</td>
		</tr>
	</table>
	
	<!--外面是大体的框架结束-->
</body>
</html>


