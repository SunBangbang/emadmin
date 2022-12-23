<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.io.*,com.lf.util.*,java.text.SimpleDateFormat,com.lf.lfbase.service.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,javax.servlet.http.HttpServletRequest,java.net.*,java.text.*"%>
<%

        /*
        1、首先检查上传的Excel文件的合法性
            1）是不是Excel文件
            2）工作表的数量是不是1个，工作表的名称对不对“供应商档案”
            3）标题列对不对
        2、检查Excel文件数据自身的合法性
             1）名称、类型有没有没录的 
             2）名称有没有重复 
        3、Excel文件数据与数据库中的已有数据的关联性检查
            1）类型有没有
            2）已录入负责人有没有，空白不报错
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


    
    //2）工作表的数量是不是1个，工作表的名称对不对“供应商档案”
    if (wb.getNumberOfSheets()!= 1)
        throw new LFException("模板的工作表数量应该是1个,请检查是否使用了正确的模板!");
	
    HSSFSheet sheet = wb.getSheetAt(0); 
     
    //if (!wb.getSheetName(sheet).eqauls("供应商档案"))
        //throw new LFException("工作表的名称不是[供应商档案]!");
    
    //3）标题列对不对

    String title="";
    String [] sheetTitle=new String [17];
    sheetTitle[0]="供应商名称*";
    sheetTitle[1]="供应商类型*";
    sheetTitle[2]="地址";
    sheetTitle[3]="联系人*";
    sheetTitle[4]="部门";
    sheetTitle[5]="职务";
    sheetTitle[6]="联系电话*";
    sheetTitle[7]="手机";
    sheetTitle[8]="MSN/QQ";
    sheetTitle[9]="邮箱";
    sheetTitle[10]="公司传真";
    sheetTitle[11]="公司网址";
    sheetTitle[12]="开户银行";
    sheetTitle[13]="银行账号";
    sheetTitle[14]="税号";
    sheetTitle[15]="负责人";
    sheetTitle[16]="备注";
    for (int i=0;i<sheetTitle.length;i++) {
        title=ExcelService.getCellValue(sheet, 0, i,"0").trim();    //row,col
        if (title==null || !title.equals(sheetTitle[i].trim()) ) 
            throw new LFException("工作表的第 "+String.valueOf(i+1)+" 列应为：["+sheetTitle[i].trim()+"]!");
   }

///2、检查Excel文件数据自身的合法性        
         //1）名称、类型有没有没录的 
         String errorMessage="";   //错误信息
         int  error_num=0;  //错误数
         String mc="";        //名称
         String lx="";          //类型
		 HashMap  allMc= new HashMap ();	//所有的产品类型	

         int realTotalRows=0;   //实际的行数
         int totalRows = sheet.getLastRowNum()+2;   //Excel返回总行数
         for (int i=1;i<totalRows;i++)  {    //开始扫描  从地2行开始
                mc=ExcelService.getCellValue(sheet, i,0,"0").trim();  
                lx=ExcelService.getCellValue(sheet, i,1,"0").trim(); 
                if (mc.length()==0 && lx.length()==0) { //名称和类型都为空，同时后边没有了，就到底了
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
                if (mc.length()==0 && lx.length()>0)  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [供应商名称] 不能为空！";
                    error_num++;
                    continue;
                }
                if (mc.length()>0 && lx.length()==0)  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [供应商类型] 不能为空！";
                    error_num++;
                    continue;
                }
                 //2）名称有没有重复
                if (allMc.containsKey(mc))  {
                        errorMessage += "\r\n  第[ "+String.valueOf(i+1)+" ]行 [供应商名称] 与 第[ "+allMc.get(mc)+" ]行重复！ ";
                        error_num++;
                } else {
                        if (!Util.isBlankString(mc)) allMc.put(mc,String.valueOf(i+1));
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
       //1）类型有没有
        String sqlTemp="";
        String temp="";
        String sql="  declare @djh varchar(200)  ";
        String r[]=null;
        String valueMc="";
        boolean  is_update=false;  //对于修改方式,标志是否是执行update,如果为否,则执行insert
        String valueLx="";
        String valueDq="";
        String valueXsdb="";
        String valueXsdb_mc="";
        String valueBm="";
        String valueBm_mc="";
        for (int i=1;i<realTotalRows+1;i++)  {    //开始扫描   从第2行开始
                //名称
                temp=ExcelService.getCellValue(sheet, i,0,"0").trim();  
                allMcString+=","+temp+",";
                sqlTemp="select count(*) from gys_da where gysjc='"+temp+"'";
                r=Api.sb(sqlTemp);
                if (importType.equals("insert")) {     //如果是插入方式, 数据库里有该名称,则报错
                        if (r==null || r.length==0 || !r[0].equals("0"))  {
                            errorMessage+="\r\n   第[ "+String.valueOf(i+1)+" ]行 [供应商名称] 中的 ["+temp+"] 与数据库中的数据重复！";
                            error_num++;
                            continue;
                        }
                       is_update=false;
                       valueMc=temp;
                } else {  //如果是更新方式, 数据库里有该名称,则说明需要做update
                       if (r==null || r.length==0 || !r[0].equals("0"))  {
                            is_update=true;
                       } else {
                            is_update=false;
                       }
                        valueMc=temp;
                }
                //类型(单层代码)(必录)
                temp=ExcelService.getCellValue(sheet, i,1,"0").trim();    
                sqlTemp="select dm from jc_gysfl where mc='"+temp+"'";
                r=Api.sb(sqlTemp);
                if (r==null || r.length==0)  {
                    errorMessage+="\r\n 第[ "+String.valueOf(i+1)+" ]行 [供应商类型] 中的 ["+temp+"] 在供应商分类中未定义,请先添加该分类！";
                    error_num++;
                    continue;
                }  
                valueLx=r[0];
                //负责人    (单层码)(非必录)
                temp=ExcelService.getCellValue(sheet, i,15,"0").trim();  
                if (!Util.isBlankString(temp)) {    //非必录项如果录入了值,则检查合法性
                        //查找出代码 同时查找出部门
                        sqlTemp="select a.id,a.name,a.bm_id,b.name from xt_yh a,xt_bm b  where a.bm_id=b.id and (a.name='"+temp+"' or  a.zhanghao='"+temp+"')";
                        r=Api.sb(sqlTemp);
                        if (r==null || r.length==0)  {
                            errorMessage+="\r\n  负责人 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在用户帐号中未定义,请先添加该帐号！";
                            error_num++;
                            continue;
                        }  
                        if (r.length>4)  {   //如果通过姓名找出的帐号多余一个
                            errorMessage+="\r\n  负责人 第 [ "+String.valueOf(i+1)+" ] 行中的 ["+temp+"] 在用户帐号有重名的记录,请通过帐号而不是姓名指定！";
                            error_num++;
                            continue;
                        }  
                        valueXsdb=r[0];
                        valueXsdb_mc=r[1];
                        valueBm=r[2];
                        valueBm_mc=r[3];
                } else {
                        valueXsdb=((String[])session.getAttribute("userInfo"))[0];
                        valueXsdb_mc=((String[])session.getAttribute("userInfo"))[2];
                        valueBm=((String[])session.getAttribute("userInfo"))[3];
                        valueBm_mc=Api.getValueName("000", valueBm);
                }

                //对该行的列都检查完了,可以预生成sql语句了

                if (!is_update)  { // 如果是插入模式

                        sql+="  exec getDJH  'xtgysbh', @djh output  ";   //取一个单据号
                        sql+="  insert into gys_da (id,gysbh,gysjc,gyslx,gsdz,lxr,bm,zw,lxdh,sj,msn,email,gscz,gswz,khh,gszh,sh,bz,ywy_id,ywy_mc,ywbm_id,ywbm_mc,lrr,lrrq,lrbm,enabled,autokeyword) values (";
                        sql+=" @djh,";                                          // id 就用单据号
                        sql+=" @djh,";                                        // gysbh 就用单据号
                        sql+="'"+valueMc+"',";                         // gysjc 
                        sql+="'"+valueLx+"',";                         // gyslx 
                        sql+="'"+ExcelService.getCellValue(sheet, i,2,"0").trim()+"',";                          // gsdz 地址         
                        sql+="'"+ExcelService.getCellValue(sheet, i,3,"0").trim()+"',";                         /// lxr联系人          
                        sql+="'"+ExcelService.getCellValue(sheet, i,4,"0").trim()+"',";                         /// bm部门             
                        sql+="'"+ExcelService.getCellValue(sheet, i,5,"0").trim()+"',";                         /// zw职务             
                        sql+="'"+ExcelService.getCellValue(sheet, i,6,"0").trim()+"',";                         /// lxdh联系电话    
                        sql+="'"+ExcelService.getCellValue(sheet, i,7,"0").trim()+"',";                         ///sj手机                
                        sql+="'"+ExcelService.getCellValue(sheet, i,8,"0").trim()+"',";                         /// msnMSN/QQ	
                        sql+="'"+ExcelService.getCellValue(sheet, i,9,"0").trim()+"',";                          //email邮箱        
                        sql+="'"+ExcelService.getCellValue(sheet, i,10,"0").trim()+"',";                          //gscz 公司传真 
                        sql+="'"+ExcelService.getCellValue(sheet, i,11,"0").trim()+"',";                          // gswz 公司网址
                        sql+="'"+ExcelService.getCellValue(sheet, i,12,"0").trim()+"',";                          //khh 开户银行   
                        sql+="'"+ExcelService.getCellValue(sheet, i,13,"0").trim()+"',";                          //gszh银行账号  
                        sql+="'"+ExcelService.getCellValue(sheet, i,14,"0").trim()+"',";                          //sh 税号            
                        sql+="'"+ExcelService.getCellValue(sheet, i,16,"0").trim()+"',";                           //bz 备注           
                        sql+="'"+valueXsdb+"',";                                                                                                // ywy_id负责人
                        sql+="'"+valueXsdb_mc+"',";                                                                                                // ywy_mc 负责人
                        sql+="'"+valueBm+"',";                                                                                                // ywbm_id负责人
                        sql+="'"+valueBm_mc+"',";                                                                                                // ywbm_mc负责人
                        sql+="'"+((String[])session.getAttribute("userInfo"))[0]+"',";                        // lrr 负责人
                        sql+="'"+Util.getDate()+"',";                                                                                     // lrrq
                        sql+="'"+((String[])session.getAttribute("userInfo"))[3]+"',";                         // lrbm
                        sql+="'1','')";                                                                                                               // enabled
                } else {
                        sql+=" update gys_da  set ";
                        sql+="gyslx='"+valueLx+"',";                         // gyslx 
                        sql+="gsdz='"+ExcelService.getCellValue(sheet, i,2,"0").trim()+"',";                         // gsdz 地址
                        sql+="lxr='"+ExcelService.getCellValue(sheet, i,3,"0").trim()+"',";                         // lxr联系人
                        sql+="bm='"+ExcelService.getCellValue(sheet, i,4,"0").trim()+"',";                         // bm部门
                        sql+="zw='"+ExcelService.getCellValue(sheet, i,5,"0").trim()+"',";                         // zw职务
                        sql+="lxdh='"+ExcelService.getCellValue(sheet, i,6,"0").trim()+"',";                         // lxdh联系电话
                        sql+="sj='"+ExcelService.getCellValue(sheet, i,7,"0").trim()+"',";                         //sj手机 
                        sql+="msn='"+ExcelService.getCellValue(sheet, i,8,"0").trim()+"',";                         // msnMSN/QQ	
                        sql+="email='"+ExcelService.getCellValue(sheet, i,9,"0").trim()+"',";                         //email邮箱
                        sql+="gscz='"+ExcelService.getCellValue(sheet, i,10,"0").trim()+"',";                         //gscz 公司传真
                        sql+="gswz='"+ExcelService.getCellValue(sheet, i,11,"0").trim()+"',";                         // gswz 公司网址
                        sql+="khh='"+ExcelService.getCellValue(sheet, i,12,"0").trim()+"',";                         //khh 开户银行
                        sql+="gszh='"+ExcelService.getCellValue(sheet, i,13,"0").trim()+"',";                         //gszh银行账号
                        sql+="sh='"+ExcelService.getCellValue(sheet, i,14,"0").trim()+"',";                         //sh 税号
                        sql+="bz='"+ExcelService.getCellValue(sheet, i,16,"0").trim()+"',";                          //bz 备注
                        sql+="ywy_mc='"+valueXsdb_mc+"',";                                                                              // ywy_mc 负责人
                        sql+="ywy_id='"+valueXsdb+"',";                                                                                        // ywy_id负责人
                        sql+="ywbm_id='"+valueBm+"'";                                                                                       // ywbm_id负责人
                        sql+=" where gysjc='"+valueMc+"'";                                                                                       //条件
                }

        }  //for

        //报出检查的问题
         if (error_num>0) 
                throw new LFException("\r\n工作表存在如下 "+String.valueOf(error_num)+" 个问题:<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+Util.getChangeLine(errorMessage)+"</div>");

     // 4、如果是更新方式，删除数据库中多余的记录，（没有被使用的）（加个删除选项，默认不删除）  
         if (importType.equals("update") && deleteDate.equals("delete"))   {
                //从数据库中找出所有的待删除记录
                sqlTemp="select id,gysjc from gys_da where '"+allMcString+"' not like '%,'+gysjc+ ',%'";
                r=Api.sb(sqlTemp);
                if (r!=null && r.length>0)  {   //存在需要删除的记录
                        for (int i=0;i<r.length;i+=2) {
                            if (Api.checkIftheDataIsUsed("gys_da",r[i])) {   //如果被使用了，则在处理完成后报出来
                                    failDeleteMessage+="<div style='width:100%;text-align:left;font-size:14px;font-weight:bold;font-family:\"宋体\"'>"+r[i+1]+"</div>";
                            } else {
                                     sql+=" delete from gys_da where id='"+r[i]+"'";                     //未被使用,则删除
                            }
                        }
               }  

         }
	
        //System.out.println(sql);
		Api.ub(sql);     //实际执行
		Api.XtRefreshAutoKeyWords("gys_da");
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
						供应商档案导入
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
                                        但有如下供应商由于已经被某张单据使用,不能删除:
                                        <%=failDeleteMessage%>
                                     <%}%>
                                        <div align="center" width="100%" style="padding-top:10px;width:100%;"><img src="/emadmin/images/c2/button/bill_ok.gif" onMouseOver="this.style.cursor='hand'"   onclick='javascript:location.href="/emadmin/jsp/common/list.jsp?modul_id=gys_da_listModul"'/> </div>
							</td>
						  </tr>
						</table>
				</form>													
							 
											
			<!-- 内容区 -->

</body>
</html>

