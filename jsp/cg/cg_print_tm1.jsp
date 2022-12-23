<%@page contentType="text/html;charset=UTF-8"%>
<%@page errorPage="/emadmin/shared/error.jsp"%>
<%@page import="com.lf.util.*,java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
        response.setHeader("Pragma","No-cache"); 
        response.setHeader("Cache-Control","no-cache"); 
        response.setDateHeader("Expires", 0); 

		if( !Serve.checkMkQx( request ) )
		{
			//response.sendRedirect("/emadmin/shared/gotologin.jsp");
			//return ;
		}
        //读出采购单的条码
        String id=request.getParameter("id");
        String sql="select a.chbm,a.chmc,a.ggxh,a.sl,b.cd from cg_cgd_sub a,jc_chda b where a.ch_id=b.id and a.fid='"+id+"' order by a.id";
        String r[]=Api.sb(sql);
        //首先生成待打印条码单元
        ArrayList<String> tmBox  = new ArrayList<String>();
        String tempString="";
        for (int i=0;i<r.length;i+=5) {
                tempString="<div>品名："+r[i+1]+" 规格："+r[i+2]+"</div>";
                //tempString+="<div><img src='/barbecue/barcode?data="+r[i]+"&width=1&height=10'  border='1'></div>";
                tempString="<div><img src='/barbecue/barcode?data=1234567890123&type=UCC128&appid=0&resolution=100&width=1&drawText=false'  border='0'></div><div aligh='center'>1234567890123</vid>";
                //取得打印条码的数量
                int sl=Util.intValue(request.getParameter(r[i]+"_sl"));
                for (int j=0;j<sl;j++) {
                        tmBox.add(tempString);
                }
        }
        
        
        int cols=Util.intValue(request.getParameter("cols"));  //打印列数
        int rows=Util.intValue(request.getParameter("rows"));//打印行数


        String header="<table valign=top width='90%' border='0'  cellpadding='0' cellspacing='0' borderColorLight=#B3C3D0 borderColorDark=#ffffff>";
       // String footer="</tr></table> <div style=\"PAGE-BREAK-AFTER: always\"></div>";
        String footer="</tr></table> <div style=\"PAGE-BREAK-AFTER: always\"></div>";
        String result="";
        for (int i=0;i<tmBox.size();i++) {
                    if (i%(cols*rows)==0) {
                         if (i>0) result+=footer;    
                        result+=header;
                    }

            		if ((i)%cols==0) {
					    if (i>0) result+="</tr>";
					    result+="<tr  height='80'>";
				    }

                    result+="<td align='left'  height='80' width='200' valig='top'>"+(String)tmBox.get(i)+"</td>";
        }
		//如果不是整行，则补空格
			if (tmBox.size()%cols>0)
				for (int k=0;k<(cols-(tmBox.size()%cols));k++) result+="<td>&nbsp;</td>";

        result+=footer;    



%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title></title>
<%@include file="/emadmin/shared/headres.jsp"%>
<SCRIPT LANGUAGE='JavaScript'>
    <!--
 		function _click_button(form1) { 
			if (doCheck(form1)==true) {
				document.getElementById('_button_area' ).style.display="none";
				document.getElementById('_button_area_message' ).style.display="block";
				form1.submit();
			}
		}
   //-->
</SCRIPT>
</head>
<body>

                                <div><img src='/barbecue/barcode?data=123ABC78901&type=EAN128&resolution=50&width=1&drawText=false' width='120'  border='0'></div><div aligh='center'>EAN128</div>
                                <div><img src='/barbecue/barcode?data=123ABC78901&type=Code128&resolution=50&width=1&drawText=false' width='120'  border='0'></div><div aligh='center'>Code128</div>
                                <div><img src='/barbecue/barcode?data=123ABC78901&type=Code128A&resolution=50&width=1&drawText=false' width='120'  border='0'></div><div aligh='center'>Code128A</div>
                                <div><img src='/barbecue/barcode?data=123ABC78901&type=Code128B&resolution=50&width=1&drawText=false' width='120'  border='0'></div><div aligh='center'>Code128B</div>
                                <div><img src='/barbecue/barcode?data=123ABC78901&type=EAN128&resolution=50&width=1&drawText=false' border='0'></div><div aligh='center'>EAN128</div>
                                <div><img src='/barbecue/barcode?data=123ABC78901&type=Code128&resolution=50&width=1&drawText=false'  border='0'></div><div aligh='center'>Code128</div>
                                <div><img src='/barbecue/barcode?data=123ABC78901&type=Code128A&resolution=50&width=1&drawText=false' border='0'></div><div aligh='center'>Code128A</div>
                                <div><img src='/barbecue/barcode?data=123ABC78901&type=Code128B&resolution=50&width=1&drawText=false' border='0'></div><div aligh='center'>Code128B</div>
</body>
</html>
