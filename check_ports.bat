@echo off
echo collecting... port_security_check
setlocal enabledelayedexpansion

rem 定义要检查的风险端口列表
set "riskPorts=139,445,3389,22,23,80,443,8000,8080,8081,1521,3306,1433,5432,6379,11211,27017"

rem 获取并打印当前主机的IP地址
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr /i "IPv4"') do echo IP Address: %%i

rem 获取并打印当前时间
echo Current Time: %date% %time%
echo.

rem 初始化风险端口字符串
set "openRiskPorts="
set "closedSafePorts="

rem 遍历风险端口列表进行检查
for %%P in (%riskPorts%) do (
    set "port=%%P"
    
    rem 使用netstat检查端口状态
    netstat -ano -p tcp | find ":%%P " >nul 2>nul
    if !errorlevel! == 0 (
        rem 端口已开启，添加到风险列表
        set "openRiskPorts=!openRiskPorts!%%P, "
    ) else (
        rem 端口未开启，添加到安全列表
        set "closedSafePorts=!closedSafePorts!%%P, "
    )
)

rem 移除最后一个逗号和空格
if defined openRiskPorts (
    set "openRiskPorts=!openRiskPorts:~0,-2!"
)
if defined closedSafePorts (
    set "closedSafePorts=!closedSafePorts:~0,-2!"
)

rem 输出检查结果
echo =============== Port Security Check Result ===============
if defined openRiskPorts (
    echo Risk_Ports_Open: yes
    echo.
    echo Risk_Ports_Open: !openRiskPorts!
) else (
    echo Risk_Ports_Open: no
)

echo.
if defined closedSafePorts (
    echo Safe_Ports_Closed: yes
    echo.
    echo Safe_Ports_Closed: !closedSafePorts!
) else (
    echo Safe_Ports_Closed: no
)

echo.
echo ==========================================================

echo check over ......
pause
endlocal