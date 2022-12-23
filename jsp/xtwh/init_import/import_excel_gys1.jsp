<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/emadmin/shared/checkAdminPermission.jsp"%>
<%@page import="com.lf.lfbase.common.*,java.sql.*,com.lf.lfbase.service.*,java.io.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,java.net.*,com.lf.util.*,java.text.*"%>
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
			if (wb.getNumberOfSheets()!= 2) 
				throw new Exception("模板的工作表数量应该是2个,请检查是否使用了正确的模板!");
			
			HSSFSheet sheetFl = wb.getSheetAt(0); //客户类型


			HSSFSheet sheetGys = wb.getSheetAt(1); //仓库
			String sheetTitle;

			sheetTitle = ExcelService.getSheetValueNoSpace(sheetFl, 0, 0).trim();
			if (!sheetTitle.equalsIgnoreCase("供应商分类"))
				throw new Exception("模板的第一个工作表应该是供应商分类,请检查是否使用了正确的模板!");


			//检查标题
			sheetTitle = ExcelService.getSheetValueNoSpace(sheetGys, 0, 0).trim();
			if (!sheetTitle.equalsIgnoreCase("供应商档案信息"))
				throw new Exception("模板的第二个工作表应该是供应商档案信息,请检查是否使用了正确的模板!");
		
			String tmp;
			
			//检查------开始-----------
			String ret = "\r\n";
			
			String errMessage = "";

			//供应商分类信息检查
			int gysflRows = sheetFl.getLastRowNum()+1;
			String currentgysflCode = "23500";
			String gysflMc;
			
			SLfHashMap  allGysfl = new SLfHashMap ();	//所有的供应商分类		
			String flStr=""; //客户分类名称的字符串，不带空格
			String flS[];  //客户分类名称的数组
			
			for (int i=6;i<gysflRows;i++)
			{
				gysflMc = ExcelService.getSheetValueNoSpace(sheetFl, i, 0); //供应商分类名称
				
				if (Util.isBlankString(gysflMc))
				{
					gysflRows = i;
					break;
				}
				flStr+=gysflMc.trim()+",";
				

				if(i==6)
				{
					currentgysflCode = currentgysflCode + "1";
				}
				else
				{
					currentgysflCode =Integer.toString (Util.intValue(currentgysflCode)+1);
				}


				

				//所有的供应商分类
				allGysfl.put(gysflMc.trim(), currentgysflCode);

			}
			//开始检查重复
			flS = Util.segmentString(flStr, ","); //从字符串变成数组
			int k=Util.checkDuplicateElement(flS);
			if (k>=0)
				errMessage += " 供应商分类信息中存在重复的名称: “"+flS[k]+"” 。供应商分类不允许重复，请修改正确"+ ";<br> \r\n";

			if (gysflRows == 6)
			{
				errMessage += " 你没有建立供应商分类，供应商分类信息必须创建！"+ ";<br> \r\n";
			}





			//供应商信息检查
			//	1 供应商简称 *	2  供应商全称 *	3 供应商类型	4公司地址	5联系电话	6邮政编码	7公司传真	8电子邮件	
			//9 公司网址	10 信用等级	11 开户行 12	公司帐号 13	税号 14 法定代表人	15 营业执照号码	16 注册资本 17	注册登记日期	
			//18 主营业务	19 结算类型	20 建立日期	 21 ABC分类  22	业务员


			int gysRows = sheetGys.getLastRowNum()+1;
			
			SLfHashMap  allgysqc = new SLfHashMap ();	//供应商全称
			
			for (int i=9;i<gysRows;i++)
			{
				
				String gysjc = ExcelService.getSheetValueNoSpace(sheetGys, i, 0); //供应商简称
				if (Util.isBlankString(gysjc))
				{
					if (Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetGys, i, 1)) && Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetGys, i, 2))) {
						gysRows = i;
						break;   //这里有问题，有一个空行就断了
					} else {
						errMessage += " 供应商档案信息的第 "+Integer.toString(i+1)+" 行的供应商简称不允许为空"+ ";<br> \r\n";
					}
				}


				String gysqc = ExcelService.getSheetValueNoSpace(sheetGys, i, 1).trim(); //供应商全称
				if (Util.isBlankString(gysqc))
					errMessage += " 供应商档案信息的第 "+Integer.toString(i+1)+" 行的供应商全称不允许为空"+ ";<br> \r\n";

				
				if (allgysqc.containsKey(gysqc))
				{
					errMessage += " 供应商档案信息的第 "+Integer.toString(i+1)+" 行的供应商全称重复了"+ ";<br> \r\n";
				}
				else
					allgysqc.put(gysqc, gysqc);


				tmp = ExcelService.getSheetValueNoSpace(sheetGys, i, 2).trim(); //供应商类型
				if (Util.isBlankString(tmp))
					errMessage += " 供应商档案信息的第 "+Integer.toString(i+1)+" 行的供应商类型不允许为空"+ ";<br> \r\n";
				
				String gysfl =(String) allGysfl.get(tmp);
				if (Util.isBlankString(gysfl))
					errMessage += " 供应商档案信息的第 "+Integer.toString(i+1)+" 行的供应商类型 “"+tmp+"” 在供应商分类中不存在,请检查是供应商分类名称录入错误,还是未建立供应商分类"+ ";<br> \r\n";

				tmp = ExcelService.getSheetValueNoSpace(sheetGys, i, 18); //17注册登记日期
				if (!Util.isBlankString(tmp) && !Util.checkDateFormat(tmp) )
					errMessage += " 供应商档案信息的第 "+Integer.toString(i+1)+" 行的注册登记日期格式不正确,格式为 2008-01-01 "+ ";<br> \r\n";
				
				
				tmp = ExcelService.getSheetValueNoSpace(sheetGys, i, 20); //	20建立日期
				if (!Util.isBlankString(tmp) && !Util.checkDateFormat(tmp) )
					errMessage += " 供应商档案信息的第 "+Integer.toString(i+1)+" 行的建立日期格式不正确,格式为 2008-01-01 "+ ";<br> \r\n";

			}
			
			if (!Util.isBlankString(errMessage))
				throw new Exception (errMessage);
			//检查------结束-----------
			
			
			// 导入 -----开始-------------------------
			String importSql = "";
			
			GB2Alpha gb2alpha = new GB2Alpha();
			importSql += "delete xt_option_code where group_name='供应商类型' and ischild ='1' " + ret;
			
			for (int i=6;i<gysflRows;i++)
			{				
				gysflMc = ExcelService.getSheetValueNoSpace(sheetFl, i, 0).trim(); //分类名称
				
				currentgysflCode =(String)allGysfl.get(gysflMc);
				//存货分类名称 *	存货分类简称	存货分类代号
				importSql += "insert xt_option_code (id,group_name,code_value,code_title,code_order,ischild,enabled,autokeyword)" 
					+"values('"+currentgysflCode 
				+"','供应商类型',substring ('"+currentgysflCode				
				+"',4,6),'"+gysflMc+"','"+currentgysflCode
				+"','1','1','"+gb2alpha.String2Alpha(gysflMc)+"')" +ret;
			}



			//供应商信息
			//0 供应商编号 *	1 供应商简称 *	2  供应商全称 *	3 供应商类型	4公司地址	5联系电话	6邮政编码	7公司传真	8电子邮件	
			//9 公司网址 10 联系人 11 联系人电话	12 信用等级	13 开户行 14	公司帐号 15	税号 16 法定代表人	17 营业执照号码	18 注册资本 19	注册登记日期	
			//20 主营业务		21 建立日期	 22 ABC分类  23	业务员

			//19 结算类型 --去掉 
			//公司网址 后增 两项目 ：联系人 联系电话 

			importSql += "delete gys_da  " + ret;			
			importSql += "delete gys_lxr  " + ret;			
			
			//流水号复员			
			Api.ub("update xt_bill_no set lsh='0' where id = 'xtgysbh'");
			
			
			
			for (int i=9;i<gysRows;i++)
			{	
				String gys_id = Util.getSequence();
				
				String gyslx = ExcelService.getSheetValueNoSpace(sheetGys, i, 2).trim();//供应商类型
				gyslx =(String) allGysfl.get(gyslx);


				String lxren = ExcelService.getSheetValueNoSpace(sheetGys, i, 9);//10联系人
				String lxrendh = ExcelService.getSheetValueNoSpace(sheetGys, i, 11);//11联系电话




				String xydj = ExcelService.getSheetValueNoSpace(sheetGys, i, 11);//10信用等级
				xydj = Api.getCodeByOptionSourceIdAndName("207", xydj);


				//String jslx = ExcelService.getSheetValue(sheetGys, i, 19);//19 结算类型
				//jslx = Api.getCodeByOptionSourceIdAndName("952", jslx);

				String jlrq = ExcelService.getSheetValueNoSpace(sheetGys, i, 20); //20建立日期
				if (Util.isBlankString(jlrq) ||!Util.checkDateFormat(jlrq) )
					jlrq = Util.getDate(); //默认为当日

				String abcfl = ExcelService.getSheetValueNoSpace(sheetGys, i, 21);// 21 ABC分类 
				abcfl = Api.getCodeByOptionSourceIdAndName("944", abcfl);

				
				String ywbm_mc="",ywbm_id="",ywy_id="",ywy_mc="";
				tmp = ExcelService.getSheetValueNoSpace(sheetGys, i, 22);//22	业务员
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

			//供应商信息
			//0 供应商编号 *	1 供应商简称 *	2  供应商全称 *	3 供应商类型	4公司地址	5联系电话	6邮政编码	7公司传真	8电子邮件	
			//9 公司网址 10 联系人 11 联系电话	12 信用等级	13 开户行 14	公司帐号 15	税号 16 法定代表人	17 营业执照号码	18 注册资本 19	注册登记日期	
			//20 主营业务		21 建立日期	 22 ABC分类  23	业务员

			//19 结算类型 --去掉 
			//公司网址 后增 两项目 ：联系人 联系电话 


			//  gysbh,        gysjc,            gysqc,          gyslx,           gsdz ,      lxdh,         yzbm,     gscz,     Email,
			//gswz,          xydj,   khh,         gszh,         sh,   fddby,          yyzzhm,       zczb,         zcdjrq,
			//zyyw,            jslx,      jlrq,      abcfl,    ywbm_mc,ywbm_id,ywy_id,ywy_mc

				String gysbh =Api.getXtLsh("xtgysbh");
				importSql += "insert gys_da (id,gysbh,        gysjc,            gysqc,          gyslx,           gsdz ,      lxdh,         yzbm,     gscz,     Email," +
						"gswz,          xydj,   khh,         gszh,         sh,   fddby,          yyzzhm,       zczb,         zcdjrq," +
						"zyyw,                  jlrq,      abcfl,    ywbm_mc,ywbm_id,ywy_id,ywy_mc,autokeyword )" +
				"values('"+ gys_id 				
				+"','"+gysbh
				+"','"+ExcelService.getSheetValueNoSpace(sheetGys, i, 0) //gysjc
				+"','"+ExcelService.getSheetValueNoSpace(sheetGys, i, 1) //gysqc
				+"',substring ('"+gyslx
				+"',4,6),'"+ExcelService.getSheetValueNoSpace(sheetGys, i, 3) //4公司地址
				+"','"+ExcelService.getSheetValueNoSpace(sheetGys, i, 4) //5联系电话
				+"','"+ExcelService.getSheetValueNoSpace(sheetGys, i, 5) //6邮政编码
				+"','"+ExcelService.getSheetValueNoSpace(sheetGys, i, 6) //7公司传真
				+"','"+ExcelService.getSheetValueNoSpace(sheetGys, i, 7) //	8电子邮件
				+"','"+ExcelService.getSheetValueNoSpace(sheetGys, i, 8) //	9公司网址
				+"','"+xydj//10信用等级
				+"','"+ExcelService.getSheetValueNoSpace(sheetGys, i, 12) 
				+"','"+ExcelService.getSheetValueNoSpace(sheetGys, i, 13) 
				+"','"+ExcelService.getSheetValueNoSpace(sheetGys, i, 14) 
				+"','"+ExcelService.getSheetValueNoSpace(sheetGys, i, 15) 
				+"','"+ExcelService.getSheetValueNoSpace(sheetGys, i, 16) 
				+"','"+ExcelService.getSheetValueNoSpace(sheetGys, i, 17) 
				+"','"+ExcelService.getSheetValueNoSpace(sheetGys, i, 18) 
				+"','"+ExcelService.getSheetValueNoSpace(sheetGys, i, 19) 
				
				+"','"+jlrq //20 结算类型
				+"','"+abcfl //21 结算类型

				+"','"+ywbm_mc+"','"+ywbm_id+"','"+ywy_id+"','"+ywy_mc
				+"','"
				+gb2alpha.String2Alpha(ExcelService.getSheetValueNoSpace(sheetGys, i, 1)+ExcelService.getSheetValueNoSpace(sheetGys, i, 2) ) +"')" +ret;

			    //增加联系信息
				String lxr_id = Util.getSequence();
				if (!Util.isBlankString(lxren))
				{
					importSql += "insert gys_lxr (id,lxrfl,gys,gys_id,gysbh,xm,gzdh,  ywbm_mc,ywbm_id,ywy_id,ywy_mc,autokeyword )" +
					"values('"+ lxr_id 				
					+"','001" //lxrfl
					+"','"+ExcelService.getSheetValueNoSpace(sheetGys, i, 1) //gysqc
					+"','"+ gys_id //gys_id
					+"','"+gysbh

					+"','"+lxren//xm
					+"','"+lxrendh//gzdh

					+"','"+ywbm_mc+"','"+ywbm_id+"','"+ywy_id+"','"+ywy_mc
					+"','"
					+gb2alpha.String2Alpha(ExcelService.getSheetValueNoSpace(sheetGys, i, 1)+ExcelService.getSheetValueNoSpace(sheetGys, i, 2)+lxren ) +"')" +ret;
					
				}
			}
			
			if (Util.isBlankString(importSql))
				throw new Exception ("没有可以导入的数据！");

			
			//删除前期导入的
			
			
			//8 销售应付
				importSql += "delete sf_yfd " + ret;			
			
			Api.ub(importSql);
			// 导入 -----结束-------------------------
			Api.reloadAllOption();




		}
			response.sendRedirect("/emadmin/shared/message.jsp?back=/emadmin/init.jsp&message="+URLEncoder.encode("供应商档案信息已导入成功 ！","UTF-8"));
%>
