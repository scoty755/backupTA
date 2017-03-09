@echo off
cd /d %~dp0

for /F "delims=" %%a in ('windows\adb.exe shell getprop ro.product.cpu.abi') do set ARCH=%%a
for /F "delims=" %%a in ('windows\adb.exe shell getprop ro.product.device') do set DEVICE=%%a
for /F "delims=" %%a in ('windows\adb.exe shell getprop ro.serialno') do set SERIAL=%%a

set DIR=../libs/armeabi-v7a
IF %ARCH% == "arm64-v8a" (
   set SUFFIX=../libs/arm64-v8a
)

for /f "tokens=1-8 delims=.:,/ " %%a in ("%date% %time%") do set DateNtime=%%a%%b%%c-%%d%%e
set TAIMG=TA_%DEVICE%_%SERIAL%_%DateNtime%.img

windows\adb.exe push %DIR%/dirtycow /data/local/tmp/dirtycow
windows\adb.exe push %DIR%/cow-run-as /data/local/tmp/run-as
windows\adb.exe push %DIR%/exploitta /data/local/tmp/exploitta
windows\adb.exe push %DIR%/dumpta /data/local/tmp/dumpta
windows\adb.exe push %DIR%/checkta /data/local/tmp/checkta
windows\adb.exe push backupTADevice.sh /data/local/tmp
windows\adb.exe shell "chmod 755 /data/local/tmp/*"
windows\adb.exe shell "/data/local/tmp/backupTADevice.sh %TAIMG%"
windows\adb.exe pull /data/local/tmp/%TAIMG% %TAIMG%
windows\adb.exe shell "rm -f /data/local/tmp/dirtycow /data/local/tmp/run-as /data/local/tmp/exploitta /data/local/tmp/dumpta /data/local/tmp/backupTADevice.sh"
echo TA Sucessfully pulled to %TAIMG%
pause
