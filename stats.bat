@ECHO OFF

:loop
IF NOT "%1"=="" (
    IF "%1"=="/help" GOTO :help
	
	IF "%1"=="/d" (
        SET destination=%2
        SHIFT
        SHIFT
		GOTO :loop
    )

	IF "%1"=="/h" (
        SET host=%2
        SHIFT
        SHIFT
		GOTO :loop
    )
    ECHO Invalid key: %1
	ECHO Use key /help to get help
	GOTO :eof
)

ECHO stats for %host% > %destination%


ECHO +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >> %destination%
ECHO 1. Network adapter information: >> %destination%
	ECHO. >> %destination%
	ipconfig | find "IPv4" >> %destination%
	ipconfig | find "Subnet Mask" >> %destination%
	ipconfig | find "Default Gateway" >> %destination%

ECHO +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >> %destination%
ECHO 2. Physical address information of the network card: >> %destination%
	getmac >> %destination%

ECHO +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >> %destination%
ECHO 3. DHCP, DNS availability: >> %destination%
	ECHO. >> %destination%
	ipconfig /all | find "DHCP Server" >> %destination%
	for /f "tokens=15 usebackq" %%a in (`ipconfig /all^| find "DHCP Server"`) do ping %%a >> %destination%
ECHO --------------------------------------------------------------------------------------------- >> %destination%
	ipconfig /all | find "DNS Server" >> %destination%
	for /f "tokens=15 usebackq" %%a in (`ipconfig /all^| find "DNS Server"`) do ping %%a >> %destination%

ECHO +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >> %destination%
ECHO 4. Default Gateway, %host% availability: >> %destination%
	ECHO. >> %destination%
	ipconfig | find "Default Gateway" >> %destination%
	for /f "tokens=13 usebackq" %%a in (`ipconfig ^| find "Default Gateway"`) do ping %%a >> %destination%
	ECHO --------------------------------------------------------------------------------------------- >> %destination%
	ping %host% >> %destination%

ECHO +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >> %destination%
ECHO 5. Network adapter speed: >> %destination%
	ECHO. >> %destination%
	wmic NIC where "NetEnabled='true'" get "Name","Speed" | find /v "" >> %destination%

ECHO +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >> %destination%
ECHO 6. Traceroute (3 first routers): >> %destination%
	tracert -d -h 3 %host% >> %destination%

ECHO +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >> %destination%
ECHO 7 - 8. Traceroute and search for underperforming routers on the way to the %host%: >> %destination%
	tracert -d %host% >> %destination%
rem To search for underperforming routers on the way to the server pathping -n %host% >> %destination% can be used.
rem However, if the intermediate router does not send ICMP responses, the operation cannot be completed. 

ECHO +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >> %destination%
ECHO 9. Address Resolution Protocol table: >> %destination%
	arp -a >> %destination%

ECHO +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >> %destination%
ECHO 10. Current connections: >> %destination%
	netstat -a >> %destination%

ECHO +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >> %destination%
ECHO 11. Maximum Transmission Unit - Refers to the maximum packet size that can be transmitted over the network without fragmentation. >> %destination%
	ECHO. >> %destination%
	rem "Maximum Segment Size 1450 - keenetic recommendation"
	SET MSS=1450
	ping %host% -n 1 -f -l %MSS% >nul
	if %ERRORLEVEL%==1 (
		ECHO Maximum Transmission Unit cannot be obtained. %host% is not available.  >> %destination%
		goto :eof
	)
	:ping
	ping %host% -n 1 -f -l %MSS% >nul
	if %ERRORLEVEL%==0 (
		SET /a MSS = MSS + 1
		goto ping
	)
	SET /a MSS = MSS - 1
	rem "28 = 20 bytes IPv4 Header + 8 bytes ICMP Header"
	SET /a MTY = MSS + 28
	ECHO Maximum Transmission Unit: %MTY% >> %destination%
ECHO ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >> %destination%
goto :eof

:help
ECHO.
ECHO    Output information about the current network connection to a file.
ECHO. 
ECHO    stats [/h] [/d]
ECHO.
ECHO 	ARGUMENTS
ECHO 		/h 		Remote host name to process.
ECHO        /d 		The path to the report file for information to be saved to.
ECHO        /help 	Print this help message.
ECHO.	
ECHO 	EXAMPLE
ECHO 	   stats microsoft.com ./stats.txt