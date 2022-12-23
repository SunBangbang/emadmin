<%@page contentType="application/vnd.ms-excel;charset=UTF-8" %>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*, jxl.Workbook,jxl.write.*,com.lf.util.*,java.text.*"%>
<%
    response.reset();
    response.setContentType("application/vnd.ms-excel;charset=UTF-8");
    response.setHeader("Content-Disposition","attachment; filename="+ java.net.URLEncoder.encode("供应商档案", "UTF-8")+".xls");
%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%
		String sheetName="供应商档案";
	    String [] sheetTitle=new String [18];
	    String sql="";
		    sheetName="供应商档案";
			sheetTitle=new String [17];
		    sheetTitle[0]="供应商名称*";
		    sheetTitle[1]="供应商类型*";
		    sheetTitle[2]="地址";
		    sheetTitle[3]="联系人*";
		    sheetTitle[4]="部门";
		    sheetTitle[5]="职务";
		    sheetTitle[6]="联系电话*";
		    sheetTitle[7]="手机";
		    sheetTitle[8]="MSN/QQ";
		    sheetTitle[9]="邮箱";
		    sheetTitle[10]="公司传真";
		    sheetTitle[11]="公司网址";
		    sheetTitle[12]="开户银行";
		    sheetTitle[13]="银行账号";
		    sheetTitle[14]="税号";
		    sheetTitle[15]="负责人";
		    sheetTitle[16]="备注";
		    sql="select gysjc,gyslx,gsdz,lxr,bm,zw,lxdh,sj,msn,email,gscz,gswz,khh,gszh,sh,ywy_mc,bz from gys_da order by gysjc";
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
                                if (j==1)  //供应商类型
                                    result[i+j]=Api.getValueName("jc_gysfl",result[i+j]);

                            
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
