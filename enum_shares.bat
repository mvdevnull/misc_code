@echo off
setlocal enabledelayedexpansion
cls
echo ========================================
echo BEGIN - Scanning .\ips.txt for Shares
echo ========================================

echo "LINK","IP","Share","Remark","OpenShare" > shares.csv

for /f %%H in (ips.txt) do (
	for /f "skip=2 tokens=1,*" %%A in ('net view \\%%H ^| findstr /r /v "command completed Used Comment ----" ') do (
		set "sharepath=\\%%H\%%A"
        set "connection_status="
        net use Z: "!sharepath!" >nul 2>&1
        rem Check if net use was successful
        if !errorlevel! equ 0 (
            rem Net use was successful, check directory listing access
            dir Z: >nul 2>&1
            if !errorlevel! equ 0 (
                set "connection_status=Connected"
            ) else (
                set "connection_status=Failed (Dir Access Denied)"
            )
            net use Z: /delete >nul
        )
		 echo "!sharepath!","%%H","%%A","%%B","!connection_status!" >> shares.csv"
	)
	echo %%H - Complete
)

echo ========================================
echo END - See results in .\shares.csv
echo ========================================
