<%@page contentType="application/vnd.ms-excel;charset=UTF-8" %>
<%
    response.reset();
    response.setContentType("application/vnd.ms-excel;charset=UTF-8");
    response.setHeader("Content-Disposition","attachment; filename="+ java.net.URLEncoder.encode("正式客户联系记录档案", "UTF-8")+".xls");
%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*, jxl.Workbook,jxl.write.*;"%>
<%
            String sheetName="";
            String [] sheetTitle=new String [9];
            String sql="";
			sheetName="正式客户联系记录档案";
			sheetTitle[0]="客户名称*";
			sheetTitle[1]="联系人";
			sheetTitle[2]="最新报价";
			sheetTitle[3]="下次联系日期";
			sheetTitle[4]="联系主题*";
			sheetTitle[5]="联系内容";
			sheetTitle[6]="跟踪状态";
			sheetTitle[7]="是否重点跟踪";
			sheetTitle[8]="联系日期*";
		    /*
		     * Edit by zbing.wang at 2009-8-26 15:11:15
		     * 
		     * 
		     * */
		   sql="select zskh,lxr,zxbj,xclxrq,lxzt,lxnr,gzzt,sfzdgz,lxrq from kh_da_lxjl order by zskh";
		  
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
                               
                                if (j==7)  {//是否重点跟踪
                                    if(result[i+j].trim().length()!=0)//如果重点跟踪没填写则不做下面是与否的判断
                                        result[i+j]=(result[i+j].equals("1"))?"是":"否";	
                                }
                                if (j==6)  //跟踪状态
                                    result[i+j]=Api.getValueName("dm_gzzt",result[i+j]);
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
