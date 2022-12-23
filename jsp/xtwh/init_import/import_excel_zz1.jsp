<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/emadmin/shared/checkAdminPermission.jsp"%>
<%@page import="com.lf.util.*,java.sql.*,com.lf.lfbase.service.*,java.io.*,java.util.*,org.apache.commons.fileupload.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.* ,java.net.*,java.util.*"%>
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
			if (wb.getNumberOfSheets()!= 3)
				throw new Exception("模板的工作表数量应该是3个,请检查是否使用了正确的模板!");
			
			
			HSSFSheet sheetBm = wb.getSheetAt(0); //部门
			HSSFSheet sheetYh = wb.getSheetAt(1); //用户
			HSSFSheet sheetGs = wb.getSheetAt(2); //公司信息
			
			String sheetTitle;
			
			
			//检查标题
			sheetTitle = ExcelService.getSheetValueNoSpace(sheetBm, 0, 0).trim();
			if (!sheetTitle.equalsIgnoreCase("部门信息"))
				throw new Exception("模板的第一个工作表应该是部门信息,请检查是否使用了正确的模板!");
				
			sheetTitle = ExcelService.getSheetValueNoSpace(sheetYh, 0, 0).trim();
			if (!sheetTitle.equalsIgnoreCase("用户信息"))
				throw new Exception("模板的第二个工作表应该是用户信息,请检查是否使用了正确的模板!");
			
			sheetTitle = ExcelService.getSheetValueNoSpace(sheetGs, 0, 0).trim();
			if (!sheetTitle.equalsIgnoreCase("公司信息"))
				throw new Exception("模板的第三个工作表应该是公司信息,请检查是否使用了正确的模板!");
			
			String tmp;
			
			//检查------开始-----------
			String ret = "\r\n";
			
			String errMessage = "";
			//部门信息检查
			int bmRows = sheetBm.getLastRowNum()+1;
			String bmStr=""; //部门全称字符串
			String bmS[];  //部门全称
			String bmjcStr=""; //部门简称字符串
			String bmjcS[];  //部门简称
			for (int i=7;i<bmRows;i++)
			{
				tmp = ExcelService.getSheetValueHaveSpace(sheetBm, i, 0); //取第0列，部门名称 
				
				bmStr += tmp.trim() + ret;
				if (Util.isBlankString(tmp)) //如果遇到部门名称为空，就不再继续了
				{
					if (Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetBm, i, 1)) && Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetBm, i, 2))) {
						bmRows = i;
						break;
					} else {
						errMessage += " 部门信息的第 "+Integer.toString(i+1)+" 行的部门名称不允许为空"+ ";<br> \r\n";
					}
				}
				
				if (Util.getNumSpaceOfleftString(tmp)%2 != 0)
					errMessage += " 部门信息的第 "+Integer.toString(i+1)+" 行的["+tmp+"]前的为表示级别的空格数必须为偶数个"+ ";<br> \r\n";
				//开始取得部门简称
				tmp = ExcelService.getSheetValueHaveSpace(sheetBm, i, 1); //取第1列，部门简称 
				bmjcStr += tmp.trim() + ret;
				if (Util.isBlankString(tmp))
					errMessage += " 部门信息的第 "+Integer.toString(i+1)+" 行的“部门简称”为必录项，不能为空。"+ ";<br> \r\n";
				
			}
			
			if (Util.getNumSpaceOfleftString(ExcelService.getSheetValueHaveSpace(sheetBm, 7, 0))>0)
				errMessage += " 部门信息的第 一 行的部门名称必须是第一级,不允许在前面加空格"+ ";<br> \r\n";
			
			bmS = Util.segmentString(bmStr, ret);
			bmjcS = Util.segmentString(bmjcStr, ret);
			//开始检查重复
			int k=Util.checkDuplicateElement(bmS);
			if (k>=0)
				errMessage += " 部门信息中存在重复的名称: "+bmS[k]+" 。部门名称不允许重复，请修改正确"+ ";<br> \r\n";
			k=Util.checkDuplicateElement(bmjcS);
			if (k>=0)
				errMessage += " 部门信息中存在重复的简称: "+bmjcS[k]+" 。部门简称不允许重复，请修改正确"+ ";<br> \r\n";
			
			if (bmRows<=7)
				errMessage += " 请录入部门信息"+ ";<br> \r\n";
			
			//检查用户 11
			//用户登陆帐号 *	姓名 *	部门名称 *	岗位
			int yhRows = sheetYh.getLastRowNum()+1;
			for (int i=11;i<yhRows;i++)
			{
				SLfHashMap  allZhangho = new SLfHashMap ();				
				tmp = ExcelService.getSheetValueNoSpace(sheetYh, i, 0); //用户登陆帐号
					
				if (Util.isBlankString(tmp))
				{
					if (Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetYh, i, 1)) && Util.isBlankString(ExcelService.getSheetValueNoSpace(sheetYh, i, 2))) {
						yhRows = i;
						break;
					} else {
						errMessage += " 用户信息的第 "+Integer.toString(i+1)+" 行的用户登陆帐号不允许为空"+ ";<br> \r\n";
					}
				}
				if (allZhangho.containsKey(tmp))
					errMessage += " 用户信息的第 "+Integer.toString(i+1)+" 行的帐号重复了"+ ";<br> \r\n";
				
				allZhangho.put(tmp, tmp);
				
				tmp = ExcelService.getSheetValueNoSpace(sheetYh, i, 1); //姓名
				if (Util.isBlankString(tmp))
					errMessage += " 用户信息的第 "+Integer.toString(i+1)+" 行的姓名不允许为空"+ ";<br> \r\n";

				tmp = ExcelService.getSheetValueNoSpace(sheetYh, i, 2).trim(); //部门名称
				if (Util.isBlankString(tmp))
					errMessage += " 用户信息的第 "+Integer.toString(i+1)+" 行的部门名称不允许为空"+ ";<br> \r\n";
				
				boolean findBm = false;
				for (int j=0;j<bmS.length;j++)
				{
					if (bmS[j].equalsIgnoreCase(tmp))
					{
						findBm = true;
						break;
					}
					
				}
				
				if (!findBm)
					errMessage += " 用户信息的第 "+Integer.toString(i+1)+" 行的部门名称在部门信息中没有定义"+ ";<br> \r\n";
				
				tmp = ExcelService.getSheetValueNoSpace(sheetYh, i, 3).trim(); //岗位
				if (!Util.isBlankString(tmp)&& !tmp.equalsIgnoreCase("所有岗位权限"))
				{
					String sql = "select id from xt_qxz where name = '"+ tmp +"'";
					String res[] = Api.sb(sql);
					if ((res == null ||res.length<1) && !tmp.equals("其他岗位"))
						errMessage += " 用户信息的第 "+Integer.toString(i+1)+" 行的岗位在你购买的产品中不存在,你可能没有购买相关的产品模块"+ ";<br> \r\n";
				}
				
			}
			
			//公司信息 检查
			//1 公司简称 *	公司全称 *
			int gsxxStart = 6;
			
			tmp = ExcelService.getSheetValueNoSpace(sheetGs, gsxxStart, 0).trim(); //公司简称
			if (Util.isBlankString(tmp))
				errMessage += " 公司信息的公司简称不允许为空"+ ";<br> \r\n";
			
			tmp = ExcelService.getSheetValueNoSpace(sheetGs, gsxxStart, 1).trim(); //公司全称
			if (Util.isBlankString(tmp))
				errMessage += " 公司信息的公司全称不允许为空"+ ";<br> \r\n";
			
			if (!Util.isBlankString(errMessage))
				throw new Exception (errMessage);
			
			//检查------结束-----------
			
			
			// 导入 -----开始-------------------------
			String importSql = "";
			//公司信息导入
			//公司简称 *	公司全称 *	公司地址	邮政编码	联系电话	公司传真	公司网址	电子邮件
			//select id,gsjc,gsqc,gsdz,yzbm,lxdh,gscz,gswz,email from xt_gs_da
			
			importSql += "delete xt_gs_da " + ret;			
			String gsjc = ExcelService.getSheetValueNoSpace(sheetGs, gsxxStart, 0).trim(); //公司简称
			importSql += " insert xt_gs_da (id,gsjc,gsqc,gsdz,yzbm,lxdh,gscz,gswz,email)" +
					"values('1','"+ gsjc 
					+"','"+ExcelService.getSheetValueNoSpace(sheetGs, gsxxStart, 1).trim() 
					+"','"+ExcelService.getSheetValueNoSpace(sheetGs, gsxxStart, 2).trim() 
					+"','"+ExcelService.getSheetValueNoSpace(sheetGs, gsxxStart, 3).trim() 
					+"','"+ExcelService.getSheetValueNoSpace(sheetGs, gsxxStart, 4).trim() 
					+"','"+ExcelService.getSheetValueNoSpace(sheetGs, gsxxStart, 5).trim() 
					+"','"+ExcelService.getSheetValueNoSpace(sheetGs, gsxxStart, 6).trim() 
					+"','"+ExcelService.getSheetValueNoSpace(sheetGs, gsxxStart, 7).trim() 
					+"')"+ ret;
			
			
			
			//部门信息 导入
			importSql += "delete xt_bm " + ret;

			GB2Alpha gb2alpha = new GB2Alpha();
			//根部门
			importSql += "insert xt_bm (id,name,short_name,bm_dh,c1,enabled,code_order,autokeyword)" +
					"values('100','"+gsjc+"','"+gsjc+"','','1','1','100','"
					+gb2alpha.String2Alpha(gsjc)+"')" + ret;
			
			
			//更新菜单的头部 信息
			importSql += "update xt_option_code set code_value = '"+gsjc+"' where id = '000001'" + ret;
			
			String currentBmCode = "100";
			String bmMc;
			int level;
			
			SLfHashMap  allBm = new SLfHashMap ();			
			for (int i=7;i<bmRows;i++)
			{				
				bmMc = ExcelService.getSheetValueHaveSpace(sheetBm, i, 0); //部门名称
				level = (Util.getNumSpaceOfleftString(bmMc)/2 + 1) * 3;
				if (level>currentBmCode.length()+3)
				{
					errMessage += " 部门信息的第 "+Integer.toString(i+1)+" 行的上级部门不存在!"+ ";<br> \r\n";
					throw new Exception (errMessage);
				}
				
				if(level > currentBmCode.length())
					currentBmCode = currentBmCode + "001";
				else
				{
					if(level>4)
					{
						String theLateValue =Integer.toString (Util.intValue(currentBmCode.substring(level-4, level))+1); 
						theLateValue = Util.getStr('0', 4-theLateValue.length()) + theLateValue;

						currentBmCode =currentBmCode.substring(0, level-4)
						+theLateValue;												

					}
					else
						currentBmCode = Integer.toString (Util.intValue(currentBmCode.substring(0, level))+1);
				}
					
					
					
				//部门名称 *	部门简称	部门代号
				importSql += "insert xt_bm (id,name,short_name,bm_dh,c1,enabled,code_order,autokeyword)" +
				"values('100"+currentBmCode
				+"','"+ExcelService.getSheetValueNoSpace(sheetBm, i, 0).trim()
				+"','"+ExcelService.getSheetValueNoSpace(sheetBm, i, 1).trim()
				+"','"+ExcelService.getSheetValueNoSpace(sheetBm, i, 2).trim()+"','1','1','"
				+ String.valueOf(i*10) +"','"+gb2alpha.String2Alpha(bmMc)+"')" +ret;
				
				//所有的部门
				allBm.put(bmMc.trim(), "100"+currentBmCode);
			}
			
			//用户信息的导入
			//用户登陆帐号 *	姓名 *	部门名称 *	岗位
			//select id,zhanghao,name,bm_id,password,enabled,autokeyword from xt_yh
			importSql += "delete  xt_yh where id <> 'admin'  " + ret;
			importSql += "delete xt_yh_qxz where yh_id not in (select id from xt_yh) " + ret;
			for (int i=11;i<yhRows;i++)
			{
				String sql = "select value from xt_preference where name = '用户默认密码'";
				String res[] = Api.sb(sql);
				String password = "111111";
				if (res!=null && res.length>0)
					password = res[0];
				
				String bm_id =(String) allBm.get(ExcelService.getSheetValueNoSpace(sheetYh, i, 2).trim());
				String yh_id = Util.getSequence() ;
				importSql += "insert xt_yh (id,zhanghao,name,bm_id,password,enabled,autokeyword)" +
						" values('"+ yh_id
						+"','"+ ExcelService.getSheetValueNoSpace(sheetYh, i, 0)
						+"','"+ ExcelService.getSheetValueNoSpace(sheetYh, i, 1)+"','"+bm_id+"','"
						+ password +"','1','"
						+ gb2alpha.String2Alpha(ExcelService.getSheetValueNoSpace(sheetYh, i, 1)+ExcelService.getSheetValueNoSpace(sheetYh, i, 2))+"')" + ret;
				String qxz_id = ExcelService.getSheetValueNoSpace(sheetYh, i, 3).trim();
				if (qxz_id.equalsIgnoreCase("所有岗位权限"))
				{
					importSql += "insert xt_yh_qxz ( id,yh_id,qxz_id ) " +
							" select  '"+ yh_id +"' + id ,'"+ yh_id +"',id from xt_qxz where id not in ('admin','subadmin')" +ret;	
				}				
				else
				{
					qxz_id = Api.getCodeByOptionSourceIdAndName("101", qxz_id);
					if (!Util.isBlankString(qxz_id))
					{
						
						importSql += "insert xt_yh_qxz ( id,yh_id,qxz_id )values('"+yh_id +"','"+yh_id+"','"+qxz_id +"')" +ret;
					}					
				}
			}
			
			if (Util.isBlankString(importSql))
				throw new Exception ("没有可以导入的数据！");

			
			//删除前期导入的

			//2  仓库设置
				importSql += "delete jc_cksz " + ret;	
			
			//3  存货
				importSql += "delete xt_option_code where enabled = '1' and group_name='产品类型' and ischild ='1' " + ret;
				importSql += "delete  jc_chda  " + ret;
				importSql += "delete  jc_ckchdz " + ret;
			
			//4 期初
				importSql += "delete kc_kcspz  " + ret;			
			
			
			//5 客户
				importSql += "delete xt_option_code where group_name='客户类型' and ischild ='1' " + ret;
				importSql += "delete kh_da  " + ret;
				importSql += "delete kh_lxr  " + ret;
			
			//6 销售应收
				importSql += "delete sf_ysd " + ret;
			
			//7 供应商
				importSql += "delete xt_option_code where group_name='供应商类型' and ischild ='1' " + ret;
				importSql += "delete gys_da  " + ret;			
				importSql += "delete gys_lxr  " + ret;	
			
			//8 销售应付
				importSql += "delete sf_yfd " + ret;

			
			Api.ub(importSql);
			// 导入 -----结束-------------------------
			Api.reloadAllOption();

		}

		response.sendRedirect("/emadmin/shared/message.jsp?back=/emadmin/init.jsp&message="+URLEncoder.encode("组织机构信息已导入成功 ！","UTF-8")); 
%>
