<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/emadmin/shared/checkAdminPermission.jsp"%>
<%@page import="java.sql.*,com.lf.util.*,com.lf.lfbase.service.*,java.io.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,java.net.* "%>
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
			
			
			
			
			HSSFSheet sheetCk = wb.getSheetAt(0); //仓库
			
			String sheetTitle;
			
			
			//检查标题
			sheetTitle = ExcelService.getSheetValueNoSpace(sheetCk, 0, 0).trim();
			if (!sheetTitle.equalsIgnoreCase("仓库信息"))
				throw new Exception("模板的第一个工作表应该是仓库信息,请检查是否使用了正确的模板!");
				
			
			String tmp;
			
			//检查------开始-----------
			String ret = "\r\n";
			
			String errMessage = "";
			//仓库信息检查
			//仓库名称 *	所属部门 *	库管	负责人	地址	联系电话	备注	序号
			int ckRows = sheetCk.getLastRowNum()+1;
			for (int i=8;i<ckRows;i++)
			{
				tmp = ExcelService.getSheetValueNoSpace(sheetCk, i, 0); //仓库名称
				
				if (Util.isBlankString(tmp))
				{
					if (Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetCk, i, 1)) && Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetCk, i, 2))) {
						ckRows = i;
						break;
					} else {
						errMessage += " 仓库信息的第 "+Integer.toString(i+1)+" 行的仓库名称不允许为空"+ ";<br> \r\n";
					}
				}
				
				tmp = ExcelService.getSheetValueNoSpace(sheetCk, i, 1); //所属部门
				if (Util.isBlankString(tmp))
					errMessage += " 仓库信息的第 "+Integer.toString(i+1)+" 行的所属部门不允许为空"+ ";<br> \r\n";

				tmp = ExcelService.getBmIdByBmName(tmp);
				if (Util.isBlankString(tmp))
					errMessage += " 仓库信息的第 "+Integer.toString(i+1)+" 行的所属部门在部门定义中不存在,请检查是否输入了错误的部门名称,还是未在部门信息中定义"+ ";<br> \r\n";
			}
			
			if (!Util.isBlankString(errMessage))
				throw new Exception (errMessage);
			//检查------结束-----------
			
			
			// 导入 -----开始-------------------------
			String importSql = "";
			//仓库信息检查
			//仓库名称 *	所属部门 *	库管	负责人	地址	联系电话	备注	序号
			//select id,ckmc,ssbm,kg,fzr,dz,lxdh,bz,row_index,zt,enabled,autokeyword from jc_cksz

			//复员仓库编号
			String fy_sql = "update xt_bill_no set lsh = '0',start_date = '' where  id = 'xtckbh'" + ret;
			Api.ub(fy_sql);

			
			importSql += "delete jc_cksz " + ret;			
		
			
			GB2Alpha gb2alpha = new GB2Alpha();
			for (int i=8;i<ckRows;i++)
			{	
				String id = Util.getSequence();
				tmp = ExcelService.getSheetValueNoSpace(sheetCk, i, 1);//部门名称
				String ssbm = ExcelService.getBmIdByBmName(tmp);
				
				tmp = ExcelService.getSheetValueNoSpace(sheetCk, i, 2);//库管
				String kg = ExcelService.getYhIdByZhangHaoOrName(tmp);
				
				
				String row_index =	Integer.toString(ExcelService.getSheetNumValue(sheetCk, i, 7) );
				
				String ckbm = Api.getXtLsh( "xtckbh");

				importSql += "insert jc_cksz (id,ckbm,ckmc,ssbm,kg,fzr,dz,lxdh,bz,row_index,zt,enabled,autokeyword )" +
				"values('"+ id 
				+"','"+ckbm +"','"+ExcelService.getSheetValueNoSpace(sheetCk, i, 0) 
				+"','"+ ssbm +"','"+ kg 
				+"','"+ExcelService.getSheetValueNoSpace(sheetCk, i, 3)
				+"','"+ExcelService.getSheetValueNoSpace(sheetCk, i, 4)
				+"','"+ExcelService.getSheetValueNoSpace(sheetCk, i, 5)
				+"','"+ExcelService.getSheetValueNoSpace(sheetCk, i, 6)
				+"','"+ row_index+"','1','1','"
				+gb2alpha.String2Alpha(ExcelService.getSheetValueNoSpace(sheetCk, i, 0) ) +"')" +ret;
			}
			
			if (Util.isBlankString(importSql))
				throw new Exception ("没有可以导入的数据！");

			
			//删除前期导入的
			
			//3  存货
				importSql += "delete xt_option_code where enabled = '1' and group_name='产品类型' and ischild ='1' " + ret;
				importSql += "delete  jc_chda  " + ret;
				importSql += "delete  jc_ckchdz " + ret;
			
			//4 期初
				importSql += "delete kc_kcspz " + ret;			
			
			
		
			
			Api.ub(importSql);
			// 导入 -----结束-------------------------
			Api.reloadAllOption();

		}
			response.sendRedirect("/emadmin/shared/message.jsp?back=/emadmin/init.jsp&message="+URLEncoder.encode("仓库设置信息已导入成功 ！","UTF-8"));
%>
