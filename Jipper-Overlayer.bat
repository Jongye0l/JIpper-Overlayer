@echo off

REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
REM
REM Copyright (C) 2023 Jongyeol.
REM All rights reserved.
REM
REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

del /f /q "Update Completer.bat"
cls

set version=1.0.2

title 얼불춤 파일 체크중...
if exist "C:\Program Files (x86)\Steam\steamapps\common\A Dance of Fire and Ice" (
	set "file=C:\Program Files (x86)\Steam\steamapps\common\A Dance of Fire and Ice"
) else if exist "D:\SteamLibrary\steamapps\common\A Dance of Fire and Ice" (
	set "file=D:\SteamLibrary\steamapps\common\A Dance of Fire and Ice"
) else (
	echo 얼불춤 파일이 존재하지 않습니다.
	pause
	exit
)

goto VersionCheck


:VersionCheck

REM PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://jongyeol.kr/JipperOverlayer/version', 'version') }"
REM type "version" | findstr /C:"%version%" >nul
REM 
REM if not %errorlevel% equ 0 (
REM 	cls
REM 	echo ------------------------------
REM 	echo.
REM 	echo 버전이 최신버전이 아니므로 업데이트를 진행합니다.
REM 	echo.
REM 	echo ------------------------------
REM 	PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://github.com/Jongye0l/JIpper-Overlayer/raw/main/Jipper-Overlayer.bat', 'batchfile') }"
REM 	echo @echo off>"Update Completer.bat"
REM 	echo del /f /q Jipper-Overlayer.bat>>"Update Completer.bat"
REM 	echo move batchfile Jipper-Overlayer.bat>>"Update Completer.bat"
REM 	echo "Jipper-Overlayer">>"Update Completer.bat"
REM 	del /f /q version
REM 	"Update Completer.bat"
REM )
REM 
REM del /f /q version
goto CheckModFile


:MainMenu

title 지퍼 오버레이어 설정기
cls
echo ------------------------------
echo.
echo 지퍼 오버레이어 설정기
echo 적용시 자신의 오버레이터 데이터가 날라갑니다. 데이터를 미리 백업해두세요.
echo 적용을 할 때 얼불춤이 자동으로 꺼집니다.
echo.
echo.
echo Version : %version%
echo.
echo Developer : Jongyeol
echo └ Youtube : https://www.youtube.com/@Jongyeol
echo └ Discord : jongyeol_
echo.
echo Design : Jipper
echo └ Youtube : https://www.youtube.com/@jipper1214
echo └ Discord : jipper1214
echo.
echo Script : 끼툿
echo └ Discord : kkitut
echo.
echo SouceCode : https://github.com/Jongye0l/Jipper-Overlayer
echo.
echo ------------------------------
echo.
echo.

set /p scale=적용시킬 UI의 크기의 배수를 적어주세요(기본값 : 1) : 

if a%scale% == a set a=1

goto ApplyUI

exit


:CheckModFile

title 모드폴더 체크중...
if not exist "%file%\Mods" (
	title 모드폴더를 찾을 수 없습니다.
	cls
	echo ------------------------------
	echo.
	echo 모드폴더를 찾을 수 없습니다.
	echo 유니티 모드매니저를 다운로드 해주세요.
	echo 링크 : https://www.nexusmods.com/site/mods/21
	echo.
	echo 작업
	echo 1. 재로딩
	echo 2. 프로그램 종료
	echo 3. 폴더 위치 설정
	echo.
	echo ------------------------------
	set /p a=실행할 작업을 선택해주세요 : 
	if a%a% == a2 (
		exit
	) else if a%a% == a3 (
		goto SetModFileLoc
	) else (
		goto CheckModFile
	)
)

goto CheckOverlayerFile

:SetModFileLoc
set /p a=폴더의 위치를 적어주세요 : 
if a%a% == a (
	echo 적힌 내용이 아무것도 없습니다.
	goto SetModFileLoc
) else if exist %a% (
	echo 폴더를 찾을 수 없습니다.
	goto SetModFileLoc
) else (
	goto CheckOverlayerFile
)


:CheckOverlayerFile

title 오버레이어 체크중...
if not exist "%file%\Mods\Overlayer" (
	title 오버레이어를 찾을 수 없습니다.
	cls
	echo ------------------------------
	echo.
	echo 오버레이어 폴더를 찾을 수 없습니다.
	echo 오버레이어를 다운로드 해주세요.
	echo 링크 : https://discord.com/invite/TKdpbUUfUa
	echo.
	echo 작업
	echo 1. 모드 자동 적용하기
	echo  경고 : 특정버전에서 사용이 안될 수 있습니다.
	echo 2. 모드 재로딩
	echo 3. 프로그램 종료
	echo.
	echo ------------------------------
	set /p a=실행할 작업을 선택해주세요 : 
	if a%a% == a1 (
		goto ApplyOverlayer
	) else if a%a% == a3 (
		exit
	) else (
		goto CheckOverlayerFile
	)
)

goto MainMenu


:ApplyOverlayer

title 오버레이어 다운로드
cls
echo ------------------------------
echo.
echo 오버레이어를 다운로드 중입니다.
echo.
echo ------------------------------
PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://jongyeol.kr/Overlayer.zip', 'Overlayer.zip') }"

title 오버레이어 적용
cls
echo ------------------------------
echo.
echo 오버레이어를 적용중입니다.
echo.
echo ------------------------------
PowerShell -Command "& {Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('Overlayer.zip', '%file%\Mods\Overlayer')}"

del /f /q Overlayer.zip

goto CheckOverlayerFile


:ApplyUI

title UI 적용(0/6)
cls
echo ------------------------------
echo.
echo UI를 적용중입니다.
echo ○○○○
echo.
echo ------------------------------
taskkill /f /im "A Dance of Fire and Ice.exe"
if not exist "C:\OverlayerFont\MAPLESTORY_OTF_BOLD.OTF" (
	PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://github.com/Jongye0l/JIpper-Overlayer/raw/main/Font/MAPLESTORY_OTF_BOLD.OTF', 'MAPLESTORY_OTF_BOLD.OTF') }"

	title UI 적용(1/6)
	cls
	echo ------------------------------
	echo.
	echo UI를 적용중입니다.
	echo ●○○○○○
	echo.
	echo ------------------------------
	mkdir "C:\OverlayerFont"
	move "MAPLESTORY_OTF_BOLD.OTF" "C:\OverlayerFont"
)

title UI 적용(2/6)
cls
echo ------------------------------
echo.
echo UI를 적용중입니다.
echo ●●○○○○
echo.
echo ------------------------------

if not exist "%file%\Mods\Overlayer\Scripts" mkdir "%file%\Mods\Overlayer\Scripts"

PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://github.com/Jongye0l/JIpper-Overlayer/raw/main/Scripts/Scripts.zip', 'Jipper-Overlayer-Scripts.zip') }"

title UI 적용(3/6)
cls
echo ------------------------------
echo.
echo UI를 적용중입니다.
echo ●●●○○○
echo.
echo ------------------------------

PowerShell -Command "& {Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('Jipper-Overlayer-Scripts.zip', '%file%\Mods\Overlayer\Scripts')}"

title UI 적용(4/6)
cls
echo ------------------------------
echo.
echo UI를 적용중입니다.
echo ●●●●○○
echo.
echo ------------------------------

PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://jongyeol.kr/JipperOverlayer/Texts/%scale%', 'Texts.json') }"

title UI 적용(5/6)
cls
echo ------------------------------
echo.
echo UI를 적용중입니다.
echo ●●●●●○
echo.
echo ------------------------------

del "%file%\Mods\Overlayer\Texts.json"
move "Texts.json" "%file%\Mods\Overlayer"

title UI 적용(6/6)
cls
echo ------------------------------
echo.
echo UI를 적용을 완료했습니다.
echo ●●●●●●
echo.
echo ------------------------------

pause
exit
