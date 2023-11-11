@echo off

REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
REM
REM Copyright (C) 2023 Jongyeol.
REM All rights reserved.
REM
REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

del /f /q "Update Completer.bat"
cls

set version=1.0.0

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

PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://jongyeol.click/JipperOverlayer/version', 'version') }"
type "version" | findstr /C:"%version%" >nul

if not %errorlevel% equ 0 (
	cls
	echo ------------------------------
	echo.
	echo 버전이 최신버전이 아니므로 업데이트를 진행합니다.
	echo.
	echo ------------------------------
	FOR /F %%i IN ('TYPE "version"') DO SET "downloadVersion=%%i"
	PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://github.com/Jongye0l/Jipper-Overlayer/releases/download/v%downloadVersion%/Jipper-Overlayer.bat', 'batchfile') }"
	pause
	echo QGVjaG8gb2ZmDQpkZWwgL2YgL3EgSmlwcGVyLU92ZXJsYXllci5iYXQNCm1vdmUg>"Update Completer"
	echo YmF0Y2hmaWxlIEppcHBlci1PdmVybGF5ZXIuYmF0DQoiSmlwcGVyLU92ZXJsYXll>>"Update Completer"
	echo ciI=>>"Update Completer"
	del "Update Completer.bat"
	certutil -decode "Update Completer" "Update Completer.bat"
	del /f /q version
	del /f /q "Update Completer"
	cls
	"Update Completer.bat"
)

del /f /q version
goto CheckModFile

:MainMenu

title 지퍼 오버레이어 설정기
cls
echo ------------------------------
echo.
echo 지퍼 오버레이어 설정기
echo 적용시 자신의 오버레이터 데이터가 날라갑니다.
echo 데이터를 미리 백업해두세요.
echo.
echo.
echo Version : %version%
echo.
echo Developeent : Jongyeol
echo └ Youtube : https://www.youtube.com/@Jongyeol
echo └ Discord : jongyeol_
echo.
echo Contributors : Jipper
echo └ Youtube : https://www.youtube.com/@jipper1214
echo └ Discord : jipper1214
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
PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://jongyeol.click/Overlayer.zip', 'Overlayer.zip') }"

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

title UI 적용(0/10)
cls
echo ------------------------------
echo.
echo UI를 적용중입니다.
echo ○○○○○○○○○○
echo.
echo ------------------------------
if not exist "C:\OverlayerFont\MAPLESTORY_OTF_BOLD.OTF" (
	PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://jongyeol.click/MAPLESTORY_OTF_BOLD.OTF', 'MAPLESTORY_OTF_BOLD.OTF') }"

	title UI 적용(1/10)
	cls
	echo ------------------------------
	echo.
	echo UI를 적용중입니다.
	echo ●○○○○○○○○○
	echo.
	echo ------------------------------
	move "MAPLESTORY_OTF_BOLD.OTF" "C:\OverlayerFont"
)

title UI 적용(2/10)
cls
echo ------------------------------
echo.
echo UI를 적용중입니다.
echo ●●○○○○○○○○
echo.
echo ------------------------------

set filepath=uidumpfile
echo UmVnaXN0ZXJUYWcoIkN1c3RvbUNvbG9yUmFuZ2VQbHVzIiwgZnVuY3Rpb24gKFJB>%filepath%
echo V2Z1bmMsIHJhbmdlMSwgcmFuZ2UyLCBjb2xvcjEsIGNvbG9yMiwgZWFzZVJBVykg>>%filepath%
echo ew0KICBsZXQgZnVuYyA9IGV2YWwoUkFXZnVuYyArICIoOCkiKTsNCiAgaWYgKGlz>>%filepath%
echo TmFOKGZ1bmMpPT0wKSB7DQogICAgbGV0IG51bVZhbHVlID0gcGFyc2VGbG9hdChl>>%filepath%
echo dmFsKGZ1bmMpLnRvU3RyaW5nKCkucmVwbGFjZSgvIi9nLCAiIikpOw0KICAgIGxl>>%filepath%
echo dCBudW1SYW5nZTEgPSBwYXJzZUZsb2F0KHJhbmdlMS5yZXBsYWNlKC8iL2csICIi>>%filepath%
echo KSk7DQogICAgbGV0IG51bVJhbmdlMiA9IHBhcnNlRmxvYXQocmFuZ2UyLnJlcGxh>>%filepath%
echo Y2UoLyIvZywgIiIpKTsNCiAgICBpZiAobnVtVmFsdWUgPCBudW1SYW5nZTEpe251>>%filepath%
echo bVZhbHVlID0gbnVtUmFuZ2UxO30NCiAgICBpZiAobnVtVmFsdWUgPiBudW1SYW5n>>%filepath%
echo ZTIpe251bVZhbHVlID0gbnVtUmFuZ2UyO30NCiAgICBsZXQgSU5lYXNlID0gemVy>>%filepath%
echo b2FuZG9uZShudW1WYWx1ZSxudW1SYW5nZTEsbnVtUmFuZ2UyKTsNCiAgICBsZXQg>>%filepath%
echo ZWFzZSA9IElOZWFzZTsNCiAgICBsZXQgZWFzZXN0ciA9IGVhc2VSQVcudG9TdHJp>>%filepath%
echo bmcoKS50b1VwcGVyQ2FzZSgpOw0KICAgIGlmIChlYXNlc3RyID09ICJJTlNJTkUi>>%filepath%
echo KXtlYXNlID0gZWFzZUluU2luZShJTmVhc2UpO30NCiAgICBpZiAoZWFzZXN0ciA9>>%filepath%
echo PSAiT1VUU0lORSIpe2Vhc2UgPSBlYXNlT3V0U2luZShJTmVhc2UpO30NCiAgICBp>>%filepath%
echo ZiAoZWFzZXN0ciA9PSAiSU5PVVRTSU5FIil7ZWFzZSA9IGVhc2VJbk91dFNpbmUo>>%filepath%
echo SU5lYXNlKTt9DQogICAgaWYgKGVhc2VzdHIgPT0gIklOUVVBRCIpe2Vhc2UgPSBl>>%filepath%
echo YXNlSW5RdWFkKElOZWFzZSk7fQ0KICAgIGlmIChlYXNlc3RyID09ICJPVVRRVUFE>>%filepath%
echo Iil7ZWFzZSA9IGVhc2VPdXRRdWFkKElOZWFzZSk7fQ0KICAgIGlmIChlYXNlc3Ry>>%filepath%
echo ID09ICJJTk9VVFFVQUQiKXtlYXNlID0gZWFzZUluT3V0UXVhZChJTmVhc2UpO30N>>%filepath%
echo CiAgICBpZiAoZWFzZXN0ciA9PSAiSU5DVUJJQyIpe2Vhc2UgPSBlYXNlSW5DdWJp>>%filepath%
echo YyhJTmVhc2UpO30NCiAgICBpZiAoZWFzZXN0ciA9PSAiT1VUQ1VCSUMiKXtlYXNl>>%filepath%
echo ID0gZWFzZU91dEN1YmljKElOZWFzZSk7fQ0KICAgIGlmIChlYXNlc3RyID09ICJJ>>%filepath%
echo Tk9VVENVQklDIil7ZWFzZSA9IGVhc2VJbk91dEN1YmljKElOZWFzZSk7fQ0KICAg>>%filepath%
echo IGlmIChlYXNlc3RyID09ICJJTlFVQU5UIil7ZWFzZSA9IGVhc2VJblF1YXJ0KElO>>%filepath%
echo ZWFzZSk7fQ0KICAgIGlmIChlYXNlc3RyID09ICJPVVRRVUFOVCIpe2Vhc2UgPSBl>>%filepath%
echo YXNlT3V0UXVhcnQoSU5lYXNlKTt9DQogICAgaWYgKGVhc2VzdHIgPT0gIklOT1VU>>%filepath%
echo UVVBTlQiKXtlYXNlID0gZWFzZUluT3V0UXVhcnQoSU5lYXNlKTt9DQogICAgaWYg>>%filepath%
echo KGVhc2VzdHIgPT0gIklOUVVJTlQiKXtlYXNlID0gZWFzZUluUXVpbnQoSU5lYXNl>>%filepath%
echo KTt9DQogICAgaWYgKGVhc2VzdHIgPT0gIk9VVFFVSU5UIil7ZWFzZSA9IGVhc2VP>>%filepath%
echo dXRRdWludChJTmVhc2UpO30NCiAgICBpZiAoZWFzZXN0ciA9PSAiSU5PVVRRVUlO>>%filepath%
echo VCIpe2Vhc2UgPSBlYXNlSW5PdXRRdWludChJTmVhc2UpO30NCiAgICBpZiAoZWFz>>%filepath%
echo ZXN0ciA9PSAiSU5FWFBPIil7ZWFzZSA9IGVhc2VJbkV4cG8oSU5lYXNlKTt9DQog>>%filepath%
echo ICAgaWYgKGVhc2VzdHIgPT0gIk9VVEVYUE8iKXtlYXNlID0gZWFzZU91dEV4cG8o>>%filepath%
echo SU5lYXNlKTt9DQogICAgaWYgKGVhc2VzdHIgPT0gIklOT1VURVhQTyIpe2Vhc2Ug>>%filepath%
echo PSBlYXNlSW5PdXRFeHBvKElOZWFzZSk7fQ0KICAgIGlmIChlYXNlc3RyID09ICJJ>>%filepath%
echo TkNJUkMiKXtlYXNlID0gZWFzZUluQ2lyYyhJTmVhc2UpO30NCiAgICBpZiAoZWFz>>%filepath%
echo ZXN0ciA9PSAiT1VUQ0lSQyIpe2Vhc2UgPSBlYXNlT3V0Q2lyYyhJTmVhc2UpO30N>>%filepath%
echo CiAgICBpZiAoZWFzZXN0ciA9PSAiSU5PVVRDSVJDIil7ZWFzZSA9IGVhc2VJbk91>>%filepath%
echo dENpcmMoSU5lYXNlKTt9DQogICAgaWYgKGVhc2VzdHIgPT0gIklOQkFDSyIpe2Vh>>%filepath%
echo c2UgPSBlYXNlSW5CYWNrKElOZWFzZSk7fQ0KICAgIGlmIChlYXNlc3RyID09ICJP>>%filepath%
echo VVRCQUNLIil7ZWFzZSA9IGVhc2VPdXRCYWNrKElOZWFzZSk7fQ0KICAgIGlmIChl>>%filepath%
echo YXNlc3RyID09ICJJTk9VVEJBQ0siKXtlYXNlID0gZWFzZUluT3V0QmFjayhJTmVh>>%filepath%
echo c2UpO30NCiAgICBpZiAoZWFzZXN0ciA9PSAiSU5FTEFTVElDIil7ZWFzZSA9IGVh>>%filepath%
echo c2VJbkVsYXN0aWMoSU5lYXNlKTt9DQogICAgaWYgKGVhc2VzdHIgPT0gIk9VVEVM>>%filepath%
echo QVNUSUMiKXtlYXNlID0gZWFzZU91dEVsYXN0aWMoSU5lYXNlKTt9DQogICAgaWYg>>%filepath%
echo KGVhc2VzdHIgPT0gIklOT1VURUxBU1RJQyIpe2Vhc2UgPSBlYXNlSW5PdXRFbGFz>>%filepath%
echo dGljKElOZWFzZSk7fQ0KICAgIGlmIChlYXNlc3RyID09ICJJTkJPVU5DRSIpe2Vh>>%filepath%
echo c2UgPSBlYXNlSW5Cb3VuY2UoSU5lYXNlKTt9DQogICAgaWYgKGVhc2VzdHIgPT0g>>%filepath%
echo Ik9VVEJPVU5DRSIpe2Vhc2UgPSBlYXNlT3V0Qm91bmNlKElOZWFzZSk7fQ0KICAg>>%filepath%
echo IGlmIChlYXNlc3RyID09ICJJTk9VVEJPVU5DRSIpe2Vhc2UgPSBlYXNlSW5PdXRC>>%filepath%
echo b3VuY2UoSU5lYXNlKTt9DQogICAgaWYgKGVhc2UgPCAwKXtlYXNlID0gMDt9DQog>>%filepath%
echo ICAgaWYgKGVhc2UgPiAxKXtlYXNlID0gMDt9DQogICAgbGV0IHJlZCA9IE1hdGgu>>%filepath%
echo cm91bmQoKDEgLSBlYXNlKSAqIHBhcnNlSW50KGNvbG9yMS5zdWJzdHJpbmcoMCwg>>%filepath%
echo MiksIDE2KSArIGVhc2UgKiBwYXJzZUludChjb2xvcjIuc3Vic3RyaW5nKDAsIDIp>>%filepath%
echo LCAxNikpOw0KICAgIGxldCBncmVlbiA9IE1hdGgucm91bmQoKDEgLSBlYXNlKSAq>>%filepath%
echo IHBhcnNlSW50KGNvbG9yMS5zdWJzdHJpbmcoMiwgNCksIDE2KSArIGVhc2UgKiBw>>%filepath%
echo YXJzZUludChjb2xvcjIuc3Vic3RyaW5nKDIsIDQpLCAxNikpOw0KICAgIGxldCBi>>%filepath%
echo bHVlID0gTWF0aC5yb3VuZCgoMSAtIGVhc2UpICogcGFyc2VJbnQoY29sb3IxLnN1>>%filepath%
echo YnN0cmluZyg0LCA2KSwgMTYpICsgZWFzZSAqIHBhcnNlSW50KGNvbG9yMi5zdWJz>>%filepath%
echo dHJpbmcoNCwgNiksIDE2KSk7DQogICAgcmV0dXJuIChyZWQudG9TdHJpbmcoMTYp>>%filepath%
echo KS5wYWRTdGFydCgyLCAiMCIpICsgKGdyZWVuLnRvU3RyaW5nKDE2KSkucGFkU3Rh>>%filepath%
echo cnQoMiwgIjAiKSArIChibHVlLnRvU3RyaW5nKDE2KSkucGFkU3RhcnQoMiwgIjAi>>%filepath%
echo KTsNCiAgfSBlbHNlIHsNCiAgICByZXR1cm4gIkZGRkZGRiI7DQogIH0NCn0sIHRy>>%filepath%
echo dWUpDQpmdW5jdGlvbiB6ZXJvYW5kb25lKG5vd1YsIG1pblYsIG1heFYpIHsNCiAg>>%filepath%
echo cmV0dXJuIChNYXRoLm1pbihNYXRoLm1heChub3dWLCBtaW5WKSwgbWF4VikgLSBt>>%filepath%
echo aW5WKSAvIChtYXhWIC0gbWluVik7DQp9DQpmdW5jdGlvbiBlYXNlSW5TaW5lKHQp>>%filepath%
echo IHtyZXR1cm4gMSAtIE1hdGguY29zKCh0ICogTWF0aC5QSSkgLyAyKTt9DQpmdW5j>>%filepath%
echo dGlvbiBlYXNlT3V0U2luZSh0KSB7cmV0dXJuIE1hdGguc2luKCh0ICogTWF0aC5Q>>%filepath%
echo SSkgLyAyKTt9DQpmdW5jdGlvbiBlYXNlSW5PdXRTaW5lKHQpIHtyZXR1cm4gLShN>>%filepath%
echo YXRoLmNvcyhNYXRoLlBJICogdCkgLSAxKSAvIDI7fQ0KZnVuY3Rpb24gZWFzZUlu>>%filepath%
echo UXVhZCh0KSB7cmV0dXJuIHQgKiB0O30NCmZ1bmN0aW9uIGVhc2VPdXRRdWFkKHQp>>%filepath%
echo IHtyZXR1cm4gMSAtICgxIC0gdCkgKiAoMSAtIHQpO30NCmZ1bmN0aW9uIGVhc2VJ>>%filepath%
echo bk91dFF1YWQodCkge3JldHVybiB0IDwgMC41ID8gMiAqIHQgKiB0IDogMSAtIE1h>>%filepath%
echo dGgucG93KC0yICogdCArIDIsIDIpIC8gMjt9DQpmdW5jdGlvbiBlYXNlSW5DdWJp>>%filepath%
echo Yyh0KSB7cmV0dXJuIHQgKiB0ICogdDt9DQpmdW5jdGlvbiBlYXNlT3V0Q3ViaWMo>>%filepath%
echo dCkge3JldHVybiAxIC0gTWF0aC5wb3coMSAtIHQsIDMpO30NCmZ1bmN0aW9uIGVh>>%filepath%
echo c2VJbk91dEN1YmljKHQpIHtyZXR1cm4gdCA8IDAuNSA/IDQgKiB0ICogdCAqIHQg>>%filepath%
echo OiAxIC0gTWF0aC5wb3coLTIgKiB0ICsgMiwgMykgLyAyO30NCmZ1bmN0aW9uIGVh>>%filepath%
echo c2VJblF1YXJ0KHQpIHtyZXR1cm4gdCAqIHQgKiB0ICogdDt9DQpmdW5jdGlvbiBl>>%filepath%
echo YXNlT3V0UXVhcnQodCkge3JldHVybiAxIC0gTWF0aC5wb3coMSAtIHQsIDQpO30N>>%filepath%
echo CmZ1bmN0aW9uIGVhc2VJbk91dFF1YXJ0KHQpIHtyZXR1cm4gdCA8IDAuNSA/IDgg>>%filepath%
echo KiB0ICogdCAqIHQgKiB0IDogMSAtIE1hdGgucG93KC0yICogdCArIDIsIDQpIC8g>>%filepath%
echo Mjt9DQpmdW5jdGlvbiBlYXNlSW5RdWludCh0KSB7cmV0dXJuIHQgKiB0ICogdCAq>>%filepath%
echo IHQgKiB0O30NCmZ1bmN0aW9uIGVhc2VPdXRRdWludCh0KSB7cmV0dXJuIDEgLSBN>>%filepath%
echo YXRoLnBvdygxIC0gdCwgNSk7fQ0KZnVuY3Rpb24gZWFzZUluT3V0UXVpbnQodCkg>>%filepath%
echo e3JldHVybiB0IDwgMC41ID8gMTYgKiB0ICogdCAqIHQgKiB0ICogdCA6IDEgLSBN>>%filepath%
echo YXRoLnBvdygtMiAqIHQgKyAyLCA1KSAvIDI7fQ0KZnVuY3Rpb24gZWFzZUluRXhw>>%filepath%
echo byh0KSB7cmV0dXJuIHQgPT09IDAgPyAwIDogTWF0aC5wb3coMiwgMTAgKiAodCAt>>%filepath%
echo IDEpKTt9DQpmdW5jdGlvbiBlYXNlT3V0RXhwbyh0KSB7cmV0dXJuIHQgPT09IDEg>>%filepath%
echo PyAxIDogMSAtIE1hdGgucG93KDIsIC0xMCAqIHQpO30NCmZ1bmN0aW9uIGVhc2VJ>>%filepath%
echo bk91dEV4cG8odCkge2lmICh0ID09PSAwKSByZXR1cm4gMDtpZiAodCA9PT0gMSkg>>%filepath%
echo cmV0dXJuIDE7aWYgKHQgPCAwLjUpe3JldHVybiAwLjUgKiBNYXRoLnBvdygyLCAy>>%filepath%
echo MCAqIHQgLSAxMCk7fWVsc2V7cmV0dXJuIDEgLSAwLjUgKiBNYXRoLnBvdygyLCAt>>%filepath%
echo MjAgKiB0ICsgMTApO319DQpmdW5jdGlvbiBlYXNlSW5DaXJjKHQpIHtyZXR1cm4g>>%filepath%
echo MSAtIE1hdGguc3FydCgxIC0gdCAqIHQpO30NCmZ1bmN0aW9uIGVhc2VPdXRDaXJj>>%filepath%
echo KHQpIHtyZXR1cm4gTWF0aC5zcXJ0KDEgLSAodCAtIDEpICogKHQgLSAxKSk7fQ0K>>%filepath%
echo ZnVuY3Rpb24gZWFzZUluT3V0Q2lyYyh0KSB7aWYgKHQgPCAwLjUpIHtyZXR1cm4g>>%filepath%
echo MC41ICogKDEgLSBNYXRoLnNxcnQoMSAtIDQgKiB0ICogdCkpO31lbHNle3JldHVy>>%filepath%
echo biAwLjUgKiAoTWF0aC5zcXJ0KDEgLSAoMiAqIHQgLSAyKSAqICgyICogdCAtIDIp>>%filepath%
echo KSArIDEpO319DQpmdW5jdGlvbiBlYXNlSW5CYWNrKHQsIHMgPSAxLjcwMTU4KSB7>>%filepath%
echo cmV0dXJuIHQgKiB0ICogKChzICsgMSkgKiB0IC0gcyk7fQ0KZnVuY3Rpb24gZWFz>>%filepath%
echo ZU91dEJhY2sodCwgcyA9IDEuNzAxNTgpIHtyZXR1cm4gKHQgPSB0IC0gMSkgKiB0>>%filepath%
echo ICogKChzICsgMSkgKiB0ICsgcykgKyAxO30NCmZ1bmN0aW9uIGVhc2VJbk91dEJh>>%filepath%
echo Y2sodCwgcyA9IDEuNzAxNTgpIHtpZiAoKHQgLz0gMC41KSA8IDEpIHJldHVybiAw>>%filepath%
echo LjUgKiAodCAqIHQgKiAoKChzICo9IDEuNTI1KSArIDEpICogdCAtIHMpKTtyZXR1>>%filepath%
echo cm4gMC41ICogKCh0IC09IDIpICogdCAqICgoKHMgKj0gMS41MjUpICsgMSkgKiB0>>%filepath%
echo ICsgcykgKyAyKTt9DQpmdW5jdGlvbiBlYXNlSW5FbGFzdGljKHQpIHtpZiAodCA9>>%filepath%
echo PT0gMCkgcmV0dXJuIDA7aWYgKHQgPT09IDEpIHJldHVybiAxO3JldHVybiAtTWF0>>%filepath%
echo aC5wb3coMiwgMTAgKiB0IC0gMTApICogTWF0aC5zaW4oKHQgKiAxMCAtIDEwLjc1>>%filepath%
echo KSAqICgyICogTWF0aC5QSSkgLyAzKTt9DQpmdW5jdGlvbiBlYXNlT3V0RWxhc3Rp>>%filepath%
echo Yyh0KSB7aWYgKHQgPT09IDApIHJldHVybiAwO2lmICh0ID09PSAxKSByZXR1cm4g>>%filepath%
echo MTtyZXR1cm4gTWF0aC5wb3coMiwgLTEwICogdCkgKiBNYXRoLnNpbigodCAqIDEw>>%filepath%
echo IC0gMC43NSkgKiAoMiAqIE1hdGguUEkpIC8gMykgKyAxO30NCmZ1bmN0aW9uIGVh>>%filepath%
echo c2VJbk91dEVsYXN0aWModCkge2lmICh0ID09PSAwKSByZXR1cm4gMDtpZiAodCA9>>%filepath%
echo PT0gMSkgcmV0dXJuIDE7dCAqPSAyO2lmICh0IDwgMSl7cmV0dXJuIC0wLjUgKiAo>>%filepath%
echo TWF0aC5wb3coMiwgMTAgKiB0IC0gMTApICogTWF0aC5zaW4oKHQgKiAxMCAtIDEw>>%filepath%
echo Ljc1KSAqICgyICogTWF0aC5QSSkgLyAzKSk7fWVsc2V7cmV0dXJuIDAuNSAqIChN>>%filepath%
echo YXRoLnBvdygyLCAtMTAgKiAodCAtIDEpKSAqIE1hdGguc2luKCh0ICogMTAgLSAx>>%filepath%
echo MC43NSkgKiAoMiAqIE1hdGguUEkpIC8gMykpICsgMTt9fQ0KZnVuY3Rpb24gZWFz>>%filepath%
echo ZUluQm91bmNlKHQpIHtyZXR1cm4gMSAtIGVhc2VPdXRCb3VuY2UoMSAtIHQpO30N>>%filepath%
echo CmZ1bmN0aW9uIGVhc2VPdXRCb3VuY2UodCkge2lmICh0IDwgKDEgLyAyLjc1KSkg>>%filepath%
echo e3JldHVybiA3LjU2MjUgKiB0ICogdDt9ZWxzZSBpZih0IDwgKDIgLyAyLjc1KSl7>>%filepath%
echo cmV0dXJuIDcuNTYyNSAqICh0IC09ICgxLjUgLyAyLjc1KSkgKiB0ICsgMC43NTt9>>%filepath%
echo ZWxzZSBpZih0IDwgKDIuNSAvIDIuNzUpKXtyZXR1cm4gNy41NjI1ICogKHQgLT0g>>%filepath%
echo KDIuMjUgLyAyLjc1KSkgKiB0ICsgMC45Mzc1O31lbHNle3JldHVybiA3LjU2MjUg>>%filepath%
echo KiAodCAtPSAoMi42MjUgLyAyLjc1KSkgKiB0ICsgMC45ODQzNzU7fX0NCmZ1bmN0>>%filepath%
echo aW9uIGVhc2VJbk91dEJvdW5jZSh0KSB7aWYgKHQgPCAwLjUpIHJldHVybiBlYXNl>>%filepath%
echo SW5Cb3VuY2UodCAqIDIpICogMC41O3JldHVybiBlYXNlT3V0Qm91bmNlKHQgKiAy>>%filepath%
echo IC0gMSkgKiAwLjUgKyAwLjU7fQ==>>%filepath%

title UI 적용(3/10)
cls
echo ------------------------------
echo.
echo UI를 적용중입니다.
echo ●●●○○○○○○○
echo.
echo ------------------------------

del "%file%\Mods\Overlayer\Scripts\CustomColorRangePlus.js"
certutil -decode %filepath% "%file%\Mods\Overlayer\Scripts\CustomColorRangePlus.js"

title UI 적용(4/10)
cls
echo ------------------------------
echo.
echo UI를 적용중입니다.
echo ●●●●○○○○○○
echo.
echo ------------------------------

echo UmVnaXN0ZXJUYWcoIkZ1bGxYQWNjdXJhY3lKIiwgZnVuY3Rpb24gKCkgew0KICAg>%filepath%
echo IGlmKFhBY2N1cmFjeSgpID09PSAxMDApe3JldHVybiAiPGNvbG9yPSNGRkRBMDA+>>%filepath%
echo IiArIFhBY2N1cmFjeSgyKSArICIlPC9jb2xvcj4ifQ0KICAgIGVsc2V7cmV0dXJu>>%filepath%
echo IFhBY2N1cmFjeSgyKX0NCn0sIHRydWUpOw==>>%filepath%

title UI 적용(5/10)
cls
echo ------------------------------
echo.
echo UI를 적용중입니다.
echo ●●●●●○○○○○
echo.
echo ------------------------------

del "%file%\Mods\Overlayer\Scripts\FullXAccuracy.js"
certutil -decode %filepath% "%file%\Mods\Overlayer\Scripts\FullXAccuracy.js"

title UI 적용(6/10)
cls
echo ------------------------------
echo.
echo UI를 적용중입니다.
echo ●●●●●●○○○○
echo.
echo ------------------------------

echo UmVnaXN0ZXJUYWcoIk1vdmluZ01hbk4iLCBmdW5jdGlvbiAoU3RhcnRTaXplUkFX>%filepath%
echo LCBNYXhTaXplUkFXLCBTcGVlZFJBVywgU3ViU2l6ZVJBVywgQ2hhbmdlUkFXLCBl>>%filepath%
echo YXNlUkFXKSB7DQogICAgbGV0IEZ1bmMgPSBDb21ibygpOyBsZXQgU3RhcnRTaXpl>>%filepath%
echo ID0gMzA7IGxldCBNYXhTaXplID0gODA7IGxldCBTcGVlZCA9IDgwMDsgbGV0IFN1>>%filepath%
echo YlNpemUgPSAzMDsgLy82NeuyiOykhOqzvCDtlbTri7kg7KSE7J2YIO2VqOyImOul>>%filepath%
echo vCDrsJTqv4Ag7IiYIOyeiOyKteuLiOuLpC4NCiAgICBpZihpc05hTihwYXJzZUZs>>%filepath%
echo b2F0KFN0YXJ0U2l6ZVJBVykpPT0wKXtTdGFydFNpemUgPSBTdGFydFNpemVSQVc7>>%filepath%
echo fQ0KICAgIGlmKGlzTmFOKHBhcnNlRmxvYXQoU3ViU2l6ZVJBVykpPT0wKXtTdWJT>>%filepath%
echo aXplID0gU3ViU2l6ZVJBVzt9DQogICAgaWYoaXNOYU4ocGFyc2VGbG9hdChNYXhT>>%filepath%
echo aXplUkFXKSk9PTApe01heFNpemUgPSBNYXhTaXplUkFXO30NCiAgICBpZihpc05h>>%filepath%
echo TihwYXJzZUZsb2F0KFNwZWVkUkFXKSk9PTApe1NwZWVkID0gU3BlZWRSQVc7fQ0K>>%filepath%
echo ICAgIGlmKGlzTmFOKEZ1bmMpKXtyZXR1cm4gU3ViU2l6ZX0NCiAgICBpZiAoRnVu>>%filepath%
echo YyAhPT0gU3ViRnVuYyl7U3ViRnVuYyA9IEZ1bmM7U3RhcnRUaW1lID0gbmV3IERh>>%filepath%
echo dGUoKS5nZXRUaW1lKCk7fQ0KICAgIGxldCBlbGFwc2VkVGltZSA9IG5ldyBEYXRl>>%filepath%
echo KCkuZ2V0VGltZSgpIC0gU3RhcnRUaW1lOw0KICAgIGlmIChlbGFwc2VkVGltZSA8>>%filepath%
echo IFNwZWVkKXsNCiAgICAgICAgbGV0IElOZWFzZSA9IChlbGFwc2VkVGltZSAvIFNw>>%filepath%
echo ZWVkKTsNCiAgICAgICAgbGV0IGVhc2UgPSBJTmVhc2U7DQogICAgICAgIGxldCBl>>%filepath%
echo YXNlc3RyID0gZWFzZVJBVy50b1N0cmluZygpLnRvVXBwZXJDYXNlKCk7DQogICAg>>%filepath%
echo ICAgIGlmIChlYXNlc3RyID09ICJJTlNJTkUiKXtlYXNlID0gZWFzZUluU2luZShJ>>%filepath%
echo TmVhc2UpO30NCiAgICAgICAgaWYgKGVhc2VzdHIgPT0gIk9VVFNJTkUiKXtlYXNl>>%filepath%
echo ID0gZWFzZU91dFNpbmUoSU5lYXNlKTt9DQogICAgICAgIGlmIChlYXNlc3RyID09>>%filepath%
echo ICJJTk9VVFNJTkUiKXtlYXNlID0gZWFzZUluT3V0U2luZShJTmVhc2UpO30NCiAg>>%filepath%
echo ICAgICAgaWYgKGVhc2VzdHIgPT0gIklOUVVBRCIpe2Vhc2UgPSBlYXNlSW5RdWFk>>%filepath%
echo KElOZWFzZSk7fQ0KICAgICAgICBpZiAoZWFzZXN0ciA9PSAiT1VUUVVBRCIpe2Vh>>%filepath%
echo c2UgPSBlYXNlT3V0UXVhZChJTmVhc2UpO30NCiAgICAgICAgaWYgKGVhc2VzdHIg>>%filepath%
echo PT0gIklOT1VUUVVBRCIpe2Vhc2UgPSBlYXNlSW5PdXRRdWFkKElOZWFzZSk7fQ0K>>%filepath%
echo ICAgICAgICBpZiAoZWFzZXN0ciA9PSAiSU5DVUJJQyIpe2Vhc2UgPSBlYXNlSW5D>>%filepath%
echo dWJpYyhJTmVhc2UpO30NCiAgICAgICAgaWYgKGVhc2VzdHIgPT0gIk9VVENVQklD>>%filepath%
echo Iil7ZWFzZSA9IGVhc2VPdXRDdWJpYyhJTmVhc2UpO30NCiAgICAgICAgaWYgKGVh>>%filepath%
echo c2VzdHIgPT0gIklOT1VUQ1VCSUMiKXtlYXNlID0gZWFzZUluT3V0Q3ViaWMoSU5l>>%filepath%
echo YXNlKTt9DQogICAgICAgIGlmIChlYXNlc3RyID09ICJJTlFVQU5UIil7ZWFzZSA9>>%filepath%
echo IGVhc2VJblF1YXJ0KElOZWFzZSk7fQ0KICAgICAgICBpZiAoZWFzZXN0ciA9PSAi>>%filepath%
echo T1VUUVVBTlQiKXtlYXNlID0gZWFzZU91dFF1YXJ0KElOZWFzZSk7fQ0KICAgICAg>>%filepath%
echo ICBpZiAoZWFzZXN0ciA9PSAiSU5PVVRRVUFOVCIpe2Vhc2UgPSBlYXNlSW5PdXRR>>%filepath%
echo dWFydChJTmVhc2UpO30NCiAgICAgICAgaWYgKGVhc2VzdHIgPT0gIklOUVVJTlQi>>%filepath%
echo KXtlYXNlID0gZWFzZUluUXVpbnQoSU5lYXNlKTt9DQogICAgICAgIGlmIChlYXNl>>%filepath%
echo c3RyID09ICJPVVRRVUlOVCIpe2Vhc2UgPSBlYXNlT3V0UXVpbnQoSU5lYXNlKTt9>>%filepath%
echo DQogICAgICAgIGlmIChlYXNlc3RyID09ICJJTk9VVFFVSU5UIil7ZWFzZSA9IGVh>>%filepath%
echo c2VJbk91dFF1aW50KElOZWFzZSk7fQ0KICAgICAgICBpZiAoZWFzZXN0ciA9PSAi>>%filepath%
echo SU5FWFBPIil7ZWFzZSA9IGVhc2VJbkV4cG8oSU5lYXNlKTt9DQogICAgICAgIGlm>>%filepath%
echo IChlYXNlc3RyID09ICJPVVRFWFBPIil7ZWFzZSA9IGVhc2VPdXRFeHBvKElOZWFz>>%filepath%
echo ZSk7fQ0KICAgICAgICBpZiAoZWFzZXN0ciA9PSAiSU5PVVRFWFBPIil7ZWFzZSA9>>%filepath%
echo IGVhc2VJbk91dEV4cG8oSU5lYXNlKTt9DQogICAgICAgIGlmIChlYXNlc3RyID09>>%filepath%
echo ICJJTkNJUkMiKXtlYXNlID0gZWFzZUluQ2lyYyhJTmVhc2UpO30NCiAgICAgICAg>>%filepath%
echo aWYgKGVhc2VzdHIgPT0gIk9VVENJUkMiKXtlYXNlID0gZWFzZU91dENpcmMoSU5l>>%filepath%
echo YXNlKTt9DQogICAgICAgIGlmIChlYXNlc3RyID09ICJJTk9VVENJUkMiKXtlYXNl>>%filepath%
echo ID0gZWFzZUluT3V0Q2lyYyhJTmVhc2UpO30NCiAgICAgICAgaWYgKGVhc2VzdHIg>>%filepath%
echo PT0gIklOQkFDSyIpe2Vhc2UgPSBlYXNlSW5CYWNrKElOZWFzZSk7fQ0KICAgICAg>>%filepath%
echo ICBpZiAoZWFzZXN0ciA9PSAiT1VUQkFDSyIpe2Vhc2UgPSBlYXNlT3V0QmFjayhJ>>%filepath%
echo TmVhc2UpO30NCiAgICAgICAgaWYgKGVhc2VzdHIgPT0gIklOT1VUQkFDSyIpe2Vh>>%filepath%
echo c2UgPSBlYXNlSW5PdXRCYWNrKElOZWFzZSk7fQ0KICAgICAgICBpZiAoZWFzZXN0>>%filepath%
echo ciA9PSAiSU5FTEFTVElDIil7ZWFzZSA9IGVhc2VJbkVsYXN0aWMoSU5lYXNlKTt9>>%filepath%
echo DQogICAgICAgIGlmIChlYXNlc3RyID09ICJPVVRFTEFTVElDIil7ZWFzZSA9IGVh>>%filepath%
echo c2VPdXRFbGFzdGljKElOZWFzZSk7fQ0KICAgICAgICBpZiAoZWFzZXN0ciA9PSAi>>%filepath%
echo SU5PVVRFTEFTVElDIil7ZWFzZSA9IGVhc2VJbk91dEVsYXN0aWMoSU5lYXNlKTt9>>%filepath%
echo DQogICAgICAgIGlmIChlYXNlc3RyID09ICJJTkJPVU5DRSIpe2Vhc2UgPSBlYXNl>>%filepath%
echo SW5Cb3VuY2UoSU5lYXNlKTt9DQogICAgICAgIGlmIChlYXNlc3RyID09ICJPVVRC>>%filepath%
echo T1VOQ0UiKXtlYXNlID0gZWFzZU91dEJvdW5jZShJTmVhc2UpO30NCiAgICAgICAg>>%filepath%
echo aWYgKGVhc2VzdHIgPT0gIklOT1VUQk9VTkNFIil7ZWFzZSA9IGVhc2VJbk91dEJv>>%filepath%
echo dW5jZShJTmVhc2UpO30NCiAgICAgICAgbGV0IENoYW5nZU91dCA9IE1heFNpemUg>>%filepath%
echo KiBlYXNlOw0KICAgICAgICBpZihDaGFuZ2VSQVcgPT0gMSl7Q2hhbmdlT3V0ID0g>>%filepath%
echo TWF4U2l6ZSAqICgxLWVhc2UpO30NCiAgICAgICAgbGV0IGludGVycG9sYXRlZFZh>>%filepath%
echo bHVlID0gQ2hhbmdlT3V0Ow0KICAgICAgICBpZiAoaW50ZXJwb2xhdGVkVmFsdWUg>>%filepath%
echo PiBNYXhTaXplKSB7aW50ZXJwb2xhdGVkVmFsdWUgPSBNYXhTaXplO30NCiAgICAg>>%filepath%
echo ICAgaWYgKGludGVycG9sYXRlZFZhbHVlIDwgMCkge2ludGVycG9sYXRlZFZhbHVl>>%filepath%
echo ID0gMDt9DQogICAgICAgIHJldHVybiAoaW50ZXJwb2xhdGVkVmFsdWUgKyBwYXJz>>%filepath%
echo ZUludChTdGFydFNpemUpKS50b0ZpeGVkKDQpOw0KICAgIH0NCiAgICBlbHNle3Jl>>%filepath%
echo dHVybiBTdWJTaXplO30NCn0sIHRydWUpOw0KbGV0IFN1YkZ1bmMgPSBDb21ibygp>>%filepath%
echo OyAvL+ydtOqyg+uPhCDrsJTqv5Tso7zshLjsmpQuDQpsZXQgU3RhcnRUaW1lID0g>>%filepath%
echo bmV3IERhdGUoKS5nZXRUaW1lKCk7DQpmdW5jdGlvbiBlYXNlSW5TaW5lKHQpIHty>>%filepath%
echo ZXR1cm4gMSAtIE1hdGguY29zKCh0ICogTWF0aC5QSSkgLyAyKTt9DQpmdW5jdGlv>>%filepath%
echo biBlYXNlT3V0U2luZSh0KSB7cmV0dXJuIE1hdGguc2luKCh0ICogTWF0aC5QSSkg>>%filepath%
echo LyAyKTt9DQpmdW5jdGlvbiBlYXNlSW5PdXRTaW5lKHQpIHtyZXR1cm4gLShNYXRo>>%filepath%
echo LmNvcyhNYXRoLlBJICogdCkgLSAxKSAvIDI7fQ0KZnVuY3Rpb24gZWFzZUluUXVh>>%filepath%
echo ZCh0KSB7cmV0dXJuIHQgKiB0O30NCmZ1bmN0aW9uIGVhc2VPdXRRdWFkKHQpIHty>>%filepath%
echo ZXR1cm4gMSAtICgxIC0gdCkgKiAoMSAtIHQpO30NCmZ1bmN0aW9uIGVhc2VJbk91>>%filepath%
echo dFF1YWQodCkge3JldHVybiB0IDwgMC41ID8gMiAqIHQgKiB0IDogMSAtIE1hdGgu>>%filepath%
echo cG93KC0yICogdCArIDIsIDIpIC8gMjt9DQpmdW5jdGlvbiBlYXNlSW5DdWJpYyh0>>%filepath%
echo KSB7cmV0dXJuIHQgKiB0ICogdDt9DQpmdW5jdGlvbiBlYXNlT3V0Q3ViaWModCkg>>%filepath%
echo e3JldHVybiAxIC0gTWF0aC5wb3coMSAtIHQsIDMpO30NCmZ1bmN0aW9uIGVhc2VJ>>%filepath%
echo bk91dEN1YmljKHQpIHtyZXR1cm4gdCA8IDAuNSA/IDQgKiB0ICogdCAqIHQgOiAx>>%filepath%
echo IC0gTWF0aC5wb3coLTIgKiB0ICsgMiwgMykgLyAyO30NCmZ1bmN0aW9uIGVhc2VJ>>%filepath%
echo blF1YXJ0KHQpIHtyZXR1cm4gdCAqIHQgKiB0ICogdDt9DQpmdW5jdGlvbiBlYXNl>>%filepath%
echo T3V0UXVhcnQodCkge3JldHVybiAxIC0gTWF0aC5wb3coMSAtIHQsIDQpO30NCmZ1>>%filepath%
echo bmN0aW9uIGVhc2VJbk91dFF1YXJ0KHQpIHtyZXR1cm4gdCA8IDAuNSA/IDggKiB0>>%filepath%
echo ICogdCAqIHQgKiB0IDogMSAtIE1hdGgucG93KC0yICogdCArIDIsIDQpIC8gMjt9>>%filepath%
echo DQpmdW5jdGlvbiBlYXNlSW5RdWludCh0KSB7cmV0dXJuIHQgKiB0ICogdCAqIHQg>>%filepath%
echo KiB0O30NCmZ1bmN0aW9uIGVhc2VPdXRRdWludCh0KSB7cmV0dXJuIDEgLSBNYXRo>>%filepath%
echo LnBvdygxIC0gdCwgNSk7fQ0KZnVuY3Rpb24gZWFzZUluT3V0UXVpbnQodCkge3Jl>>%filepath%
echo dHVybiB0IDwgMC41ID8gMTYgKiB0ICogdCAqIHQgKiB0ICogdCA6IDEgLSBNYXRo>>%filepath%
echo LnBvdygtMiAqIHQgKyAyLCA1KSAvIDI7fQ0KZnVuY3Rpb24gZWFzZUluRXhwbyh0>>%filepath%
echo KSB7cmV0dXJuIHQgPT09IDAgPyAwIDogTWF0aC5wb3coMiwgMTAgKiAodCAtIDEp>>%filepath%
echo KTt9DQpmdW5jdGlvbiBlYXNlT3V0RXhwbyh0KSB7cmV0dXJuIHQgPT09IDEgPyAx>>%filepath%
echo IDogMSAtIE1hdGgucG93KDIsIC0xMCAqIHQpO30NCmZ1bmN0aW9uIGVhc2VJbk91>>%filepath%
echo dEV4cG8odCkge2lmICh0ID09PSAwKSByZXR1cm4gMDtpZiAodCA9PT0gMSkgcmV0>>%filepath%
echo dXJuIDE7aWYgKHQgPCAwLjUpe3JldHVybiAwLjUgKiBNYXRoLnBvdygyLCAyMCAq>>%filepath%
echo IHQgLSAxMCk7fWVsc2V7cmV0dXJuIDEgLSAwLjUgKiBNYXRoLnBvdygyLCAtMjAg>>%filepath%
echo KiB0ICsgMTApO319DQpmdW5jdGlvbiBlYXNlSW5DaXJjKHQpIHtyZXR1cm4gMSAt>>%filepath%
echo IE1hdGguc3FydCgxIC0gdCAqIHQpO30NCmZ1bmN0aW9uIGVhc2VPdXRDaXJjKHQp>>%filepath%
echo IHtyZXR1cm4gTWF0aC5zcXJ0KDEgLSAodCAtIDEpICogKHQgLSAxKSk7fQ0KZnVu>>%filepath%
echo Y3Rpb24gZWFzZUluT3V0Q2lyYyh0KSB7aWYgKHQgPCAwLjUpIHtyZXR1cm4gMC41>>%filepath%
echo ICogKDEgLSBNYXRoLnNxcnQoMSAtIDQgKiB0ICogdCkpO31lbHNle3JldHVybiAw>>%filepath%
echo LjUgKiAoTWF0aC5zcXJ0KDEgLSAoMiAqIHQgLSAyKSAqICgyICogdCAtIDIpKSAr>>%filepath%
echo IDEpO319DQpmdW5jdGlvbiBlYXNlSW5CYWNrKHQsIHMgPSAxLjcwMTU4KSB7cmV0>>%filepath%
echo dXJuIHQgKiB0ICogKChzICsgMSkgKiB0IC0gcyk7fQ0KZnVuY3Rpb24gZWFzZU91>>%filepath%
echo dEJhY2sodCwgcyA9IDEuNzAxNTgpIHtyZXR1cm4gKHQgPSB0IC0gMSkgKiB0ICog>>%filepath%
echo KChzICsgMSkgKiB0ICsgcykgKyAxO30NCmZ1bmN0aW9uIGVhc2VJbk91dEJhY2so>>%filepath%
echo dCwgcyA9IDEuNzAxNTgpIHtpZiAoKHQgLz0gMC41KSA8IDEpIHJldHVybiAwLjUg>>%filepath%
echo KiAodCAqIHQgKiAoKChzICo9IDEuNTI1KSArIDEpICogdCAtIHMpKTtyZXR1cm4g>>%filepath%
echo MC41ICogKCh0IC09IDIpICogdCAqICgoKHMgKj0gMS41MjUpICsgMSkgKiB0ICsg>>%filepath%
echo cykgKyAyKTt9DQpmdW5jdGlvbiBlYXNlSW5FbGFzdGljKHQpIHtpZiAodCA9PT0g>>%filepath%
echo MCkgcmV0dXJuIDA7aWYgKHQgPT09IDEpIHJldHVybiAxO3JldHVybiAtTWF0aC5w>>%filepath%
echo b3coMiwgMTAgKiB0IC0gMTApICogTWF0aC5zaW4oKHQgKiAxMCAtIDEwLjc1KSAq>>%filepath%
echo ICgyICogTWF0aC5QSSkgLyAzKTt9DQpmdW5jdGlvbiBlYXNlT3V0RWxhc3RpYyh0>>%filepath%
echo KSB7aWYgKHQgPT09IDApIHJldHVybiAwO2lmICh0ID09PSAxKSByZXR1cm4gMTty>>%filepath%
echo ZXR1cm4gTWF0aC5wb3coMiwgLTEwICogdCkgKiBNYXRoLnNpbigodCAqIDEwIC0g>>%filepath%
echo MC43NSkgKiAoMiAqIE1hdGguUEkpIC8gMykgKyAxO30NCmZ1bmN0aW9uIGVhc2VJ>>%filepath%
echo bk91dEVsYXN0aWModCkge2lmICh0ID09PSAwKSByZXR1cm4gMDtpZiAodCA9PT0g>>%filepath%
echo MSkgcmV0dXJuIDE7dCAqPSAyO2lmICh0IDwgMSl7cmV0dXJuIC0wLjUgKiAoTWF0>>%filepath%
echo aC5wb3coMiwgMTAgKiB0IC0gMTApICogTWF0aC5zaW4oKHQgKiAxMCAtIDEwLjc1>>%filepath%
echo KSAqICgyICogTWF0aC5QSSkgLyAzKSk7fWVsc2V7cmV0dXJuIDAuNSAqIChNYXRo>>%filepath%
echo LnBvdygyLCAtMTAgKiAodCAtIDEpKSAqIE1hdGguc2luKCh0ICogMTAgLSAxMC43>>%filepath%
echo NSkgKiAoMiAqIE1hdGguUEkpIC8gMykpICsgMTt9fQ0KZnVuY3Rpb24gZWFzZUlu>>%filepath%
echo Qm91bmNlKHQpIHtyZXR1cm4gMSAtIGVhc2VPdXRCb3VuY2UoMSAtIHQpO30NCmZ1>>%filepath%
echo bmN0aW9uIGVhc2VPdXRCb3VuY2UodCkge2lmICh0IDwgKDEgLyAyLjc1KSkge3Jl>>%filepath%
echo dHVybiA3LjU2MjUgKiB0ICogdDt9ZWxzZSBpZih0IDwgKDIgLyAyLjc1KSl7cmV0>>%filepath%
echo dXJuIDcuNTYyNSAqICh0IC09ICgxLjUgLyAyLjc1KSkgKiB0ICsgMC43NTt9ZWxz>>%filepath%
echo ZSBpZih0IDwgKDIuNSAvIDIuNzUpKXtyZXR1cm4gNy41NjI1ICogKHQgLT0gKDIu>>%filepath%
echo MjUgLyAyLjc1KSkgKiB0ICsgMC45Mzc1O31lbHNle3JldHVybiA3LjU2MjUgKiAo>>%filepath%
echo dCAtPSAoMi42MjUgLyAyLjc1KSkgKiB0ICsgMC45ODQzNzU7fX0NCmZ1bmN0aW9u>>%filepath%
echo IGVhc2VJbk91dEJvdW5jZSh0KSB7aWYgKHQgPCAwLjUpIHJldHVybiBlYXNlSW5C>>%filepath%
echo b3VuY2UodCAqIDIpICogMC41O3JldHVybiBlYXNlT3V0Qm91bmNlKHQgKiAyIC0g>>%filepath%
echo MSkgKiAwLjUgKyAwLjU7fQ==>>%filepath%

title UI 적용(7/10)
cls
echo ------------------------------
echo.
echo UI를 적용중입니다.
echo ●●●●●●●○○○
echo.
echo ------------------------------

del "%file%\Mods\Overlayer\Scripts\MovingManN.js"
certutil -decode %filepath% "%file%\Mods\Overlayer\Scripts\MovingManN.js"

title UI 적용(8/10)
cls
echo ------------------------------
echo.
echo UI를 적용중입니다.
echo ●●●●●●●●○○
echo.
echo ------------------------------

PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://jongyeol.click/JipperOverlayer/Texts/%scale%', 'Texts.json') }"

title UI 적용(9/10)
cls
echo ------------------------------
echo.
echo UI를 적용중입니다.
echo ●●●●●●●●●○
echo.
echo ------------------------------

del "%file%\Mods\Overlayer\Texts.json"
move "Texts.json" "%file%\Mods\Overlayer"

title UI 적용(10/10)
cls
echo ------------------------------
echo.
echo UI를 적용을 완료했습니다.
echo ●●●●●●●●●●
echo.
echo ------------------------------

del /f /q %filepath%

pause
exit
