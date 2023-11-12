@echo off

REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
REM
REM Copyright (C) 2023 Jongyeol.
REM All rights reserved.
REM
REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

del /f /q "Update Completer.bat"
cls

set version=1.0.1

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
	echo @echo off>"Update Completer.bat"
	echo del /f /q Jipper-Overlayer.bat>>"Update Completer.bat"
	echo move batchfile Jipper-Overlayer.bat>>"Update Completer.bat"
	echo "Jipper-Overlayer">>"Update Completer.bat"
	del /f /q version
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

goto ApplyUI-1

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


:ApplyUI-1

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
	PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://jongyeol.click/MAPLESTORY_OTF_BOLD.OTF', 'MAPLESTORY_OTF_BOLD.OTF') }"

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

certutil -decode "jipperOverlayer-decodetest" "jipperOverlayer-decodetest"
if errorlevel 1 (
	goto ApplyUI-2-download
) else (
	goto ApplyUI-2-decode
)


:ApplyUI-2-decode

set filepath=uidumpfile
echo UEsDBBQAAAAIADBybFfjhCNhewUAACQZAAAYAAAAQ3VzdG9tQ29sb3JSYW5nZVBs>>%filepath%
echo dXNGLmpzrVjbctMwEH1nhn/Q5MlOk2CbpBRCYNrQzGgAl14CvJrUFA9BDr4AQyf/>>%filepath%
echo zq4kXxJJtSgwtLGtPefsWVnSphfxTZIXcXYV3Ti9eZkX6bd5uk6zi4jdxO/WZb7o>>%filepath%
echo Dcjnkq2KJGXEuTj+gDcDkuG4Lz+DAVkhyJefcB9HeQzBA7KIXHL78AEh67jgRGRG>>%filepath%
echo 4h/RuqIiB6TnHLk9dwpBkhZCxMUoizfraBU7kAT+b0cFVVRgiBIpQRS/MHGJhKso>>%filepath%
echo E5e0A2HyyhC3iMgMfhlGk8/ESfIwCh107s5mnqwNDjmInRHfvYVrXil+63nubRYX>>%filepath%
echo ZcZIb7F4dex5ve0WMaKirPz2PlqXMchuoiyPF+s0KhwssNAYFellkSXsxnF5Dg3s>>%filepath%
echo gld4FyeqrgsMNIGBCBS+6kSe1xiw0qTXPJ1uNagXjZIWFUxbpmkIs4Cjv+Msjdh1>>%filepath%
echo yuKaaVDr1FdB25BASoq953mRNTPcqhxcLjebOJvDiNM2XYNmpEfDSxqe9txbqYAf>>%filepath%
echo lF0mkJsQc6dbPfJseaVCz8rCBktDLZoya/z58vjVPvi8jK67kKCrQkHVBktDLZoy>>%filepath%
echo a/x8eULn++h5+SlZdWFBWQMGYSs0DfV4yuwZwHh41VNLnhVdWNDWgEHZCk1DPZ4y>>%filepath%
echo e4bzJVXh52XCOrGgrQGDshWahno8ZfYMpx/fne2jT39t0i4kKKtQkLXB0lCLpswa>>%filepath%
echo P6cXyrs2T7LO9wx0VSio2mBpqEVTZo0/OZ6/3gefRKuvXUjQVaGgaoOloRZNmTX+>>%filepath%
echo 9M3x5ZW6tE/XUV50r2xQ1xKAvCUDDU0clP0Ny8nZMpwrR8JJCh1B54kAGejgIG+H>>%filepath%
echo p6GBgbJODmgevBrjKaMviK+O4uGdxdfw6G1UfBllIHDtOD4ZEi5B+qJvobBDyEYw>>%filepath%
echo Lz/l4mT3BiRwB8Q/dMkBD1eiA210u6G4yeKY3Usd2uSxvTpGq+qfoOW5l/h4QA7t>>%filepath%
echo xavoRlz2pA6UvumUcHy0ia4vCzhMMOOe10N+hxfJIg7tdIRx/S2J13lcNc91f8z/>>%filepath%
echo 9UTEwwfbASmyMnYfPqi+wOw0jOnP9wPyLWH4O/r1nrfijS9eURgVFxDQArgVYihu>>%filepath%
echo ySPi4IPqfgrajWi7EyxARSrgNHHuVZo7TkH64u4dRTpoWVsM1QLcoxCAPGE2cMo0>>%filepath%
echo BEOnzkCigadAXz6n0bBge9amKBChxMk+bt8vfzfhWV9eGdI8VzRgXxhNyEsSoBr/>>%filepath%
echo edYUcJP+dIZi5IAEsEhNufP+TEneZECJbguK/AfkscGCAm48jFHQxsdjkw/eq2l9>>%filepath%
echo mLwoCJ2XscGLAm68HKGgrZ+x2U/CzH7MnhLW6Wli9KRIVp78Q9JXM7jL2MRkDDu8>>%filepath%
echo XZHZDI4u8hJ+njVcQOF7uCgKvvLUlCFhPZWP+dapNXRD5DOur5oLT1aZk1vtfN60>>%filepath%
echo eerXT33+VBap+osEL1h/RzhAXW7DA3HcpFuzo4kfSsCBAKjpQrupX4T596wQs6x3>>%filepath%
echo KltVdb+UuKrad9WdsjZLuwJktwSOmla9zF1ZiD3EXjKBrFvAE2ruXCyNtjK8pYVX>>%filepath%
echo PCcwUaMnnj85UleQ4+ScQPLlqkdweCcTvgpEFEjHeQCceKfwUmZkxkIC7aOZKOVz>>%filepath%
echo 5NotTp0+avUROwkgcseJO93F4CzOoGIdUJGw/oiUDfZfr43qOFVWtFwJcLVzVsMz>>%filepath%
echo PjB6Mqmnuzm+dYcK1PIfk9NtD/q8zGmZJ/q+yYEozJkY5C9C3ZrIWf1vJb1jFTZV>>%filepath%
echo aTaDewhgdbQLFb/zKL3fzpcqUztUB+xsQBAN5w0m0lA+GU0Og0m15wiv8M1JxAd1>>%filepath%
echo vBIuVo0Dq6SKqZYJOt3nGU06mYJRoKF6+rgiM+MOtcCjMUB1ZdXXhu8oXGK//ECJ>>%filepath%
echo mwNGiDWhlBgjcI5lFNcH6T9QSwMEFAAAAAgA0YpoV7iLWOaDAAAAqQAAABAAAABG>>%filepath%
echo dWxsWEFjY3VyYWN5LmpzVYzBCsIwEETvgv+wrAgJFoxebQoFycGjePBawrYEQgLb>>%filepath%
echo 5CCl/25QsXRuM/N4dxrcmIgf3SDQZO+frbWZO/u6YQV9Dja5GEBImLYbKHG9+CNl>>%filepath%
echo 1VrDSSk5MaXMAbC20UfWO2OurVINwgEW/ixLxX19/EANzl8n+ZF+ghVc7rmCxJnk>>%filepath%
echo 5Q1QSwMEFAAAAAgAMBBsVxwfGmCRBQAAZhkAAA0AAABNb3ZpbmdNYW5OLmpzrZdN>>%filepath%
echo b9MwGMfPIPEdTE9JWUsbVt5KQVsZkgVkjK7ANWxmRBS3JCkgqp3gzoUTEie+AEIc>>%filepath%
echo OCDxfWAfgscviZPYbl1g2lbXef6/58Wx8+Q+OYrTjCT70ZHXuDt9GdOjuxENGxvo>>%filepath%
echo yZweZPGUIm+URUk2it+Q+1sPN9Dd6HUxHs0IORSj+eNidvg0okdiSKKUDXy0OHP6>>%filepath%
echo lFKiQQnTTshsEh0QD5yy34bfB2OOFqZ8aDcUnoUpfFlK5aFJWz62m0Lo0hBGVjME>>%filepath%
echo PxOSoVtQLcacPn889fw+nyvqBhcudPgcS1vOXBYzIjv+XUywHAqR9BA/8eI0jEJv>>%filepath%
echo FiUpuTWZRlllVXx/MOj4i7LD8uX+8RKM8KYgyj2MHAAyIwVQKcLIAcALoOR5Pfin>>%filepath%
echo ScpK7fuLhGTzhOZBFkaIX0dnBzx+NuYpyfVhH31emv34OQuRklfoZpQRz28fET4J>>%filepath%
echo q3es1pVMollKDpdYoxYqgH0VRVl4TSTjL8TlnI1DuLMAWzU+L437VWNhKjWGa2mW>>%filepath%
echo lG7VbDrKEtjLng/D8WxGkiFc8XJoHmQhHKAGDkc43Gn4C+mJfWA6iinxhFOoi129>>%filepath%
echo O97X5bvzzFWPQyMB07UYe+Otm3XA3jw6dFGDf10O3l31ODQSMF2LMRxv42GdMJw/>>%filepath%
echo jg9c9BCBAQABOBNwaGZguh4FChHuN/SlSDIXPcRgAEAEzgQcmhmYrkfZG2MdsTeP>>%filepath%
echo qZMeYjAAIAJnAg7NDEzXo+w8urdbJ+y8nk1d1BCBLgf3rnocGgmYrsUY4vvaPTmM>>%filepath%
echo E6f7EfzrcvDuqsehkYDpWoztreHtOmA7Onjmogb/uhy8u+pxaCRguhZj587WaF8/>>%filepath%
echo GnYmUZq5nQwQhRECYaxBwaGNg+m6pO3dcTjUHjvbU+gUnJ46EIkJAWG4M3BooWC6>>%filepath%
echo lAMPf9nGgplquFCTiysPe69od5nHrr8w67xuy+gFDhqSzKYTaH4OH0STOQSoPNe6>>%filepath%
echo Ct32eu4BXgT0q4X//vEq0DXUsSA6ZbHoDU2Ac4h3npiWGmifNUm34tfk0NvMOyQJ>>%filepath%
echo I5OU1DpN5ud4A2XJnDBj2bHX+//z508+ffv19e3v9+/Q7y8ffv38cPL5x8m77ycf>>%filepath%
echo P7SFaGUXeuZ0/gpW7sUyH+UBdVELKpc9bR9MU8/LUFN8u4d9aCIDWEJFyG/JGkII>>%filepath%
echo 0pi6yDE1AFpeEYFUAydjTXGXYwwU1gyVERlTaHaya6rn67F/MNeUI0uYe5oPuHPa>>%filepath%
echo PXQDBcwb/7uqCjibvvJa4so5FGygwBY774C04G0JaNZlhyL+DXTBkoImVjlsMocu>>%filepath%
echo eVyw5cE7IGMetlw0hSmXTUsumljlcpk5dM1n055PTO352HOK6cqcetacNJd5Tt2L>>%filepath%
echo qKlHsCyxni0x1h9VnQwGcNihG/B3VbEA0e2wTZHxnaeHDAGbUV0WbxGawrUYz7q/>>%filepath%
echo ChY7pmVMfn7sdvpqtlvMdvmsLFL++s4L1qw4DphfnkYHnPMDWK2Owb4lBeeEQA8X>>%filepath%
echo GjTzJkxfJJlYZXOmsrnTz0upy6u9rO6YlinlCqBqCTw9rGKb+7IQNUUtmEDWLeAB>>%filepath%
echo qW8+K42xMrzxg1s8RbBQ7Uudbu+yvoM8L+UAyUv1HCHDpSR2KyBRIBPzHDDZN42L>>%filepath%
echo qZXMCgnY8wNRymuMVS1OET7z1WTaXgCWlUz8flXDVnEAFVshFQGbH5Gy9Vx7b+SP>>%filepath%
echo U21Hy50Ao8qzGub4hfalXrHc6vFteqhALf8xONPxYI7LHpZ9of82OHAKayYu8huh>>%filepath%
echo aE3kqv63ki7Zhaoq6jD4CwesOsaNyt4AtN6v8ppha4cKg8oBBNbwvGGBKOSldu9i>>%filepath%
echo 0MvPHJErtOHCPijsNXOxazzYJblNvk1YpnVOu7eSFLQDA+rKhRxm1100Ci9vgtRU>>%filepath%
echo VnNt+InCXdTLD0h2ODALsSe0EjMLtsbSivsH138AUEsDBBQAAAAIAFRybFeNLyBL>>%filepath%
echo UwUAAMkYAAAXAAAAQ3VzdG9tQ29sb3JSYW5nZVBsdXMuanOtV9ty0zAQfWem/6DJ>>%filepath%
echo k50mITZJKYTAtKHMaACXXgK8mtQUD0EOvgBDp//OriRfJdWi0GkbWdpzzu7KK23O>>%filepath%
echo o+s4y6P0Mrx2Bqsiy5Nvq2SbpOchu47ebYtsMCKfC7bJ44QR5/zoAz6MSIrLnvz0>>%filepath%
echo R2SDGE9+wnMUZhEYu+Rm7wEh2yjnJGRJoh/htqQh+2TgHLoDdwFGkhJMxGCSRrtt>>%filepath%
echo uIkccAB/m1Z+aeUbrIQ7YMUHJi7hbGll4pKhgJkcGeziz8SJsyAMHIzNXS6nMnoR>>%filepath%
echo Pyu+vQ+3RQQ8uzDNolfbJMwdTIewn+TJRZ7G7NpxOV8NO+f5aONEjnSGvsbQF4bC>>%filepath%
echo x8qRZzW5e1O7V88ubjWo57WSFuUDqnKKBpAzXP0dpUnIrhIWVUyjSqca+c2ABFJS>>%filepath%
echo dOazPK33o5E5GK53uyhdwYrTDLoCLcmABhc0OBm4N1IBPyi7iME3IeYubvXI0/Wl>>%filepath%
echo Cj0tchssDbRoyqzxZ+ujl13wWRFe9SFBV4WCqg2WBlo0Zdb41fqYrrroVfEp3vRh>>%filepath%
echo QVkDBmErNA30eMrsGSDw4HKgpjzN+7CgrQGDshWaBno8ZfYMZ2uqws+KmPViQVsD>>%filepath%
echo BmUrNA30eMrsGU4+vjvtok9+7ZI+JCirUJC1wdJAi6bMGr+i58q7torT3vcMdFUo>>%filepath%
echo qNpgaaBFU2aNPz5ave6Cj8PN1z4k6KpQULXB0kCLpswaf/Lm6OJSLe2TbZjl/ZUN>>%filepath%
echo 6loCkLdkoIGJg7K/YTk+XQcr5Uo4TqAj6L0RwAMdHOTt8DQwMFDWywHNw7TCTJXV>>%filepath%
echo 58RTV/HyTqMrmHob5l8mKQhcOY5HxoRLkKHoWyicELJty4pPmbjZpyPiuyPiHbhk>>%filepath%
echo n5sr1r7WutlQXKdRxO6lDg3tzF4drVX1T9Dy3Et8NiIH9uKldS2eRnmRMsx83SjB>>%filepath%
echo 8mQXXl3kcJWgv4PpANhFhnqtMJK7jbjyLYm24OxNy4vBK/4zEBZ7D25HJE+LyN17>>%filepath%
echo sPeg/JrRahaTn+9H5FvM8H/46z1vqSs2h2cTVsUADBoAt0SMxSN5SBycKJ8XoF6L>>%filepath%
echo NrvAHFSkAm4R594kmePkZCie3lGkg3a1wVAWX4dCALKY2cAp0xCMncoDiQaeHOPy>>%filepath%
echo OI2GBVuzJkWOCMVO9nDdePl7CXNDOTK4eaZowJkwmZMXxEc1/ve0TuAu+emMxco+>>%filepath%
echo 8aFATb7z3kxx3hSAYt0UFP6PyCNDCAq4jmGGgjZxPDLFwfs0bRymWBSELpaZIRYF>>%filepath%
echo XMdyiIK28czM8cTMHI85ppj1xjQ3xqRIljF5B2SoenBXYHNTYNjdtUWWS7i2yAv4>>%filepath%
echo e1pzAYU3xaLIeeWpLoPDeioP/a1cq+nGyGesr4oLb1Xpk1uefNNFPetVsx6flUly>>%filepath%
echo pRM8YcOWsI+6PIwpiOMx3dgdjf1YAvYFQHUXWk19EWbf01zssj5S2aaq56XEldm+>>%filepath%
echo K++UNVmaGSDtFDiqW1WZuzIRHUTHGV/mzecO1U8upkabGd7OwiueEdioyeOpNz9U>>%filepath%
echo K8hxMk4g+TI1RojwTiZ8FYhIkI5zHzjxSeGlzMiMiQTah0uRymfI1U5O5T5qDRE7>>%filepath%
echo 98GyFYm7aGNwF5eQsR6ocFh/Rcrm+q9ro7xOlYqWlQCj1l0Nc3xh8nhebXd9fesu>>%filepath%
echo FcjlPzqnOx70fpndMm/0fZ0DUdgzschfhKo1kbv631J6RxXWWakPg3sIYHa0hYrf>>%filepath%
echo d5Ter/WFytQOVQatAwis4b5BR2rKx5P5gT8vzxwRK3xrEvZ+Za+Yi6pxoEpKm7JM>>%filepath%
echo MNIuz2Tey+RPfA3Vk0clmRl3oAUezgCqS6s+N/xE4RLd9AMlHg5oIWpCSTFa4B5L>>%filepath%
echo K64P0n8AUEsBAj8AFAAAAAgAMHJsV+OEI2F7BQAAJBkAABgAJAAAAAAAAAAgAAAA>>%filepath%
echo AAAAAEN1c3RvbUNvbG9yUmFuZ2VQbHVzRi5qcwoAIAAAAAAAAQAYAAC+woknFdoB>>%filepath%
echo AL7CiScV2gEAbZRKJxXaAVBLAQI/ABQAAAAIANGKaFe4i1jmgwAAAKkAAAAQACQA>>%filepath%
echo AAAAAAAAIAAAALEFAABGdWxsWEFjY3VyYWN5LmpzCgAgAAAAAAABABgAAIFquRwS>>%filepath%
echo 2gGA2xHZoBTaAYDbEdmgFNoBUEsBAj8AFAAAAAgAMBBsVxwfGmCRBQAAZhkAAA0A>>%filepath%
echo JAAAAAAAAAAgAAAAYgYAAE1vdmluZ01hbk4uanMKACAAAAAAAAEAGAAAflm4wBTa>>%filepath%
echo AYCH5t3AFNoBgNsR2aAU2gFQSwECPwAUAAAACABUcmxXjS8gS1MFAADJGAAAFwAk>>%filepath%
echo AAAAAAAAACAAAAAeDAAAQ3VzdG9tQ29sb3JSYW5nZVBsdXMuanMKACAAAAAAAAEA>>%filepath%
echo GAAAuEqyJxXaAQC4SrInFdoBALhKsicV2gFQSwUGAAAAAAQABACUAQAAphEAAAAA>>%filepath%
del "Jipper-Overlayer-Scripts.zip"
certutil -decode %filepath% "Jipper-Overlayer-Scripts.zip"

goto ApplyUI-3


:ApplyUI-2-download

PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://jongyeol.click/JipperOverlayer/Scripts.zip', 'Jipper-Overlayer-Scripts.zip') }"

goto ApplyUI-3


:ApplyUI-3

title UI 적용(3/6)
cls
echo ------------------------------
echo.
echo UI를 적용중입니다.
echo ●●●○○○
echo.
echo ------------------------------

PowerShell -Command "& {Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('Jipper-Overlayer-Scripts.zip', '%file%\Mods\Overlayer\Scripts')}"

goto ApplyUI-3

title UI 적용(4/6)
cls
echo ------------------------------
echo.
echo UI를 적용중입니다.
echo ●●●●○○
echo.
echo ------------------------------

PowerShell -Command "& { (New-Object System.Net.WebClient).DownloadFile('https://jongyeol.click/JipperOverlayer/Texts/%scale%', 'Texts.json') }"

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

del /f /q %filepath%

pause
exit
