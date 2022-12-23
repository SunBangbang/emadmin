<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/emadmin/shared/checkAdminPermission.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.io.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*,java.net.*,com.lf.util.*,java.text.*"%>
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
			
			
			
			
			HSSFSheet sheetChfl = wb.getSheetAt(0); //产品类型
			HSSFSheet sheetChda = wb.getSheetAt(1); //产品目录
			
			
			String sheetTitle;
			
			
			//检查标题
			sheetTitle = ExcelService.getSheetValueNoSpace(sheetChfl, 0, 0).trim();
			if (!sheetTitle.equalsIgnoreCase("产品类型"))
				throw new Exception("模板的第一个工作表应该是产品类型信息,请检查是否使用了正确的模板!");
				
			sheetTitle = ExcelService.getSheetValueNoSpace(sheetChda, 0, 0).trim();
			if (!sheetTitle.equalsIgnoreCase("产品目录"))
				throw new Exception("模板的第二个工作表应该是产品目录信息,请检查是否使用了正确的模板!");
			
			
			String tmp;
			
			//检查------开始-----------
			String ret = "\r\n";
			
			String errMessage = "";
			//产品类型信息检查
			int chflRows = sheetChfl.getLastRowNum()+1;
			String currentchFlCode = "10";
			String chflMc;  //带空格的产品类型名称
			String chflStr=""; //产品类型名称的字符串，不带空格
			String chflS[];  //产品类型名称的数组
			int level;
			SLfHashMap  allChfl = new SLfHashMap ();	//所有的产品类型		
			SLfHashMap  middleChfl = new SLfHashMap ();	//中间产品类型		
			for (int i=6;i<chflRows;i++)
			{
				chflMc = ExcelService.getSheetValueHaveSpace(sheetChfl, i, 0); //产品类型名称
				
				if (Util.isBlankString(chflMc))
				{
					chflRows = i;
					break;
				}
				chflStr+=chflMc.trim()+",";
				if (Util.getNumSpaceOfleftString(chflMc)%2 != 0)
					errMessage += " 产品类型信息的第 "+Integer.toString(i+1)
							+" 行的["+chflMc+"]前的为表示级别的空格数必须为偶数个"+ ";<br> \r\n";

				level = (Util.getNumSpaceOfleftString(chflMc)/2 + 1) * 2;
				if (level>currentchFlCode.length()+2)
				{
					errMessage += " 产品类型信息的第 "
							+Integer.toString(i+1)+" 行的上级产品类型不存在!"+ ";<br> \r\n";
				}
				
				if(level > currentchFlCode.length())
				{
					middleChfl.put(currentchFlCode, currentchFlCode);
					currentchFlCode = currentchFlCode + "01";
				}
				else
				{
					if(level>4)
					{
						String theLateValue =Integer.toString (Util.intValue(currentchFlCode.substring(level-4, level))+1); 
						theLateValue = Util.getStr('0', 4-theLateValue.length()) + theLateValue;
						
						currentchFlCode = currentchFlCode.substring(0, level-4)
						+theLateValue;												
						
					}
					else
						currentchFlCode = Integer.toString (Util.intValue(currentchFlCode.substring(0, level))+1);
				}

				//currentchFlCode =Integer.toString (Util.intValue(currentchFlCode.substring(0, level))+1);

				//所有的产品类型
				allChfl.put(chflMc.trim(), currentchFlCode);



			}
			//开始检查重复
			chflS = Util.segmentString(chflStr, ","); //从字符串变成数组
			int k=Util.checkDuplicateElement(chflS);
			if (k>=0)
				errMessage += " 产品类型信息中存在重复的名称: "+chflS[k]+" 。产品类型不允许重复，请修改正确"+ ";<br> \r\n";
			
			if (Util.getNumSpaceOfleftString(ExcelService.getSheetValueHaveSpace(sheetChfl, 6, 0))>0)
				errMessage += " 产品类型信息的第 一 行的产品类型名称必须是第一级,不允许在前面加空格"+ ";<br> \r\n";

			if (chflRows <= 6)
			{
				errMessage += " 请录入产品类型信息"+ ";<br> \r\n";
			}

			
			//检查产品目录 9
			//产品名称 *	产品编码	产品类型 *	规格型号 *	计价单位 *	税率	参考成本价	参考零售价 	条码	助记码	大包装单位	包装换算率	是否批次管理	是否有效期管理	预警天数	保质期（天）	计价方式	产地	生产商	备注
			int chdaRows = sheetChda.getLastRowNum()+1;
			SLfHashMap  allChda = new SLfHashMap ();	//产品名称		
			SLfHashMap  allChbm = new SLfHashMap ();	//产品名称
			
			int error_num = 0;
			
			for (int i= 10;i<chdaRows;i++)
			{
				


				tmp = ExcelService.getSheetValueNoSpace(sheetChda, i, 0); //产品编号
				if (Util.isBlankString(tmp)) //第一个字段为空 认为是最后一行
				{
					if (Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetChda, i, 1)) && Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetChda, i, 2))) {
						chdaRows = i;
						break;   //这里有问题，有一个空行就断了
					} else {
						errMessage += " 产品目录信息的第 "+Integer.toString(i+1)+" 行的产品编号不允许为空"+ ";<br> \r\n";
						error_num++;
					}
				}


				if (allChbm.containsKey(tmp))
				{
					errMessage += " 产品目录信息的第 "+Integer.toString(i+1)+" 行的产品编号 “"+tmp+"” 重复了"+ ";<br> \r\n";
					error_num++;
				}
				allChbm.put (tmp,tmp);
				
				
				tmp = ExcelService.getSheetValueNoSpace(sheetChda, i, 1); //产品档 产品名称
				
				if (Util.isBlankString(tmp))
				{
					errMessage += " 产品目录信息的第 "+Integer.toString(i+1)+" 行的产品名称不允许为空"+ ";<br> \r\n";
					error_num++;
				}

				allChda.put(tmp, tmp);
				

				tmp = ExcelService.getSheetValueNoSpace(sheetChda, i, 2); //产品类型

				if (Util.isBlankString(tmp))
				{
					errMessage += " 产品目录信息的第 "+Integer.toString(i+1)+" 行的产品类型不允许为空"+ ";<br> \r\n";
					error_num++;
				}
				
				String chfl =(String) allChfl.get(tmp);
				if (Util.isBlankString(chfl))
				{
					errMessage += " 产品目录信息的第 "+Integer.toString(i+1)+" 行的产品类型 “"+tmp+"” 在产品类型中不存在,请检查是产品类型名称录入错误,还是未建立产品类型"+ ";<br> \r\n";
					error_num++;
					
				}
				else
				{
					tmp = (String)middleChfl.get(chfl);
					if (!Util.isBlankString(tmp))
					{
						errMessage += " 产品目录信息的第 "+Integer.toString(i+1)+" 行的产品类型不允许使用中间级产品类型，请使用末级分类"+ ";<br> \r\n";
						error_num++;
					}
				}

				//产品名称 *	产品编码	产品类型 *	规格型号 *	计价单位 *	税率	参考成本价	参考零售价 	条码	助记码	大包装单位	包装换算率	是否批次管理	是否有效期管理	预警天数	保质期（天）	计价方式	产地	生产商	备注
				tmp = ExcelService.getSheetValueNoSpace(sheetChda, i, 3).trim(); //规格型号
				if (Util.isBlankString(tmp))
				{
					errMessage += " 产品目录信息的第 "+Integer.toString(i+1)+" 行的规格型号不允许为空"+ ";<br> \r\n";
					error_num++;
				}
				
				tmp = ExcelService.getSheetValueNoSpace(sheetChda, i, 4).trim(); //计价单位
				if (Util.isBlankString(tmp))
				{
					errMessage += " 产品目录信息的第 "+Integer.toString(i+1)+" 行的计价单位不允许为空"+ ";<br> \r\n";
					error_num++;
				}
				
				String dbzdw = ExcelService.getSheetValueNoSpace(sheetChda, i, 10).trim(); //大包装单位
				String bzhsl = ExcelService.getSheetValueNoSpace(sheetChda, i, 11).trim(); //包装换算率
				
				if (Util.isBlankString(bzhsl)&& !Util.isBlankString(dbzdw))
				{
					errMessage += " 产品目录信息的第 "+Integer.toString(i+1)+" 行的大包装单位 录入后，必须录入 包装换算率"+ ";<br> \r\n";
					error_num++;
				}
				
				if (!ExcelService.checkSheetDoubleValue(sheetChda, i, 6))//ckcbj
				{
					errMessage += " 产品目录信息的第 "+Integer.toString(i+1)+" 行的参考成本价 不是数字"+ ";<br> \r\n";
					error_num++;
				}
				
				if (!ExcelService.checkSheetDoubleValue(sheetChda, i, 7))//cklsj
				{
					errMessage += " 产品目录信息的第 "+Integer.toString(i+1)+" 行的参考零售价 不是数字"+ ";<br> \r\n";
					error_num++;
				}
				
				if (error_num>=50)
					throw new Exception (errMessage);	
				
			}
			if (chdaRows <= 9)
			{
				errMessage += " 请录入产品目录"+ ";<br> \r\n";
			}
			if (!Util.isBlankString(errMessage))
				throw new Exception (errMessage);						
			//检查------结束-----------
			
			
			// 导入 -----开始-------------------------
			String importSql = "";
			
			
			
			//产品类型信息 导入
			importSql += "delete xt_option_code where enabled = '1' and group_name='产品类型' and ischild ='1' " + ret;

			GB2Alpha gb2alpha = new GB2Alpha();
			//select id,group_name,code_value,code_title,code_order,ischild,enabled,autokeyword
			 //from xt_option_code where enabled = '1' and group_name='产品类型' and ischild ='1'
			//  23911	产品类型	11	原辅料	110	1	1	,YFL启用,QY,1
						
			for (int i=6;i<chflRows;i++)
			{				
				chflMc = ExcelService.getSheetValueNoSpace(sheetChfl, i, 0).trim(); //产品类型名称
				
				currentchFlCode =(String)allChfl.get(chflMc);
				//产品类型名称 *	产品类型简称	产品类型代号
				importSql += "insert xt_option_code (id,group_name,code_value,code_title,code_order,ischild,enabled,autokeyword)" 
					+"values('239"+currentchFlCode
				+"','产品类型','"+currentchFlCode				
				+"','"+chflMc+"','"+currentchFlCode
				+"','1','1','"+gb2alpha.String2Alpha(chflMc)+"')" +ret;
			}
			
			//产品目录信息的导入
			//产品编码  产品名称 *		产品类型 *	规格型号 *	计价单位 *	税率	
			//参考成本价	参考零售价 	条码	助记码	大包装单位	包装换算率	12是否批次管理 	13是否有效期管理	预警天数	保质期（天）	计价方式	产地	生产商	备注
			//select chmc,chbm,  chlx,      ggxh,       jldw,       sl, 
			//ckcbj,    cklsj,     tm,  zjm,     bzdw,       hsl,      xt_cpfz_sfpcgl, xt_cpfz_sfbzqgl,yjts,bzq, jjfs,cd,scs, from jc_chda
/////////////////////chsx,cgdhxe,enabled,autokeyword  

			importSql += "delete  jc_chda  " + ret;
			importSql += "delete  jc_ckchdz " + ret;
			for (int i=10; i<chdaRows;i++)
			{
				String chfl =(String) allChfl.get(ExcelService.getSheetValueNoSpace(sheetChda, i, 2));
				
				String xt_cpfz_sfpcgl = ExcelService.getSheetValueNoSpace(sheetChda, i, 12);
				if(Util.isBlankString(xt_cpfz_sfpcgl))
					xt_cpfz_sfpcgl = "否";
				
				xt_cpfz_sfpcgl = Api.getCodeByOptionSourceIdAndName("010", xt_cpfz_sfpcgl);
				
				String xt_cpfz_sfbzqgl = ExcelService.getSheetValueNoSpace(sheetChda, i, 13);
				if(Util.isBlankString(xt_cpfz_sfbzqgl))
					xt_cpfz_sfbzqgl = "否";
				
				xt_cpfz_sfbzqgl = Api.getCodeByOptionSourceIdAndName("010", xt_cpfz_sfbzqgl);
				
				String jjfs = ExcelService.getSheetValueNoSpace(sheetChda, i, 16);
				if(Util.isBlankString(jjfs))
					jjfs = "全月平均法";
				jjfs = Api.getCodeByOptionSourceIdAndName("241", jjfs);
				
				
				Double d_sl = ExcelService.getSheetDoubleValue(sheetChda, i, 5);
				if (d_sl ==0)
					d_sl = Util.doubleValue("0.17");
				String sl =Double.toString(d_sl)  ;
				
				
				
				importSql += "insert jc_chda (id,chbm,chmc,  chlx,      ggxh,       jldw,       sl," +
						"ckcbj,    cklsj,     tm,  zjm,     bzdw,       hsl,      " +
						"xt_cpfz_sfpcgl, xt_cpfz_sfbzqgl,yjts,bzq, jjfs,cd,scs,bz," +
						"chsx,cgdhxe,enabled,autokeyword)" +
						" values('"+ Util.getSequence()+"','"+ ExcelService.getSheetValueNoSpace(sheetChda, i, 0)
						+"','"+ ExcelService.getSheetValueNoSpace(sheetChda, i, 1)
						+"','"+ chfl
						+"','"+ ExcelService.getSheetValueNoSpace(sheetChda, i, 3) //ggxh
						+"','"+ ExcelService.getSheetValueNoSpace(sheetChda, i, 4) //jldw
						+"','"+ sl //sl
						+"','"+  new DecimalFormat("#.#########").format(ExcelService.getSheetDoubleValue(sheetChda, i, 6)) //ckcbj
						+"','"+  new DecimalFormat("#.#########").format(ExcelService.getSheetDoubleValue(sheetChda, i, 7)) //cklsj
						+"','"+ ExcelService.getSheetValueNoSpace(sheetChda, i, 8) //tm
						+"','"+ ExcelService.getSheetValueNoSpace(sheetChda, i, 9) //zzm
						+"','"+ ExcelService.getSheetValueNoSpace(sheetChda, i, 10) //bzdw
						+"','"+  new DecimalFormat("#.#########").format(ExcelService.getSheetDoubleValue(sheetChda, i, 11)) //hsl
						+"','"+xt_cpfz_sfpcgl
						+"','"+xt_cpfz_sfbzqgl
						+"','"+Integer.toString( ExcelService.getSheetNumValue(sheetChda, i, 14) ) //yjts
						+"','"+Integer.toString(ExcelService.getSheetNumValue(sheetChda, i, 15) ) //bzq
						
						+"','"+ jjfs //jjfs
						+"','"+ ExcelService.getSheetValueNoSpace(sheetChda, i, 17) //cd
						+"','"+ ExcelService.getSheetValueNoSpace(sheetChda, i, 18) //scs
						+"','"+ ExcelService.getSheetValueNoSpace(sheetChda, i, 19) //bz
						+"','"+ ",001,002,003,004," //chsx						
						+"','0','1','"						
						+ gb2alpha.String2Alpha(ExcelService.getSheetValueNoSpace(sheetChda, i, 0))+"')" + ret;
			}
			
			if (Util.isBlankString(importSql))
				throw new Exception ("没有可以导入的数据！");

			
			
					
			//删除前期导入的			 
			
			//4 期初
				importSql += "delete kc_kcspz  " + ret;	  		
			
					
			Api.ub(importSql);
			// 导入 -----结束-------------------------
			Api.reloadAllOption();
			

		}
				
            response.sendRedirect("/emadmin/shared/message.jsp?back=/emadmin/init.jsp&message="+URLEncoder.encode("产品目录信息已导入成功 ！","UTF-8"));
%>
