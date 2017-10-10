set BASE_DIR=%1
set /p LATEST_RELEASE=<..\latest_release.version

set X86_DEBUG_NAME=pcapplusplus-%LATEST_RELEASE%-windows-vs2015-Debug-x86
set X64_DEBUG_NAME=pcapplusplus-%LATEST_RELEASE%-windows-vs2015-Debug-x64
set X86_RELEASE_NAME=pcapplusplus-%LATEST_RELEASE%-windows-vs2015-Release-x86
set X64_RELEASE_NAME=pcapplusplus-%LATEST_RELEASE%-windows-vs2015-Release-x64

7z x %BASE_DIR%\%X86_DEBUG_NAME%.zip -o"%BASE_DIR%"
7z x %BASE_DIR%\%X64_DEBUG_NAME%.zip -o"%BASE_DIR%"
7z x %BASE_DIR%\%X86_RELEASE_NAME%.zip -o"%BASE_DIR%"
7z x %BASE_DIR%\%X64_RELEASE_NAME%.zip -o"%BASE_DIR%"

set TARGET_NAME=pcapplusplus-%LATEST_RELEASE%-windows-vs2015
set TARGET_DIR=%BASE_DIR%\%TARGET_NAME%
mkdir %TARGET_DIR%

xcopy %BASE_DIR%\%X86_DEBUG_NAME%\header\* %TARGET_DIR%\header /s /i
xcopy %BASE_DIR%\%X86_DEBUG_NAME%\ExampleProject\* %TARGET_DIR%\ExampleProject /s /i
xcopy %BASE_DIR%\%X86_DEBUG_NAME%\README.release %TARGET_DIR%\ /Y

mkdir %TARGET_DIR%\x86\Debug
mkdir %TARGET_DIR%\x86\Release
mkdir %TARGET_DIR%\x64\Debug
mkdir %TARGET_DIR%\x64\Release

xcopy %BASE_DIR%\%X86_DEBUG_NAME%\*.lib %TARGET_DIR%\x86\Debug
xcopy %BASE_DIR%\%X86_DEBUG_NAME%\*.pdb %TARGET_DIR%\x86\Debug
xcopy %BASE_DIR%\%X64_DEBUG_NAME%\*.lib %TARGET_DIR%\x64\Debug
xcopy %BASE_DIR%\%X64_DEBUG_NAME%\*.pdb %TARGET_DIR%\x64\Debug
xcopy %BASE_DIR%\%X86_RELEASE_NAME%\*.lib %TARGET_DIR%\x86\Release
xcopy %BASE_DIR%\%X64_RELEASE_NAME%\*.lib %TARGET_DIR%\x64\Release
xcopy %BASE_DIR%\%X86_RELEASE_NAME%\examples\* %TARGET_DIR%\x86\examples /s /i
xcopy %BASE_DIR%\%X64_RELEASE_NAME%\examples\* %TARGET_DIR%\x64\examples /s /i

7z a -r %TARGET_DIR%.zip %TARGET_DIR%\