@ECHO OFF
setlocal enabledelayedexpansion

REM Create Strings.xml for product names
:PRODUCTNAME
    ECHO Setting product names
    FOR /F "tokens=1* delims=|" %%i in (devs.txt) do CALL :CREATESTRINGS %%i, "%%j"
REM :PRODUCTNAME END


REM Create bitmap fonts
:FONTS
    ECHO Generating fonts
    FOR /F "tokens=1,2,3,4,5,6,7 delims=|" %%i in (fonts.txt) do CALL :CREATEFONTS %%i, "%%j", "%%k", "%%l", "%%m", "%%n", "%%o"
REM :FONTS END

GOTO :EOF

GOTO :FONTS
:CREATESTRINGS
    ECHO Creating strings for %~1

    SET outdir=..\resources-%~1
    SET output=%outdir%\strings.xml

    @MKDIR "%outdir%"
    ECHO ^<strings^> > "%output%"
    ECHO     ^<string id="ProductName"^>%~2^</string^> >> "%output%"
    ECHO ^</strings^> >> "%output%"
    EXIT /B 0
REM :CREATESTRINGS END



:CREATEFONTS
    ECHO Creating fonts for %~1
    SET outdir=..\resources-%~1\fonts
    MKDIR "%outdir%"
    
    CALL :CREATEBMFC fonts\numeric.bmfc, "Zen dots", "%~2", "%~3"
    CALL bmfont64 -c temp.bmfc -o %outdir%\zen-n-l.fnt
    CALL :CREATEBMFC fonts\numeric.bmfc, "Sarpanch", "%~4", "%~5"
    CALL bmfont64 -c temp.bmfc -o %outdir%\sar-n-m.fnt
    CALL :CREATEBMFC fonts\text.bmfc, "Sarpanch", "%~6", "%~7"
    CALL bmfont64 -c temp.bmfc -o %outdir%\sar-n-s.fnt
    CALL DEL temp.bmfc

    ECHO ^<fonts^> > %outdir%\fonts.xml
	ECHO ^<font id="ZenL" filename="zen-n-l.fnt" antialias="true" filter=".,:/0123456789"/^> >> %outdir%\fonts.xml
	ECHO ^<font id="SarM" filename="sar-n-m.fnt" antialias="true" filter=".,:/0123456789"/^> >> %outdir%\fonts.xml
	ECHO ^<font id="SarS" filename="sar-n-s.fnt" antialias="true" filter=".,:/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZĒÍ "/^> >> %outdir%\fonts.xml
    ECHO ^</fonts^> >> %outdir%\fonts.xml

    EXIT /B 0
REM :CREATEFONTS END


:CREATEBMFC

    ECHO temp.bmfc creation
    set "filename=%~1"
    set "font=%~2"
    set "val=%~3"
    set "sval=%~4"
    set "outfile=temp.bmfc"
    echo # Generated > %outfile%

    (for /f "delims=" %%i in (%filename%) do (
        set "line=%%i"
        set "line=!line:fontVar=%font%!"
        set "line=!line:fontSizeVar=%val%!"
        set "line=!line:bmpSizeVar=%sval%!"
        echo !line!
    )) > %outfile%

    EXIT /B 0
REM :CREATEBMFC END

:EOF
EXIT /B 0