@ECHO OFF

IF NOT "%1"=="" (
    IF "%1"=="/help" GOTO :help
    IF "%1"=="/h" 	 GOTO :help

	IF "%1"=="/kill" GOTO :kill
	IF "%1"=="/k" 	 GOTO :kill
	ECHO Invalid key: %1
	ECHO Try 'process /help' for more information.
	GOTO :eof
)

ECHO   Image Name                     PID Session Name        Session#    Mem Usage
ECHO   ========================= ======== ================ =========== ============
tasklist /fi "session eq 1" /nh | sort /R /+68 |findstr/n ^^|findstr "^[0-9]:"
GOTO :eof

:kill
taskkill /pid %2
GOTO :eof

:help
ECHO.
ECHO 	PROCESS [] [/k,/kill PID] [/h,/help]
ECHO.
ECHO 	DESCRIPTION
ECHO 		Displays information about first 10 processes and kills the process with specified PID.
ECHO.
ECHO 	KEYS
ECHO 		/k 	/kill 	PID terminates the process with corresponding PID
ECHO 		/h 	/help 	show brief description of the command
ECHO.	
ECHO 	EXAMPLE
ECHO 		process
ECHO 		process /kill 1337
ECHO 		process /help
