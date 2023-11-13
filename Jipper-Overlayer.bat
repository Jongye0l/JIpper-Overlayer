@echo off

REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
REM
REM Copyright (C) 2023 Jongyeol.
REM All rights reserved.
REM
REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

del /f /q "Update Completer.bat"
cls

set version=1.1.0

title ����� ���� üũ��...
if exist "C:\Program Files (x86)\Steam\steamapps\common\A Dance of Fire and Ice" (
	set "file=C:\Program Files (x86)\Steam\steamapps\common\A Dance of Fire and Ice"
) else if exist "C:\Program Files\Steam\steamapps\common\A Dance of Fire and Ice" (
	set "file=C:\Program Files\Steam\steamapps\common\A Dance of Fire and Ice"
) else if exist "D:\SteamLibrary\steamapps\common\A Dance of Fire and Ice" (
	set "file=D:\SteamLibrary\steamapps\common\A Dance of Fire and Ice"
) else if exist "E:\SteamLibrary\steamapps\common\A Dance of Fire and Ice" (
	set "file=E:\SteamLibrary\steamapps\common\A Dance of Fire and Ice"
) else if exist "F:\SteamLibrary\steamapps\common\A Dance of Fire and Ice" (
	set "file=F:\SteamLibrary\steamapps\common\A Dance of Fire and Ice"
) else if exist "G:\SteamLibrary\steamapps\common\A Dance of Fire and Ice" (
	set "file=G:\SteamLibrary\steamapps\common\A Dance of Fire and Ice"
) else (
	cls
	echo ------------------------------
	echo.
	echo ����� ������ ã�� �� �����ϴ�.
	echo ����� ������ ��ġ�� �Է����ּ���.
	echo.
	echo ------------------------------
	echo.
	echo.
	goto writeAdofaiFile
)

goto VersionCheck


:writeAdofaiFile
set /p file=����� ������ ��ġ : 
if not exist "%file%\A Dance of Fire and Ice.exe" (
	cls
	echo ------------------------------
	echo.
	echo ����� ������ ��ġ�� �߸� �ԷµǾ����ϴ�.
	echo �ٽ� �Է����ּ���.
	echo.
	echo ------------------------------
	echo.
	echo.
	goto writeAdofaiFile
)

:VersionCheck
PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://jongyeol.kr/JipperOverlayer/version', 'version') }"
type "version" | findstr /C:"%version%" >nul
 
if not %errorlevel% equ 0 (
	cls
	echo ------------------------------
	echo.
	echo ���� �������̾� ����Ⱑ �ֽŹ����� �ƴմϴ�.
	echo ������������ �۵��� ����� ���� ���� �� �ֽ��ϴ�.
	echo.
	echo �ٿ�ε� : https://github.com/Jongye0l/JIpper-Overlayer/releases
	echo.
	echo ------------------------------
	echo.
	echo �����Ͻð� ����Ͻ÷��� �ƹ�Ű�� �����ּ���.
	del /f /q version
	pause > nul
REM 	PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://github.com/Jongye0l/JIpper-Overlayer/raw/main/Jipper-Overlayer.bat', 'batchfile') }"
REM 	echo @echo off>"Update Completer.bat"
REM 	echo del /f /q Jipper-Overlayer.bat>>"Update Completer.bat"
REM 	echo move batchfile Jipper-Overlayer.bat>>"Update Completer.bat"
REM 	echo "Jipper-Overlayer">>"Update Completer.bat"
REM 	del /f /q version
REM 	"Update Completer.bat"
) else (
	del /f /q version
)

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
echo Design : Jipper
echo Script : ����
echo.
echo SouceCode : https://github.com/Jongye0l/Jipper-Overlayer
echo ���α׷��� �� �۵����� ������ ���ڵ� jongyeol_�� �����ּ���.
echo.
echo �۾�
echo 1. �������̾� ������ ����
echo 2. �������̾� ���� ����
echo 3. ���α׷� ����
echo.
echo ------------------------------
echo.
echo.

set /p a=�����ų �۾��� �������ּ��� : 

if a%a% == a1 (
	goto selectScale
) else if a%a% == a2 (
	goto ApplyOverlayer
) else if a%a% == a3 (
	exit
) else (
	goto MainMenu
)

:selectScale
set /p scale=�����ų UI�� ũ���� ����� �����ּ���(�⺻�� : 1) : 
if a%scale% == a set scale=1
goto ApplyUI

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
echo �ڽ��� ����ϰ� �ִ� ����� ������ �������ּ���.
echo �ڽ��� ����� ������ �´� �ֽŹ����� �������̾� ��带 ������ѵ帳�ϴ�.
echo ��� : �ش� �������� �۵��ϴ� �������̾� ��尡 ���� �� ����㿡�� �۵����� �ʽ��ϴ�.
echo.
echo 1. older
echo 2. Default
echo 3. Beta
echo 4. Alpha
echo.
echo ------------------------------
echo.
echo.
set /p a=����� ���� (�⺻�� 2) : 

if a%a% == a set a=2

cls
echo ------------------------------
echo.
echo �������̾ �ٿ�ε� ���Դϴ�.
echo.
echo ------------------------------
PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://jongyeol.kr/JipperOverlayer/Overlayer/%a%', 'Overlayer.zip') }"

title �������̾� ����
cls
echo ------------------------------
echo.
echo �������̾ �������Դϴ�.
echo.
echo ------------------------------
powershell -Command "Expand-Archive -Path 'Overlayer.zip' -DestinationPath '%file%\Mods\Overlayer' -Force"

del /f /q Overlayer.zip

goto CheckOverlayerFile


:ApplyUI
title UI ����(0/6)
cls
echo ------------------------------
echo.
echo UI�� �������Դϴ�.
echo �ۡۡۡۡۡ�
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

mkdir "%file%\Mods\Overlayer\Scripts"

PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://github.com/Jongye0l/JIpper-Overlayer/raw/main/Scripts/Scripts.zip', 'Jipper-Overlayer-Scripts.zip') }"

title UI ����(3/6)
cls
echo ------------------------------
echo.
echo UI�� �������Դϴ�.
echo �ܡܡܡۡۡ�
echo.
echo ------------------------------

powershell -Command "Expand-Archive -Path 'Jipper-Overlayer-Scripts.zip' -DestinationPath '%file%\Mods\Overlayer\Scripts' -Force"

if exist "%file%\Mods\Overlayer.Scripting" (
	mkdir "%file%\Mods\Overlayer.Scripting\Scripts"
	powershell -Command "Expand-Archive -Path 'Jipper-Overlayer-Scripts.zip' -DestinationPath '%file%\Mods\Overlayer.Scripting\Scripts' -Force"
)
if exist "%file%\Mods\Overlayer\Modules\Scripting" (
	mkdir "%file%\Mods\Overlayer\Modules\Scripting\Scripts"
	powershell -Command "Expand-Archive -Path 'Jipper-Overlayer-Scripts.zip' -DestinationPath '%file%\Mods\Overlayer\Modules\Scripting\Scripts' -Force"
)

del /f /q "Jipper-Overlayer-Scripts.zip"

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

del /f /q "%file%\Mods\Overlayer\Texts.json"
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
