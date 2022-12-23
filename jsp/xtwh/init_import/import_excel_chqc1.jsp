<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/emadmin/shared/checkAdminPermission.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.io.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.* ,java.net.*,com.lf.util.*,java.text.*"%>
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
			if (wb.getNumberOfSheets()< 1)
				throw new Exception("模板没有工作表,请检查是否使用了正确的模板!");
			
			HSSFSheet sheetQc = wb.getSheetAt(0); //仓库
			String sheetTitle;

			//检查标题
			sheetTitle = ExcelService.getSheetValueNoSpace(sheetQc, 0, 0).trim();
			if (!sheetTitle.equalsIgnoreCase("库存期初信息"))
				throw new Exception("模板的第一个工作表应该是库存期初,请检查是否使用了正确的模板!");
		
			String tmp;
			
			//检查------开始-----------
			String ret = "\r\n";
			
			String errMessage = "";
			//库存期初检查
			//0 仓库名称 * 1 产品编码 	2 产品名称 *	3 规格型号 * 4 计价单位 * 5 结存数量 * 6 结存单价	7 结存金额	8 批次	9 生产日期	10 失效日期
			int qcRows = sheetQc.getLastRowNum()+1;
			SLfHashMap  allCk = new SLfHashMap ();	//仓库
			String ckStr = "''";
			for (int i=10;i<qcRows;i++)
			{
				tmp = ExcelService.getSheetValueNoSpace(sheetQc, i, 0); //仓库名称
				
				if (Util.isBlankString(tmp))
				{
					if (Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetQc, i, 1)) && Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetQc, i, 2))) {
						qcRows = i;
						break;   //这里有问题，有一个空行就断了
					} else {
						errMessage += " 库存期初的第 "+Integer.toString(i+1)+" 行的仓库名称为空,请输入正确的仓库"+ ";<br> \r\n";
					}
				}
				
				String ck_id = Api.getCodeByOptionSourceIdAndName("242", tmp);

				if (Util.isBlankString(ck_id))
					errMessage += " 库存期初的第 "+Integer.toString(i+1)+" 行的仓库名称在仓库定义中不存在,请检查是输入了错误,还是缺少定义"+ ";<br> \r\n";

				if (!allCk.containsKey(ck_id))
				{
					ckStr += ",'"+ ck_id +"'";
					allCk.put(ck_id, ck_id);
				}

				String chbm = ExcelService.getSheetValueNoSpace(sheetQc, i, 1); //产品编码
				if (Util.isBlankString(chbm))
					errMessage += " 库存期初的第 "+Integer.toString(i+1)+" 行的产品编码不允许为空"+ ";<br> \r\n";

				
				String chmc = ExcelService.getSheetValueNoSpace(sheetQc, i, 2); //产品名称
				if (Util.isBlankString(chmc))
					errMessage += " 库存期初的第 "+Integer.toString(i+1)+" 行的产品名称不允许为空"+ ";<br> \r\n";

				String ggxh = ExcelService.getSheetValueNoSpace(sheetQc, i, 3); //规格型号
				if (Util.isBlankString(ggxh))
					errMessage += " 库存期初的第 "+Integer.toString(i+1)+" 行的规格型号不允许为空"+ ";<br> \r\n";

				String jldw = ExcelService.getSheetValueNoSpace(sheetQc, i, 4); //计价单位
				if (Util.isBlankString(jldw))
					errMessage += " 库存期初的第 "+Integer.toString(i+1)+" 行的计价单位不允许为空"+ ";<br> \r\n";

				//检查 产品名称 规格型号 计价单位
				String sql= "select top 1 xt_cpfz_sfpcgl,xt_cpfz_sfbzqgl from jc_chda where chmc = '"+ chmc +"' and ggxh = '"+ ggxh +"' and chbm = '"+ chbm +"'";
				String res[] = Api.sb(sql);

				String jcsl = ExcelService.getSheetValueNoSpace(sheetQc, i, 5); //结存数量
				if (Util.isBlankString(jcsl))
					errMessage += " 库存期初的第 "+Integer.toString(i+1)+" 行的结存数量不允许为空"+ ";<br> \r\n";

				
				if (!Util.checkFloat(jcsl))				
					errMessage += " 库存期初的第 "+Integer.toString(i+1)+" 行的结存数量不是数字!"+ ";<br> \r\n";
				
				
				String jcdj =  new DecimalFormat("#.#########").format(ExcelService.getSheetDoubleValue(sheetQc, i, 6));
				if (!Util.checkFloat(jcdj))				
					errMessage += " 库存期初的第 "+Integer.toString(i+1)+" 行的结存单价不是数字!"+ ";<br> \r\n";
				
				String jcje = new DecimalFormat("#.#########").format(ExcelService.getSheetDoubleValue(sheetQc, i, 7));
				if (!Util.checkFloat(jcje))				
					errMessage += " 库存期初的第 "+Integer.toString(i+1)+" 行的结存金额不是数字!"+ ";<br> \r\n";

				
				if (res==null || res.length <1)
				{
					errMessage += " 库存期初的第 "+Integer.toString(i+1)+" 行的产品编码 产品名称 规格型号 在产品目录中定义中不存在,请检查是输入错误,还是缺少定义"+ ";<br> \r\n";
					continue;
				}
				


				String xt_cpfz_sfpcgl = res[0];
				String xt_cpfz_sfbzqgl = res[1];



				if (!xt_cpfz_sfpcgl.equalsIgnoreCase("0")) //批次管理
				{
					String pc = ExcelService.getSheetValueNoSpace(sheetQc, i, 8); //批次
					if (Util.isBlankString(pc))
						errMessage += " 库存期初的第 "+Integer.toString(i+1)+" 行的产品的批次不允许为空"+ ";<br> \r\n";

				}

				if (!xt_cpfz_sfbzqgl.equalsIgnoreCase("0")) //有效期管理
				{
					String scrq = ExcelService.getSheetValueNoSpace(sheetQc, i, 9); //生产日期
					if (Util.isBlankString(scrq))
					{
						errMessage += " 库存期初的第 "+Integer.toString(i+1)+" 行的产品的生产日期不允许为空"+ ";<br> \r\n";
					}						
					else  if (!Util.checkDateFormat(scrq))
					{
						errMessage += " 库存期初的第 "+Integer.toString(i+1)+" 行的产品的生产日期格式不正确,其格式为 2008-01-01 "+ ";<br> \r\n";
					}

					String sxrq = ExcelService.getSheetValueNoSpace(sheetQc, i, 10); //失效日期
					if (Util.isBlankString(sxrq))
						errMessage += " 库存期初的第 "+Integer.toString(i+1)+" 行的产品的失效日期不允许为空"+ ";<br> \r\n";
					else if (!Util.checkDateFormat(sxrq))
					{
						errMessage += " 库存期初的第 "+Integer.toString(i+1)+" 行的产品的失效日期格式不正确,其格式为 2008-01-01 "+ ";<br> \r\n";
					}
				}
				
				
				

				
			}
			
			if (!Util.isBlankString(errMessage))
				throw new Exception (errMessage);
			//检查------结束-----------
			
			
			// 导入 -----开始-------------------------
			String importSql = "";
			//库存期初
			//0 仓库名称 *	1产品名称 *	2规格型号 * 3 计价单位 * 4 结存数量 * 5 结存单价 6 结存金额 7批次 8 生产日期 9 失效日期
			//yj2007-10-011181715682312000911824044169400185070913	405	月结转	半成品库A	11817156823120009	33010002	祛风舒筋丸药粉	kg	kg	.0000	.0000	.00	.0000	.0000	.00	225.0000	24.1739	5439.13	11824044169400185	01181715682312000911824044169400185070913	070913	2007-09-15	2007-11-12	60	产品批号：070913;生产日期：2007-09-15;失效日期：2007-11-12	1	1			0	0	,0FSJWYF药粉,YF,3301是,S,1是,S,1领用,外购,LY0WG,,002,003,先进先出法,XJXCF,002仓储课,CCK,100001004002张秀梅,ZXM,11817250703280393启用,QY,1,BCPKA仓储课,CCK,100001004002张秀梅,ZXM,,11817250703280393,正常使用,ZCSY,1启用,QY,1					0	3301
			//select top 1 id,ywlx,djlx,ckmc,ck_id,jcsl,jcdj,jcje,ch_id,rls,
			//xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,autokeyword from kc_kcspz where djrq = '2007-10-01' and id like 'yj%'
			importSql += "delete kc_kcspz where ck_id in ("+ckStr +") " + ret;	
			
			Api.ub(importSql);
			
			GB2Alpha gb2alpha = new GB2Alpha();
			for (int i=10;i<qcRows;i++)
			{	
				String id = "yj"+Util.getSequence();
				
				String ck_mc = ExcelService.getSheetValueNoSpace(sheetQc, i, 0);
				String ck_id = Api.getCodeByOptionSourceIdAndName("242", ck_mc);
				
				String chbm = ExcelService.getSheetValueNoSpace(sheetQc, i, 1); //产品编码
				String chmc = ExcelService.getSheetValueNoSpace(sheetQc, i, 2); 
				
				String sql= "select top 1 id from jc_chda where chbm = '"+ chbm + "' ";
				String ch_id = Api.sb(sql)[0];
				
				String jcsl =  new DecimalFormat("#.#########").format( ExcelService.getSheetDoubleValue(sheetQc, i, 5) ); 
						
				String jcdj =  new DecimalFormat("#.#########").format(ExcelService.getSheetDoubleValue(sheetQc, i, 6));
				String jcje =  new DecimalFormat("#.#########").format(ExcelService.getSheetDoubleValue(sheetQc, i, 7));
				
				String xt_cpfz_pc = ExcelService.getSheetValueNoSpace(sheetQc, i, 8);
				String rls = "0" + ck_id+ch_id+xt_cpfz_pc;
				
				String xgsx="";
				if (!Util.isBlankString(xt_cpfz_pc)) {
					xgsx+="批次："+xt_cpfz_pc;
				}
				if (!Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetQc, i, 9))) {  //scrp
					xgsx+=" 生产日期："+ExcelService.getSheetValueNoSpace(sheetQc, i, 9);
				}
				if (!Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetQc, i, 10))) {  //scrp
					xgsx+=" 失效日期："+ExcelService.getSheetValueNoSpace(sheetQc, i, 10);
				}
				
				

				importSql = "insert kc_kcspz (id,djrq,ywlx,djlx,ckmc,ck_id,jcsl,jcdj,jcje,ch_id,rls,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_xgsx,autokeyword )" +
				"values('"+ id 
				+"','" + Util.getDate()  //djrq
				+"','405','期初','"+ ck_mc +"','"+ ck_id +"','"+jcsl
				+"','"+jcdj+"','"+jcje+"','"+ch_id+"','"+rls+"','"+xt_cpfz_pc
				+"','"+ExcelService.getSheetValueNoSpace(sheetQc, i, 9) //scrq
				+"','"+ExcelService.getSheetValueNoSpace(sheetQc, i, 10) //sxrq
				+"','"+xgsx+"','"
				+gb2alpha.String2Alpha(ck_mc+chmc ) +"')" +ret;
				System.out.println(importSql);
				System.out.println(i);
				try{
					Api.ub(importSql);	
				}
				catch(Exception e)
				{
					e.printStackTrace();
					errMessage += " 库存期初的第 "+Integer.toString(i+1)+" 行执行出错误! "+ ";<br> \r\n";
					throw new Exception (errMessage);
				}
				
			}
			
			
			importSql = "update kc_kcspz set kc_kcspz.chbm = jc_chda.chbm,kc_kcspz.chmc = jc_chda.chmc,kc_kcspz.ggxh = jc_chda.ggxh," +
					"  kc_kcspz.dw = jc_chda.jldw  from jc_chda where kc_kcspz.ch_id = jc_chda.id";
			
			Api.ub(importSql);
			
			// 导入 -----结束-------------------------
			Api.reloadAllOption();

		}
		
        response.sendRedirect("/emadmin/shared/message.jsp?back=/emadmin/init.jsp&message="+URLEncoder.encode("库存期初信息已导入成功 ！","UTF-8"));
%>
