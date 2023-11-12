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

title ����� ���� üũ��...
if exist "C:\Program Files (x86)\Steam\steamapps\common\A Dance of Fire and Ice" (
	set "file=C:\Program Files (x86)\Steam\steamapps\common\A Dance of Fire and Ice"
) else if exist "D:\SteamLibrary\steamapps\common\A Dance of Fire and Ice" (
	set "file=D:\SteamLibrary\steamapps\common\A Dance of Fire and Ice"
) else (
	echo ����� ������ �������� �ʽ��ϴ�.
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
REM 	echo ������ �ֽŹ����� �ƴϹǷ� ������Ʈ�� �����մϴ�.
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

title ���� �������̾� ������
cls
echo ------------------------------
echo.
echo ���� �������̾� ������
echo ����� �ڽ��� ���������� �����Ͱ� ���󰩴ϴ�. �����͸� �̸� ����صμ���.
echo ������ �� �� ������� �ڵ����� �����ϴ�.
echo.
echo.
echo Version : %version%
echo.
echo Developer : Jongyeol
echo �� Youtube : https://www.youtube.com/@Jongyeol
echo �� Discord : jongyeol_
echo.
echo Design : Jipper
echo �� Youtube : https://www.youtube.com/@jipper1214
echo �� Discord : jipper1214
echo.
echo Script : ����
echo �� Discord : kkitut
echo.
echo SouceCode : https://github.com/Jongye0l/Jipper-Overlayer
echo.
echo ------------------------------
echo.
echo.

set /p scale=�����ų UI�� ũ���� ����� �����ּ���(�⺻�� : 1) : 

if a%scale% == a set a=1

goto ApplyUI

exit


:CheckModFile

title ������� üũ��...
if not exist "%file%\Mods" (
	title ��������� ã�� �� �����ϴ�.
	cls
	echo ------------------------------
	echo.
	echo ��������� ã�� �� �����ϴ�.
	echo ����Ƽ ���Ŵ����� �ٿ�ε� ���ּ���.
	echo ��ũ : https://www.nexusmods.com/site/mods/21
	echo.
	echo �۾�
	echo 1. ��ε�
	echo 2. ���α׷� ����
	echo 3. ���� ��ġ ����
	echo.
	echo ------------------------------
	set /p a=������ �۾��� �������ּ��� : 
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
set /p a=������ ��ġ�� �����ּ��� : 
if a%a% == a (
	echo ���� ������ �ƹ��͵� �����ϴ�.
	goto SetModFileLoc
) else if exist %a% (
	echo ������ ã�� �� �����ϴ�.
	goto SetModFileLoc
) else (
	goto CheckOverlayerFile
)


:CheckOverlayerFile

title �������̾� üũ��...
if not exist "%file%\Mods\Overlayer" (
	title �������̾ ã�� �� �����ϴ�.
	cls
	echo ------------------------------
	echo.
	echo �������̾� ������ ã�� �� �����ϴ�.
	echo �������̾ �ٿ�ε� ���ּ���.
	echo ��ũ : https://discord.com/invite/TKdpbUUfUa
	echo.
	echo �۾�
	echo 1. ��� �ڵ� �����ϱ�
	echo  ��� : Ư���������� ����� �ȵ� �� �ֽ��ϴ�.
	echo 2. ��� ��ε�
	echo 3. ���α׷� ����
	echo.
	echo ------------------------------
	set /p a=������ �۾��� �������ּ��� : 
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

title �������̾� �ٿ�ε�
cls
echo ------------------------------
echo.
echo �������̾ �ٿ�ε� ���Դϴ�.
echo.
echo ------------------------------
PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://jongyeol.kr/Overlayer.zip', 'Overlayer.zip') }"

title �������̾� ����
cls
echo ------------------------------
echo.
echo �������̾ �������Դϴ�.
echo.
echo ------------------------------
PowerShell -Command "& {Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('Overlayer.zip', '%file%\Mods\Overlayer')}"

del /f /q Overlayer.zip

goto CheckOverlayerFile


:ApplyUI

title UI ����(0/6)
cls
echo ------------------------------
echo.
echo UI�� �������Դϴ�.
echo �ۡۡۡ�
echo.
echo ------------------------------
taskkill /f /im "A Dance of Fire and Ice.exe"
if not exist "C:\OverlayerFont\MAPLESTORY_OTF_BOLD.OTF" (
	PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://github.com/Jongye0l/JIpper-Overlayer/raw/main/Font/MAPLESTORY_OTF_BOLD.OTF', 'MAPLESTORY_OTF_BOLD.OTF') }"

	title UI ����(1/6)
	cls
	echo ------------------------------
	echo.
	echo UI�� �������Դϴ�.
	echo �ܡۡۡۡۡ�
	echo.
	echo ------------------------------
	mkdir "C:\OverlayerFont"
	move "MAPLESTORY_OTF_BOLD.OTF" "C:\OverlayerFont"
)

title UI ����(2/6)
cls
echo ------------------------------
echo.
echo UI�� �������Դϴ�.
echo �ܡܡۡۡۡ�
echo.
echo ------------------------------

if not exist "%file%\Mods\Overlayer\Scripts" mkdir "%file%\Mods\Overlayer\Scripts"

PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://github.com/Jongye0l/JIpper-Overlayer/raw/main/Scripts/Scripts.zip', 'Jipper-Overlayer-Scripts.zip') }"

title UI ����(3/6)
cls
echo ------------------------------
echo.
echo UI�� �������Դϴ�.
echo �ܡܡܡۡۡ�
echo.
echo ------------------------------

PowerShell -Command "& {Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('Jipper-Overlayer-Scripts.zip', '%file%\Mods\Overlayer\Scripts')}"

title UI ����(4/6)
cls
echo ------------------------------
echo.
echo UI�� �������Դϴ�.
echo �ܡܡܡܡۡ�
echo.
echo ------------------------------

PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://jongyeol.kr/JipperOverlayer/Texts/%scale%', 'Texts.json') }"

title UI ����(5/6)
cls
echo ------------------------------
echo.
echo UI�� �������Դϴ�.
echo �ܡܡܡܡܡ�
echo.
echo ------------------------------

del "%file%\Mods\Overlayer\Texts.json"
move "Texts.json" "%file%\Mods\Overlayer"

title UI ����(6/6)
cls
echo ------------------------------
echo.
echo UI�� ������ �Ϸ��߽��ϴ�.
echo �ܡܡܡܡܡ�
echo.
echo ------------------------------

pause
exit
