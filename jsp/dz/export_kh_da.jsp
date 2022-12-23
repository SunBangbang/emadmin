<%@page contentType="application/vnd.ms-excel;charset=UTF-8" %>
<%
    response.reset();
    response.setContentType("application/vnd.ms-excel;charset=UTF-8");
    response.setHeader("Content-Disposition","attachment; filename="+ java.net.URLEncoder.encode("正式客户档案", "UTF-8")+".xls");
%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*, jxl.Workbook,jxl.write.*;"%>
<%
            String sheetName="正式客户档案";
            String [] sheetTitle=new String [30];
            String sql="";
		    sheetName="客户档案";
		    sheetTitle[0]="客户名称*";
			sheetTitle[1]="客户类型*";
			sheetTitle[2]="客户级别*";
			sheetTitle[3]="公司电话*";
			sheetTitle[4]="联系人*";
			sheetTitle[5]="性别";
			sheetTitle[6]="移动电话";
			sheetTitle[7]="MSN/(QQ)";
			sheetTitle[8]="公司传真";
			sheetTitle[9]="公司网址";
			sheetTitle[10]="公司邮箱";
			sheetTitle[11]="地区";
			sheetTitle[12]="地址";
			sheetTitle[13]="邮编";
			sheetTitle[14]="客户来源";
			sheetTitle[15]="公司性质";
			sheetTitle[16]="行业";
			sheetTitle[17]="主营业务";
			sheetTitle[18]="公司规模";
			sheetTitle[19]="开业年份";
			sheetTitle[20]="注册资金";
			sheetTitle[21]="公司法人";
			sheetTitle[22]="信用等级";
			sheetTitle[23]="开户银行";
			sheetTitle[24]="银行账号";
			sheetTitle[25]="税号";
			sheetTitle[26]="下次联系日期";
			sheetTitle[27]="客户建立日期";
			sheetTitle[28]="销售代表";
			sheetTitle[29]="备注";
		    sql="select a.khjc,a.khlx,a.khjb,a.lxdh,b.xm,b.xb,b.yddh,b.msn,a.gscz,a.gswz,a.email,a.dq,a.gsdz,a.yb,a.khly,a.gsxz,a.hy,a.zyyw,a.gsgm,a.kynf,";
			sql+=" a.zczj,a.fddbr,a.xydj,a.khh,a.gszh,a.sh,";
		    sql+=" a.xclxrq,a.jlrq,a.ywy_mc,a.bz";
		    sql+=" from  kh_da a left join kh_da_lxr b on a.id=b.kh_id";
		    sql+=" where a.id<>'00000000' and (b.id in (select top 1 id from kh_da_lxr where kh_id=a.id order by id) or b.xm is null)";
		    sql+=" order by a.khjc";
           String result[] = Api.sb( sql );
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
                                if (j==5) { //性别
                                        if(result[i+j].trim().length()!=0)//如果性别没填写则不做下面男女的判断
                                            result[i+j]=(result[i+j].equals("001"))?"男":"女";
                                }
                                if (j==11)  //地区
                                    result[i+j]=Api.getValueName("dm_dq",result[i+j]);
								if (j==14)  //客户来源
                                    result[i+j]=Api.getValueName("dm_khly",result[i+j]);
								if (j==15)  //公司性质
                                    result[i+j]=Api.getValueName("dm_gsxz",result[i+j]);
								if (j==16)  //行业
                                    result[i+j]=Api.getValueName("dm_hy",result[i+j]);
								if (j==18)  //公司规模
                                    result[i+j]=Api.getValueName("dm_gsgm",result[i+j]);
								if (j==22)  //信用等级
                                    result[i+j]=Api.getValueName("dm_xydj",result[i+j]);

                            lr1 = new Label(j, line, result[i+j],wrappedText);
                            ws0.addCell(lr1);
                        }
                        line ++;
                    }
            
            w.write();
         }catch(Exception e){
            e.printStackTrace();
            throw e; 
         }finally{ w.close();}
		
%>
