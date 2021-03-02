@echo off
@setlocal enableextensions  
@cd /d "%~dp0"

del /s /q iw4x.stat
RD /S /Q demos
xcopy . %USERPROFILE%\Documents\GitHub\IW4x_Promod\ /S /Q /Y
cd %USERPROFILE%\Documents\GitHub\IW4x_Promod\
git add *
git commit -a -m "Updated Things"
git push