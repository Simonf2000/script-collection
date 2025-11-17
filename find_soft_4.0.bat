@echo off
echo collecting... find_soft_3.0
setlocal enabledelayedexpansion

rem 定义要检查的软件列表，使用逗号分隔
set "softwareList=Adobe,Anaconda,AppScan,CleanMail,Fiddler,MyEclipse,WinRAR,Xftp,Xshell,WinZip,Xmanager,Navicat,Fiddler,Telerik,Miniconda,PyCharm,CLion,WebStorm,PhpStorm,Acrobat,HCL,PremiumSoft,PostgreSQL"
set "softwareList2=IntelliJ IDEA"
set "softwareList8=IntelliJ IDEA Community Edition"
set "softwareList3=Microsoft Office"
set "softwareList4=Navicat Premium"
set "softwareList5=Sublime Text"
set "softwareList6=VMware Player"
set "softwareList7=VMware Workstation"


rem 获取并打印当前主机的IP地址
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr /i "IPv4"') do echo IP Address: %%i

rem 获取并打印当前时间
echo Current Time: %date% %time%

rem 查询32位系统中的已安装软件
reg query "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" /s > temp.txt

rem 查询64位系统中的已安装软件
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s >> temp.txt

rem 提取 DisplayName 项，获取软件名称列表
for /f "tokens=2*" %%A in ('findstr /i "DisplayName" temp.txt') do (
    echo %%B>> installed_software.txt
)
rem 初始化一个空字符串，用来存储安装的违规软件
set "violations="

rem 遍历 installed_software.txt 文件，检查是否包含软件列表中的软件（模糊匹配）
for %%S in (%softwareList%) do (
    set "item=%%S"
    
    rem 遍历 installed_software.txt 文件，检查是否包含软件列表中的软件（精确匹配）
    for /f "delims=" %%L in (installed_software.txt) do (
        echo %%L | findstr /i /c:"!item!" > nul
        if !errorlevel! == 0 (
            set "violations=!violations!%%L, "
        )
    )
)

rem 遍历 installed_software.txt 文件，检查是否包含软件列表中的软件（模糊匹配）
set "violations2="
for %%S in ("!softwareList2:;=" "!") do (
    call set "item=%%~S"
    
    rem 遍历 installed_software.txt 文件，检查是否包含软件列表中的软件（模糊匹配）
    for /f "delims=" %%L in (installed_software.txt) do (
        rem 首先模糊匹配 item
        echo %%L | findstr /i /c:"!item!" > nul
        if !errorlevel! == 0 (
            set "violations2=!violations2!%%L, "
        )
    )
)

rem 检查 violations2 是否包含 IntelliJ IDEA Community Edition
if defined violations2 (
    echo !violations2! | findstr /i /c:"%softwareList8%" > nul
    if !errorlevel! == 1 (
        set "violations=!violations!!violations2!"
    )
)
	


rem 遍历 installed_software.txt 文件，检查是否包含软件列表中的软件（模糊匹配）
for %%S in ("!softwareList3:;=" "!") do (
    call set "item=%%~S"
	
    rem 遍历 installed_software.txt 文件，检查是否包含软件列表中的软件（精确匹配）
    for /f "delims=" %%L in (installed_software.txt) do (
        echo %%L | findstr /i /c:"!item!" > nul
        if !errorlevel! == 0 (
            set "violations=!violations!%%L, "
        )
    )
)
rem 遍历 installed_software.txt 文件，检查是否包含软件列表中的软件（模糊匹配）
for %%S in ("!softwareList4:;=" "!") do (
    call set "item=%%~S"
	
    rem 遍历 installed_software.txt 文件，检查是否包含软件列表中的软件（精确匹配）
    for /f "delims=" %%L in (installed_software.txt) do (
        echo %%L | findstr /i /c:"!item!" > nul
        if !errorlevel! == 0 (
            set "violations=!violations!%%L, "
        )
    )
)
rem 遍历 installed_software.txt 文件，检查是否包含软件列表中的软件（模糊匹配）
for %%S in ("!softwareList5:;=" "!") do (
    call set "item=%%~S"
	
    rem 遍历 installed_software.txt 文件，检查是否包含软件列表中的软件（精确匹配）
    for /f "delims=" %%L in (installed_software.txt) do (
        echo %%L | findstr /i /c:"!item!" > nul
        if !errorlevel! == 0 (
           set "violations=!violations!%%L, "
        )
    )
)
rem 遍历 installed_software.txt 文件，检查是否包含软件列表中的软件（模糊匹配）
for %%S in ("!softwareList6:;=" "!") do (
    call set "item=%%~S"
	
    rem 遍历 installed_software.txt 文件，检查是否包含软件列表中的软件（精确匹配）
    for /f "delims=" %%L in (installed_software.txt) do (
        echo %%L | findstr /i /c:"!item!" > nul
        if !errorlevel! == 0 (
            set "violations=!violations!%%L, "
        )
    )
)
rem 遍历 installed_software.txt 文件，检查是否包含软件列表中的软件（模糊匹配）
for %%S in ("!softwareList7:;=" "!") do (
    call set "item=%%~S"
	
    rem 遍历 installed_software.txt 文件，检查是否包含软件列表中的软件（精确匹配）
    for /f "delims=" %%L in (installed_software.txt) do (
        echo %%L | findstr /i /c:"!item!" > nul
        if !errorlevel! == 0 (
            set "violations=!violations!%%L, "
        )
    )
)
rem 检查是否找到任何违规软件
if defined violations (
    echo Install_Illegal_Software: yes
	echo.
    echo Install_Illegal_Software: !violations!
) else (
    echo Install_Illegal_Software: no
)

del temp.txt
del installed_software.txt

echo check over ......
pause
endlocal

