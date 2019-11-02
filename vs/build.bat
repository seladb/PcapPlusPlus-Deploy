call configure-windows-visual-studio.bat -v %compiler% -w C:\WpdPack -p C:\pthreads

powershell -command "msbuild mk\%compiler%\PcapPlusPlus.sln /p:Configuration=%config% /p:Platform=%platform% /m"
if "%config%"=="Release" powershell -command "msbuild mk\%compiler%\PcapPlusPlus-Examples.sln /p:Configuration=%config% /p:Platform=%platform% /m"