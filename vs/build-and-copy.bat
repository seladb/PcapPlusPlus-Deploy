set DEPLOY_PROJ_DIR=C:\projects\pcapplusplus-deploy
set PACKAGE_DIR=%DEPLOY_PROJ_DIR%\vs-package
set /p LATEST_RELEASE=<C:\projects\pcapplusplus-deploy\misc\latest_release.version

set TARGET_NAME=pcapplusplus-%LATEST_RELEASE%-windows-%compiler%
set TARGET_DIR=%PACKAGE_DIR%\%TARGET_NAME%


:: Build x86|Debug binaries
set platform=x86
set config=Debug

call %DEPLOY_PROJ_DIR%\vs\build.bat

if not exist "%TARGET_DIR%\%platform%\%config%" mkdir %TARGET_DIR%\%platform%\%config%
xcopy Dist\*.lib %TARGET_DIR%\%platform%\%config% /Y
xcopy Dist\*.pdb %TARGET_DIR%\%platform%\%config% /Y

call %DEPLOY_PROJ_DIR%\vs\clean.bat


:: Build x64|Debug binaries
set platform=x64
set config=Debug

call %DEPLOY_PROJ_DIR%\vs\build.bat

if not exist "%TARGET_DIR%\%platform%\%config%" mkdir %TARGET_DIR%\%platform%\%config%
xcopy Dist\*.lib %TARGET_DIR%\%platform%\%config% /Y
xcopy Dist\*.pdb %TARGET_DIR%\%platform%\%config% /Y

call %DEPLOY_PROJ_DIR%\vs\clean.bat


:: Build x86|Release binaries
set platform=x86
set config=Release

call %DEPLOY_PROJ_DIR%\vs\build.bat

if not exist "%TARGET_DIR%\%platform%\%config%" mkdir %TARGET_DIR%\%platform%\%config%
xcopy Dist\*.lib %TARGET_DIR%\%platform%\%config% /Y
xcopy Dist\*.pdb %TARGET_DIR%\%platform%\%config% /Y

:: copy example binaries
if not exist "%TARGET_DIR%\%platform%\examples" mkdir %TARGET_DIR%\%platform%\examples
xcopy Dist\examples\* %TARGET_DIR%\%platform%\examples /s /i /Y

call %DEPLOY_PROJ_DIR%\vs\clean.bat


:: Build x64|Release binaries
set platform=x64
set config=Release

call %DEPLOY_PROJ_DIR%\vs\build.bat

if not exist "%TARGET_DIR%\%platform%\%config%" mkdir %TARGET_DIR%\%platform%\%config%
xcopy Dist\*.lib %TARGET_DIR%\%platform%\%config% /Y
xcopy Dist\*.pdb %TARGET_DIR%\%platform%\%config% /Y

:: copy example binaries
if not exist "%TARGET_DIR%\%platform%\examples" mkdir %TARGET_DIR%\%platform%\examples
xcopy Dist\examples\* %TARGET_DIR%\%platform%\examples /s /i /Y

:: copy header files
if not exist "%TARGET_DIR%\header" mkdir %TARGET_DIR%\header
xcopy Dist\header\* %TARGET_DIR%\header /s /i /Y

call %DEPLOY_PROJ_DIR%\vs\clean.bat


:: copy README.release file
copy %DEPLOY_PROJ_DIR%\READMEs\README.release.header %TARGET_DIR%\README.release
type %DEPLOY_PROJ_DIR%\READMEs\README.release.win.vs >> %TARGET_DIR%\README.release
type %DEPLOY_PROJ_DIR%\READMEs\release_notes.txt >> %TARGET_DIR%\README.release

:: copy example project
if not exist "%TARGET_DIR%\ExampleProject" mkdir %TARGET_DIR%\ExampleProject
xcopy %DEPLOY_PROJ_DIR%\vs\ExampleProject.sln %TARGET_DIR%\ExampleProject /Y
echo f | xcopy %DEPLOY_PROJ_DIR%\vs\ExampleProject.vcxproj.%compiler% %TARGET_DIR%\ExampleProject\ExampleProject.vcxproj /Y /f
xcopy %DEPLOY_PROJ_DIR%\vs\ExampleProject.vcxproj.filters %TARGET_DIR%\ExampleProject /Y
xcopy %DEPLOY_PROJ_DIR%\vs\PcapPlusPlusPropertySheet.props %TARGET_DIR%\ExampleProject /Y
xcopy Examples\Tutorials\Tutorial-HelloWorld\main.cpp %TARGET_DIR%\ExampleProject /Y
xcopy Examples\Tutorials\Tutorial-HelloWorld\1_packet.pcap %TARGET_DIR%\ExampleProject /Y

