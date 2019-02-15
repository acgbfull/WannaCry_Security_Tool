@echo off
mode con: cols=84 lines=30
:ZEROES
cls
title WannaCry勒索病毒检测、查杀与安全加固工具  
color 0A
echo.
echo.
echo ----------------  WannaCry勒索病毒检测、查杀与安全加固工具  ---------------------
echo.
echo.
echo    * WannaCry勒索病毒可加密硬盘文件，受害者必须支付高额赎金才有可能解密恢复，安
echo      全风险高，影响范围广！
echo.
echo    * 网络层面：建议边界防火墙阻断445端口的访问，可通过IPS、防火墙等相关安全设备配
echo      置相关阻断策略。    
echo.
echo    * 终端层面：暂时关闭Server服务,使用命令"netstat -ano | findstr ":445""，确保
echo      关闭445端口，建议在微软官网下载MS17-010补丁,选择对应的版本进行补丁安装，补
echo      丁下载地址：https://technet.microsoft.com/zh-cn/library/security/MS17-010。        
echo.
echo    * 必须以系统管理员身份运行，此工具可选功能介绍：
echo.
echo       1：病毒检测
echo.
echo       2：病毒查杀
echo.
echo       3：安全加固
echo.
echo       4：退出
echo                                                       By acgbfull                      
echo                                                  https://github.com/acgbfull/ 
echo                                                            
echo ---------------------------------------------------------------------------------
echo.
set num="menu"
set /p num="请输入所需执行的功能(1 2 3 4 5 6)后按回车键:"
if "%num%"=="1" goto virus_check
if "%num%"=="2" goto virus_kill
if "%num%"=="3" goto security_reinforcement
if "%num%"=="4" goto quit
goto ZEROES

:virus_check
cls
color 0C
title 1. 病毒检测
rem 1. 病毒检测
netstat -ano | findstr /i "SYN_SENT"
echo ---------------------------------------------------------------------------------
c:
cd c:/
dir /od /s /a /b tasks*.exe
dir /od /s /a /b msse*.exe
dir /od /s /a /b qeriuwj*
echo ---------------------------------------------------------------------------------
echo     *  显示tasks*.exe、msse*.exe、qeriuwj*文件, 则已感染病毒!
echo.
echo     *  显示大量状态为SYN_SENT的记录, 则已感染病毒!
echo.
pause
goto ZEROES

:virus_kill
rem 2. 病毒查杀
taskkill /F /IM mssecsvc.exe
taskkill /F /IM mssecsvr.exe
taskkill /F /IM tasksche.exe
taskkill /F /IM qeriuwjhrf
attrib -s -h c:\Windows\mssecsvc.exe > nul
attrib -s -h c:\Windows\mssecsvr.exe > nul
attrib -s -h c:\Windows\tasksche.exe > nul
attrib -s -h c:\Windows\qeriuwjhrf > nul
del c:\Windows\mssecsvc.exe /F
del c:\Windows\mssecsvr.exe /F
del c:\Windows\tasksche.exe /F
del c:\Windows\qeriuwjhrf /F
echo ---------------------------------------------------------------------------------
echo     *  WannaCry勒索病毒已查杀成功!
echo.
pause
goto ZEROES

:security_reinforcement
rem 安全加固
cls
echo.
echo.
echo --------------------------------  安全加固  -------------------------------------
echo.
echo.
echo       1：WIN7/XP加固 2：WIN10加固 3：WIN2003加固 4：WIN2008/2012加固 5.WIN2016加固
echo.      
echo       6: 返回上级菜单
echo.
echo       7: 退出
echo.
echo ---------------------------------------------------------------------------------
set num2="menu1"
set /p num2="请输入所需执行的功能(1 2 3 4 5 6)后按回车键:"
if "%num2%"=="1" goto create_file
if "%num2%"=="2" goto create_file
if "%num2%"=="3" goto create_file
if "%num2%"=="4" goto create_file
if "%num2%"=="5" goto create_file
if "%num2%"=="6" goto ZEROES
if "%num2%"=="7" goto quit
goto security_reinforcement

:create_file
rem 3. 加固
rem 3.1 创建文件
c:
cd c:\Windows\
attrib -s -h -r c:\Windows\mssecsvc.exe  > nul
attrib -s -h -r c:\Windows\mssecsvr.exe > nul
attrib -s -h -r c:\Windows\tasksche.exe > nul
attrib -s -h -r c:\Windows\qeriuwjhrf > nul
echo 病毒免疫 > mssecsvc.exe
echo 病毒免疫 > mssecsvr.exe
echo 病毒免疫 > tasksche.exe
echo 病毒免疫 > qeriuwjhrf
attrib +r mssecsvc.exe > nul
attrib +r mssecsvr.exe > nul
attrib +r tasksche.exe > nul
attrib +r qeriuwjhrf > nul

rem 3.2 关闭端口
if "%num2%"=="1" goto WIN7
if "%num2%"=="2" goto WIN10
if "%num2%"=="3" goto WIN2003
if "%num2%"=="4" goto WIN2012
if "%num2%"=="5" goto WIN2016

:WIN7
net stop server /Y > nul
netsh advfirewall set currentprofile state on > nul
netsh advfirewall firewall add rule name="DenyEquationTCP" dir=in action=block localport=445 remoteip=any protocol=tcp > nul
netsh advfirewall firewall add rule name="DenyEquationUDP" dir=in action=block localport=445 remoteip=any protocol=udp > nul
echo ---------------------------------------------------------------------------------
echo    *  Windows 7 OR XP系统已加固成功！
echo.
pause
goto ZEROES
:WIN10
net stop server /Y > nul
netsh firewall set opmode enable > nul
netsh advfirewall firewall add rule name="DenyEquationTCP" dir=in action=block localport=445 remoteip=any protocol=tcp > nul
netsh advfirewall firewall add rule name="DenyEquationUDP" dir=in action=block localport=445 remoteip=any protocol=udp > nul
echo ---------------------------------------------------------------------------------
echo    *  Windows 10系统已加固成功！
echo.
pause
goto ZEROES
:WIN2003
net stop server /Y > nul
net start sharedaccess > nul
netsh firewall add portopening protocol = ALL port = 445 name = DenyEquationTCP mode = DISABLE scope = ALL profile = ALL > nul
echo ---------------------------------------------------------------------------------
echo    *  Windows Server 2003系统已加固成功！
echo.
pause
goto ZEROES
:WIN2012
net stop server /Y > nul
net start MpsSvc > nul
netsh advfirewall firewall add rule name="DenyEquationTCP" dir=in action=block localport=445 remoteip=any protocol=tcp > nul
netsh advfirewall firewall add rule name="DenyEquationUDP" dir=in action=block localport=445 remoteip=any protocol=udp > nul
echo ---------------------------------------------------------------------------------
echo    *  Windows Server 2012 OR 2008系统已加固成功！
echo.
pause
goto ZEROES
:WIN2016
net stop server /Y > nul
netsh advfirewall firewall add rule name="DenyEquationTCP" dir=in action=block localport=445 remoteip=any protocol=tcp > nul
netsh advfirewall firewall add rule name="DenyEquationUDP" dir=in action=block localport=445 remoteip=any protocol=udp > nul
echo ---------------------------------------------------------------------------------
echo    *  Windows Server 2016系统已加固成功！
echo.
pause
goto ZEROES

:verify
rem 4.1 验证是否成功
netsh advfirewall firewall show rule name=all | findstr /i "denyequation"
netstat -ano | findstr /i "SYN_SENT"

:quit
