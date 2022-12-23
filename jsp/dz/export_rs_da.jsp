<%@page contentType="application/vnd.ms-excel;charset=UTF-8" %>
<%
    response.reset();
    response.setContentType("application/vnd.ms-excel;charset=UTF-8");
    response.setHeader("Content-Disposition","attachment; filename="+ java.net.URLEncoder.encode("员工档案", "UTF-8")+".xls");
%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*, jxl.Workbook,jxl.write.*;"%>
<%
            String sheetName="员工档案";
            String [] sheetTitle=new String [40];
            String sql="";
		    sheetTitle[0]="员工编号*";
			sheetTitle[1]="姓名*";
			sheetTitle[2]="性别*";
			sheetTitle[3]="出生日期*";
			sheetTitle[4]="婚否";
			sheetTitle[5]="民族";
			sheetTitle[6]="政治面貌";
			sheetTitle[7]="籍贯";
			sheetTitle[8]="部门*";
			sheetTitle[9]="职务";
			sheetTitle[10]="来源时间";
			sheetTitle[11]="入职日期";
			sheetTitle[12]="员工来源";
			sheetTitle[13]="离职时间";
			sheetTitle[14]="员工状态";
			sheetTitle[15]="状态时间";
			sheetTitle[16]="专业";
			sheetTitle[17]="毕业院校";
			sheetTitle[18]="毕业时间";
			sheetTitle[19]="学历*";
			sheetTitle[20]="身份证号*";
			sheetTitle[21]="户口类型";
			sheetTitle[22]="养老保险序号";
			sheetTitle[23]="养老保险起始日";
			sheetTitle[24]="失业保险起始日";
			sheetTitle[25]="劳动合同起始日";
			sheetTitle[26]="劳动合同到期日";
			sheetTitle[27]="常住地址";
			sheetTitle[28]="常住地电话";
			sheetTitle[29]="移动电话";
			sheetTitle[30]="现住址";
			sheetTitle[31]="家庭电话";
			sheetTitle[32]="办公电话";
			sheetTitle[33]="电子邮件";
			sheetTitle[34]="QQ(MSN)";
			sheetTitle[35]="工作经历";
			sheetTitle[36]="教育培训";
			sheetTitle[37]="奖惩情况";
			sheetTitle[38]="家庭成员";
			sheetTitle[39]="备注";
    
		    sql="select a01,a02,a03,a04,hf,a05,a06,a07,a08,a09,a13,a11,a12,a10,a14,a15,a16,a17,a18,a19,a20,hklb,ylbxxh,ylbxqsr,sybxqsr,ldhtqsr,ldhtdqr,a21,a22,a23,a24,a25,a26,a27,qq,a28,a29,a30,a31,a32 from rs_da order by a01";
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
                                if (j==2)  //性别
                                     if(result[i+j].trim().length()!=0)//如果性别没填写则不做下面男女的判断
                                            result[i+j]=(result[i+j].equals("001"))?"男":"女";
								if (j==2)  //婚否
                                   if(result[i+j].trim().length()!=0)//如果性别没填写则不做下面男女的判断
                                            result[i+j]=(result[i+j].equals("0"))?"否":"是";
                                if (j==5) { //民族
											result[i+j]=Api.getValueName("228",result[i+j]);
                                }
                                if (j==6)  //政治面貌
                                    result[i+j]=Api.getValueName("229",result[i+j]);
								if (j==7)  //籍贯
                                    result[i+j]=Api.getValueName("dm_jg",result[i+j]);
								if (j==8)  //部门
                                    result[i+j]=Api.getValueName("xt_bm",result[i+j]);
								if (j==14)  //员工状态
                                    result[i+j]=Api.getValueName("226",result[i+j]);
								if (j==19)  //学历
                                    result[i+j]=Api.getValueName("227",result[i+j]);
								if (j==21)  //户口类型
                                    result[i+j]=Api.getValueName("dm_hklx",result[i+j]);

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
