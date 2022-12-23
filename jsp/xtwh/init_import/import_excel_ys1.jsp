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
			
			
			HSSFSheet sheetYs = wb.getSheetAt(0); //应收信息
			
			
			String sheetTitle;
			
			
			//检查标题
			sheetTitle = ExcelService.getSheetValueNoSpace(sheetYs, 0, 0).trim();
			if (!sheetTitle.equalsIgnoreCase("销售应收款信息"))
				throw new Exception("模板的第一个工作表应该是应收信息,请检查是否使用了正确的模板!");
				
			
			
			String tmp;
			
			//检查------开始-----------
			String ret = "\r\n";
			
			String errMessage = "";
			//应收信息检查
			int ysRows = sheetYs.getLastRowNum()+1;

			//0 单据日期 *	1 客户 * 2 无税金额 * 3 税额 *	4价税合计	5收款期限 *	6销售类型	7收款类型 8	结算方式
			//9	是否开票 10	业务员 11	摘要

			for (int i=8;i<ysRows;i++)
			{
				tmp = ExcelService.getSheetValueNoSpace(sheetYs, i, 0); //单据日期
				
				if (Util.isBlankString(tmp))
				{
					if (Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetYs, i, 1)) && Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetYs, i, 2))) {
						ysRows = i;
						break;
					} else {
						errMessage += " 销售应收款信息的第 "+Integer.toString(i+1)+" 行的单据日期不允许为空"+ ";<br> \r\n";
					}
				}
				
				if (!Util.checkDateFormat(tmp) )
					errMessage += " 销售应收款信息的第 "+Integer.toString(i+1)+" 行的单据日期格式不正确,格式为 2008-01-01 "+ ";<br> \r\n";



				tmp = ExcelService.getSheetValueNoSpace(sheetYs, i, 1); //客户
				if (Util.isBlankString(tmp))
					errMessage += " 销售应收款信息的第 "+Integer.toString(i+1)+" 行的客户不允许为空"+ ";<br> \r\n";

				if (Util.isBlankString(Api.getCodeByOptionSourceIdAndName("252", tmp)))
					errMessage += " 销售应收款信息的第 "+Integer.toString(i+1)+" 行的客户在客户定义中不正确，请检查是客户简称录入不正确,还是未在客户信息中定义"+ ";<br> \r\n";

				tmp = ExcelService.getSheetValueNoSpace(sheetYs, i, 2); //无税金额
				if (Util.isBlankString(tmp))
					errMessage += " 销售应收款信息的第 "+Integer.toString(i+1)+" 行的无税金额不允许为空"+ ";<br> \r\n";

				tmp = ExcelService.getSheetValueNoSpace(sheetYs, i, 3); //税额
				if (Util.isBlankString(tmp))
					errMessage += " 销售应收款信息的第 "+Integer.toString(i+1)+" 行的税额不允许为空"+ ";<br> \r\n";

				tmp = ExcelService.getSheetValueNoSpace(sheetYs, i, 5); //5收款期限
				if (Util.isBlankString(tmp))
					errMessage += " 销售应收款信息的第 "+Integer.toString(i+1)+" 行的收款期限不允许为空"+ ";<br> \r\n";

				if (!Util.checkDateFormat(tmp) )
					errMessage += " 销售应收款信息的第 "+Integer.toString(i+1)+" 行的收款期限格式不正确,格式为 2008-01-01 "+ ";<br> \r\n";
			}

			
			
			if (!Util.isBlankString(errMessage))
				throw new Exception (errMessage);
			
			//检查------结束-----------
			
			
			// 导入 -----开始-------------------------
			String importSql = "";
			
			//应收信息信息 导入
			importSql += "delete sf_ysd " + ret;

			GB2Alpha gb2alpha = new GB2Alpha();
			for (int i=8;i<ysRows;i++)
			{	
				String id = Util.getSequence();
	
				String kh_id = ExcelService.getSheetValueNoSpace(sheetYs, i, 1);//客户id
				kh_id = Api.getCodeByOptionSourceIdAndName("252", kh_id);

				String wsje =  new DecimalFormat("#.#########").format(ExcelService.getSheetDoubleValue(sheetYs, i, 2) ); //2 无税金额

				String se =  new DecimalFormat("#.#########").format(ExcelService.getSheetDoubleValue(sheetYs, i, 3) ); //3 税额

				String jshj =  new DecimalFormat("#.#########").format(ExcelService.getSheetDoubleValue(sheetYs, i, 4) ); //4价税合计


				String xslx = ExcelService.getSheetValueNoSpace(sheetYs, i, 6);//6销售类型
				if (Util.isBlankString(xslx))
				{
					xslx = "普通销售";
				}
				xslx = Api.getCodeByOptionSourceIdAndName("243", xslx);


				String sklx = ExcelService.getSheetValueNoSpace(sheetYs, i, 7);//7收款类型
				if(Util.isBlankString(sklx))
				{
					sklx = "款到发货";
				}

				sklx = Api.getCodeByOptionSourceIdAndName("920", sklx);


				String jsfs = ExcelService.getSheetValueNoSpace(sheetYs, i,8);// 8	结算方式
				jsfs = Api.getCodeByOptionSourceIdAndName("915", jsfs);

				String sfkp = ExcelService.getSheetValueNoSpace(sheetYs, i, 9);//9	是否开票
				sfkp = Api.getCodeByOptionSourceIdAndName("010", sfkp);

				String ywbm_mc="",ywbm_id="",ywy_id="",ywy_mc="";
				tmp = ExcelService.getSheetValueNoSpace(sheetYs, i, 10); //10	业务员
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

				String ysdh = Api.getXtLsh( "11690308058880767");

			//0 单据日期 *	1 客户 * 2 无税金额 * 3 税额 *	4价税合计	5收款期限 *	6销售类型	7收款类型 8	结算方式
			//9	是否开票 10	业务员 11	摘要

			//djrq,        kh_id,     wsje,        se,        jshj,     skqx,        xslx,          sklx,  jsfs,  
			// sfkp,                zy,  ysdh,

				importSql += "insert sf_ysd (id,djrq,        kh_id,     wsje,        se,        jshj,     skqx,        xslx,          sklx,  jsfs,  " +
						" sfkp,                zy,  ysdh, ywbm_mc,ywbm_id,ywy_id,ywy_mc,autokeyword,shzt ,shr,shrq,lrr,lrrq )" +

				"values('"+ id 				
				+"','"+ExcelService.getSheetValueNoSpace(sheetYs, i, 0) //0 单据日期
				+"','"+kh_id
				+"','"+wsje
				+"','"+se 
				+"','"+jshj
				+"','"+ExcelService.getSheetValueNoSpace(sheetYs, i, 5) //5收款期限
				+"','"+xslx
				+"','"+sklx
				+"','"+jsfs
				+"','"+sfkp
				+"','"+ExcelService.getSheetValueNoSpace(sheetYs, i, 11) //11	摘要
				+"','"+ysdh
				+"','"+ywbm_mc+"','"+ywbm_id+"','"+ywy_id+"','"+ywy_mc
				+"','"
				+gb2alpha.String2Alpha(ExcelService.getSheetValueNoSpace(sheetYs, i, 1) ) 
				+"','1','admin','"+ Util.getDate() +"','admin','"+ Util.getDate() +"')" +ret;
			}
			
			if (Util.isBlankString(importSql))
				throw new Exception ("没有可以导入的数据！");

			importSql += "update sf_ysd set kh = kh_da.khqc ,khbh = kh_da.khbh from kh_da where sf_ysd.kh_id = kh_da.id	 " + ret;



			Api.ub(importSql);
			// 导入 -----结束-------------------------
			Api.reloadAllOption();

		}
			response.sendRedirect("/emadmin/shared/message.jsp?back=/emadmin/init.jsp&message="+URLEncoder.encode("销售应收款信息已导入成功 ！","UTF-8")); 
%>
