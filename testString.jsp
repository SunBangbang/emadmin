<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.common.*,com.lf.lfbase.util.Util,java.text.*,java.math.BigDecimal"%>
<% 
		DecimalFormat df;
        double tmpDouble;
		tmpDouble = Util.doubleValue("82.535");;
		df =  new DecimalFormat("###,##0.00");
		String value = df.format(tmpDouble);
		System.out.println(value);

		BigDecimal b = new BigDecimal("250.405");

		//System.out.println(b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());

%>


 
