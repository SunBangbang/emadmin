<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.io.*,com.lf.util.*,java.text.SimpleDateFormat,com.lf.lfbase.service.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,javax.servlet.http.HttpServletRequest,java.net.*,java.text.*"%>
<%

        /*
        1、首先检查上传的Excel文件的合法性
            1) 是不是Excel文件
            2) 工作表的数量是不是1个，工作表的名称对不对“货品档案”
            3) 标题列对不对
        2、检查Excel文件数据自身的合法性
             1) 名称、类型有没有没录的 
             2) 名称有没有重复 
        3、Excel文件数据与数据库中的已有数据的关联性检查
            1) 类型有没有
            2) 已录入销售代表有没有，空白不报错
            3) 已录入的地区有没有，空白不报错
            4) 分别处理新增和更新
                新增
                  检查名称是不是重复了名称是不是重了(数据库里已经有了) 
                   生成流水号，插入数据
                更新
                 如果名称数据里有了，则update,否则，分配一个编号，insert
      4、删除数据库中多余的记录，(没有被使用的) (加个删除选项，默认不删除) 
         原则：所有操作必须包含在一个sql串中提交，有问题可以回滚。
    */    
//1、首先检查上传的Excel文件的合法性


                    
    // 1) 是不是Excel文件
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


    
    //2) 工作表的数量是不是1个，工作表的名称对不对“货品档案”
    if (wb.getNumberOfSheets()!= 1)
        throw new LFException("模板的工作表数量应该是1个,请检查是否使用了正确的模板!");
	
    HSSFSheet sheet = wb.getSheetAt(0); 
     
    //if (!wb.getSheetName(sheet).eqauls("货品档案"))
        //throw new LFException("工作表的名称不是[货品档案]!");
    
    //3) 标题列对不对

    String title="";
    String [] sheetTitle=new String [19];
    sheetTitle[0]="货品编码*";
    sheetTitle[1]="货品名称*";
    sheetTitle[2]="货品类型*";
    sheetTitle[3]="原编号";
	sheetTitle[4]="货位";
    sheetTitle[5]="规格型号*";
    sheetTitle[6]="计价单位*";
    sheetTitle[7]="大包装单位";
    sheetTitle[8]="包装换算率*";
    sheetTitle[9]="计价方式";
    sheetTitle[10]="税率";
    sheetTitle[11]="成本价";
    sheetTitle[12]="销售价";
    sheetTitle[13]="产地";
    sheetTitle[14]="品牌";
    sheetTitle[15]="生产商";
    sheetTitle[16]="备注";
    sheetTitle[17]="是否批次管理";
    sheetTitle[18]="是否有效期管理";
    for (int i=0;i<sheetTitle.length;i++) {
        title=ExcelService.getCellValue(sheet, 0, i,"0").trim();    //row,col
        if (title==null || !title.equals(sheetTitle[i].trim()) ) 
            throw new LFException("工作表的第 "+String.valueOf(i+1)+" 列应为：["+sheetTitle[i].trim()+"]!");
   }

///2、检查Excel文件数据自身的合法性        
         //1) 名称、类型有没有没录的 
         String errorMessage="";   //错误信息
         int  error_num=0;  //错误数
         String hpbm="";        //货品编码
         String hpmc="";          //货品名称
		 String ggxh="";
		 String chlx="";
         String tempMc="";          //临时存放
		 HashMap  allMc= new HashMap ();	//所有的货品编码
		 HashMap  allUnion=new HashMap(); //所有chmc_chlx+ggxh
         int realTotalRows=0;   //实际的行数
         int totalRows = sheet.getLastRowNum()+2;   //Excel返回总行数
         for (int i=1;i<totalRows;i++)  {    //开始扫描  从地2行开始
                hpbm=ExcelService.getCellValue(sheet, i,0,"0").trim();  
                hpmc=ExcelService.getCellValue(sheet, i,1,"0").trim(); 
				chlx=ExcelService.getCellValue(sheet, i,2,"0").trim(); 
				ggxh=ExcelService.getCellValue(sheet, i,5,"0").trim(); 
                if (hpbm.length()==0 && hpmc.length()==0) { //编号和名称都为空，同时后边没有了，就到底了
                        boolean find=false;
                        for (int j=i+1;j<totalRows;j++) {
                            if (ExcelService.getCellValue(sheet, j,0,"0").trim().length()>0  
                                || ExcelService.getCellValue(sheet, j,1,"0").trim().length()>0) {
                                find=true;
                                break;   //不用继续找了
                            }
                        }
                        if (!find) {    //到底了
                            realTotalRows=i-1;
                            break;
                        }
                }
                if (hpbm.length()==0 && hpmc.length()>0)  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [货品编码] 不能为空！";
                    error_num++;
                    continue;
                }
                if (hpbm.length()>0 && hpmc.length()==0)  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [货品名称] 不能为空！";
                    error_num++;
                    continue;
                }
                //检查其他必录项
                //货品类型
                tempMc=ExcelService.getCellValue(sheet, i,2,"0").trim(); 
                if (Util.isBlankString(tempMc))  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [货品类型] 不能为空！";
                    error_num++;
                    continue;
                }
                //规格型号
                tempMc=ExcelService.getCellValue(sheet, i,5,"0").trim(); 
                if (Util.isBlankString(tempMc))  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [规格型号] 不能为空！";
                    error_num++;
                    continue;
                }
                //计价单位
                tempMc=ExcelService.getCellValue(sheet, i,6,"0").trim(); 
                if (Util.isBlankString(tempMc))  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [计价单位] 不能为空！";
                    error_num++;
                    continue;
                } 
                
                //批次管理 
                 tempMc=ExcelService.getCellValue(sheet, i,17,"0").trim(); 
                 //如果系统未启用批次管理，却选择批次管理，则报错
                 if (tempMc.equals("是") && !Api.getXtPreferenceValueByName("is_pc").equals("1"))  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [是否有效期管理] 不能为“是”，因为系统未启用批次及有效期管理，请选择“否”，或到首选参数中启用批次及有效期！";
                    error_num++;
                    continue;
                 } 
                //有效期管理 
                 tempMc=ExcelService.getCellValue(sheet, i,18,"0").trim(); 
                 //如果系统未启用批次管理，却选择批次管理，则报错
                 if (tempMc.equals("是") && !Api.getXtPreferenceValueByName("is_pc").equals("1"))  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [是否批次管理] 不能为“是”，因为系统未启用批次及有效期管理，请选择“否”，或到首选参数中启用批次及有效期！";
                    error_num++;
                    continue;
                 } 

                 //2) 编号有没有重复
                if (allMc.containsKey(hpbm))  {
                        errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [货品编码] 与 第[ "+allMc.get(hpbm)+" ]行重复！ ";
                        error_num++;
                } else {
                        if (!Util.isBlankString(hpbm)) allMc.put(hpbm,String.valueOf(i+1));
                        realTotalRows++;
                }

				//2) 存货名称,存货类型,规格型号有没有重复
                if (allMc.containsKey(hpmc+chlx+ggxh))  {
                        errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [存货名称+存货类型+规格型号] 与 第[ "+allMc.get(hpmc+chlx+ggxh)+" ]行重复！ ";
                        error_num++;
                } else {
                        if (!Util.isBlankString(hpmc+chlx+ggxh)) allMc.put(hpmc+chlx+ggxh,String.valueOf(i+1));
                        realTotalRows++;
                }
         } //for

         //先报出自身检查的问题
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<br/><div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");


//3、Excel文件数据与数据库中的已有数据的关联性检查   
        
        errorMessage="";
        error_num=0;
        String allMcString="";  // 取得所有的名称，用于删除的时候和数据库比较
        String failDeleteMessage=""; //不能成功删除的记录
       //1) 类型有没有
        String sqlTemp="";
        String temp="";
        String sql="  declare @djh varchar(200)  ";
        String r[]=null;
        boolean  is_update=false;  //对于修改方式,标志是否是执行update,如果为否,则执行insert
        String value_hpbm="";
        String value_hplx="";
        String value_jjfs="";
		
        for (int i=1;i<realTotalRows+1;i++)  {    //开始扫描   从第2行开始
                //货品编码
                temp=ExcelService.getCellValue(sheet, i,0,"0").trim();  
                allMcString+=","+temp+",";
                sqlTemp="select count(*) from jc_chda where chbm='"+temp+"'";
                r=Api.sb(sqlTemp);
                if (importType.equals("insert")) {     //如果是插入方式, 数据库里有该名称,则报错
                        if (r==null || r.length==0 || !r[0].equals("0"))  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [货品编码] 中的 ["+temp+"] 与数据库中的数据重复！";
                            error_num++;
                            continue;
                        }
                       is_update=false;
                       value_hpbm=temp;
                } else {  //如果是更新方式, 数据库里有该名称,则说明需要做update
                       if (r==null || r.length==0 || !r[0].equals("0"))  {
                            is_update=true;
                       } else {
                            is_update=false;
                       }
                        value_hpbm=temp;
                }
                //类型(多层代码)(必录)
                temp=ExcelService.getCellValue(sheet, i,2,"0").trim();    
                //查找出代码,层次码同时查找出是否是末级节点
                sqlTemp="select a.dm,(select count(*) from jc_hpfl b where b.dm<>a.dm and b.dm like a.dm+'%') from jc_hpfl a  where a.mc='"+temp+"'";
                r=Api.sb(sqlTemp);
                if (r==null || r.length==0)  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [货品类型] 中的 ["+temp+"] 在货品分类中未定义,请先添加该货品类型！";
                    error_num++;
                    continue;
                }  
                if (!r[1].equals("0"))  {   //不是末级节点
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [货品类型] 中的 ["+temp+"] 不是最末级分类,请更该为末级分类！";
                    error_num++;
                    continue;
                }  
                value_hplx=r[0];
                //计价方式    (单层码)(非必录)
                temp=ExcelService.getCellValue(sheet, i,9,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                        sqlTemp="select code_value from xt_option_code where code_title='"+temp+"'";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  计价方式 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在系统中未定义，请输入[“移动平均法”,“先进先出法”,“全月平均法”,“个别计价法”]中的一种！";
                            error_num++;
                            continue;
                        }  
                        value_jjfs=r[0];
                } else {  //默认值
                        value_jjfs="002";  //移动平均法
                }
			
                if (!is_update)  { // 如果是插入模式
						String id=Util.getSequence();
                        sql+="  insert into jc_chda (id,chbm,chmc,chlx,ybm,hw,ggxh,jldw,bzdw,hsl,jjfs,sl,ckcbj,cklsj,cd,chpp,scs,bz,xt_cpfz_sfpcgl,xt_cpfz_sfbzqgl,lrr,lrrq,lrbm,enabled,autokeyword) values (";
                        sql+=" '"+id+"',";                                          // id 就用单据号
                        sql+="'"+value_hpbm+"',";                         // 货品编码
                        sql+="'"+ExcelService.getCellValue(sheet, i,1,"0").trim()+"',";                         // chmc 
                        sql+="'"+value_hplx+"',";                         // chlx 
                        sql+="'"+ExcelService.getCellValue(sheet, i,3,"0").trim()+"',";                         // ybm
						sql+="'"+ExcelService.getCellValue(sheet, i,4,"0").trim()+"',";                         // HW
                        sql+="'"+ExcelService.getCellValue(sheet, i,5,"0").trim()+"',";                         //ggxh
                        sql+="'"+ExcelService.getCellValue(sheet, i,6,"0").trim()+"',";                         // jldw
                        sql+="'"+ExcelService.getCellValue(sheet, i,7,"0").trim()+"',";                         //bzdw
                        temp=ExcelService.getCellValueForNumber(sheet, i,8,"0.00").trim();
                        sql+="'"+(Util.isBlankString(temp)?"1":temp)+"',";                         //hsl
                        sql+="'"+value_jjfs+"',";                            //jjfs
						temp=ExcelService.getCellValue(sheet, i,10,"0").trim();
					    sql+="'"+(Util.isBlankString(ExcelService.getCellValue(sheet, i,10,"0").trim())?"0.17":temp)+"',";   //sl	
                        sql+="'"+ExcelService.getCellValueForNumber(sheet, i,11,"0.00").trim()+"',";                         //ckcbj
                        sql+="'"+ExcelService.getCellValueForNumber(sheet, i,12,"0.00").trim()+"',";                         //cklsj
                        sql+="'"+ExcelService.getCellValue(sheet, i,13,"0").trim()+"',";                         // cd
                        sql+="'"+ExcelService.getCellValue(sheet, i,14,"0").trim()+"',";                         //chpp
                        sql+="'"+ExcelService.getCellValue(sheet, i,15,"0").trim()+"',";                         //scs
                        sql+="'"+ExcelService.getCellValue(sheet, i,16,"0").trim()+"',";                         //bz
                        temp=ExcelService.getCellValue(sheet, i,17,"0").trim();
                        sql+="'"+(temp.equals("是")?"1":"0")+"',";                         //xt_cpfz_sfpcgl
                        temp=ExcelService.getCellValue(sheet, i,18,"0").trim();
                        sql+="'"+(temp.equals("是")?"1":"0")+"',";                         //xt_cpfz_sfbzqgl
                        sql+="'"+((String[])session.getAttribute("userInfo"))[0]+"',";                        // lrr 销售代表
                        sql+="'"+Util.getDate()+"',";                                                                                     // lrrq
                        sql+="'"+((String[])session.getAttribute("userInfo"))[3]+"',";                         // lrbm
                        sql+="'1','')";                                                                                                               // enabled
                } else {
                        sql+=" update jc_chda  set ";
                        sql+="chmc='"+ExcelService.getCellValue(sheet, i,1,"0").trim()+"',";                         // chmc 
                        sql+="chlx='"+value_hplx+"',";                         // chlx 
                        sql+="ybm='"+ExcelService.getCellValue(sheet, i,3,"0").trim()+"',";                         // ybm
						sql+="hw='"+ExcelService.getCellValue(sheet, i,4,"0").trim()+"',";                         // HW
                        sql+="ggxh='"+ExcelService.getCellValue(sheet, i,5,"0").trim()+"',";                         //ggxh
                        sql+="jldw='"+ExcelService.getCellValue(sheet, i,6,"0").trim()+"',";                         // jldw
                        sql+="bzdw='"+ExcelService.getCellValue(sheet, i,7,"0").trim()+"',";                         //bzdw
                        temp=ExcelService.getCellValue(sheet, i,8,"0").trim();
                        sql+="hsl='"+(Util.isBlankString(temp)?"1":temp).trim()+"',";                         //hsl
                        sql+="jjfs='"+value_jjfs+"',";                         //jjfs
                        sql+="sl='"+ExcelService.getCellValueForNumber(sheet, i,10,"0.00").trim()+"',";                         // sl
                        sql+="ckcbj='"+ExcelService.getCellValueForNumber(sheet, i,11,"0.00").trim()+"',";                         //ckcbj
                        sql+="cklsj='"+ExcelService.getCellValueForNumber(sheet, i,12,"0.00").trim()+"',";                         //cklsj
                        sql+="cd='"+ExcelService.getCellValue(sheet, i,13,"0").trim()+"',";                         // cd
                        sql+="chpp='"+ExcelService.getCellValue(sheet, i,14,"0").trim()+"',";                         //chpp
                        sql+="scs='"+ExcelService.getCellValue(sheet, i,15,"0").trim()+"',";                         //scs
                        sql+="bz='"+ExcelService.getCellValue(sheet, i,16,"0").trim()+"',";                         //bz
                        temp=ExcelService.getCellValue(sheet, i,17,"0").trim();
                        sql+="xt_cpfz_sfpcgl='"+(temp.equals("是")?"1":"0").trim()+"',";                         //xt_cpfz_sfpcgl
                        temp=ExcelService.getCellValue(sheet, i,18,"0").trim();
                        sql+="xt_cpfz_sfbzqgl='"+(temp.equals("是")?"1":"0").trim()+"' ";                         //xt_cpfz_sfpcgl
                        sql+=" where chbm='"+value_hpbm+"'";                                                                                       //条件
                }

        }  //for

        //报出检查的问题
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");

     // 4、如果是更新方式，删除数据库中多余的记录，(没有被使用的) (加个删除选项，默认不删除)   
         if (importType.equals("update") && deleteDate.equals("delete"))   {
                //从数据库中找出所有的待删除记录
                sqlTemp="select id,chmc from jc_chda where '"+allMcString+"' not like '%,'+chbm+ ',%'";
                r=Api.sb(sqlTemp);
                if (r!=null && r.length>0)  {   //存在需要删除的记录
                        for (int i=0;i<r.length;i+=2) {
                            if (Api.checkIftheDataIsUsed("jc_chda",r[i])) {   //如果被使用了，则在处理完成后报出来
                                    failDeleteMessage+="<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+r[i+1]+"</div>";
                            } else {
                                     sql+=" delete from jc_chda where id='"+r[i]+"'";                     //未被使用,则删除
                            }
                        }
               }  

         }
	
        //System.out.println(sql);
		Api.ub(sql);     //实际执行
		Api.XtRefreshAutoKeyWords("jc_chda");
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
<body><table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<!-- 标题区开始--> 
			<td  class='x_import_kh_left'>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="index1_font" >
						货品档案导入
					</span>
			</td>
			<td  class='x_import_kh_right'>
				&nbsp;
			</td>
			<!-- 标题区结束 --> 
		  </tr>
		  </table>
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
                                     <% if (failDeleteMessage.length()>0) {%>
                                        但有如下货品由于已经被某张单据使用,不能删除:
                                        <%=failDeleteMessage%>
                                     <%}%>
                                        <div align="center" width="100%" style="padding-top:10px;width:100%;"><img src="/emadmin/images/c2/button/bill_ok.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:location.href="/emadmin/jsp/common/list.jsp?modul_id=jc_chda_listModul"'/> </div>
							</td>
						  </tr>
						</table>
				</form>													
							 
											
			<!-- 内容区 -->

</body>
</html>

