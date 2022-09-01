@echo off
set time_start=%time%
set date_start=%date%

echo Uploading changes...

echo:
git add *

echo:
git status

echo:
git commit -m "%date_start% %time_start% - %date% %time%   %ComputerName%"

echo:
git push origin master



echo:
echo:
echo:
echo All done!
pause