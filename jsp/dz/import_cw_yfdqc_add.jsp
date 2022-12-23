<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.io.*,com.lf.util.*,java.text.SimpleDateFormat,com.lf.lfbase.service.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,javax.servlet.http.HttpServletRequest,java.net.*,java.text.*,java.lang.*"%>
<%

        /*
        1、首先检查上传的Excel文件的合法性
            1）是不是Excel文件
            2）工作表的数量是不是1个，工作表的名称对不对“应收单期初”
            3）标题列对不对
        2、检查Excel文件数据自身的合法性
             1）名称、类型有没有没录的 
             2）名称有没有重复 
        3、Excel文件数据与数据库中的已有数据的关联性检查
        4、删除数据库中多余的记录，（没有被使用的）（加个删除选项，默认不删除）
         原则：所有操作必须包含在一个sql串中提交，有问题可以回滚。
    */    
   
   
//1、首先检查上传的Excel文件的合法性

// 特殊处理
//  如果系统未启用批次，则模板中不含批次，如果系统启用了批次，则模板中含有批次，首先要进行这样的校验
// 在后续的处理中也要进行动态处理
                    
    // 1）是不是Excel文件
	Map req=ExcelService.initUpload(request);
	FileItem myfile = (FileItem)req.get("myfile");
    if (myfile.getName().indexOf("xls")<0)
		throw new LFException("上传的文件不是EXCEL文件!");

	if( myfile.getSize() <= 0 ) 
        throw new LFException("上传的文件内容为空!");

    
    InputStream uploadedStream = myfile.getInputStream(); 
    POIFSFileSystem fs  =  new POIFSFileSystem(uploadedStream);	
    HSSFWorkbook wb = new HSSFWorkbook(fs);


    
    //2）工作表的数量是不是1个，工作表的名称对不对“库存期初”
    if (wb.getNumberOfSheets()!= 1)
        throw new LFException("模板的工作表数量应该是1个,请检查是否使用了正确的模板!");
	
    HSSFSheet sheet = wb.getSheetAt(0); 
    //3）标题列对不对

    String title="";
    String [] sheetTitle;
        sheetTitle=new String [11];
        sheetTitle[0]="单据日期*";
        sheetTitle[1]="供应商*";
        sheetTitle[2]="支付方式";
        sheetTitle[3]="付款期限";
        sheetTitle[4]="是否开票";
        sheetTitle[5]="应付金额*";
        sheetTitle[6]="已付金额";
        sheetTitle[7]="已开票金额";
        sheetTitle[8]="摘要";
        sheetTitle[9]="备注";
        sheetTitle[10]="销售代表";

   
    for (int i=0;i<sheetTitle.length;i++) {
        title=ExcelService.getCellValue(sheet, 0, i,"0").trim();    //row,col
        if (title==null || !title.equals(sheetTitle[i].trim()) ) 
            throw new LFException("工作表的第 "+String.valueOf(i+1)+" 列应为：["+sheetTitle[i].trim()+"]!");
   }

///2、检查Excel文件数据自身的合法性        
         //1）仓库、编码有没有没录的，即必录项检查
         String errorMessage="";   //错误信息
         int  error_num=0;  //错误数

         String djrq="";        //单据日期--必录项
         String gys="";          //客户名称--必录项
         String zffs="";          //支付方式--支付方式
         String fkqx="";          //收款期限--不必录
         String sfkp="";          //是否开票--不必录
         String yfje;          //应收金额--必录项
         String yifuje;          //已收金额--不必录
		 String ykpje;          //已开票金额--不必录
         String zy="";						//摘要--不必录
         String bz="";						//备注--不必录
		 String xsdb="";						//销售代表--不必录
		 HashMap  allUnion= new HashMap ();	//仓库名称+货品编码+批次
		 		 
         //解决假行的问题
         int realTotalRows=0;   //实际的行数
         int totalRows = sheet.getLastRowNum()+2;   //Excel返回总行数
        boolean is_continue_next=false;    //如果有一个问题出现了，则去处理一条。
         for (int i=1;i<totalRows;i++)  {    //开始扫描  从第2行开始
                djrq=ExcelService.getCellValue(sheet, i,0,"0").trim();  
                gys=ExcelService.getCellValue(sheet, i,1,"0").trim(); 
                zffs=ExcelService.getCellValue(sheet, i,2,"0").trim();  
                fkqx=ExcelService.getCellValue(sheet, i,3,"0").trim();  
                sfkp=ExcelService.getCellValue(sheet, i,4,"0").trim();  
                yfje=ExcelService.getCellValue(sheet,i,5,"0.00").trim();  
                yifuje=ExcelService.getCellValue(sheet, i,6,"0.00").trim(); 
                ykpje=ExcelService.getCellValue(sheet, i,7,"0.00").trim(); 
				zy=ExcelService.getCellValue(sheet, i,8,"0").trim();  
				bz=ExcelService.getCellValue(sheet, i,9,"0").trim(); 
				xsdb=ExcelService.getCellValue(sheet, i,10,"0").trim(); 

                if (djrq.length()==0 && gys.length()==0) { //单据日期和客户名称都为空，同时后边行的这两列没有了，就到底了
                        boolean find=false;
                        for (int j=i+1;j<totalRows;j++) {
                            if (ExcelService.getCellValue(sheet, j,0,"0").trim().length()>0  
                                || ExcelService.getCellValue(sheet, j,1,"0").trim().length()>0) {
                                find=true;
                                break;   //不用继续找了
                            }
                           
                        }
                        if (!find) {    //到底了
                            realTotalRows=i;
                            break;
                        }
                }
                realTotalRows++;

                if (djrq.length()==0 && gys.length()>0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [单据日期] 不能为空！";
                    error_num++;
                    is_continue_next=true;
                }
                if (djrq.length()>0 && gys.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [供应商] 不能为空！";
                    error_num++;
                    is_continue_next=true;
                }
                if (Util.isBlankString(ExcelService.getCellValue(sheet,i,5,"0.00").trim().toString()))  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [应付金额] 不能为空！";
                    error_num++;
                    is_continue_next=true;
                }

				//判断单据日期格式
                String tmptmp=ExcelService.getCellValue(sheet, i,0,"0").trim();  
                if (!Util.checkDateFormat(tmptmp) ){
                      errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [单据日期]格式不正确,日期格式样例：2009-09-11。";
                      error_num++;
                      is_continue_next=true;
                         
                }

                tmptmp=ExcelService.getCellValue(sheet, i,3,"0").trim();  
                //判断收款期限日期格式
                if (!Util.checkDateFormat(tmptmp) ){
                      errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [付款期限]格式不正确,日期格式样例：2009-09-11。";
                      error_num++;
                      is_continue_next=true;
                         
                } 
                if(is_continue_next) continue;    //如果上边有问题，则不查重，处理下一条
               
         } //for

         //先报出自身检查的问题
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<br/><div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");

//3、Excel文件数据与数据库中的已有数据的关联性检查   


/*   1)检查仓库是否合法   2）货品几项是否合法 3）批次有效期是否合法    */
        
        errorMessage="";
        error_num=0;
         
        String sqlTemp="";
        String temp="";
        String sql="  declare @djh varchar(200)  ";
        String r[]=null;
		String gys_id="";
		String gysbh="";
		String valueXsdb="";
        String valueXsdb_mc="";
        String valueBm="";
        String valueBm_mc="";
        
        GB2Alpha gb2alpha = new GB2Alpha();//关键字搜索

        for (int i=1;i<realTotalRows;i++)  {    //开始扫描   从第2行开始

               is_continue_next=false;
 
			  //判断客户名称
			  temp=ExcelService.getCellValue(sheet, i,1,"0").trim();  
              if (!Util.isBlankString(temp)) {    
                 
                        sqlTemp="select id,gysbh from gys_da where gysjc='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n第 [ "+String.valueOf(i+1)+" ] 行[供应商] 中的 ["+temp+"] 在供应商档案中未定义<br>请【<a href='/emadmin/jsp/common/add.jsp?modul_id=gys_da_addModul'>点击这里</a>】添加该供应商！";
                            error_num++;
							is_continue_next=true;
                        }else{
							gys_id=r[0];
							gysbh=r[1];
						
						}     
                } 
				if(is_continue_next) continue;    //如果上边有问题，则不查重，处理下一条


                //取支付方式id
			   zffs=ExcelService.getCellValue(sheet,i,2,"0").trim();  
			   if(null!=zffs&&!"".equals(zffs)){
				   sqlTemp="select dm from dm_zffs where  mc='"+zffs+"' "; 
				   
				   r=Api.sb(sqlTemp);
					if (r==null || r.length==0)  { // 数据库里没有该名称,则报错
								errorMessage+="\r\n第[ "+String.valueOf(i+1)+" ]行 [支付方式] 中的 ["+zffs+"] 在数据库中不存在<br>请<a href='/emadmin/jsp/common/add.jsp?modul_id=dm_zffs_addModul'>点击这里</a>添加！";
						error_num++;
						is_continue_next=true;
					}else {
						zffs=r[0];
					}
				}
				if(is_continue_next) continue;    //如果上边有问题，则不查重，处理下一条

				//取是否开票id
				sfkp=ExcelService.getCellValue(sheet,i,4,"0").trim();  
				if(null!=sfkp&&!"".equals(sfkp)){
				   sqlTemp="select code_value from xt_inneroption_code where enabled = '1' and group_name='是否' and ischild ='1' and code_title='"+sfkp+"'";

				   r=Api.sb(sqlTemp);
					if (r==null || r.length==0)  { // 数据库里没有该名称,则报错
								errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [是否开票] 中的 ["+sfkp+"] 在数据库中不存在，该选项只能为【是】或【否】！";
						error_num++;
						is_continue_next=true;
					}else {
						sfkp=r[0];
					}
				}
                if(is_continue_next) continue;    //如果上边有问题，则不查重，处理下一条


				//销售代表    (单层码)(非必录)
                temp=ExcelService.getCellValue(sheet, i,10,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                        sqlTemp="select a.id,a.name,a.bm_id,b.name from xt_yh a,xt_bm b  where a.bm_id=b.id and  (a.name='"+temp+"' or  a.zhanghao='"+temp+"' )";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  销售代表 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在用户帐号中未定义,请先添加该帐号！";
                            error_num++;
							is_continue_next=true;
                        }  
                        if (r.length>4)  {   //如果通过姓名找出的帐号多余一个
                            errorMessage+="\r\n  销售代表 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在用户帐号有重名的记录,请通过帐号而不是姓名指定！";
                            error_num++;
							is_continue_next=true;
                        }  
						if (r!=null && r.length!=0)  {
							valueXsdb=r[0];
							valueXsdb_mc=r[1];
							valueBm=r[2];
							valueBm_mc=r[3];
						}
                } else {
                        valueXsdb=((String[])session.getAttribute("userInfo"))[0];    //取当前yh_id
                        valueXsdb_mc=((String[])session.getAttribute("userInfo"))[2];  //取当前登录人姓名
                        valueBm=((String[])session.getAttribute("userInfo"))[3];    //
                        valueBm_mc=Api.getValueName("000", valueBm);
                }
            
			   if(is_continue_next) continue;    //如果上边有问题，则不查重，处理下一条

                //对该行的列都检查完了,可以预生成sql语句了
								 
                String id="";
                String rls ="";
                String xgsx="";
					sql+=" exec getDJH  '11690308500020771', @djh output ";
				    id = Util.getSequence();
                    sql+=" insert into cw_yfd (id,yfdh,djrq,gys,gysbh,gys_id,ydzffs,skqx,is_kp,je,yfje,wfje,ykpje,wkpje,zy,bz,ywy_mc,ywy_id,ywbm_mc,ywbm_id,lrr,lrrq,lrbm,shzt) values ( ";
                        sql+="'"+id+"',";                                          // id 
                        sql+="@djh,";                                          // 应付单号 
                       	sql+="'"+ExcelService.getCellValue(sheet, i,0,"0").trim()+"',";                                         //单据日期
                     	sql+="'"+ExcelService.getCellValue(sheet, i,1,"0").trim()+"',";//客户名称
						sql+="'"+gysbh+"',";//客户编号
						sql+="'"+gys_id+"',";//客户ID
						sql+="'"+zffs+"',";//支付方式
						sql+="'"+ExcelService.getCellValue(sheet, i,3,"0").trim()+"',";//付款期限
						sql+="'"+sfkp+"',";//是否开票
                        sql+=""+Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,5,"0.00000000").trim())+",";    //应付金额
    
                        sql+=""+Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,6,"0.00000000").trim())+",";                         // 已收金额
						 sql+=""+(Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,5,"0.00000000").trim())-Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,6,"0.00000000").trim()))+","; //未收金额
                        sql+=""+Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,7,"0.00000000").trim())+",";                         // 已开票金额
						sql+=""+(Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,5,"0.00000000").trim())-Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,7,"0.00000000").trim()))+","; //未开票金额
                        sql+="'"+zy+"',";  		//摘要																									
                        sql+="'"+bz+"',";  	//备注																			
						sql+="'"+valueXsdb_mc+"',";  	//业务员名称
						sql+="'"+valueXsdb+"',";  	//业务员ID
						sql+="'"+valueBm_mc+"',";  	//业务部门名称
						sql+="'"+valueBm+"',";  	//业务部门ID
						sql+="'"+((String[])session.getAttribute("userInfo"))[0]+"',";  	//录入人
						sql+="'"+Util.getDate()+"',";  	//录入日期
						sql+="'"+((String[])session.getAttribute("userInfo"))[3]+"','0')";  	//录入部门
							

        }  //for

        //报出检查的问题
        
        
        	
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<div style='width:100%;text-align:left;font-size:12px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");
                 sql="truncate table cw_yfd " +sql; 	//备注		
               
                Api.ub(sql);     //实际执行	
				Api.XtRefreshAutoKeyWords("cw_yfd");
     		   Serve.reloadAll();
       


 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
</head>
<body>
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						应付单期初导入
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

				<form name="form2" action="kc_aqsz.jsp" method="post">
          			<table class="x_message_table" cellspacing="0" align="center">
						  <tr>
							<td align="center" width="100"  class="x_message_title_td">&nbsp;</td>
							<td align="center"  class="x_message_title_td">&nbsp;</td>
						  </tr>
						  <tr>
							<td align="center"  width="100"   class="x_message_message_td"><img src="/emadmin/images/c2/icon/message.gif" align="center"/> </td>
							<td  class="x_message_message_td">
                                      保存成功！<br>
                                    
                                        <div align="center" width="100%" style="padding-top:10px;width:100%;"><img src="/emadmin/images/c2/button/bill_ok.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:location.href="/emadmin/jsp/common/list.jsp?modul_id=cw_ysd_listModul"'/> </div>
							</td>
						  </tr>
						</table>
				</form>													
						
											
			<!-- 内容区 -->

</body>
</html>

