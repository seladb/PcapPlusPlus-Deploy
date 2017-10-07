set compiler=vs2015

set /p LATEST_RELEASE=<C:\projects\pcapplusplus-deploy\latest_release.version
set DIST_DIR_NAME=pcapplusplus-%LATEST_RELEASE%-windows-%compiler%-%config%-%platform%

move Dist %DIST_DIR_NAME%

copy Deploy\README.release.win.vs2015 %DIST_DIR_NAME%\README.release

mkdir %DIST_DIR_NAME%\ExampleProject
xcopy Examples\Tutorials\Tutorial-HelloWorld\main.cpp %DIST_DIR_NAME%\example-app /Y
xcopy Examples\Tutorials\Tutorial-HelloWorld\1_packet.pcap %DIST_DIR_NAME%\example-app /Y
xcopy C:\projects\pcapplusplus-deploy\PcapPlusPlusPropertySheet.props %DIST_DIR_NAME%\ExampleProject /Y
:: xcopy C:\projects\pcapplusplus-deploy\ExampleProject.vcxproj %DIST_DIR_NAME%\ExampleProject /Y

7z a -r %DIST_DIR_NAME%.zip %DIST_DIR_NAME%\

curl --upload-file %DIST_DIR_NAME%.zip https://transfer.sh/%DIST_DIR_NAME%.zip