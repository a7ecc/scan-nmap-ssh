@echo off
:0
set /a min = 3
set /a max = 253
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| find "IP" ^| find "Address" ^| find /v "v6"') do set IPAddr=%%a
for /f "tokens=1-3 delims=. " %%a in ("%ipaddr%") do set ip1=%%a.%%b.%%c
set /a ip2=( %RANDOM% %% (%max% - %min% + 1) ) + %min%
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "Default"') do set ip3=%%b
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set IPpc=%%a
if %ip1%.%ip2%==%IPpc% goto 0
if %ip1%.%ip2%==%ip3% goto 0
nmap -sS -p 22 -D %ip1%.%ip2%%ip3%/24  | findstr /l /v closed | findstr /v SERVICE |  findstr /l /v "Host is up"  | findstr /l /v "MAC Address" | findstr /v Starting
pause