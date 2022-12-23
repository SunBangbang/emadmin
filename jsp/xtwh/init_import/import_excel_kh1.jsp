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
			if (wb.getNumberOfSheets()!= 2) 
				throw new Exception("模板的工作表数量应该是2个,请检查是否使用了正确的模板!");
			
			HSSFSheet sheetFl = wb.getSheetAt(0); //客户类型
			HSSFSheet sheetKh = wb.getSheetAt(1); //客户
			String sheetTitle;

			//检查标题
			sheetTitle = ExcelService.getSheetValueNoSpace(sheetFl, 0, 0).trim();
			if (!sheetTitle.equalsIgnoreCase("客户分类"))
				throw new Exception("模板的第一个工作表应该是客户分类,请检查是否使用了正确的模板!");


			sheetTitle = ExcelService.getSheetValueNoSpace(sheetKh, 0, 0).trim();
			if (!sheetTitle.equalsIgnoreCase("客户档案信息"))
				throw new Exception("模板的第二个工作表应该是客户档案信息,请检查是否使用了正确的模板!");
		
			String tmp;
			
			//检查------开始-----------
			String ret = "\r\n";
			
			String errMessage = "";



			//客户分类信息检查
			int khflRows = sheetFl.getLastRowNum()+1;
			String currentkhflCode = "20400";
			String khflMc;
			
			SLfHashMap  allkhfl = new SLfHashMap ();	//所有的客户分类		
			String flStr=""; //客户分类名称的字符串，不带空格
			String flS[];  //客户分类名称的数组
			
			for (int i=6;i<khflRows;i++)
			{
				khflMc = ExcelService.getSheetValueNoSpace(sheetFl, i, 0); //客户分类名称
				
				if (Util.isBlankString(khflMc))
				{
					khflRows = i;
					break;
				}
				flStr+=khflMc.trim()+",";
				

				if(i==6)
				{
					currentkhflCode = currentkhflCode + "1";
				}
				else
				{
					currentkhflCode =Integer.toString (Util.intValue(currentkhflCode)+1);
				}


					//

				//所有的客户分类
				allkhfl.put(khflMc.trim(), currentkhflCode);

			}
			//开始检查重复
			flS = Util.segmentString(flStr, ","); //从字符串变成数组
			int k=Util.checkDuplicateElement(flS);
			if (k>=0)
				errMessage += " 客户分类信息中存在重复的名称: “"+flS[k]+"” 。客户分类不允许重复，请修改正确"+ ";<br> \r\n";

			if (khflRows == 6)
			{
				errMessage += " 你没有建立客户分类，客户分类信息必须创建！"+ ";<br> \r\n";
			}




			//客户信息检查
			//0 客户编号 *	1 客户简称 *	2 客户全称 *	3 客户类型 *	4 客户级别 *	5公司地址	6联系电话	
			//7邮政编码	8公司传真	9电子邮件	
			//10联系人	11联系人电话	
			//12客户来源	13信用等级	14信用额度(万)	15关系等级	16价值评估	17公司规模	18公司性质	19开户行	
			// 20公司帐号	21税号	22法定代表人	23营业执照号码	24注册资本	25注册登记日期	26建立日期	27销售代表


			int khRows = sheetKh.getLastRowNum()+1;
			
			SLfHashMap  allKhqc = new SLfHashMap ();	//客户全称
			
			for (int i=9;i<khRows;i++)
			{

				String khjc = ExcelService.getSheetValueNoSpace(sheetKh, i, 0); //客户简称
				if (Util.isBlankString(khjc))
				{
					if (Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetKh, i, 1)) && Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetKh, i, 2))) {
						khRows = i;
						break;   //这里有问题，有一个空行就断了
					} else {
						errMessage += " 客户信息的第 "+Integer.toString(i+1)+" 行的客户简称不允许为空"+ ";<br> \r\n";
					}
				}
				

				String khqc = ExcelService.getSheetValueNoSpace(sheetKh, i, 1).trim(); //客户全称
				if (Util.isBlankString(khqc))
					errMessage += " 客户信息的第 "+Integer.toString(i+1)+" 行的客户全称不允许为空"+ ";<br> \r\n";

				
				if (allKhqc.containsKey(khqc))
				{
					errMessage += " 客户档案信息的第 "+Integer.toString(i+1)+" 行的客户全称重复了"+ ";<br> \r\n";
				}
				else
					allKhqc.put(khqc, khqc);


				tmp = ExcelService.getSheetValueNoSpace(sheetKh, i, 2).trim(); //客户类型
				if (Util.isBlankString(tmp))
					errMessage += " 客户档案信息的第 "+Integer.toString(i+1)+" 行的客户类型不允许为空"+ ";<br> \r\n";
				
				String khfl =(String) allkhfl.get(tmp);
				if (Util.isBlankString(khfl))
					errMessage += " 客户档案信息的第 "+Integer.toString(i+1)+" 行的客户类型 “"+tmp+"” 在客户分类中不存在,请检查是客户分类名称录入错误,还是未建立客户分类"+ ";<br> \r\n";

				tmp = ExcelService.getSheetValueNoSpace(sheetKh, i, 3); //客户级别
				if (Util.isBlankString(tmp))
					errMessage += " 客户档案信息的第 "+Integer.toString(i+1)+" 行的客户级别不允许为空"+ ";<br> \r\n";

				tmp = ExcelService.getSheetValueNoSpace(sheetKh, i, 24); //25注册登记日期
				if (!Util.isBlankString(tmp) && !Util.checkDateFormat(tmp) )
					errMessage += " 客户档案信息的第 "+Integer.toString(i+1)+" 行的注册登记日期格式不正确,格式为 2008-01-01 "+ ";<br> \r\n";
				
				
				tmp = ExcelService.getSheetValueNoSpace(sheetKh, i, 25); //	26建立日期
				if (!Util.isBlankString(tmp) && !Util.checkDateFormat(tmp) )
					errMessage += " 客户档案信息的第 "+Integer.toString(i+1)+" 行的建立日期格式不正确,格式为 2008-01-01 "+ ";<br> \r\n";


			}
			
			if (!Util.isBlankString(errMessage))
				throw new Exception (errMessage);
			//检查------结束-----------
			
			
			// 导入 -----开始-------------------------
			String importSql = "";
			GB2Alpha gb2alpha = new GB2Alpha();

			importSql += "delete xt_option_code where group_name='客户类型' and ischild ='1' " + ret;
			
			for (int i=6;i<khflRows;i++)
			{				
				khflMc = ExcelService.getSheetValueNoSpace(sheetFl, i, 0).trim(); //分类名称
				
				currentkhflCode =(String)allkhfl.get(khflMc);
				
				importSql += "insert xt_option_code (id,group_name,code_value,code_title,code_order,ischild,enabled,autokeyword)" 
					+"values('"+currentkhflCode 
				+"','客户类型',substring ('"+currentkhflCode				
				+"',4,6),'"+khflMc+"','"+currentkhflCode
				+"','1','1','"+gb2alpha.String2Alpha(khflMc)+"')" +ret;
			}




			//0 客户编号 *	1 客户简称 *	2 客户全称 *	3 客户类型 *	4 客户级别 *	5公司地址	6联系电话	
			//7邮政编码	8公司传真	9电子邮件	
			//10联系人	11联系人电话	
			//12客户来源	13信用等级	14信用额度(万)	15关系等级	16价值评估	17公司规模	18公司性质	19开户行	
			// 20公司帐号	21税号	22法定代表人	23营业执照号码	24注册资本	25注册登记日期	26建立日期	27销售代表

			importSql += "delete kh_da  " + ret;
			importSql += "delete kh_lxr  " + ret;

			
			//流水号复员			
			Api.ub("update xt_bill_no set lsh='0' where id = 'xtkhbh'");
			
			
			for (int i=9;i<khRows;i++)
			{	
				String kh_id = Util.getSequence();
				

				String khlx = ExcelService.getSheetValueNoSpace(sheetKh, i, 2);//客户类型
				khlx = (String) allkhfl.get(khlx);

				String khjb = ExcelService.getSheetValueNoSpace(sheetKh, i, 3);//客户级别
				khjb = Api.getCodeByOptionSourceIdAndName("203", khjb);

				String lxren = ExcelService.getSheetValueNoSpace(sheetKh, i, 9);//联系人
				String lxrendh = ExcelService.getSheetValueNoSpace(sheetKh, i, 10);//联系人电话


				String khly = ExcelService.getSheetValueNoSpace(sheetKh, i, 11);//10客户来源
				khly = Api.getCodeByOptionSourceIdAndName("205", khly);

				String xydj = ExcelService.getSheetValueNoSpace(sheetKh, i, 12);//11信用等级
				xydj = Api.getCodeByOptionSourceIdAndName("207", xydj);


				String xyed = Integer.toString(ExcelService.getSheetNumValue(sheetKh, i, 13)); //12信用额度

				String gxdj = ExcelService.getSheetValueNoSpace(sheetKh, i, 14);//13关系等级
				gxdj = Api.getCodeByOptionSourceIdAndName("206", gxdj);


				String jzpg = ExcelService.getSheetValueNoSpace(sheetKh, i, 15);//14价值评估
				jzpg = Api.getCodeByOptionSourceIdAndName("208", jzpg);


				String gsgm = ExcelService.getSheetValueNoSpace(sheetKh, i, 16);//15公司规模
				gsgm = Api.getCodeByOptionSourceIdAndName("209", gsgm);


				String gsxz = ExcelService.getSheetValueNoSpace(sheetKh, i, 17);//16公司性质
				gsxz = Api.getCodeByOptionSourceIdAndName("210", gsxz);


				String jlrq = ExcelService.getSheetValueNoSpace(sheetKh, i, 25); //24建立日期
				if (Util.isBlankString(jlrq) ||!Util.checkDateFormat(jlrq) )
					jlrq = Util.getDate(); //默认为当日
				
				String ywbm_mc="",ywbm_id="",ywy_id="",ywy_mc="";
				tmp = ExcelService.getSheetValueNoSpace(sheetKh, i, 26).trim();//25销售代表
				ywy_id = ExcelService.getYhIdByZhangHaoOrName(tmp);
				if (!Util.isBlankString(ywy_id))
				{
					String sql = "select a.name,b.id bm_id,b.name bmmc  from xt_yh a,xt_bm b where a.bm_id = b.id and a.id = '"+ ywy_id+"'";
					String res[] = Api.sb(sql);
					
					if (res!=null && res.length>1)
					{
						ywy_mc = res[0];
						ywbm_id = res[1];
						ywbm_mc = res[2];
					}
				}

			//0 客户编号 *	1 客户简称 *	2 客户全称 *	3 客户类型 *	4 客户级别 *	5公司地址	6联系电话	
			//7邮政编码	8公司传真	9电子邮件	
			//10联系人	11联系人电话	
			//12客户来源	13信用等级	14信用额度(万)	15关系等级	16价值评估	17公司规模	18公司性质	19开户行	
			// 20公司帐号	21税号	22法定代表人	23营业执照号码	24注册资本	25注册登记日期	26建立日期	27销售代表

			//khbh,          khjc,       khqc,      khjb,          gsdz,    lxdh,          yzbm,       gscz,email,
			//khlx,       khly,       xydj,       xyed,           gxdj,        jzpg,      gsgm,       gsxz,       khh,
			//gszh,         sh,        fddby,            yyzzhm,       zczb,	zcdjrq,          jlrq,       ywbm_mc,ywbm_id,ywy_id,ywy_mc
				
				String khbh = Api.getXtLsh("xtkhbh");
				
				importSql += "insert kh_da (id,khbh,          khjc,       khqc,    khlx,  khjb,          gsdz,    lxdh,          yzbm,       gscz,email," +
						"       khly,       xydj,       xyed,           gxdj,        jzpg,      gsgm,       gsxz,       khh," +
						"gszh,         sh,        fddby,            yyzzhm,       zczb,	zcdjrq,          jlrq,       ywbm_mc,ywbm_id,ywy_id,ywy_mc,autokeyword )" +
				"values('"+ kh_id 				
				+"','"+khbh
				+"','"+ExcelService.getSheetValueNoSpace(sheetKh, i, 0) //khjc
				+"','"+ExcelService.getSheetValueNoSpace(sheetKh, i, 1) //khqc
				+"',substring ('"+khlx//9客户类型
				+"',4,6),'"+khjb
				+"','"+ExcelService.getSheetValueNoSpace(sheetKh, i, 4) //4公司地址
				+"','"+ExcelService.getSheetValueNoSpace(sheetKh, i, 5) //5联系电话
				+"','"+ExcelService.getSheetValueNoSpace(sheetKh, i, 6) //6邮政编码
				+"','"+ExcelService.getSheetValueNoSpace(sheetKh, i, 7) //7公司传真
				+"','"+ExcelService.getSheetValueNoSpace(sheetKh, i, 8) //	8电子邮件
				
				+"','"+khly//10客户来源
				+"','"+xydj//11信用等级
				+"','"+xyed//12信用额度(万)
				+"','"+gxdj//13关系等级
				+"','"+jzpg//14价值评估
				+"','"+gsgm //15公司规模
				+"','"+gsxz //16公司性质
				+"','"+ExcelService.getSheetValueNoSpace(sheetKh, i, 18) //	17开户行
				+"','"+ExcelService.getSheetValueNoSpace(sheetKh, i, 19) //	17开户行
				+"','"+ExcelService.getSheetValueNoSpace(sheetKh, i, 20) 
				+"','"+ExcelService.getSheetValueNoSpace(sheetKh, i, 21)
				+"','"+ExcelService.getSheetValueNoSpace(sheetKh, i, 22)
				+"','"+ExcelService.getSheetValueNoSpace(sheetKh, i, 23)
				+"','"+ExcelService.getSheetValueNoSpace(sheetKh, i, 24)
				+"','"+jlrq //	24建立日期 
				+"','"+ywbm_mc+"','"+ywbm_id+"','"+ywy_id+"','"+ywy_mc
				+"','"
				+gb2alpha.String2Alpha(ExcelService.getSheetValueNoSpace(sheetKh, i, 0)
						+ExcelService.getSheetValueNoSpace(sheetKh, i, 1) ) +"')" +ret;

				//增加 联系人
				String lxr_id = Util.getSequence();
				if (!Util.isBlankString(lxren))
				{
					importSql += "insert kh_lxr (id,lxrfl,kh,kh_id,khbh,xm,gzdh, ywbm_mc,ywbm_id,ywy_id,ywy_mc,autokeyword )" +
					"values('"+ lxr_id 				
					+"','001" //lxrfl
					+"','"+ExcelService.getSheetValueNoSpace(sheetKh, i, 1) //khqc
					+"','"+kh_id
					+"','"+khbh
					+"','"+lxren
					+"','"+lxrendh
					+"','"+ywbm_mc+"','"+ywbm_id+"','"+ywy_id+"','"+ywy_mc
					+"','"
					+gb2alpha.String2Alpha(ExcelService.getSheetValueNoSpace(sheetKh, i, 0)+
							ExcelService.getSheetValueNoSpace(sheetKh, i, 1)+lxren ) +"')" +ret;
					
				}



				

			}
			
			if (Util.isBlankString(importSql))
				throw new Exception ("没有可以导入的数据！");

			
			//删除前期导入的			
			
			//6 销售应收
				importSql += "delete sf_ysd " + ret;
			
			
			Api.ub(importSql);
			// 导入 -----结束-------------------------
			Api.reloadAllOption();

		}
	
			response.sendRedirect("/emadmin/shared/message.jsp?back=/emadmin/init.jsp&message="+URLEncoder.encode("客户档案信息已导入成功 ！","UTF-8")); 
%>
