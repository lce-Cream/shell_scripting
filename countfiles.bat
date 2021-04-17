@ECHO OFF
IF "%1"=="-help" GOTO :help
IF "%1"=="/help" GOTO :help
IF "%1"=="" 	 GOTO :interactive

SET source=%1
SET destination=%2
ECHO content of %source% > %destination%

:parse
	IF "%3"=="" (GOTO endparse)
	CALL :count %3
	SHIFT
	GOTO parse
:endparse
GOTO :eof

:count
SETLOCAL
	SET /A count=0
	FOR /f %%x IN ('dir /b %source%*.%~1') DO (SET /a count+=1)
	echo %~1 - %count% >> %destination%
ENDLOCAL
EXIT /B 0

:interactive
SET /p source="source: "
SET /p destination="destination: "
SET /p extensions="extensions: "
ECHO content of %source% > %destination%

FOR %%x IN (%extensions%) DO (CALL :count %%x)
GOTO :eof

:help
ECHO.
ECHO 	Counts files with specified extensions
ECHO.
ECHO 	countfiles [source] [destination] [extensions]
ECHO.
ECHO 	ARGUMENTS
ECHO 		[source]
ECHO 			specifies directory for file counting
ECHO 		[destination]
ECHO 			specifies result output directory and file name
ECHO 		[extensions]
ECHO 			specifies file extensions to count
ECHO 	EXAMPLE
ECHO 		countfiles %USERPROFILE%\desktop\other\ %USERPROFILE%\desktop\res.txt png txt pdf
