@echo off
chcp 65001>nul
set version=1.2
goto %1




:help
:helpme
:list
:cmdlist
echo  Liste aller Befehle
echo -----------------------------------------------------------------------------------------------------------------------
echo.
echo  help/helpme
echo  setup/init/prep                            -        Startet die KraftCMD CLI-Umgebung
echo  start/launch/execute/exec/run              -        Startet einen Prozess
echo  kill/stop/freeze/cancel/quit               -        Beendet einen Prozess
echo  version/ver/sysver/sysversion              -        Zeigt die aktuelle Versionsnummer
echo  scannow/scan/check/checknow                -        Scannt nach der aktuellsten Version
echo  update/upgrade                             -        Installiert Patchdateien aus dem Downloadordner
echo  clean/clear                                -        Leert den gesamten Konsolenverlauf
echo  popup/window/notify                        -        Erzeugt ein Popup-Fenster
echo  say/write/log/print/tell                   -        Erzeugt Konsolentext
echo  reboot/restart                             -        Startet das System neu
echo  remote/connect                             -        Stellt einen Fernzugang zu einem anderen System her
echo  notes/notepad                              -        Erstellt eine Notizdatei die jederzeit bearbeitet werden kann
echo  edit/sourcedit/sourcewrite                 -        Bearbeite den Quellcode von KraftCMD (Nur erfahrene Benutzer)
echo  logout/logoff/winl/lockscreen              -        Meldet den aktuellen Systemnutzer ab
echo  warp/brew/get/install                      -        Installiert Programme aus der KraftCloud
echo  kraftp/ftp/cloud/kraftcloud                -        Richtet den Fernzugang zum KraFTP Server ein
echo  key/password/pw/secret   -burn  -purge     -        Speichert ein Passwort in einer gesicherten Datei
goto return

:setup
:init
:prep
title KraftCMD v%version% CLI
color d
prompt $
goto return

:start
:launch
:execute
:exec
:run
start "" "%2.exe"
goto return


:kill
:stop
:freeze
:cancel
taskkill /f /im "%2.exe"
goto return

:version
:ver
:sysver
:sysversion
echo Die aktuelle Version ist "KraftCMD v%version%". Um nach neueren Versionen zu scannen, nutze "kraft scannow"
goto return

:scannow
:scan
:check
:checknow
echo Suche nach neuen Versionen ...
@ping -n 2 localhost> nul
echo KraftCMD 1.2 kann mithilfe einer Patchdatei installiert werden.
echo.
echo Lege die Patchdatei in den Downloadordner und installiere das Update mit "kraft flash update.dmg".
goto return

:update
:flash
if exist "Downloads\update.dmg" goto update.install
echo Es konnte keine Patchdatei im Downloadordner gefunden werden.
goto return
:update.install
echo Wenn du diese Datei liest ist dein KraftCMD korrupt. Bitte installiere die neueste stabile Version von KraftCMD.> kraft.ini 
xcopy "Downloads\update.dmg" "kraft.cmd" /y
goto return

:clean
:clear
cls
goto return

:popup
:window
:notify
msg * "%2 %3 %4 %5 %6 %7 %8 %9"
goto return

:say
:write
:log
:print
:tell
echo %2 %3 %4 %5 %6 %7 %8 %9
goto return

:reboot
:restart
shutdown /r
goto return

:autostart
:startup
xcopy "%2" "AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" /y
goto return


:remote
:connect
mstsc /f /v:%2
goto return

:notes
:notepad
if exist "%localappdata%\notes.md" goto notes.open
echo HerrKraft>"%localappdata%\notes.h0lg3r"
:notes.open
start "notepad.exe" "%localappdata%\notes.h0lg3r"
goto return

:edit
:sourcedit
:sourcewrite
start notepad.exe kraft.cmd
goto return

:logout
:logoff
:winl
:lockscreen
Rundll32.exe user32.dll,LockWorkStation
goto return

:warp
:brew
:get
:install
goto %2
:npp
:notepadplusplus
set source=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.7.5/npp.8.7.5.Installer.x64.exe
goto brew.d
:greenshot
set source=https://github.com/greenshot/greenshot/releases/download/Greenshot-RELEASE-1.2.10.6/Greenshot-INSTALLER-1.2.10.6-RELEASE.exe
goto brew.d
:parsec
set source=https://builds.parsec.app/package/parsec-windows.exe
goto brew.d
:spotify
set source=https://download.scdn.co/SpotifySetup.exe
goto brew.d

:brew.d
powershell -Command "Invoke-WebRequest -Uri '%source%' -OutFile $env:TEMP\patch.exe"
echo Datei wurde heruntergeladen nach: %TEMP%\patch.exe
start "" "%TEMP%\patch.exe
goto return



start "" "\\pizza.elektronik.schule\default-school\share\classes\efs223\hub\%2.lnk"

:kraftp
:ftp
:cloud
:kraftcloud
if exist Z: goto kraftp.skip
net use Z: \\https://nextcloud.elektronikschule.de/remote.php/webdav/KraFTP /PERSISTENT:YES
:kraftp.skip
start "" "Z:"
goto return


:kraftkey
:key
:passwort
:password
:secret
if "%2" equ "burn" goto kraftkey.burn
if "%2" equ "purge" goto kraftkey.purge
if not exist %TEMP%\%2.h0lg3r goto kraftkey.crash
set /p key=<%TEMP%\%2.h0lg3r
echo %key%| CLIP
echo Das Passwort wurde in der Zwischenablage abgespeichert.
goto return
:kraftkey.burn
set /p shortcut=Kurzbefehl zum aufrufen des Passworts: 
set /p content=Inhalt des Passworts:  
echo %content%>>%TEMP%\%shortcut%.h0lg3r
::attrib +h %shortcut%.h0lg3r
goto return
:kraftkey.purge
del %TEMP%\*.h0lg3r
echo Alle gesicherten KraftKeys wurden entfernt.
goto return
:kraftkey.crash
echo Keine gespeicherten Schlüssel.
goto return

:server
goto %2
goto return
:linux
start "" "\\pizza.elektronik.schule\default-school\share\classes\efs223\hub\VS-WEB03\VS-WEB03.vmx"
goto return
:windows
start "" "\\pizza.elektronik.schule\default-school\share\classes\efs223\hub\VM-WIN06_CD\VM-WIN06_CD.vmx"
goto return

:return