              function ReadKey()
                  On Error Resume Next
                  ePass.GetLibVersion
                 '判断是否正确驱动
                  If Err.number = &H1B6 Then
                      MsgBox "U盾安全锁驱动程序未安装或安装不正确!"
                      document.Form1.ukeyid1.value=""
                      Exit function
                  end if
                  ePass.OpenDevice 1, ""
                 '打开USBKEY 判读是否插入KEY
                  If Err then
                      MsgBox " 请 插 入 U盾安全锁 ! "
                      document.Form1.ukeyid1.value="Bad"
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
                  ePass.OpenFile 0,1
                  filesize = ePass.GetFileInfo(0,3,1,0)
                  filecontent =ePass.Read (0,0,0,filesize)
                   filecontent = left(filecontent,filesize)
                  ePass.CloseFile
                  ePass.CloseDevice
                  document.form1.ukeyid1.value=results
                  document.form1.ukeyid2.value=filecontent
              End Function
