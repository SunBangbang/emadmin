
<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,com.lf.lfbase.service.*,java.util.*"%>


<%


               HashMap x=(HashMap) session.getAttribute("myselect");

               if (x==null ) {
                    //建一个空的hashmap
                    put session
               }

     // for (int i=0;i<r[1].length;i++)
     //   out.println(r[1][i]);

        //
        if (method="post") {
                 HashMap x=(HashMap) session.getAttribute("myselect");
                 x.put();
        } 




        ObjPageBean p = new ObjPageBean();

   		p.rows = 3; //每页行数
   		p.cols = 4;  //每行列数，支持多列

   		p.start_page = request.getParameter("start_page")==null?1:Integer.valueOf(request.getParameter("start_page")).intValue();
   		p.sum_count = request.getParameter("sum_count")==null?-1:Integer.valueOf(request.getParameter("sum_count")).intValue();
     
    //如果搜索条件打钩

    //取出session中所有的id
    // where id in ('id1','id2')
     String[][] r=Api.execSpForGetPage("select zhanghao,name from xt_yh",p.start_page,p.rows*p.cols);



      out.println(r[0][0]);


	     p.sum_count = Util.intValue(r[0][0]);
	     p.r = r[1];

         p.resultCols=3;
       
        String myS="<form name=\"from1\" action=""><table border='1'>";

        for (int i=0;i<p.rows;i++) {
            myS+="<tr>";
            for (int j=0;j<p.cols;j++) {

                if ((i*p.cols+j)*p.resultCols<p.r.length) {
                    myS+="<td>行号："+p.r[(i*p.cols+j)*p.resultCols]+"姓名："+p.r[(i*p.cols+j)*p.resultCols+2]+" <input type='checkbox' name='myselect'    "+((x.get(id)==null)?"":"selected")+"   value='"+p.r[(i*p.cols+j)*p.resultCols+1]+"'></td>";
                   
                } else {
                    myS+="<td>&nbsp;</td>";
                }
            }
            myS+="</tr>";
        }
    myS+="</table></from>";


        


%>
<%=(myS)%>    

<%=p.getBar(request)%>



