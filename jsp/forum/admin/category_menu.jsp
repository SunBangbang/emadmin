<%@ page contentType="text/html;charset=UTF-8" %>
<link rel="stylesheet" href="../css/main.css">
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td colspan="3"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="category_menu_outer_table">
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td>&nbsp;&nbsp;<%=category==null||category.length==0?"":category[3]%></td>
        <td>&nbsp;</td>
        <td align="right" valign="bottom">&nbsp;</td>
      </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="37">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td nowrap="nowrap"  class="category_menu0"><div align="center"><a href="category_index.jsp?cid=<%=request.getParameter("cid")%>" class="a1">设置本级栏目</a></div></td>
                <td nowrap="nowrap"  class="category_menu0"><div align="center"><a href="category_add.jsp?cid=<%=request.getParameter("cid")%>" class="a1">添加下级栏目</a></div></td>
                <td nowrap="nowrap"  class="category_menu0"><div align="center"><a href="category_delete.jsp?cid=<%=request.getParameter("cid")%>" class="a1">删除本级栏目</a></div></td>
                <td nowrap="nowrap">&nbsp;</td>
          </tr>
      </table>
    </td>
  </tr>
</table>
