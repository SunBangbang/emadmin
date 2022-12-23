<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.io.*,com.lf.util.*,java.text.SimpleDateFormat,com.lf.lfbase.service.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,javax.servlet.http.HttpServletRequest,java.net.*,java.text.*,java.lang.*"%>
<%

        /*
        1、首先检查上传的Excel文件的合法性
            1）是不是Excel文件
            2）工作表的数量是不是1个，工作表的名称对不对“客户档案”
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

// 特殊处理
//  如果系统未启用批次，则模板中不含批次，如果系统启用了批次，则模板中含有批次，首先要进行这样的校验
// 在后续的处理中也要进行动态处理
                    
    // 1）是不是Excel文件
	Map req=ExcelService.initUpload(request);
	    FileItem fItem=(FileItem)req.get("is_pc");    //是否有批次管理
        String is_pc="";   // 导入方式 insert    update
        if (fItem==null ) {
            throw new LFException("传入参数不正确!");
        } else {
            is_pc=fItem.getString();   
        }
        if  (!is_pc.equals(Api.getXtPreferenceValueByName("is_pc"))) {
            throw new LFException("传入参数与系统参数中设置的不一致!");
        }


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
     
    //if (!wb.getSheetName(sheet).eqauls("库存期初"))
        //throw new LFException("工作表的名称不是[库存期初]!");
    
    //3）标题列对不对

    String title="";
    String [] sheetTitle;
    if (is_pc.equals("1")) {
        sheetTitle=new String [11];
        sheetTitle[0]="仓库名称*";
        sheetTitle[1]="货品编码*";
        sheetTitle[2]="货品名称*";
        sheetTitle[3]="规格型号*";
        sheetTitle[4]="计价单位";
        sheetTitle[5]="期初数量";
        sheetTitle[6]="单价";
        sheetTitle[7]="金额";
        sheetTitle[8]="批次";
        sheetTitle[9]="生产日期";
        sheetTitle[10]="失效日期";
    } else {
        sheetTitle=new String [8];
        sheetTitle[0]="仓库名称*";
        sheetTitle[1]="货品编码*";
        sheetTitle[2]="货品名称*";
        sheetTitle[3]="规格型号*";
        sheetTitle[4]="计价单位";
        sheetTitle[5]="期初数量";
        sheetTitle[6]="单价";
        sheetTitle[7]="金额";
    }

   
    for (int i=0;i<sheetTitle.length;i++) {
        title=ExcelService.getCellValue(sheet, 0, i,"0").trim();    //row,col
        if (title==null || !title.equals(sheetTitle[i].trim()) ) 
            throw new LFException("工作表的第 "+String.valueOf(i+1)+" 列应为：["+sheetTitle[i].trim()+"]!");
   }
   
    //判断上传文件和is_pc是否一致
    if (!is_pc.equals("1")) {   //未启用批次，但上传文件含有批次列
           title=ExcelService.getCellValue(sheet, 0, 8,"0").trim();
           if (title!=null && title.equals("批次")) 
             throw new LFException("此模板含有批次列，但目前系统未启用批次，请重新下载模版！");
    }
 

///2、检查Excel文件数据自身的合法性        
         //1）仓库、编码有没有没录的，即必录项检查
         String errorMessage="";   //错误信息
         int  error_num=0;  //错误数

         String ck="";        //仓库名称
         String chbm="";          //货品编码
         String chmc="";          //货品名称
         String ggxh="";          //规格型号
         String jjdw="";          //计价单位
         double qcsl;          //期初数量
         String pc="";						//批次
         String scrq="";						//生产日期
         String sxq="";						//失效日期

		 SLfHashMap  allUnion= new SLfHashMap ();	//仓库名称+货品编码+批次
		 		 
         //解决假行的问题
         int realTotalRows=0;   //实际的行数
         int totalRows = sheet.getLastRowNum()+1;   //Excel返回总行数
        boolean is_continue_next=false;    //如果有一个问题出现了，则去处理一条。
         for (int i=1;i<totalRows;i++)  {    //开始扫描  从第2行开始
                ck=ExcelService.getCellValue(sheet, i,0,"0").trim();  
                chbm=ExcelService.getCellValue(sheet, i,1,"0").trim(); 
                chmc=ExcelService.getCellValue(sheet, i,2,"0").trim();  
                ggxh=ExcelService.getCellValue(sheet, i,3,"0").trim();  
                jjdw=ExcelService.getCellValue(sheet, i,4,"0").trim();  
                qcsl=Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,5,"0.00").trim());  
                pc=ExcelService.getCellValue(sheet, i,8,"0").trim(); 
                scrq=ExcelService.getCellValue(sheet, i,9,"0").trim(); 

                if (ck.length()==0 && chbm.length()==0) { //仓库与货品编码都为空，同时后边行的这两列没有了，就到底了
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

               

                if (ck.length()==0 && chbm.length()>0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [仓库名称] 不能为空！";
                    error_num++;
                    is_continue_next=true;
                }
                if (ck.length()>0 && chbm.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [货品编码] 不能为空！";
                    error_num++;
                    is_continue_next=true;
                }
                if (chmc.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [货品名称] 不能为空！";
                    error_num++;
                    is_continue_next=true;
                }
                if (ggxh.length()==0 )  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [规格型号] 不能为空！";
                    error_num++;
                    is_continue_next=true;
                }

                //如果是批次管理，做关于批次的相关判断
                if (is_pc.equals("1")) {   //
                         String tmptmp=ExcelService.getCellValue(sheet, i,9,"0").trim();  
                        //判断日期格式
                         if (!Util.checkDateFormat(tmptmp) ){
                                errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [生产日期]格式不正确,日期格式样例：2009-05-18。";
                            error_num++;
                             is_continue_next=true;
                         
                         }
                         //如果输入了日期，没有批次，则提示
                         if (Util.isBlankString(pc) && !Util.isBlankString(tmptmp) ){
                                errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 输入了生产日期，则必需录入批次，如果您不确定批次，可以直接把生产日期作为批次。";
                                error_num++;
                                is_continue_next=true;
                         
                         }
                         String tmptmp1=ExcelService.getCellValue(sheet, i,10,"0").trim();  
                         if (!Util.checkDateFormat(tmptmp1) ){
                                errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行  [失效日期]日期格式不正确";
                                error_num++;
                                is_continue_next=true;
                         }
                                                  //如果输入了日期，没有批次，则提示
                         if (Util.isBlankString(tmptmp) && !Util.isBlankString(tmptmp1) ){
                                errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 输入了失效日期，则必需录入生产日期。";
                                error_num++;
                                is_continue_next=true;
                         
                         }

                }


                if(is_continue_next) continue;    //如果上边有问题，则不查重，处理下一条

                 //2）名称有没有重复
                if (allUnion.containsKey(ck+chbm+pc))  {
                    if(is_pc.equals("1")){
                        errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [仓库名称]为["+ck+"] ,[货品编码]为["+chbm+"],[批次]为["+pc+"]与 第[ "+allUnion.get(ck+chbm+pc)+" ]行重复！ ";
                    } else {
                        errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [仓库名称]为["+ck+"] ,[货品编码]为["+chbm+"]与 第[ "+allUnion.get(ck+chbm+pc)+" ]行重复！ ";
                    }
                        error_num++;
                } else {
                        if (!Util.isBlankString(ck+chbm+pc)) allUnion.put(ck+chbm+pc,String.valueOf(i+1));
                        realTotalRows++;
                      
                }
               
         } //for

         //先报出自身检查的问题
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<br/><div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");

        //校验并获取当前会计日历
        String r_dqkjq[]=Api.sb("select qsrq from jc_kjrl where zt='002'");
        if (r_dqkjq==null || r_dqkjq.length==0) {
             throw new LFException("系统没有当前会计期信息,请执行【系统启用】,重新建立会计日历!");
        }


//3、Excel文件数据与数据库中的已有数据的关联性检查   


/*   1)检查仓库是否合法   2）货品几项是否合法 3）批次有效期是否合法    */
        
        errorMessage="";
        error_num=0;
         
        String sqlTemp="";
        String temp="";
        String sql="";
        String r[]=null;
        
        
        String xt_cpfz_sfpcgl="";
        String xt_cpfz_sfbzqgl="";
        String ck_id="";
        String ch_id="";
        String ckmc="";
		String jldw="";
        GB2Alpha gb2alpha = new GB2Alpha();//关键字搜索

        for (int i=1;i<realTotalRows;i++)  {    //开始扫描   从第2行开始

                 is_continue_next=false;

                //取出仓库id
               ckmc=ExcelService.getCellValue(sheet,i,0,"0").trim();  
               sqlTemp="select id from jc_cksz where  ckmc='"+ckmc+"' "; 
               
               r=Api.sb(sqlTemp);
                if (r==null || r.length==0)  { // 数据库里没有该名称,则报错
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [仓库名称] 中的 ["+ckmc+"] 在数据库中不存在，请到【仓库设置】中添加该仓库！";
                    error_num++;
                    is_continue_next=true;
                }else {
                    ck_id=r[0];
                }
                  
                 //货品编码 名称 规格型号
                temp=ExcelService.getCellValue(sheet,i,1,"0").trim();  
                temp+=ExcelService.getCellValue(sheet,i,2,"0").trim(); 
                temp+=ExcelService.getCellValue(sheet,i,3,"0").trim();
                temp+=ExcelService.getCellValue(sheet,i,4,"0").trim();
           			
                chbm=ExcelService.getCellValue(sheet, i,1,"0").trim(); 
                chmc=ExcelService.getCellValue(sheet, i,2,"0").trim();  
                ggxh=ExcelService.getCellValue(sheet, i,3,"0").trim();  
                jldw=ExcelService.getCellValue(sheet, i,4,"0").trim();  
                
                sqlTemp="select xt_cpfz_sfpcgl,xt_cpfz_sfbzqgl,id  from jc_chda where  chbm+chmc+ggxh+jldw='"+temp+"' ";
                r=Api.sb(sqlTemp);

                if (r==null || r.length==0)  {
                    errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [货品编码]为["+chbm+"],[货品名称]为["+chmc+"],[规格型号]为["+ggxh+"],[计价单位]为["+jldw+"]  在数据库中不存在或二者的内容不相符，请检查【货品档案】！";
                    error_num++;
                    is_continue_next=true;
                }  else {
                        xt_cpfz_sfpcgl=r[0];
                        xt_cpfz_sfbzqgl=r[1];
                        ch_id=r[2];
                }
               // 关于批次的检查
               if (is_pc.equals("1"))  {
                    pc=ExcelService.getCellValue(sheet, i,8,"0").trim(); 
                    scrq=ExcelService.getCellValue(sheet, i,9,"0").trim(); 
                    sxq=ExcelService.getCellValue(sheet, i,10,"0").trim(); 
                    //如果是批次管理，必须录入批次
                    if (xt_cpfz_sfpcgl.equals("1") && Util.isBlankString(pc)) {
                        errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [货品编码]为["+chbm+"],[货品名称]为["+chmc+"],[规格型号]为["+ggxh+"]  的货品，在【货品档案】中定义了采用“批次管理”，这里没有录入批次，请录入！";
                        error_num++;
                        is_continue_next=true;
                    }
                    //如果是效期管理，必须录入生产日期
                    if (xt_cpfz_sfbzqgl.equals("1") && Util.isBlankString(scrq)) {
                        errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [货品编码]为["+chbm+"],[货品名称]为["+chmc+"],[规格型号]为["+ggxh+"]  的货品，在【货品档案】中定义了采用“有效期管理”，这里没有录入生产日期，请录入！";
                        error_num++;
                        is_continue_next=true;
                    }

               }

                if(is_continue_next) continue;    //如果上边有问题，则不查重，处理下一条
            
                //对该行的列都检查完了,可以预生成sql语句了
								 
                String id="";
                String rls ="";
                String xgsx="";
                
                

				id = Util.getSequence();
                rls = r_dqkjq[0] + id;
                       
                xgsx="";
                if (!Util.isBlankString(pc)) {
                    xgsx+="批次："+pc;
                }
                if (!Util.isBlankString(ExcelService.getCellValue(sheet, i,9,"0").trim())) {  //scrp
                    xgsx+=" 生产日期："+ExcelService.getCellValue(sheet, i,9,"0").trim();
                }
                if (!Util.isBlankString(ExcelService.getCellValue(sheet, i,10,"0").trim())) {  //scrp
                    xgsx+=" 失效日期："+ExcelService.getCellValue(sheet, i,10,"0").trim();
                }
                       	
                        sql+=" insert into kc_kcspz (id,djbh,djrq,ywlx,djlx,ckmc,ck_id,chbm,chmc,ggxh,dw,rksl,rkdj,rkje,cksl,ckdj,ckje,jcsl,jcdj,jcje,ch_id,rls,autokeyword,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl) values (";
                        sql+="'yj"+id+"',";                                          // id 
                        sql+="'',";                                          // djbh 
                       	sql+="'"+ r_dqkjq[0]+"',";                                      // 单据日期
                        sql+=" '405',";                         // 业务类型
                        sql+=" '期初',";                         // 单据类型
                        sql+="'"+ckmc+"',";                         // 仓库名称
                        sql+="'"+ck_id+"',";  
                        sql+="'"+chbm+"',";          
                         sql+="'"+chmc+"',";  
                         sql+="'"+ggxh+"',";  
                          sql+="'"+jldw+"',";    //
                         sql+="0,";     //rksl
                          sql+="0,";    //rkdj
                          sql+="0,";    //rkje
                          sql+="0,";    //cksl
                          sql+="0,";    //ckdj
                          sql+="0,";    //ckje
                     
                        sql+=""+Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,5,"0.00000000").trim())+",";                         // 结存数量
                        sql+=""+Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,6,"0.00000000").trim())+",";                         // 结存单价
                        sql+=""+Double.parseDouble(ExcelService.getCellValueForNumber(sheet,i,7,"0.00000000").trim())+",";                         // 结存金额
                        sql+="'"+ch_id+"',";  																													//存货id
                        sql+="'"+rls+"',";  																															//日流水
                        sql+="'"+gb2alpha.String2Alpha(ckmc+" "+chmc +" "+pc)+"', ";   																	 //系统关键字
                        sql+="'"+pc+"',";                         // 批次
                        sql+="'"+scrq+"',";                         // 生产日期
                        sql+="'"+sxq+"',";                         // 失效日期
                        sql+="'"+xgsx+"',";  		
                         sql+="'"+xt_cpfz_sfpcgl+"',";  		
                        sql+="'"+xt_cpfz_sfbzqgl+"')";  		

        }  //for

        //报出检查的问题
        
        
        	
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");
                
               sql=" truncate table kc_kcspz "+sql;   //删除库存商品帐
               //更新当前库存
               sql+=" delete kc_kcspz_dqkc ";
			   sql+=" insert kc_kcspz_dqkc select distinct ck_id+ch_id+xt_cpfz_pc,ck_id,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,jcsl from kc_kcspz where djrq+rls in(select max(djrq+rls) from kc_kcspz group by ck_id,ch_id,xt_cpfz_pc) and jcsl >0  ";
               //更新仓库存货对照
				sql+=" insert into jc_ckchdz  (id,ck,chbm,chmc,ggxh,ch_id) select distinct  "; 
				sql+=" ch_id+ck_id+chbm,ck_id,chbm,chmc,ggxh,ch_id from kc_kcspz  "; 
				sql+=" where ck_id+chbm+chmc+ggxh+ch_id  "; 
				sql+=" not in (select ck_id+chbm+chmc+ggxh+ch_id from jc_ckchdz)  "; 
                //更新仓库货品分类
				sql+=" update jc_cksz set ckchfl=ckchfl+','+b.chlx+',' from  jc_ckchdz a,jc_chda b where a.ch_id=b.id and jc_cksz.id=a.ck and jc_cksz.ckchfl not like '%,'+b.chlx+',%'";
                Api.ub(sql);     //实际执行	
				Api.XtRefreshAutoKeyWords("kc_kcspz");
				Api.ub("update xt_xszn set state=1 where modul_id='kc_kcqc_import_Modul'");
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
						库存期初导入
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
                                    
                                        <div align="center" width="100%" style="padding-top:10px;width:100%;"><img src="/emadmin/images/c2/button/bill_ok.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:location.href="/emadmin/jsp/common/list.jsp?modul_id=kc_kcspz_listModul"'/> </div>
							</td>
						  </tr>
						</table>
				</form>													
						
											
			<!-- 内容区 -->

</body>
</html>

