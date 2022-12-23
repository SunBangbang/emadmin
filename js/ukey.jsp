<%@page contentType="text/html;charset=UTF-8"%>
<% if (is_ukey.equals("1")) {%>
    <OBJECT id="ePass" style="LEFT: 0px; TOP: 0px" height="0" width="0" classid="clsid:C7672410-309E-4318-8B34-016EE77D6B58" name="ePass" VIEWASTEXT>
    </OBJECT>

       <script language="vbscript">
         function bind_ukey()
                  On Error Resume Next
                  ePass.GetLibVersion
                 '判断是否正确驱动
                  If Err.number = &H1B6 Then
                      MsgBox "V盾安全锁驱动程序未安装或安装不正确!"
                      Exit function
                  end if
                  ePass.OpenDevice 1, ""
                 '打开USBKEY 判读是否插入KEY
                  If Err then
                      MsgBox " 请插入V盾安全锁 ! "
                      ePass.CloseDevice
                      Exit function
                  End if
                  dim results
                  dim filesize
                  dim filecontent 
                  filecontent = ""
                  filesize = 0
                  results = ""
                  results = ePass.GetStrProperty(7,0,0)
                  ePass.CloseFile
                  ePass.CloseDevice
                  document.form1.ukey.value=results
                  document.form1.is_ukey.value="1"
                  MsgBox " V盾绑定成功 ! "
              End Function
              function unbind_ukey()
                  On Error Resume Next
                  ePass.GetLibVersion
                 '判断是否正确驱动
                  If Err.number = &H1B6 Then
                      MsgBox "V盾安全锁驱动程序未安装或安装不正确!"
                      Exit function
                  end if
                  ePass.OpenDevice 1, ""
                 '打开USBKEY 判读是否插入KEY
                  If Err then
                      MsgBox " 请插入V盾安全锁 ! "
                      ePass.CloseDevice
                      Exit function
                  End if
                  dim results
                  dim filesize
                  dim filecontent 
                  filecontent = ""
                  filesize = 0
                  results = ""
                  'results = ePass.GetStrProperty(7,0,0)
                  ePass.CloseFile
                  ePass.CloseDevice
                  document.form1.ukey.value=results
                  document.form1.is_ukey.value="0"
                  MsgBox " V盾已经取消绑定 ! "
              End Function

		</script>
<%}%>
