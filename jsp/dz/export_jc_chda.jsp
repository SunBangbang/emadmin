<%@page contentType="application/vnd.ms-excel;charset=UTF-8" %>
<%
    response.reset();
    response.setContentType("application/vnd.ms-excel;charset=UTF-8");
    response.setHeader("Content-Disposition","attachment; filename="+ java.net.URLEncoder.encode("货品档案", "UTF-8")+".xls");
%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*, jxl.Workbook,jxl.write.*,com.lf.util.*,java.text.*"%>
<%
		String sheetName="";
	    String [] sheetTitle=new String [19];
	    String sql="";
		    sheetName="货品档案";
			sheetTitle=new String [19];
		    sheetTitle[0]="货品编码*";
			sheetTitle[1]="货品名称*";
			sheetTitle[2]="货品类型*";
			sheetTitle[3]="原编号";
			sheetTitle[4]="货位";
			sheetTitle[5]="规格型号*";
			sheetTitle[6]="计价单位*";
			sheetTitle[7]="大包装单位";
			sheetTitle[8]="包装换算率*";
			sheetTitle[9]="计价方式";
			sheetTitle[10]="税率";
			sheetTitle[11]="成本价";
			sheetTitle[12]="销售价";
			sheetTitle[13]="产地";
			sheetTitle[14]="品牌";
			sheetTitle[15]="生产商";
			sheetTitle[16]="备注";
			sheetTitle[17]="是否批次管理";
			sheetTitle[18]="是否有效期管理";
		    sql="select chbm,chmc,chlx,ybm,hw,ggxh,jldw,bzdw,hsl,jjfs,sl,ckcbj,cklsj,cd,chpp,scs,bz,xt_cpfz_sfpcgl,xt_cpfz_sfbzqgl from jc_chda order by chbm";
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
                                if (j==2)  //货品类型
                                    result[i+j]=Api.getValueName("jc_hpfl",result[i+j]);
                                if (j==9)  //计价方式
                                    result[i+j]=Api.getValueName("241",result[i+j]);
                                if (j==8 || j==10 ||j==11 ||j==12)  //换算率//税率//成本价//销售价
                                    result[i+j]=new DecimalFormat("#0.00").format(Util.doubleValue(result[i+j]));
                                if (j==17 || j==18)  //批次
                                    result[i+j]=result[i+j].equals("1")?"是":"否";

                            
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
