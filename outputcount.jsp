<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%

   /*
     Serve.creatCount("表名称" ,"日期字段" ,"默认的统计指标字段（逗号分割）"
	                   ,"默认的头部分类字段","默认左侧分类（逗号分割）字段","是否允许定义重新分组","前缀","菜单ID");

	 --参数说明：      
          表名称， 日期字段， 默认的统计指标字段（逗号分割）， 
          默认的头部分类字段， 默认左侧分类（逗号分割）字段
          是否允许定义重新分组(0:不允许 1：允许) 
     --注意事项
		  注意所有的字段 按英文名称填写
		  如果录入的信息不正确 系统不生成
		  可以按照数据库表的定义生成
   */

   Serve.creatCount("aatest" ,"sj" ,"sl,je","hy","dq","1","_fia","100300");
%>


 
