<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="com.lf.lfbase.util.*,com.lf.lfbase.service.*,com.lf.lfbase.product.*,java.util.*,java.text.DecimalFormat"%>
<%
 		String sn = "DXX-BZK-000-00000"; // SDK帐号
		String pwd = "580402"; // SDK密码
		String newpwd = ""; // 新密码
		String mobile = "13888888888"; // 移动电话
		String province = "北京"; // 省
		String city = "北京"; // 城市
		String trade = "IT"; // 行业
		String entname = "凌飞科技"; // 企业名称
		String linkman = "张鸿"; // 联系人
		String phone = "010-82782651"; // 联系电话
		String email = "a@sina.com"; // 邮件地址
		String fax = "010-8888888"; // 传真
		String address = "长远天地"; // 地址
		String postcode = "100860"; // 邮政编码
		String sign = ""; // 签名
		String content = "你好";// 短信内容
		String subcode = "8"; // 数字扩展码
		String route = "192.168.1.252"; // 网关编号
		String rrid = ""; // 唯一标识
		String comName = ""; // 企业全称
		String cardno = ""; // 充值卡号
		String cardpwd = ""; // 充值卡密码
		String sendtime = "20090526173700";
        SmsDongFangBoXingClient  soap = new SmsDongFangBoXingClient("http://211.157.113.148:8060/","SDK-BBS-010-06312","405412");
         //out.println( soap.Register(province, city, trade, entname,	linkman, phone, mobile, email, fax, address, postcode)); // 软件序列号注册

         out.println(soap.GetBalance()); // 软件序列号注册

%>

ok