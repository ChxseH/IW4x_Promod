@echo off

del /s /q iw4x.stat
RD /S /Q demos
copy * %USERPROFILE%\Documents\GitHub\IW4x_Promod /Y
cd %USERPROFILE%\Documents\GitHub\IW4x_Promod\
git add *
git commit -a -m "Updated Things"
git push