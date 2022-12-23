<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/emadmin/version.jsp"%>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="115">出现异常情况，系统连接不上数据库！<br />
    <br />
    请按如下几种方法尝试排除上述异常情况：<br />
    <br />
    1、重新启用服务。--&gt;<br /> 
    &nbsp;&nbsp;&nbsp;请在安装软件的机器（服务器），点击windows的“开始菜单”-“程序”-“<%=_titleString%>”-“服务器管理器”-“重启服务”。<br />
    2、直接从windows的系统服务管理器中启动。--&gt;<br /> 
    &nbsp;&nbsp;&nbsp;点击windows的“开始菜单”-“控制面板”，打开“管理工具”，打开“服务”。<br />
    &nbsp;&nbsp;&nbsp;在服务列表中找到名称为“MSSQL$JDL”的服务，查看该服务状态，并用鼠标点击选中该服务。<br /> 
    &nbsp;&nbsp;&nbsp;如果服务状态是“已启动” 则点击列表左上部的“重启动此服务”。<br />
    &nbsp;&nbsp;&nbsp;如果服务状态是空白,说明该服务未成功启动,则点击列表左上部的“启动此服务”。<br />
    3、直接重新启动计算机试试。<br />
    4、检查防火墙。--&gt;<br />
&nbsp;&nbsp;    把瑞星防火墙或其他防火墙关掉，如果不出现该问题，则说明是防火墙阻止了数据库的服务端口1423,请更改防火墙的设置解除阻止。<br />
5、如果是新安装的软件，可尝试重新安装，注意在安装过程中有防火墙的提示的时候，选择“允许”。<br /></td>
  </tr>
</table>





