
PcapPlusPlus web-site:  https://pcapplusplus.github.io/

GitHub page:            https://github.com/seladb/PcapPlusPlus


This package contains:
----------------------

 - PcapPlusPlus compiled libraries
    - Common++.lib
    - Packet++.lib
    - Pcap++.lib
 - These libraries are compiled in 4 different configurations (each containing all libraries above):
    - 32bit debug configuration (`x86\Debug`)
	- 32bit release configuration (`x86\Release`)
	- 64bit debug configuration (`x64\Debug`)
	- 64bit release configuration (`x64\Release`)
 - PcapPlusPlus header files (under `header\`)
 - Compiled examples:
   - 32bit executables (under `x86\examples`)
	- 64bit executables (under `x64\examples`)
 - Visual Studio example solution configured to work with PcapPlusPlus compiled binaries (under `ExampleProject\`)


Running the examples:
---------------------

 - Make sure you have WinPcap (or Wireshark) installed
 - Make sure you have Visual C++ Redistributable for Visual Studio installed
 - If examples still doesn't run, install Visual C++ Redistributable for Visual Studio 2010 also

In order to compile your application with these binaries you need to:
---------------------------------------------------------------------

 - Make sure you have Microsoft Visual Studio installed
 - Make sure you have WinPcap Developer's pack installed (can be downloaded from https://www.winpcap.org/devel.htm)
 - Make sure you have pthread-win32 (can be downloaded from: ftp://sourceware.org/pub/pthreads-win32/pthreads-w32-2-9-1-release.zip)
 - You need to add to your project all of the include and binary paths required for PcapPlusPlus. The best option is to take a look at the configuration of the ExampleProject (under `ExampleProject\` folder). Another option
   is to use the ExampleProject, delete all the code from it and start writing your own code
 - Before using the ExampleProject solution please make sure you update the PcapPlusPlusPropertySheet.props file (inside `ExampleProject\` folder) with the following:
    - Set the value of the `PcapPlusPlusHome` XML node to the folder where PcapPlusPlus binaries package is located (the one you downloaded)
	 - Set the value of the `WinPcapHome` XML node to the folder where WinPcap Developer's Pack is located
	 - Set the value of the `PThreadWin32Home` node to the folder where pthread-win32 is located
 - Now you can load the solution and build it. You can switch between Debug/Release and x86/x64 configurations
 - Build result will be in `ExampleProject\Debug` or `ExampleProject\Release` (according to chosen configuration)


