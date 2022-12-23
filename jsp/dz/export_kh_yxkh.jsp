<%@page contentType="application/vnd.ms-excel;charset=UTF-8" %>
<%
    response.reset();
    response.setContentType("application/vnd.ms-excel;charset=UTF-8");
    response.setHeader("Content-Disposition","attachment; filename="+ java.net.URLEncoder.encode("意向客户档案", "UTF-8")+".xls");
%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*, jxl.Workbook,jxl.write.*;"%>
<%
            String sheetName="";
            String [] sheetTitle=new String [36];
            String sql="";
		    sheetName="意向客户档案";
			sheetTitle[0]="客户名称*";
			sheetTitle[1]="客户类型";
			sheetTitle[2]="客户级别*";
			sheetTitle[3]="客户需求";
			sheetTitle[4]="答复内容"; 
			sheetTitle[5]="最新报价";
			sheetTitle[6]="公司电话*";
			sheetTitle[7]="联系人*";
			sheetTitle[8]="性别";
			sheetTitle[9]="移动电话";
			sheetTitle[10]="MSN/(QQ)";
			sheetTitle[11]="公司传真";
			sheetTitle[12]="公司网址";
			sheetTitle[13]="公司邮箱";
			sheetTitle[14]="地区";
			sheetTitle[15]="地址";
			sheetTitle[16]="邮编";
			sheetTitle[17]="客户来源";
			sheetTitle[18]="公司性质";
			sheetTitle[19]="行业";
			sheetTitle[20]="主营业务";
			sheetTitle[21]="公司规模";
			sheetTitle[22]="开业年份";
			sheetTitle[23]="注册资金";
			sheetTitle[24]="公司法人";
			sheetTitle[25]="信用等级";
			sheetTitle[26]="开户银行";
			sheetTitle[27]="银行账号";
			sheetTitle[28]="税号";
			sheetTitle[29]="是否重点跟踪";
			sheetTitle[30]="跟踪状态";
			sheetTitle[31]="下次联系日期";
			sheetTitle[32]="客户建立日期";
			sheetTitle[33]="销售代表";
			sheetTitle[34]="协助人";
			sheetTitle[35]="备注";
		    /*
		     * Edit by zbing.wang at 2009-8-26 15:11:15
		     * 
		     * 
		     * */
		    sql=" select a.khjc,a.khlx,a.khjb,a.khxq,a.dfnr,a.zxbj,a.lxdh,b.xm,b.xb,b.yddh,b.msn,a.gscz,a.gswz,a.email,a.dq,a.gsdz,a.yb,a.khly,";
			sql+=" a.gsxz,a.hy,a.zyyw,a.gsgm,a.kynf,a.zczj,a.fddbr,a.xydj,a.khh,a.gszh,a.sh, ";
			sql+=" a.sfzdgz,a.gzzt,a.xclxrq,a.jlrq,a.ywy_mc,a.xzr,a.bz ";
			sql+=" from kh_yxkh a left join kh_yxkh_lxr b on a.id=b.kh_yxkh_id ";
			sql+=" where (b.id in (select top 1 id from kh_yxkh_lxr where kh_yxkh_id=a.id order by id) or b.xm is null)";
			sql+=" order by a.khjc";
		  
           String result[] = Api.sb( sql );
		   System.out.println(result.length);
           if (result ==null || result.length ==0)
        	  return; //没有需要导出的数据
		
            WritableWorkbook w = Workbook.createWorkbook( response.getOutputStream() );
            try{
                    int charNormal = 10;
                    WritableFont normalFont = new WritableFont(WritableFont
                          .createFont("宋体"), charNormal);
                    jxl.write.WritableCellFormat wrappedText = new jxl.write.WritableCellFormat(
                          normalFont);
                    jxl.write.WritableCellFormat wrappedText_center = new jxl.write.WritableCellFormat(
                              normalFont);
          	
              
                      wrappedText.setWrap(false);
                      wrappedText_center.setWrap(false);
                      wrappedText_center.setAlignment(jxl.format.Alignment.CENTRE);

                    WritableSheet ws0 = w.createSheet(sheetName, 0);


                    for(int i=0; i<sheetTitle.length; i++ )
                    {   
                        
                        Label lr0 = new Label(i,0,sheetTitle[i],wrappedText_center);
                        ws0.addCell(lr0);
                    }
            
            
                    int line=1;
                    Label lr1=null;
					
                    for(int i=0;i<result.length;i=i+sheetTitle.length)
                    {
                        for( int j=0; j<sheetTitle.length; j++)
                        {
                                if (j==1)  //客户类型
                                    result[i+j]=Api.getValueName("jc_khfl",result[i+j]);
								if (j==2)  //客户级别
                                    result[i+j]=Api.getValueName("dm_khjb",result[i+j]);
                                if (j==8) { //性别
                                        if(result[i+j].trim().length()!=0)//如果性别没填写则不做下面男女的判断
                                            result[i+j]=(result[i+j].equals("001"))?"男":"女";
                                }
                                if (j==14)  //地区
                                    result[i+j]=Api.getValueName("dm_dq",result[i+j]);
								if (j==17)  //客户来源
                                    result[i+j]=Api.getValueName("dm_khly",result[i+j]);
                                if (j==29)  {//是否重点跟踪
                                    if(result[i+j].trim().length()!=0)//如果重点跟踪没填写则不做下面是与否的判断
                                        result[i+j]=(result[i+j].equals("1"))?"是":"否";	
                                }
                                if (j==30)  //跟踪状态
                                    result[i+j]=Api.getValueName("dm_gzzt",result[i+j]);
                                if (j==18)  //公司性质
                                    result[i+j]=Api.getValueName("dm_gsxz",result[i+j]);
								if (j==19)  //行业
                                    result[i+j]=Api.getValueName("dm_hy",result[i+j]);
								if (j==21)  //公司规模
                                    result[i+j]=Api.getValueName("dm_gsgm",result[i+j]);
								if (j==25)  //信用等级
                                    result[i+j]=Api.getValueName("dm_xydj",result[i+j]);
								if (j==34)  //协助人
								{
									String xzr[]=Api.sb("select a.name from xt_yh a,xt_bm b  where a.bm_id=b.id and a.id='"+result[i+j]+"'");
									if(null!=xzr&&xzr.length!=0)
										result[i+j]=xzr[0];
									else 
										result[i+j]="";
								}
                            lr1 = new Label(j, line, result[i+j],wrappedText);
                            ws0.addCell(lr1);
                        }
                        line++;
                    }
            w.write();
         }catch(Exception e){
            e.printStackTrace();
            throw e; 
         }finally{ w.close();}
		
%>
