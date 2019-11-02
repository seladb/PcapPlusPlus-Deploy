powershell -command "msbuild mk\%compiler%\PcapPlusPlus.sln /t:Clean"
if "%config%"=="Release" powershell -command "msbuild mk\%compiler%\PcapPlusPlus-Examples.sln /t:Clean"

move Dist %compiler%%platform%%config%Dist