set /p LATEST_RELEASE=<C:\projects\pcapplusplus-deploy\misc\latest_release.version
for /f %%i in ('g++ -dumpversion') do set COMPILER_VERSION=%%i
set DIST_DIR_NAME=pcapplusplus-%LATEST_RELEASE%-windows-%compiler%-gcc-%COMPILER_VERSION%

move Dist %DIST_DIR_NAME%

move %DIST_DIR_NAME%\mk\PcapPlusPlus.mk %DIST_DIR_NAME%\mk\temp.mk
powershell -Command "(gc %DIST_DIR_NAME%\mk\temp.mk) -replace '/Dist', '' | Out-File %DIST_DIR_NAME%\mk\temp.mk"
echo PCAPPLUSPLUS_HOME := Drive:/your/PcapPlusPlus/folder> %DIST_DIR_NAME%\mk\PcapPlusPlus.mk
echo MINGW_HOME := Drive:/MinGW/folder>> %DIST_DIR_NAME%\mk\PcapPlusPlus.mk
echo WINPCAP_HOME := Drive:/WpdPack/folder>> %DIST_DIR_NAME%\mk\PcapPlusPlus.mk
more +8 %DIST_DIR_NAME%\mk\temp.mk>> %DIST_DIR_NAME%\mk\PcapPlusPlus.mk
del %DIST_DIR_NAME%\mk\temp.mk

copy C:\projects\pcapplusplus-deploy\READMEs\README.release.header %DIST_DIR_NAME%\README.release
type C:\projects\pcapplusplus-deploy\READMEs\README.release.win.mingw >> %DIST_DIR_NAME%\README.release
type C:\projects\pcapplusplus-deploy\READMEs\release_notes.txt >> %DIST_DIR_NAME%\README.release

mkdir %DIST_DIR_NAME%\example-app
xcopy Examples\Tutorials\Tutorial-HelloWorld\main.cpp %DIST_DIR_NAME%\example-app /Y
xcopy Examples\Tutorials\Tutorial-HelloWorld\1_packet.pcap %DIST_DIR_NAME%\example-app /Y
copy C:\projects\pcapplusplus-deploy\mingw\Makefile.windows %DIST_DIR_NAME%\example-app\Makefile
copy C:\projects\pcapplusplus-deploy\READMEs\README.md.example-app %DIST_DIR_NAME%\example-app\README.md

7z a -r %DIST_DIR_NAME%.zip %DIST_DIR_NAME%\

curl --upload-file %DIST_DIR_NAME%.zip https://upfile.sh/%DIST_DIR_NAME%.zip

echo Uploading %DIST_DIR_NAME%.zip ...
curl -F "file=@%DIST_DIR_NAME%.zip" https://0x0.st
