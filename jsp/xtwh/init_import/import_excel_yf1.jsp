<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/emadmin/shared/checkAdminPermission.jsp"%>
<%@page import="com.lf.lfbase.service.*,java.io.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.* ,java.net.*,com.lf.util.*,java.text.*"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
		Map req=ExcelService.initUpload(request);
		FileItem myfile = (FileItem)req.get("myfile");
		if (myfile.getName().indexOf("xls")<0)
			throw new Exception("上传的文件不是EXCEL文件!");
		
		if( myfile.getSize() > 0 ) {     
			InputStream uploadedStream = myfile.getInputStream(); 
			POIFSFileSystem fs      =             new POIFSFileSystem(uploadedStream);	
			HSSFWorkbook wb = new HSSFWorkbook(fs);
			
			//检查表单 的数量
			if (wb.getNumberOfSheets()!= 1)
				throw new Exception("模板的工作表数量应该是1个,请检查是否使用了正确的模板!");
			
			
			
			
			
			HSSFSheet sheetYf = wb.getSheetAt(0); //应付信息
			
			
			String sheetTitle;
			
			
			
				
			sheetTitle = ExcelService.getSheetValueNoSpace(sheetYf, 0, 0).trim();
			if (!sheetTitle.equalsIgnoreCase("采购应付款信息"))
				throw new Exception("模板的第二个工作表应该是采购应付款信息,请检查是否使用了正确的模板!");
			
			
			String tmp;
			
			//检查------开始-----------
			String ret = "\r\n";
			
			String errMessage = "";
			
			
			//检查应付信息 
			//0 单据日期 *	1 供应商 *	2 无税金额 *	3税额 *	4价税合计	5付款期限 *	6采购类型	7付款类型	8结算方式	9是否开票	
			//10业务员	摘要

			int yfRows = sheetYf.getLastRowNum()+1;
			for (int i=8;i<yfRows;i++)
			{

				tmp = ExcelService.getSheetValueNoSpace(sheetYf, i, 0); //单据日期
				if (Util.isBlankString(tmp))
				{
					if (Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetYf, i, 1)) && Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetYf, i, 2))) {
						yfRows = i;
						break;
					} else {
						errMessage += " 采购应付款信息的第 "+Integer.toString(i+1)+" 行的单据日期不允许为空"+ ";<br> \r\n";
					}
				}
				
				if (!Util.checkDateFormat(tmp) )
					errMessage += " 采购应付款信息的第 "+Integer.toString(i+1)+" 行的单据日期格式不正确,格式为 2008-01-01 "+ ";<br> \r\n";

				tmp = ExcelService.getSheetValueNoSpace(sheetYf, i, 1); //客户
				if (Util.isBlankString(tmp))
					errMessage += " 采购应付款信息的第 "+Integer.toString(i+1)+" 行的供应商不允许为空"+ ";<br> \r\n";

				if (Util.isBlankString(Api.getCodeByOptionSourceIdAndName("253", tmp)))
					errMessage += " 采购应付款信息的第 "+Integer.toString(i+1)+" 行的供应商在供应商定义中不正确，请检查是供应商简称录入不正确,还是未在供应商信息中定义"+ ";<br> \r\n";

				tmp = ExcelService.getSheetValueNoSpace(sheetYf, i, 2); //无税金额
				if (Util.isBlankString(tmp))
					errMessage += " 采购应付款信息的第 "+Integer.toString(i+1)+" 行的无税金额不允许为空"+ ";<br> \r\n";

				tmp = ExcelService.getSheetValueNoSpace(sheetYf, i, 3); //税额
				if (Util.isBlankString(tmp))
					errMessage += " 采购应付款信息的第 "+Integer.toString(i+1)+" 行的税额不允许为空"+ ";<br> \r\n";

				tmp = ExcelService.getSheetValueNoSpace(sheetYf, i, 5); //5付款期限
				if (Util.isBlankString(tmp))
					errMessage += " 采购应付款信息的第 "+Integer.toString(i+1)+" 行的付款期限不允许为空"+ ";<br> \r\n";

				if (!Util.checkDateFormat(tmp) )
					errMessage += " 采购应付款信息的第 "+Integer.toString(i+1)+" 行的付款期限格式不正确,格式为 2008-01-01 "+ ";<br> \r\n";
				
				
			}
			
			if (!Util.isBlankString(errMessage))
				throw new Exception (errMessage);
			
			//检查------结束-----------
			
			
			// 导入 -----开始-------------------------
			String importSql = "";
			
			
			

//////////

			//应付信息信息 导入
			importSql += "delete sf_yfd " + ret;

			//0 单据日期 *	1 供应商 *	2 无税金额 *	3税额 *	4价税合计	5付款期限 *	6采购类型	7付款类型	8结算方式	9是否开票	
			//10业务员	摘要
			GB2Alpha gb2alpha = new GB2Alpha();
			
			for (int i=8;i<yfRows;i++)
			{	
				String id = Util.getSequence();
	
				String gys_id = ExcelService.getSheetValueNoSpace(sheetYf, i, 1);//供应商id
				gys_id = Api.getCodeByOptionSourceIdAndName("253", gys_id);

				String wsje =  new DecimalFormat("#.#########").format(ExcelService.getSheetDoubleValue(sheetYf, i, 2) ); //2 无税金额

				String se =  new DecimalFormat("#.#########").format(ExcelService.getSheetDoubleValue(sheetYf, i, 3) ); //3 税额

				String jshj =  new DecimalFormat("#.#########").format(ExcelService.getSheetDoubleValue(sheetYf, i, 4) ); //4价税合计


				String cglx = ExcelService.getSheetValueNoSpace(sheetYf, i, 6);//6采购类型
				if (Util.isBlankString(cglx))
				{
					cglx = "商品采购";
				}
				cglx = Api.getCodeByOptionSourceIdAndName("250", cglx);


				String fklx = ExcelService.getSheetValueNoSpace(sheetYf, i, 7);//7付款类型
				if(Util.isBlankString(fklx))
				{
					fklx = "货到付款";
				}

				fklx = Api.getCodeByOptionSourceIdAndName("921", fklx);


				String jsfs = ExcelService.getSheetValueNoSpace(sheetYf, i,8);// 8	结算方式
				jsfs = Api.getCodeByOptionSourceIdAndName("915", jsfs);

				String sfkp = ExcelService.getSheetValueNoSpace(sheetYf, i, 9);//9	是否开票
				sfkp = Api.getCodeByOptionSourceIdAndName("010", sfkp);

				String ywbm_mc="",ywbm_id="",ywy_id="",ywy_mc="";
				tmp = ExcelService.getSheetValueNoSpace(sheetYf, i, 10); //10	业务员
				ywy_id = ExcelService.getYhIdByZhangHaoOrName(tmp);
				if (!Util.isBlankString(ywy_id))
				{
					String sql = "select a.name,b.id bm_id,b.name bmmc " +
							" from xt_yh a,xt_bm b where a.bm_id = b.id and a.id = '"+ ywy_id+"'";
					String res[] = Api.sb(sql);
					
					if (res!=null && res.length>1)
					{
						ywy_mc = res[0];
						ywbm_id = res[1];
						ywbm_mc = res[2];
					}
				}

				String yfdh = Api.getXtLsh( "11690308500020771");


				//0 单据日期 *	1 供应商 *	2 无税金额 *	3税额 *	4价税合计	5付款期限 *	6采购类型	7付款类型	8结算方式	9是否开票	
				//10业务员	11 摘要


				//djrq,          gys_id,    wsje,            se,        jshj,    fkqx,         cglx,       fklx,        jsfs,    sfkp,
				//           zy, yfdh,

//    
				importSql += "insert sf_yfd (id,djrq,          gys_id,    wsje,            se,        jshj,    fkqx,         cglx,       fklx,        jsfs,    sfkp,  " +
						" zy, yfdh, ywbm_mc,ywbm_id,ywy_id,ywy_mc,autokeyword,shzt ,shr,shrq,lrr,lrrq )" +

				"values('"+ id 				
				+"','"+ExcelService.getSheetValueNoSpace(sheetYf, i, 0) //0 单据日期
				+"','"+gys_id
				+"','"+wsje
				+"','"+se 
				+"','"+jshj
				+"','"+ExcelService.getSheetValueNoSpace(sheetYf, i, 5) //5付款期限
				+"','"+cglx
				+"','"+fklx
				+"','"+jsfs
				+"','"+sfkp
				+"','"+ExcelService.getSheetValueNoSpace(sheetYf, i, 11) //11	摘要
				+"','"+yfdh
				+"','"+ywbm_mc+"','"+ywbm_id+"','"+ywy_id+"','"+ywy_mc
				+"','"
				+gb2alpha.String2Alpha(ExcelService.getSheetValueNoSpace(sheetYf, i, 1) ) 
				+"','1','admin','"+ Util.getDate() +"','admin','"+ Util.getDate() +"')" +ret;
			}
			
			if (Util.isBlankString(importSql))
				throw new Exception ("没有可以导入的数据！");


			importSql += "update sf_yfd set gys = gys_da.gysqc ,gysbh = gys_da.gysbh from gys_da where sf_yfd.gys_id = gys_da.id	 " + ret;
			
			Api.ub(importSql);
			// 导入 -----结束-------------------------
			Api.reloadAllOption();

		}
	
			response.sendRedirect("/emadmin/shared/message.jsp?back=/emadmin/init.jsp&message="+URLEncoder.encode("采购应付款信息已导入成功 ！","UTF-8")); 
%>
