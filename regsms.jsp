<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="com.lf.lfbase.util.*,com.lf.lfbase.service.*,com.lf.lfbase.product.*,java.util.*,java.text.DecimalFormat"%>
<%
 		String sn = "DXX-BZK-000-00000"; // SDK�ʺ�
		String pwd = "580402"; // SDK����
		String newpwd = ""; // ������
		String mobile = "13888888888"; // �ƶ��绰
		String province = "����"; // ʡ
		String city = "����"; // ����
		String trade = "IT"; // ��ҵ
		String entname = "��ɿƼ�"; // ��ҵ����
		String linkman = "�ź�"; // ��ϵ��
		String phone = "010-82782651"; // ��ϵ�绰
		String email = "a@sina.com"; // �ʼ���ַ
		String fax = "010-8888888"; // ����
		String address = "��Զ���"; // ��ַ
		String postcode = "100860"; // ��������
		String sign = ""; // ǩ��
		String content = "���";// ��������
		String subcode = "8"; // ������չ��
		String route = "192.168.1.252"; // ���ر��
		String rrid = ""; // Ψһ��ʶ
		String comName = ""; // ��ҵȫ��
		String cardno = ""; // ��ֵ����
		String cardpwd = ""; // ��ֵ������
		String sendtime = "20090526173700";
        SmsDongFangBoXingClient  soap = new SmsDongFangBoXingClient("http://211.157.113.148:8060/","SDK-BBS-010-06312","405412");
         //out.println( soap.Register(province, city, trade, entname,	linkman, phone, mobile, email, fax, address, postcode)); // ������к�ע��

         out.println(soap.GetBalance()); // ������к�ע��

%>

ok