set compiler=vs2015

set /p LATEST_RELEASE=<C:\projects\pcapplusplus-deploy\misc\latest_release.version
set DIST_DIR_NAME=pcapplusplus-%LATEST_RELEASE%-windows-%compiler%-%config%-%platform%

move Dist %DIST_DIR_NAME%

copy C:\projects\pcapplusplus-deploy\READMEs\README.release.win.vs2015 %DIST_DIR_NAME%\README.release

mkdir %DIST_DIR_NAME%\ExampleProject
xcopy Examples\Tutorials\Tutorial-HelloWorld\main.cpp %DIST_DIR_NAME%\ExampleProject /Y
xcopy Examples\Tutorials\Tutorial-HelloWorld\1_packet.pcap %DIST_DIR_NAME%\ExampleProject /Y
xcopy C:\projects\pcapplusplus-deploy\vs2015\PcapPlusPlusPropertySheet.props %DIST_DIR_NAME%\ExampleProject /Y
copy C:\projects\pcapplusplus-deploy\vs2015\README.md.ExampleProject %DIST_DIR_NAME%\ExampleProject\README.md
xcopy C:\projects\pcapplusplus-deploy\vs2015\ExampleProject.sln %DIST_DIR_NAME%\ExampleProject /Y
xcopy C:\projects\pcapplusplus-deploy\vs2015\ExampleProject.vcxproj %DIST_DIR_NAME%\ExampleProject /Y
xcopy C:\projects\pcapplusplus-deploy\vs2015\ExampleProject.vcxproj.filters %DIST_DIR_NAME%\ExampleProject /Y

7z a -r %DIST_DIR_NAME%.zip %DIST_DIR_NAME%\

curl --upload-file %DIST_DIR_NAME%.zip https://transfer.sh/%DIST_DIR_NAME%.zip