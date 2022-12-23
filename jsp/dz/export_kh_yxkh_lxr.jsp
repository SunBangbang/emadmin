<%@page contentType="application/vnd.ms-excel;charset=UTF-8" %>
<%
    response.reset();
    response.setContentType("application/vnd.ms-excel;charset=UTF-8");
    response.setHeader("Content-Disposition","attachment; filename="+ java.net.URLEncoder.encode("意向客户联系人档案", "UTF-8")+".xls");
%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*, jxl.Workbook,jxl.write.*;"%>
<%
            String sheetName="";
            String [] sheetTitle=new String [16];
            String sql="";
			sheetName="意向客户联系人档案";
		    sheetTitle[0]="客户名称*";
			sheetTitle[1]="姓名*";
			sheetTitle[2]="性别";
			sheetTitle[3]="所在部门";
			sheetTitle[4]="职务";
			sheetTitle[5]="负责业务";
			sheetTitle[6]="工作电话";
			sheetTitle[7]="移动电话";
			sheetTitle[8]="家庭电话";
			sheetTitle[9]="家庭住址";
			sheetTitle[10]="传真";
			sheetTitle[11]="邮编";
			sheetTitle[12]="MSN/(QQ)";
			sheetTitle[13]="生日";
			sheetTitle[14]="爱好";
			sheetTitle[15]="备注";
		    /*
		     * Edit by zbing.wang at 2009-8-26 15:11:15
		     * 
		     * 
		     * */
		   sql="select khmc,xm,xb,szbm,zw,fzyw,gzdh,yddh,jtdh,jtzz,cz,email,msn,sr,aihao,bz from kh_yxkh_lxr order by khmc";
		  
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
                               
                                if (j==2) { //性别
                                        if(result[i+j].trim().length()!=0)//如果性别没填写则不做下面男女的判断
                                            result[i+j]=(result[i+j].equals("001"))?"男":"女";
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
