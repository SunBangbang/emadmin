<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.io.*,com.lf.util.*,java.text.SimpleDateFormat,com.lf.lfbase.service.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,javax.servlet.http.HttpServletRequest,java.net.*,java.text.*"%>
<%

        /*
        1、首先检查上传的Excel文件的合法性
            1）是不是Excel文件
            2）工作表的数量是不是1个，工作表的名称对不对“采购单”
            3）标题列对不对
        2、检查Excel文件数据自身的合法性
             1）名称、类型有没有没录的 
             2）名称有没有重复 
        3、Excel文件数据与数据库中的已有数据的关联性检查
            1）类型有没有
            2）已录入销售代表有没有，空白不报错
            3）已录入的地区有没有，空白不报错
            4）分别处理新增和更新
                新增
                  检查名称是不是重复了名称是不是重了（数据库里已经有了）
                   生成流水号，插入数据
                更新
         如果名称数据里有了，则update,否则，分配一个编号，insert
      4、删除数据库中多余的记录，（没有被使用的）（加个删除选项，默认不删除）
         原则：所有操作必须包含在一个sql串中提交，有问题可以回滚。
    */    
//1、首先检查上传的Excel文件的合法性


                    
    // 1）是不是Excel文件
	Map req=ExcelService.initUpload(request);
	    FileItem fItem=(FileItem)req.get("import_type");
        String importType="";   // 导入方式 insert    update
        if (fItem==null ) {
            importType="insert";   //默认insert
        } else {
            importType=fItem.getString();   //默认insert
        }

        String deleteDate="";   //  删除Excel文件中部包含的数据库记录  delete    nodelete
	    fItem=(FileItem)req.get("delete");
        if (fItem==null ) {
            deleteDate="nodelete";   //默认nodelete
        } else {
            deleteDate=fItem.getString();   //
        }


	FileItem myfile = (FileItem)req.get("myfile");
    if (myfile.getName().indexOf("xls")<0)
		throw new LFException("上传的文件不是EXCEL文件!");

	if( myfile.getSize() <= 0 ) 
        throw new LFException("上传的文件内容为空!");

    
    InputStream uploadedStream = myfile.getInputStream(); 
    POIFSFileSystem fs  =  new POIFSFileSystem(uploadedStream);	
    HSSFWorkbook wb = new HSSFWorkbook(fs);


    
    //2）工作表的数量是不是1个，工作表的名称对不对“采购单”
    if (wb.getNumberOfSheets()!= 1)
        throw new LFException("模板的工作表数量应该是1个,请检查是否使用了正确的模板!");
	
    HSSFSheet sheet = wb.getSheetAt(0); 
     
    //if (!wb.getSheetName(sheet).eqauls("采购单"))
        //throw new LFException("工作表的名称不是[采购单]!");
    
    //3）标题列对不对

    String title="";
    String [] sheetTitle=new String [14];
    sheetTitle[0]="物料清单名称*";
    sheetTitle[1]="单据日期*";
    sheetTitle[2]="产品编码*";
    sheetTitle[3]="产品名称*";
    sheetTitle[4]="产品规格型号";
    sheetTitle[5]="产品单位";
	sheetTitle[6]="产品备注";
    sheetTitle[7]="物料编码*";
    sheetTitle[8]="物料名称*";
	sheetTitle[9]="物料规格型号";
	sheetTitle[10]="物料单位";
	sheetTitle[11]="定额数量*";
	sheetTitle[12]="序号";
    sheetTitle[13]="物料清单备注";
    
    for (int i=0;i<sheetTitle.length;i++) {
        title=ExcelService.getCellValue(sheet, 0, i,"0");    //row,col
        if (title==null || !title.equals(sheetTitle[i].trim()) ) 
            throw new LFException("工作表的第 "+String.valueOf(i+1)+" 列应为：["+sheetTitle[i]+"]!");
   }
   
 

		 ///2、检查Excel文件数据自身的合法性        
         //1）名称、类型有没有没录的 
         String errorMessage="";   //错误信息
         int  error_num=0;  //错误数   

		 String wlqdmc="";//物料清单名称
		 String wlqdmc_next="";//下一个物料清单名称
		 String djrq="";//单据日期
		 String djrq_next="";//下一个单据日期
		 String cpch_id="";
		 String cpchbm="";//存货编码
		 String cpchbm_next="";//下一个存货编码
		 String cpchmc="";//货品名称
		 String cpchmc_next="";//下一条货品名称

		 String cpggxh="";//规格型号
		 String cpggxh_next="";//下一条规格型号
		 String cpdw="";//单位
		 String cpdw_next="";//下一条支付方式
		 String cpbz="";//备注
		 String cpbz_next="";//下一条备注
		
		 String wlch_id="";		  //物料存货名称
		 String wlchbm="";		  //物料存货编码
		 String wlchmc="";		 //物料存货名称
		 String wlggxh="";
		 String wldw="";

		 String wldesl="";		 //定额数量

         int realTotalRows=0;   //实际的行数
         int totalRows = sheet.getLastRowNum()+2;   //Excel返回总行数
       
	     
         for (int i=1;i<totalRows;i++)  {    //开始扫描  从地2行开始
                wlqdmc=ExcelService.getCellValue(sheet, i,0,"0").trim();  
                djrq=ExcelService.getCellValue(sheet, i,1,"0").trim();
				cpchbm=ExcelService.getCellValue(sheet, i,2,"0").trim();
				cpchmc=ExcelService.getCellValue(sheet, i,3,"0").trim();
				wlchbm=ExcelService.getCellValue(sheet, i,7,"0").trim();
				wlchmc=ExcelService.getCellValue(sheet, i,8,"0").trim();
				wldesl=ExcelService.getCellValue(sheet, i,11,"0").trim();
                if (wlqdmc.length()==0 && djrq.length()==0&&cpchbm.length()==0&&cpchmc.length()==0) { //物料清单名称，单据日期，存货编码，名称
                        boolean find=false;
                        for (int j=i+1;j<totalRows;j++) {
                            if (wlqdmc.length()>0|| djrq.length()>0||cpchbm.length()>0||cpchmc.length()>0) {
                                find=true;
                                break;   //不用继续找了
                            }
                        }
                        if (!find) {    //到底了
                            realTotalRows=i-1;
                            break;
                        }
                }
                if (wlqdmc.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [物料清单名称] 不能为空！";
                    error_num++;
                    continue;
                }
                if (djrq.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [单据日期] 不能为空！";
                    error_num++;
                    continue;
                }
                if (cpchbm.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [产品编码] 不能为空！";
                    error_num++;
                    continue;
                }
				if (cpchmc.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [产品名称] 不能为空！";
                    error_num++;
                    continue;
                }
				if (wlchbm.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [物料编码] 不能为空！";
                    error_num++;
                    continue;
                }
				if (wlchmc.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [物料名称] 不能为空！";
                    error_num++;
                    continue;
                }
				if (wldesl.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [定额数量] 不能为空！";
                    error_num++;
                    continue;
                }
                //判断单据日期格式
                String tmptmp=ExcelService.getCellValue(sheet, i,1,"0").trim();  
                if (!Util.checkDateFormat(tmptmp) ){
                 	errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 单据日期格式不正确";
                    error_num++;
                    continue;
                }
               
         } //for

         //先报出自身检查的问题
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<br/><div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");


        //3、Excel文件数据与数据库中的已有数据的关联性检查   
     
        errorMessage="";
        error_num=0;

        String sqlTemp="";
        String temp="";
        String sql="  declare @djh varchar(200)  declare @djh2 varchar(200) declare @djh_del varchar(255)  ";
        String r[]=null;
        boolean  is_update=false;  //对于修改方式,标志是否是执行update,如果为否,则执行insert
		String zdzy="";//自动摘要
		String id="";
        for (int i=1;i<=realTotalRows;i++)  {    //开始扫描   从第2行开始
				wlqdmc=ExcelService.getCellValue(sheet, i,0,"0").trim();  
				wlqdmc_next=ExcelService.getCellValue(sheet, i+1,0,"0").trim(); 
				
                djrq=ExcelService.getCellValue(sheet, i,1,"0").trim(); 
				djrq_next=ExcelService.getCellValue(sheet, i+1,1,"0").trim();
				
                cpchbm=ExcelService.getCellValue(sheet, i,2,"0").trim(); 
				cpchbm_next=ExcelService.getCellValue(sheet, i+1,2,"0").trim(); 

				cpchmc=ExcelService.getCellValue(sheet, i,3,"0").trim(); 
				cpchmc_next=ExcelService.getCellValue(sheet, i+1,3,"0").trim(); 

				cpggxh=ExcelService.getCellValue(sheet, i,4,"0").trim(); 
				cpggxh_next=ExcelService.getCellValue(sheet, i+1,4,"0").trim(); 

				cpdw=ExcelService.getCellValue(sheet, i,5,"0").trim(); 
				cpdw_next=ExcelService.getCellValue(sheet, i+1,5,"0").trim(); 

				cpbz=ExcelService.getCellValue(sheet, i,6,"0").trim(); 
				cpbz_next=ExcelService.getCellValue(sheet, i+1,6,"0").trim(); 



			    //取出存货id
			    wlchbm=ExcelService.getCellValue(sheet,i,7,"0").trim(); //存货编码
			    wlchmc=ExcelService.getCellValue(sheet,i,8,"0").trim(); //货品名称
			    wlggxh=ExcelService.getCellValue(sheet,i,9,"0").trim();//规格型号
			    wldw=ExcelService.getCellValue(sheet,i,10,"0").trim();	//单位
  				/*//移动电话是否与数据库中重复
				temp3=ExcelService.getCellValue(sheet, i,6,"0");  
				sqlTemp3="select count(*) from kh_da_lxr where yddh='"+temp3+"'" ;
				r3=Api.sb(sqlTemp3);
				if(importType.equals("insert")){ //如果是插入方式, 数据库里有该移动电话,则报错
					 if ((r3==null || r3.length==0 || !r3[0].equals("0"))&&temp3.length()!=0)  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [移动电话] 中的 ["+temp3+"] 与数据库中的数据重复！";
                            error_num++;
                            continue;
                        }
                       is_update_lxr=false;
                       valueYddh=temp3;
				}else {  //如果是更新方式, 数据库里有该名称,则说明需要做update
                       if (r3==null || r3.length==0 || !r3[0].equals("0"))  {
                            is_update_lxr=true;
                       } else {
                            is_update_lxr=false;
                       }
                        valueYddh=temp3;
                }*/

			   //判断物料清单名称不能与数据库中的重复
			   sqlTemp="select count(*) from scan_wlqd where wlqdmc='"+ExcelService.getCellValue(sheet,i,0,"0").trim()+"'  ";
               r=Api.sb(sqlTemp);
			   if(importType.equals("insert")){ //如果是插入方式, 数据库里有该移动电话,则报错
					 if ((r!=null && r.length!=0 && !r[0].equals("0")))  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [物料清单名称] 中的 ["+wlqdmc+"] 与数据库中的数据重复！";
                            error_num++;
                            continue;
                        }
			   }

			   sqlTemp="select id,chbm,chmc,ggxh,bzdw,hsl,jldw from jc_chda where chbm='"+cpchbm+"' and chmc='"+cpchmc+"' ";
               r=Api.sb(sqlTemp);
			 
               if (importType.equals("insert")) {     //如果是插入方式, 数据库里没有该名称,则报错
                        if (r==null||r.length==0 )  {
							//向jc_chda中插入一条新的货品档案这个不包含在事务当中
							errorMessage+="\r\n  物料清单 第 [ "+String.valueOf(i+1)+" ] 行中的 产品编码:["+cpchbm+"],产品名称:["+cpchmc+"],产品规格型号:["+cpggxh+"] 在货品档案中未定义,请先添加该货品档案！";
                            error_num++;
                            continue;
							
                        }else
                        {
								cpch_id=r[0];
								cpchbm=r[1];
								cpchmc=r[2];
								cpggxh=r[3];
								cpdw=r[6];
                        }
                  
              } 

			 sqlTemp="select id,chbm,chmc,ggxh,bzdw,hsl,jldw from jc_chda where chbm='"+wlchbm+"' and chmc='"+wlchmc+"' ";
               r=Api.sb(sqlTemp);
			 
               if (importType.equals("insert")) {     //如果是插入方式, 数据库里没有该名称,则报错
                        if (r==null||r.length==0 )  {
							//向jc_chda中插入一条新的货品档案这个不包含在事务当中
							errorMessage+="\r\n  物料清单 第 [ "+String.valueOf(i+1)+" ] 行中的 物料编码:["+wlchbm+"],物料名称:["+wlchmc+"],物料规格型号:["+wlggxh+"] 在货品档案中未定义,请先添加该货品档案！";
                            error_num++;
                            continue;
							
                        }else
                        {
								wlch_id=r[0];
								wlchbm=r[1];
								wlchmc=r[2];
								wlggxh=r[3];
								wldw=r[6];
                        }
                  
              } 
			
                //对该行的列都检查完了,可以预生成sql语句了
				
                if (!is_update )  { // 如果是插入模式
						id=Util.getSequence();
						sql+=" update scan_wlqd_sub set fid='"+id+"' where fid='888888' ";
                        sql+="  exec getDJH  '11837784274670003', @djh output  ";   //取一个单据号
                        sql+=" insert into scan_wlqd (id,wldh,wlqdmc,djrq,chbm,chmc,ggxh,dw,sl,bz,ch_id,lrr,lrrq,lrbm,enabled,autokeyword) values( ";
                        sql+="'"+id+"',";                                          // id 
                        sql+=" @djh,";                                        // 物料清单号
                        sql+="'"+wlqdmc+"',";//物料清单名称
						sql+="'"+djrq+"',";//物料清单名称
						sql+="'"+cpchbm+"',";//产品存货编码
						sql+="'"+cpchmc+"',";//产品存货名称
						sql+="'"+cpggxh+"',";//产品规格型号
						sql+="'"+cpdw+"',";//单位
						sql+="'1',";//数量
						sql+="'"+cpbz+"',";//产品备注
						sql+="'"+cpch_id+"',";//产品存货id
                        sql+="'"+((String[])session.getAttribute("userInfo"))[0]+"',";          // lrr 销售代表
                        sql+="'"+Util.getDate()+"',";                                               // lrrq
                        sql+="'"+((String[])session.getAttribute("userInfo"))[3]+"',";         // lrbm
						sql+="'1', ";    //enabled
                        sql+="'' ";    //autokeyword
                        sql+=")";   
                        
                        //插销售单子表
                      	
		                sql+=" insert into scan_wlqd_sub (id,fid,chbm,chmc,ggxh,dw,sl,row_index,bz,ch_id)values( ";
		                sql+=" '"+id+"',";                                          // id 
		                sql+=" '"+id+"',"; 
		                sql+=" '"+wlchbm+"',"; //货品编码
						sql+=" '"+wlchmc+"',"; //货品名称
						sql+=" '"+wlggxh+"',"; //规格型号
						sql+=" '"+wldw+"',";//单位		
						sql+="'"+ExcelService.getCellValueForNumber(sheet, i,11,"0.00").trim()+"',";//数量	
						sql+="'"+ExcelService.getCellValueForNumber(sheet, i,12,"0.00").trim()+"',";//序号	

						sql+="'"+ExcelService.getCellValue(sheet, i,13,"0").trim()+"',";//备注
						sql+="'"+wlch_id+"'";//wlch_id
						sql+=" )  ";  

						zdzy+=wlchbm+" "+wlchmc+" "+wlggxh+" "+wldw+" "+ExcelService.getCellValueForNumber(sheet, i,11,"0.00").trim()+", ";
						if( (wlqdmc.equals(wlqdmc_next) ) && (djrq.equals(djrq_next)) && (cpchbm.equals(cpchbm_next)) && (cpchmc.equals(cpchmc_next))){
								
						 sql+="  delete scan_wlqd where id='"+id+"'  update scan_wlqd_sub set fid='888888' where fid='"+id+"' ";
						}  
						 //更新自动摘要
						sql+="update scan_wlqd set zdzy='"+zdzy+"' where id='"+id+"' ";
                } 
				

        }  //for

        //报出检查的问题
        
        
        	
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");
	
		Api.ub(sql);     //实际执行
		Api.XtRefreshAutoKeyWords("scan_wlqd");
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
						物料清单导入
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
							<td align="center"  width="100"   class="x_message_message_td">
							<img src="/emadmin/images/c2/icon/message.gif" align="center"/> </td>
							<td  class="x_message_message_td">
                                      保存成功！<br>

                                        <div align="center" width="100%" style="padding-top:10px;width:100%;">
										<img src="/emadmin/images/c2/button/bill_ok.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:location.href="/emadmin/jsp/common/list.jsp?modul_id=scan_wlqd_listModul"'/> </div>
							</td>
						  </tr>
						</table>
				</form>																
			<!-- 内容区 -->

</body>
</html>

