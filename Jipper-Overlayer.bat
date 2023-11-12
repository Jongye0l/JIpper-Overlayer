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

if not exist "%file%\Mods\Overlayer\Scripts" mkdir "%file%\Mods\Overlayer\Scripts"

set filepath=uidumpfile
echo UmVnaXN0ZXJUYWcoIkN1c3RvbUNvbG9yUmFuZ2VQbHVzIiwgZnVuY3Rpb24gKFJB>>%filepath%
echo V2Z1bmMsIHJhbmdlMSwgcmFuZ2UyLCBjb2xvcjEsIGNvbG9yMiwgZWFzZVJBVykg>>%filepath%
echo ew0KICBsZXQgZnVuYyA9IGV2YWwoUkFXZnVuYyArICIoOCkiKTsNCiAgcmFuZ2Ux>>%filepath%
echo ID0gcmFuZ2UxLnJlcGxhY2UoIiwgIiwgIiIpOw0KICByYW5nZTIgPSByYW5nZTIu>>%filepath%
echo cmVwbGFjZSgiLCAiLCAiIik7DQogIGNvbG9yMSA9IGNvbG9yMS5yZXBsYWNlKCIs>>%filepath%
echo ICIsICIiKTsNCiAgY29sb3IyID0gY29sb3IyLnJlcGxhY2UoIiwgIiwgIiIpOw0K>>%filepath%
echo ICBlYXNlUkFXID0gZWFzZVJBVy5yZXBsYWNlKCIsICIsICIiKTsNCiAgaWYgKGlz>>%filepath%
echo TmFOKGZ1bmMpPT0wKSB7DQogICAgbGV0IG51bVZhbHVlID0gcGFyc2VGbG9hdChl>>%filepath%
echo dmFsKGZ1bmMpLnRvU3RyaW5nKCkpOw0KICAgIGxldCBudW1SYW5nZTEgPSBwYXJz>>%filepath%
echo ZUZsb2F0KHJhbmdlMSk7DQogICAgbGV0IG51bVJhbmdlMiA9IHBhcnNlRmxvYXQo>>%filepath%
echo cmFuZ2UyKTsNCiAgICBpZiAobnVtVmFsdWUgPCBudW1SYW5nZTEpe251bVZhbHVl>>%filepath%
echo ID0gbnVtUmFuZ2UxO30NCiAgICBpZiAobnVtVmFsdWUgPiBudW1SYW5nZTIpe251>>%filepath%
echo bVZhbHVlID0gbnVtUmFuZ2UyO30NCiAgICBsZXQgSU5lYXNlID0gemVyb2FuZG9u>>%filepath%
echo ZShudW1WYWx1ZSxudW1SYW5nZTEsbnVtUmFuZ2UyKTsNCiAgICBsZXQgZWFzZSA9>>%filepath%
echo IElOZWFzZTsNCiAgICBsZXQgZWFzZXN0ciA9IGVhc2VSQVcudG9TdHJpbmcoKS50>>%filepath%
echo b1VwcGVyQ2FzZSgpOw0KICAgIGlmIChlYXNlc3RyID09ICJJTlNJTkUiKXtlYXNl>>%filepath%
echo ID0gZWFzZUluU2luZShJTmVhc2UpO30NCiAgICBpZiAoZWFzZXN0ciA9PSAiT1VU>>%filepath%
echo U0lORSIpe2Vhc2UgPSBlYXNlT3V0U2luZShJTmVhc2UpO30NCiAgICBpZiAoZWFz>>%filepath%
echo ZXN0ciA9PSAiSU5PVVRTSU5FIil7ZWFzZSA9IGVhc2VJbk91dFNpbmUoSU5lYXNl>>%filepath%
echo KTt9DQogICAgaWYgKGVhc2VzdHIgPT0gIklOUVVBRCIpe2Vhc2UgPSBlYXNlSW5R>>%filepath%
echo dWFkKElOZWFzZSk7fQ0KICAgIGlmIChlYXNlc3RyID09ICJPVVRRVUFEIil7ZWFz>>%filepath%
echo ZSA9IGVhc2VPdXRRdWFkKElOZWFzZSk7fQ0KICAgIGlmIChlYXNlc3RyID09ICJJ>>%filepath%
echo Tk9VVFFVQUQiKXtlYXNlID0gZWFzZUluT3V0UXVhZChJTmVhc2UpO30NCiAgICBp>>%filepath%
echo ZiAoZWFzZXN0ciA9PSAiSU5DVUJJQyIpe2Vhc2UgPSBlYXNlSW5DdWJpYyhJTmVh>>%filepath%
echo c2UpO30NCiAgICBpZiAoZWFzZXN0ciA9PSAiT1VUQ1VCSUMiKXtlYXNlID0gZWFz>>%filepath%
echo ZU91dEN1YmljKElOZWFzZSk7fQ0KICAgIGlmIChlYXNlc3RyID09ICJJTk9VVENV>>%filepath%
echo QklDIil7ZWFzZSA9IGVhc2VJbk91dEN1YmljKElOZWFzZSk7fQ0KICAgIGlmIChl>>%filepath%
echo YXNlc3RyID09ICJJTlFVQU5UIil7ZWFzZSA9IGVhc2VJblF1YXJ0KElOZWFzZSk7>>%filepath%
echo fQ0KICAgIGlmIChlYXNlc3RyID09ICJPVVRRVUFOVCIpe2Vhc2UgPSBlYXNlT3V0>>%filepath%
echo UXVhcnQoSU5lYXNlKTt9DQogICAgaWYgKGVhc2VzdHIgPT0gIklOT1VUUVVBTlQi>>%filepath%
echo KXtlYXNlID0gZWFzZUluT3V0UXVhcnQoSU5lYXNlKTt9DQogICAgaWYgKGVhc2Vz>>%filepath%
echo dHIgPT0gIklOUVVJTlQiKXtlYXNlID0gZWFzZUluUXVpbnQoSU5lYXNlKTt9DQog>>%filepath%
echo ICAgaWYgKGVhc2VzdHIgPT0gIk9VVFFVSU5UIil7ZWFzZSA9IGVhc2VPdXRRdWlu>>%filepath%
echo dChJTmVhc2UpO30NCiAgICBpZiAoZWFzZXN0ciA9PSAiSU5PVVRRVUlOVCIpe2Vh>>%filepath%
echo c2UgPSBlYXNlSW5PdXRRdWludChJTmVhc2UpO30NCiAgICBpZiAoZWFzZXN0ciA9>>%filepath%
echo PSAiSU5FWFBPIil7ZWFzZSA9IGVhc2VJbkV4cG8oSU5lYXNlKTt9DQogICAgaWYg>>%filepath%
echo KGVhc2VzdHIgPT0gIk9VVEVYUE8iKXtlYXNlID0gZWFzZU91dEV4cG8oSU5lYXNl>>%filepath%
echo KTt9DQogICAgaWYgKGVhc2VzdHIgPT0gIklOT1VURVhQTyIpe2Vhc2UgPSBlYXNl>>%filepath%
echo SW5PdXRFeHBvKElOZWFzZSk7fQ0KICAgIGlmIChlYXNlc3RyID09ICJJTkNJUkMi>>%filepath%
echo KXtlYXNlID0gZWFzZUluQ2lyYyhJTmVhc2UpO30NCiAgICBpZiAoZWFzZXN0ciA9>>%filepath%
echo PSAiT1VUQ0lSQyIpe2Vhc2UgPSBlYXNlT3V0Q2lyYyhJTmVhc2UpO30NCiAgICBp>>%filepath%
echo ZiAoZWFzZXN0ciA9PSAiSU5PVVRDSVJDIil7ZWFzZSA9IGVhc2VJbk91dENpcmMo>>%filepath%
echo SU5lYXNlKTt9DQogICAgaWYgKGVhc2VzdHIgPT0gIklOQkFDSyIpe2Vhc2UgPSBl>>%filepath%
echo YXNlSW5CYWNrKElOZWFzZSk7fQ0KICAgIGlmIChlYXNlc3RyID09ICJPVVRCQUNL>>%filepath%
echo Iil7ZWFzZSA9IGVhc2VPdXRCYWNrKElOZWFzZSk7fQ0KICAgIGlmIChlYXNlc3Ry>>%filepath%
echo ID09ICJJTk9VVEJBQ0siKXtlYXNlID0gZWFzZUluT3V0QmFjayhJTmVhc2UpO30N>>%filepath%
echo CiAgICBpZiAoZWFzZXN0ciA9PSAiSU5FTEFTVElDIil7ZWFzZSA9IGVhc2VJbkVs>>%filepath%
echo YXN0aWMoSU5lYXNlKTt9DQogICAgaWYgKGVhc2VzdHIgPT0gIk9VVEVMQVNUSUMi>>%filepath%
echo KXtlYXNlID0gZWFzZU91dEVsYXN0aWMoSU5lYXNlKTt9DQogICAgaWYgKGVhc2Vz>>%filepath%
echo dHIgPT0gIklOT1VURUxBU1RJQyIpe2Vhc2UgPSBlYXNlSW5PdXRFbGFzdGljKElO>>%filepath%
echo ZWFzZSk7fQ0KICAgIGlmIChlYXNlc3RyID09ICJJTkJPVU5DRSIpe2Vhc2UgPSBl>>%filepath%
echo YXNlSW5Cb3VuY2UoSU5lYXNlKTt9DQogICAgaWYgKGVhc2VzdHIgPT0gIk9VVEJP>>%filepath%
echo VU5DRSIpe2Vhc2UgPSBlYXNlT3V0Qm91bmNlKElOZWFzZSk7fQ0KICAgIGlmIChl>>%filepath%
echo YXNlc3RyID09ICJJTk9VVEJPVU5DRSIpe2Vhc2UgPSBlYXNlSW5PdXRCb3VuY2Uo>>%filepath%
echo SU5lYXNlKTt9DQogICAgaWYgKGVhc2UgPCAwKXtlYXNlID0gMDt9DQogICAgaWYg>>%filepath%
echo KGVhc2UgPiAxKXtlYXNlID0gMDt9DQogICAgbGV0IHJlZCA9IE1hdGgucm91bmQo>>%filepath%
echo KDEgLSBlYXNlKSAqIHBhcnNlSW50KGNvbG9yMS5zdWJzdHJpbmcoMCwgMiksIDE2>>%filepath%
echo KSArIGVhc2UgKiBwYXJzZUludChjb2xvcjIuc3Vic3RyaW5nKDAsIDIpLCAxNikp>>%filepath%
echo Ow0KICAgIGxldCBncmVlbiA9IE1hdGgucm91bmQoKDEgLSBlYXNlKSAqIHBhcnNl>>%filepath%
echo SW50KGNvbG9yMS5zdWJzdHJpbmcoMiwgNCksIDE2KSArIGVhc2UgKiBwYXJzZUlu>>%filepath%
echo dChjb2xvcjIuc3Vic3RyaW5nKDIsIDQpLCAxNikpOw0KICAgIGxldCBibHVlID0g>>%filepath%
echo TWF0aC5yb3VuZCgoMSAtIGVhc2UpICogcGFyc2VJbnQoY29sb3IxLnN1YnN0cmlu>>%filepath%
echo Zyg0LCA2KSwgMTYpICsgZWFzZSAqIHBhcnNlSW50KGNvbG9yMi5zdWJzdHJpbmco>>%filepath%
echo NCwgNiksIDE2KSk7DQogICAgcmV0dXJuIHJlZC50b1N0cmluZygxNikucGFkU3Rh>>%filepath%
echo cnQoMiwgIjAiKSArIGdyZWVuLnRvU3RyaW5nKDE2KS5wYWRTdGFydCgyLCAiMCIp>>%filepath%
echo ICsgYmx1ZS50b1N0cmluZygxNikucGFkU3RhcnQoMiwgIjAiKTsNCiAgfSBlbHNl>>%filepath%
echo IHsNCiAgICByZXR1cm4gIkZGRkZGRiI7DQogIH0NCn0sIHRydWUpDQoNCmZ1bmN0>>%filepath%
echo aW9uIHplcm9hbmRvbmUobm93ViwgbWluViwgbWF4Vikgew0KICByZXR1cm4gKE1h>>%filepath%
echo dGgubWluKE1hdGgubWF4KG5vd1YsIG1pblYpLCBtYXhWKSAtIG1pblYpIC8gKG1h>>%filepath%
echo eFYgLSBtaW5WKTsNCn0NCmZ1bmN0aW9uIGVhc2VJblNpbmUodCkge3JldHVybiAx>>%filepath%
echo IC0gTWF0aC5jb3MoKHQgKiBNYXRoLlBJKSAvIDIpO30NCmZ1bmN0aW9uIGVhc2VP>>%filepath%
echo dXRTaW5lKHQpIHtyZXR1cm4gTWF0aC5zaW4oKHQgKiBNYXRoLlBJKSAvIDIpO30N>>%filepath%
echo CmZ1bmN0aW9uIGVhc2VJbk91dFNpbmUodCkge3JldHVybiAtKE1hdGguY29zKE1h>>%filepath%
echo dGguUEkgKiB0KSAtIDEpIC8gMjt9DQpmdW5jdGlvbiBlYXNlSW5RdWFkKHQpIHty>>%filepath%
echo ZXR1cm4gdCAqIHQ7fQ0KZnVuY3Rpb24gZWFzZU91dFF1YWQodCkge3JldHVybiAx>>%filepath%
echo IC0gKDEgLSB0KSAqICgxIC0gdCk7fQ0KZnVuY3Rpb24gZWFzZUluT3V0UXVhZCh0>>%filepath%
echo KSB7cmV0dXJuIHQgPCAwLjUgPyAyICogdCAqIHQgOiAxIC0gTWF0aC5wb3coLTIg>>%filepath%
echo KiB0ICsgMiwgMikgLyAyO30NCmZ1bmN0aW9uIGVhc2VJbkN1YmljKHQpIHtyZXR1>>%filepath%
echo cm4gdCAqIHQgKiB0O30NCmZ1bmN0aW9uIGVhc2VPdXRDdWJpYyh0KSB7cmV0dXJu>>%filepath%
echo IDEgLSBNYXRoLnBvdygxIC0gdCwgMyk7fQ0KZnVuY3Rpb24gZWFzZUluT3V0Q3Vi>>%filepath%
echo aWModCkge3JldHVybiB0IDwgMC41ID8gNCAqIHQgKiB0ICogdCA6IDEgLSBNYXRo>>%filepath%
echo LnBvdygtMiAqIHQgKyAyLCAzKSAvIDI7fQ0KZnVuY3Rpb24gZWFzZUluUXVhcnQo>>%filepath%
echo dCkge3JldHVybiB0ICogdCAqIHQgKiB0O30NCmZ1bmN0aW9uIGVhc2VPdXRRdWFy>>%filepath%
echo dCh0KSB7cmV0dXJuIDEgLSBNYXRoLnBvdygxIC0gdCwgNCk7fQ0KZnVuY3Rpb24g>>%filepath%
echo ZWFzZUluT3V0UXVhcnQodCkge3JldHVybiB0IDwgMC41ID8gOCAqIHQgKiB0ICog>>%filepath%
echo dCAqIHQgOiAxIC0gTWF0aC5wb3coLTIgKiB0ICsgMiwgNCkgLyAyO30NCmZ1bmN0>>%filepath%
echo aW9uIGVhc2VJblF1aW50KHQpIHtyZXR1cm4gdCAqIHQgKiB0ICogdCAqIHQ7fQ0K>>%filepath%
echo ZnVuY3Rpb24gZWFzZU91dFF1aW50KHQpIHtyZXR1cm4gMSAtIE1hdGgucG93KDEg>>%filepath%
echo LSB0LCA1KTt9DQpmdW5jdGlvbiBlYXNlSW5PdXRRdWludCh0KSB7cmV0dXJuIHQg>>%filepath%
echo PCAwLjUgPyAxNiAqIHQgKiB0ICogdCAqIHQgKiB0IDogMSAtIE1hdGgucG93KC0y>>%filepath%
echo ICogdCArIDIsIDUpIC8gMjt9DQpmdW5jdGlvbiBlYXNlSW5FeHBvKHQpIHtyZXR1>>%filepath%
echo cm4gdCA9PT0gMCA/IDAgOiBNYXRoLnBvdygyLCAxMCAqICh0IC0gMSkpO30NCmZ1>>%filepath%
echo bmN0aW9uIGVhc2VPdXRFeHBvKHQpIHtyZXR1cm4gdCA9PT0gMSA/IDEgOiAxIC0g>>%filepath%
echo TWF0aC5wb3coMiwgLTEwICogdCk7fQ0KZnVuY3Rpb24gZWFzZUluT3V0RXhwbyh0>>%filepath%
echo KSB7aWYgKHQgPT09IDApIHJldHVybiAwO2lmICh0ID09PSAxKSByZXR1cm4gMTtp>>%filepath%
echo ZiAodCA8IDAuNSl7cmV0dXJuIDAuNSAqIE1hdGgucG93KDIsIDIwICogdCAtIDEw>>%filepath%
echo KTt9ZWxzZXtyZXR1cm4gMSAtIDAuNSAqIE1hdGgucG93KDIsIC0yMCAqIHQgKyAx>>%filepath%
echo MCk7fX0NCmZ1bmN0aW9uIGVhc2VJbkNpcmModCkge3JldHVybiAxIC0gTWF0aC5z>>%filepath%
echo cXJ0KDEgLSB0ICogdCk7fQ0KZnVuY3Rpb24gZWFzZU91dENpcmModCkge3JldHVy>>%filepath%
echo biBNYXRoLnNxcnQoMSAtICh0IC0gMSkgKiAodCAtIDEpKTt9DQpmdW5jdGlvbiBl>>%filepath%
echo YXNlSW5PdXRDaXJjKHQpIHtpZiAodCA8IDAuNSkge3JldHVybiAwLjUgKiAoMSAt>>%filepath%
echo IE1hdGguc3FydCgxIC0gNCAqIHQgKiB0KSk7fWVsc2V7cmV0dXJuIDAuNSAqIChN>>%filepath%
echo YXRoLnNxcnQoMSAtICgyICogdCAtIDIpICogKDIgKiB0IC0gMikpICsgMSk7fX0N>>%filepath%
echo CmZ1bmN0aW9uIGVhc2VJbkJhY2sodCwgcyA9IDEuNzAxNTgpIHtyZXR1cm4gdCAq>>%filepath%
echo IHQgKiAoKHMgKyAxKSAqIHQgLSBzKTt9DQpmdW5jdGlvbiBlYXNlT3V0QmFjayh0>>%filepath%
echo LCBzID0gMS43MDE1OCkge3JldHVybiAodCA9IHQgLSAxKSAqIHQgKiAoKHMgKyAx>>%filepath%
echo KSAqIHQgKyBzKSArIDE7fQ0KZnVuY3Rpb24gZWFzZUluT3V0QmFjayh0LCBzID0g>>%filepath%
echo MS43MDE1OCkge2lmICgodCAvPSAwLjUpIDwgMSkgcmV0dXJuIDAuNSAqICh0ICog>>%filepath%
echo dCAqICgoKHMgKj0gMS41MjUpICsgMSkgKiB0IC0gcykpO3JldHVybiAwLjUgKiAo>>%filepath%
echo KHQgLT0gMikgKiB0ICogKCgocyAqPSAxLjUyNSkgKyAxKSAqIHQgKyBzKSArIDIp>>%filepath%
echo O30NCmZ1bmN0aW9uIGVhc2VJbkVsYXN0aWModCkge2lmICh0ID09PSAwKSByZXR1>>%filepath%
echo cm4gMDtpZiAodCA9PT0gMSkgcmV0dXJuIDE7cmV0dXJuIC1NYXRoLnBvdygyLCAx>>%filepath%
echo MCAqIHQgLSAxMCkgKiBNYXRoLnNpbigodCAqIDEwIC0gMTAuNzUpICogKDIgKiBN>>%filepath%
echo YXRoLlBJKSAvIDMpO30NCmZ1bmN0aW9uIGVhc2VPdXRFbGFzdGljKHQpIHtpZiAo>>%filepath%
echo dCA9PT0gMCkgcmV0dXJuIDA7aWYgKHQgPT09IDEpIHJldHVybiAxO3JldHVybiBN>>%filepath%
echo YXRoLnBvdygyLCAtMTAgKiB0KSAqIE1hdGguc2luKCh0ICogMTAgLSAwLjc1KSAq>>%filepath%
echo ICgyICogTWF0aC5QSSkgLyAzKSArIDE7fQ0KZnVuY3Rpb24gZWFzZUluT3V0RWxh>>%filepath%
echo c3RpYyh0KSB7aWYgKHQgPT09IDApIHJldHVybiAwO2lmICh0ID09PSAxKSByZXR1>>%filepath%
echo cm4gMTt0ICo9IDI7aWYgKHQgPCAxKXtyZXR1cm4gLTAuNSAqIChNYXRoLnBvdygy>>%filepath%
echo LCAxMCAqIHQgLSAxMCkgKiBNYXRoLnNpbigodCAqIDEwIC0gMTAuNzUpICogKDIg>>%filepath%
echo KiBNYXRoLlBJKSAvIDMpKTt9ZWxzZXtyZXR1cm4gMC41ICogKE1hdGgucG93KDIs>>%filepath%
echo IC0xMCAqICh0IC0gMSkpICogTWF0aC5zaW4oKHQgKiAxMCAtIDEwLjc1KSAqICgy>>%filepath%
echo ICogTWF0aC5QSSkgLyAzKSkgKyAxO319DQpmdW5jdGlvbiBlYXNlSW5Cb3VuY2Uo>>%filepath%
echo dCkge3JldHVybiAxIC0gZWFzZU91dEJvdW5jZSgxIC0gdCk7fQ0KZnVuY3Rpb24g>>%filepath%
echo ZWFzZU91dEJvdW5jZSh0KSB7aWYgKHQgPCAoMSAvIDIuNzUpKSB7cmV0dXJuIDcu>>%filepath%
echo NTYyNSAqIHQgKiB0O31lbHNlIGlmKHQgPCAoMiAvIDIuNzUpKXtyZXR1cm4gNy41>>%filepath%
echo NjI1ICogKHQgLT0gKDEuNSAvIDIuNzUpKSAqIHQgKyAwLjc1O31lbHNlIGlmKHQg>>%filepath%
echo PCAoMi41IC8gMi43NSkpe3JldHVybiA3LjU2MjUgKiAodCAtPSAoMi4yNSAvIDIu>>%filepath%
echo NzUpKSAqIHQgKyAwLjkzNzU7fWVsc2V7cmV0dXJuIDcuNTYyNSAqICh0IC09ICgy>>%filepath%
echo LjYyNSAvIDIuNzUpKSAqIHQgKyAwLjk4NDM3NTt9fQ0KZnVuY3Rpb24gZWFzZUlu>>%filepath%
echo T3V0Qm91bmNlKHQpIHtpZiAodCA8IDAuNSkgcmV0dXJuIGVhc2VJbkJvdW5jZSh0>>%filepath%
echo ICogMikgKiAwLjU7cmV0dXJuIGVhc2VPdXRCb3VuY2UodCAqIDIgLSAxKSAqIDAu>>%filepath%
echo NSArIDAuNTt9>>%filepath%

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
echo YXNlUkFXKSB7DQoJTWF4U2l6ZVJBVyA9IE1heFNpemVSQVcucmVwbGFjZSgiLCAi>>%filepath%
echo LCAiIik7DQoJU3BlZWRSQVcgPSBTcGVlZFJBVy5yZXBsYWNlKCIsICIsICIiKTsN>>%filepath%
echo CglTdWJTaXplUkFXID0gU3ViU2l6ZVJBVy5yZXBsYWNlKCIsICIsICIiKTsNCglD>>%filepath%
echo aGFuZ2VSQVcgPSBDaGFuZ2VSQVcucmVwbGFjZSgiLCAiLCAiIik7DQoJZWFzZVJB>>%filepath%
echo VyA9IGVhc2VSQVcucmVwbGFjZSgiLCAiLCAiIik7DQogICAgbGV0IEZ1bmMgPSBD>>%filepath%
echo b21ibygpOyBsZXQgU3RhcnRTaXplID0gMzA7IGxldCBNYXhTaXplID0gODA7IGxl>>%filepath%
echo dCBTcGVlZCA9IDgwMDsgbGV0IFN1YlNpemUgPSAzMDsNCiAgICBpZihpc05hTihw>>%filepath%
echo YXJzZUZsb2F0KFN0YXJ0U2l6ZVJBVykpPT0wKXtTdGFydFNpemUgPSBTdGFydFNp>>%filepath%
echo emVSQVc7fQ0KICAgIGlmKGlzTmFOKHBhcnNlRmxvYXQoU3ViU2l6ZVJBVykpPT0w>>%filepath%
echo KXtTdWJTaXplID0gU3ViU2l6ZVJBVzt9DQogICAgaWYoaXNOYU4ocGFyc2VGbG9h>>%filepath%
echo dChNYXhTaXplUkFXKSk9PTApe01heFNpemUgPSBNYXhTaXplUkFXO30NCiAgICBp>>%filepath%
echo Zihpc05hTihwYXJzZUZsb2F0KFNwZWVkUkFXKSk9PTApe1NwZWVkID0gU3BlZWRS>>%filepath%
echo QVc7fQ0KICAgIGlmKGlzTmFOKEZ1bmMpKXtyZXR1cm4gU3ViU2l6ZX0NCiAgICBp>>%filepath%
echo ZiAoRnVuYyAhPT0gU3ViRnVuYyl7U3ViRnVuYyA9IEZ1bmM7U3RhcnRUaW1lID0g>>%filepath%
echo bmV3IERhdGUoKS5nZXRUaW1lKCk7fQ0KICAgIGxldCBlbGFwc2VkVGltZSA9IG5l>>%filepath%
echo dyBEYXRlKCkuZ2V0VGltZSgpIC0gU3RhcnRUaW1lOw0KICAgIGlmIChlbGFwc2Vk>>%filepath%
echo VGltZSA8IFNwZWVkKXsNCiAgICAgICAgbGV0IElOZWFzZSA9IChlbGFwc2VkVGlt>>%filepath%
echo ZSAvIFNwZWVkKTsNCiAgICAgICAgbGV0IGVhc2UgPSBJTmVhc2U7DQogICAgICAg>>%filepath%
echo IGxldCBlYXNlc3RyID0gZWFzZVJBVy50b1N0cmluZygpLnRvVXBwZXJDYXNlKCk7>>%filepath%
echo DQogICAgICAgIGlmIChlYXNlc3RyID09ICJJTlNJTkUiKXtlYXNlID0gZWFzZUlu>>%filepath%
echo U2luZShJTmVhc2UpO30NCiAgICAgICAgaWYgKGVhc2VzdHIgPT0gIk9VVFNJTkUi>>%filepath%
echo KXtlYXNlID0gZWFzZU91dFNpbmUoSU5lYXNlKTt9DQogICAgICAgIGlmIChlYXNl>>%filepath%
echo c3RyID09ICJJTk9VVFNJTkUiKXtlYXNlID0gZWFzZUluT3V0U2luZShJTmVhc2Up>>%filepath%
echo O30NCiAgICAgICAgaWYgKGVhc2VzdHIgPT0gIklOUVVBRCIpe2Vhc2UgPSBlYXNl>>%filepath%
echo SW5RdWFkKElOZWFzZSk7fQ0KICAgICAgICBpZiAoZWFzZXN0ciA9PSAiT1VUUVVB>>%filepath%
echo RCIpe2Vhc2UgPSBlYXNlT3V0UXVhZChJTmVhc2UpO30NCiAgICAgICAgaWYgKGVh>>%filepath%
echo c2VzdHIgPT0gIklOT1VUUVVBRCIpe2Vhc2UgPSBlYXNlSW5PdXRRdWFkKElOZWFz>>%filepath%
echo ZSk7fQ0KICAgICAgICBpZiAoZWFzZXN0ciA9PSAiSU5DVUJJQyIpe2Vhc2UgPSBl>>%filepath%
echo YXNlSW5DdWJpYyhJTmVhc2UpO30NCiAgICAgICAgaWYgKGVhc2VzdHIgPT0gIk9V>>%filepath%
echo VENVQklDIil7ZWFzZSA9IGVhc2VPdXRDdWJpYyhJTmVhc2UpO30NCiAgICAgICAg>>%filepath%
echo aWYgKGVhc2VzdHIgPT0gIklOT1VUQ1VCSUMiKXtlYXNlID0gZWFzZUluT3V0Q3Vi>>%filepath%
echo aWMoSU5lYXNlKTt9DQogICAgICAgIGlmIChlYXNlc3RyID09ICJJTlFVQU5UIil7>>%filepath%
echo ZWFzZSA9IGVhc2VJblF1YXJ0KElOZWFzZSk7fQ0KICAgICAgICBpZiAoZWFzZXN0>>%filepath%
echo ciA9PSAiT1VUUVVBTlQiKXtlYXNlID0gZWFzZU91dFF1YXJ0KElOZWFzZSk7fQ0K>>%filepath%
echo ICAgICAgICBpZiAoZWFzZXN0ciA9PSAiSU5PVVRRVUFOVCIpe2Vhc2UgPSBlYXNl>>%filepath%
echo SW5PdXRRdWFydChJTmVhc2UpO30NCiAgICAgICAgaWYgKGVhc2VzdHIgPT0gIklO>>%filepath%
echo UVVJTlQiKXtlYXNlID0gZWFzZUluUXVpbnQoSU5lYXNlKTt9DQogICAgICAgIGlm>>%filepath%
echo IChlYXNlc3RyID09ICJPVVRRVUlOVCIpe2Vhc2UgPSBlYXNlT3V0UXVpbnQoSU5l>>%filepath%
echo YXNlKTt9DQogICAgICAgIGlmIChlYXNlc3RyID09ICJJTk9VVFFVSU5UIil7ZWFz>>%filepath%
echo ZSA9IGVhc2VJbk91dFF1aW50KElOZWFzZSk7fQ0KICAgICAgICBpZiAoZWFzZXN0>>%filepath%
echo ciA9PSAiSU5FWFBPIil7ZWFzZSA9IGVhc2VJbkV4cG8oSU5lYXNlKTt9DQogICAg>>%filepath%
echo ICAgIGlmIChlYXNlc3RyID09ICJPVVRFWFBPIil7ZWFzZSA9IGVhc2VPdXRFeHBv>>%filepath%
echo KElOZWFzZSk7fQ0KICAgICAgICBpZiAoZWFzZXN0ciA9PSAiSU5PVVRFWFBPIil7>>%filepath%
echo ZWFzZSA9IGVhc2VJbk91dEV4cG8oSU5lYXNlKTt9DQogICAgICAgIGlmIChlYXNl>>%filepath%
echo c3RyID09ICJJTkNJUkMiKXtlYXNlID0gZWFzZUluQ2lyYyhJTmVhc2UpO30NCiAg>>%filepath%
echo ICAgICAgaWYgKGVhc2VzdHIgPT0gIk9VVENJUkMiKXtlYXNlID0gZWFzZU91dENp>>%filepath%
echo cmMoSU5lYXNlKTt9DQogICAgICAgIGlmIChlYXNlc3RyID09ICJJTk9VVENJUkMi>>%filepath%
echo KXtlYXNlID0gZWFzZUluT3V0Q2lyYyhJTmVhc2UpO30NCiAgICAgICAgaWYgKGVh>>%filepath%
echo c2VzdHIgPT0gIklOQkFDSyIpe2Vhc2UgPSBlYXNlSW5CYWNrKElOZWFzZSk7fQ0K>>%filepath%
echo ICAgICAgICBpZiAoZWFzZXN0ciA9PSAiT1VUQkFDSyIpe2Vhc2UgPSBlYXNlT3V0>>%filepath%
echo QmFjayhJTmVhc2UpO30NCiAgICAgICAgaWYgKGVhc2VzdHIgPT0gIklOT1VUQkFD>>%filepath%
echo SyIpe2Vhc2UgPSBlYXNlSW5PdXRCYWNrKElOZWFzZSk7fQ0KICAgICAgICBpZiAo>>%filepath%
echo ZWFzZXN0ciA9PSAiSU5FTEFTVElDIil7ZWFzZSA9IGVhc2VJbkVsYXN0aWMoSU5l>>%filepath%
echo YXNlKTt9DQogICAgICAgIGlmIChlYXNlc3RyID09ICJPVVRFTEFTVElDIil7ZWFz>>%filepath%
echo ZSA9IGVhc2VPdXRFbGFzdGljKElOZWFzZSk7fQ0KICAgICAgICBpZiAoZWFzZXN0>>%filepath%
echo ciA9PSAiSU5PVVRFTEFTVElDIil7ZWFzZSA9IGVhc2VJbk91dEVsYXN0aWMoSU5l>>%filepath%
echo YXNlKTt9DQogICAgICAgIGlmIChlYXNlc3RyID09ICJJTkJPVU5DRSIpe2Vhc2Ug>>%filepath%
echo PSBlYXNlSW5Cb3VuY2UoSU5lYXNlKTt9DQogICAgICAgIGlmIChlYXNlc3RyID09>>%filepath%
echo ICJPVVRCT1VOQ0UiKXtlYXNlID0gZWFzZU91dEJvdW5jZShJTmVhc2UpO30NCiAg>>%filepath%
echo ICAgICAgaWYgKGVhc2VzdHIgPT0gIklOT1VUQk9VTkNFIil7ZWFzZSA9IGVhc2VJ>>%filepath%
echo bk91dEJvdW5jZShJTmVhc2UpO30NCiAgICAgICAgbGV0IENoYW5nZU91dCA9IE1h>>%filepath%
echo eFNpemUgKiBlYXNlOw0KICAgICAgICBpZihDaGFuZ2VSQVcgPT0gMSl7Q2hhbmdl>>%filepath%
echo T3V0ID0gTWF4U2l6ZSAqICgxLWVhc2UpO30NCiAgICAgICAgbGV0IGludGVycG9s>>%filepath%
echo YXRlZFZhbHVlID0gQ2hhbmdlT3V0Ow0KICAgICAgICBpZiAoaW50ZXJwb2xhdGVk>>%filepath%
echo VmFsdWUgPiBNYXhTaXplKSB7aW50ZXJwb2xhdGVkVmFsdWUgPSBNYXhTaXplO30N>>%filepath%
echo CiAgICAgICAgaWYgKGludGVycG9sYXRlZFZhbHVlIDwgMCkge2ludGVycG9sYXRl>>%filepath%
echo ZFZhbHVlID0gMDt9DQogICAgICAgIHJldHVybiAoaW50ZXJwb2xhdGVkVmFsdWUg>>%filepath%
echo KyBwYXJzZUludChTdGFydFNpemUpKS50b0ZpeGVkKDQpOw0KICAgIH0NCiAgICBl>>%filepath%
echo bHNle3JldHVybiBTdWJTaXplO30NCn0sIHRydWUpOw0KbGV0IFN1YkZ1bmMgPSBD>>%filepath%
echo b21ibygpOyAvL+ydtOqyg+uPhCDrsJTqv5Tso7zshLjsmpQuDQpsZXQgU3RhcnRU>>%filepath%
echo aW1lID0gbmV3IERhdGUoKS5nZXRUaW1lKCk7DQpmdW5jdGlvbiBlYXNlSW5TaW5l>>%filepath%
echo KHQpIHtyZXR1cm4gMSAtIE1hdGguY29zKCh0ICogTWF0aC5QSSkgLyAyKTt9DQpm>>%filepath%
echo dW5jdGlvbiBlYXNlT3V0U2luZSh0KSB7cmV0dXJuIE1hdGguc2luKCh0ICogTWF0>>%filepath%
echo aC5QSSkgLyAyKTt9DQpmdW5jdGlvbiBlYXNlSW5PdXRTaW5lKHQpIHtyZXR1cm4g>>%filepath%
echo LShNYXRoLmNvcyhNYXRoLlBJICogdCkgLSAxKSAvIDI7fQ0KZnVuY3Rpb24gZWFz>>%filepath%
echo ZUluUXVhZCh0KSB7cmV0dXJuIHQgKiB0O30NCmZ1bmN0aW9uIGVhc2VPdXRRdWFk>>%filepath%
echo KHQpIHtyZXR1cm4gMSAtICgxIC0gdCkgKiAoMSAtIHQpO30NCmZ1bmN0aW9uIGVh>>%filepath%
echo c2VJbk91dFF1YWQodCkge3JldHVybiB0IDwgMC41ID8gMiAqIHQgKiB0IDogMSAt>>%filepath%
echo IE1hdGgucG93KC0yICogdCArIDIsIDIpIC8gMjt9DQpmdW5jdGlvbiBlYXNlSW5D>>%filepath%
echo dWJpYyh0KSB7cmV0dXJuIHQgKiB0ICogdDt9DQpmdW5jdGlvbiBlYXNlT3V0Q3Vi>>%filepath%
echo aWModCkge3JldHVybiAxIC0gTWF0aC5wb3coMSAtIHQsIDMpO30NCmZ1bmN0aW9u>>%filepath%
echo IGVhc2VJbk91dEN1YmljKHQpIHtyZXR1cm4gdCA8IDAuNSA/IDQgKiB0ICogdCAq>>%filepath%
echo IHQgOiAxIC0gTWF0aC5wb3coLTIgKiB0ICsgMiwgMykgLyAyO30NCmZ1bmN0aW9u>>%filepath%
echo IGVhc2VJblF1YXJ0KHQpIHtyZXR1cm4gdCAqIHQgKiB0ICogdDt9DQpmdW5jdGlv>>%filepath%
echo biBlYXNlT3V0UXVhcnQodCkge3JldHVybiAxIC0gTWF0aC5wb3coMSAtIHQsIDQp>>%filepath%
echo O30NCmZ1bmN0aW9uIGVhc2VJbk91dFF1YXJ0KHQpIHtyZXR1cm4gdCA8IDAuNSA/>>%filepath%
echo IDggKiB0ICogdCAqIHQgKiB0IDogMSAtIE1hdGgucG93KC0yICogdCArIDIsIDQp>>%filepath%
echo IC8gMjt9DQpmdW5jdGlvbiBlYXNlSW5RdWludCh0KSB7cmV0dXJuIHQgKiB0ICog>>%filepath%
echo dCAqIHQgKiB0O30NCmZ1bmN0aW9uIGVhc2VPdXRRdWludCh0KSB7cmV0dXJuIDEg>>%filepath%
echo LSBNYXRoLnBvdygxIC0gdCwgNSk7fQ0KZnVuY3Rpb24gZWFzZUluT3V0UXVpbnQo>>%filepath%
echo dCkge3JldHVybiB0IDwgMC41ID8gMTYgKiB0ICogdCAqIHQgKiB0ICogdCA6IDEg>>%filepath%
echo LSBNYXRoLnBvdygtMiAqIHQgKyAyLCA1KSAvIDI7fQ0KZnVuY3Rpb24gZWFzZUlu>>%filepath%
echo RXhwbyh0KSB7cmV0dXJuIHQgPT09IDAgPyAwIDogTWF0aC5wb3coMiwgMTAgKiAo>>%filepath%
echo dCAtIDEpKTt9DQpmdW5jdGlvbiBlYXNlT3V0RXhwbyh0KSB7cmV0dXJuIHQgPT09>>%filepath%
echo IDEgPyAxIDogMSAtIE1hdGgucG93KDIsIC0xMCAqIHQpO30NCmZ1bmN0aW9uIGVh>>%filepath%
echo c2VJbk91dEV4cG8odCkge2lmICh0ID09PSAwKSByZXR1cm4gMDtpZiAodCA9PT0g>>%filepath%
echo MSkgcmV0dXJuIDE7aWYgKHQgPCAwLjUpe3JldHVybiAwLjUgKiBNYXRoLnBvdygy>>%filepath%
echo LCAyMCAqIHQgLSAxMCk7fWVsc2V7cmV0dXJuIDEgLSAwLjUgKiBNYXRoLnBvdygy>>%filepath%
echo LCAtMjAgKiB0ICsgMTApO319DQpmdW5jdGlvbiBlYXNlSW5DaXJjKHQpIHtyZXR1>>%filepath%
echo cm4gMSAtIE1hdGguc3FydCgxIC0gdCAqIHQpO30NCmZ1bmN0aW9uIGVhc2VPdXRD>>%filepath%
echo aXJjKHQpIHtyZXR1cm4gTWF0aC5zcXJ0KDEgLSAodCAtIDEpICogKHQgLSAxKSk7>>%filepath%
echo fQ0KZnVuY3Rpb24gZWFzZUluT3V0Q2lyYyh0KSB7aWYgKHQgPCAwLjUpIHtyZXR1>>%filepath%
echo cm4gMC41ICogKDEgLSBNYXRoLnNxcnQoMSAtIDQgKiB0ICogdCkpO31lbHNle3Jl>>%filepath%
echo dHVybiAwLjUgKiAoTWF0aC5zcXJ0KDEgLSAoMiAqIHQgLSAyKSAqICgyICogdCAt>>%filepath%
echo IDIpKSArIDEpO319DQpmdW5jdGlvbiBlYXNlSW5CYWNrKHQsIHMgPSAxLjcwMTU4>>%filepath%
echo KSB7cmV0dXJuIHQgKiB0ICogKChzICsgMSkgKiB0IC0gcyk7fQ0KZnVuY3Rpb24g>>%filepath%
echo ZWFzZU91dEJhY2sodCwgcyA9IDEuNzAxNTgpIHtyZXR1cm4gKHQgPSB0IC0gMSkg>>%filepath%
echo KiB0ICogKChzICsgMSkgKiB0ICsgcykgKyAxO30NCmZ1bmN0aW9uIGVhc2VJbk91>>%filepath%
echo dEJhY2sodCwgcyA9IDEuNzAxNTgpIHtpZiAoKHQgLz0gMC41KSA8IDEpIHJldHVy>>%filepath%
echo biAwLjUgKiAodCAqIHQgKiAoKChzICo9IDEuNTI1KSArIDEpICogdCAtIHMpKTty>>%filepath%
echo ZXR1cm4gMC41ICogKCh0IC09IDIpICogdCAqICgoKHMgKj0gMS41MjUpICsgMSkg>>%filepath%
echo KiB0ICsgcykgKyAyKTt9DQpmdW5jdGlvbiBlYXNlSW5FbGFzdGljKHQpIHtpZiAo>>%filepath%
echo dCA9PT0gMCkgcmV0dXJuIDA7aWYgKHQgPT09IDEpIHJldHVybiAxO3JldHVybiAt>>%filepath%
echo TWF0aC5wb3coMiwgMTAgKiB0IC0gMTApICogTWF0aC5zaW4oKHQgKiAxMCAtIDEw>>%filepath%
echo Ljc1KSAqICgyICogTWF0aC5QSSkgLyAzKTt9DQpmdW5jdGlvbiBlYXNlT3V0RWxh>>%filepath%
echo c3RpYyh0KSB7aWYgKHQgPT09IDApIHJldHVybiAwO2lmICh0ID09PSAxKSByZXR1>>%filepath%
echo cm4gMTtyZXR1cm4gTWF0aC5wb3coMiwgLTEwICogdCkgKiBNYXRoLnNpbigodCAq>>%filepath%
echo IDEwIC0gMC43NSkgKiAoMiAqIE1hdGguUEkpIC8gMykgKyAxO30NCmZ1bmN0aW9u>>%filepath%
echo IGVhc2VJbk91dEVsYXN0aWModCkge2lmICh0ID09PSAwKSByZXR1cm4gMDtpZiAo>>%filepath%
echo dCA9PT0gMSkgcmV0dXJuIDE7dCAqPSAyO2lmICh0IDwgMSl7cmV0dXJuIC0wLjUg>>%filepath%
echo KiAoTWF0aC5wb3coMiwgMTAgKiB0IC0gMTApICogTWF0aC5zaW4oKHQgKiAxMCAt>>%filepath%
echo IDEwLjc1KSAqICgyICogTWF0aC5QSSkgLyAzKSk7fWVsc2V7cmV0dXJuIDAuNSAq>>%filepath%
echo IChNYXRoLnBvdygyLCAtMTAgKiAodCAtIDEpKSAqIE1hdGguc2luKCh0ICogMTAg>>%filepath%
echo LSAxMC43NSkgKiAoMiAqIE1hdGguUEkpIC8gMykpICsgMTt9fQ0KZnVuY3Rpb24g>>%filepath%
echo ZWFzZUluQm91bmNlKHQpIHtyZXR1cm4gMSAtIGVhc2VPdXRCb3VuY2UoMSAtIHQp>>%filepath%
echo O30NCmZ1bmN0aW9uIGVhc2VPdXRCb3VuY2UodCkge2lmICh0IDwgKDEgLyAyLjc1>>%filepath%
echo KSkge3JldHVybiA3LjU2MjUgKiB0ICogdDt9ZWxzZSBpZih0IDwgKDIgLyAyLjc1>>%filepath%
echo KSl7cmV0dXJuIDcuNTYyNSAqICh0IC09ICgxLjUgLyAyLjc1KSkgKiB0ICsgMC43>>%filepath%
echo NTt9ZWxzZSBpZih0IDwgKDIuNSAvIDIuNzUpKXtyZXR1cm4gNy41NjI1ICogKHQg>>%filepath%
echo LT0gKDIuMjUgLyAyLjc1KSkgKiB0ICsgMC45Mzc1O31lbHNle3JldHVybiA3LjU2>>%filepath%
echo MjUgKiAodCAtPSAoMi42MjUgLyAyLjc1KSkgKiB0ICsgMC45ODQzNzU7fX0NCmZ1>>%filepath%
echo bmN0aW9uIGVhc2VJbk91dEJvdW5jZSh0KSB7aWYgKHQgPCAwLjUpIHJldHVybiBl>>%filepath%
echo YXNlSW5Cb3VuY2UodCAqIDIpICogMC41O3JldHVybiBlYXNlT3V0Qm91bmNlKHQg>>%filepath%
echo KiAyIC0gMSkgKiAwLjUgKyAwLjU7fQ==>>%filepath%

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
