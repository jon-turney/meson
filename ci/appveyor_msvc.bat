goto %1

:install
powershell (new-object net.webclient).DownloadFile('http://nirbheek.in/files/binaries/ninja/win32/ninja.exe', 'C:\projects\meson\ninja.exe')

rem Use the x86 python only when building for x86 for the cpython tests.
rem For all other archs (including, say, arm), use the x64 python.
if %arch%==x86 (set MESON_PYTHON_PATH=C:\python35) else (set MESON_PYTHON_PATH=C:\python35-x64)

rem Set paths for BOOST dll files
if %compiler%==msvc2015 ( if %arch%==x86 ( set "PATH=%PATH%;C:\Libraries\boost_1_59_0\lib32-msvc-14.0" ) else ( set "PATH=%PATH%;C:\Libraries\boost_1_59_0\lib64-msvc-14.0" ) )
if %compiler%==msvc2017 ( if %arch%==x86 ( set "PATH=%PATH%;C:\Libraries\boost_1_64_0\lib32-msvc-14.1" ) else ( set "PATH=%PATH%;C:\Libraries\boost_1_64_0\lib64-msvc-14.1" ) )

rem Set paths and config for build type
if %compiler%==msvc2010 ( call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" %arch% )
if %compiler%==msvc2015 ( call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" %arch% )
if %compiler%==msvc2017 ( call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\VsDevCmd.bat" -arch=%arch% )
set "PATH=%cd%;%MESON_PYTHON_PATH%;%PATH%;"

rem pkg-config is needed for the pkg-config tests on msvc
powershell (new-object net.webclient).DownloadFile('http://nirbheek.in/files/binaries/pkg-config/win32/pkg-config.exe', 'C:\projects\meson\pkg-config.exe')

rem Install MS-MPI
powershell (new-object net.webclient).DownloadFile('https://download.microsoft.com/download/D/B/B/DBB64BA1-7B51-43DB-8BF1-D1FB45EACF7A/msmpisdk.msi','C:\projects\msmpisdk.msi')
c:\windows\system32\msiexec.exe /i C:\projects\msmpisdk.msi /quiet
powershell (new-object net.webclient).DownloadFile('https://download.microsoft.com/download/D/B/B/DBB64BA1-7B51-43DB-8BF1-D1FB45EACF7A/MSMpiSetup.exe','C:\projects\MSMpiSetup.exe')
c:\projects\MSMpiSetup.exe -unattend -full

goto :eof

:build_script
MSBuild /version & echo.
goto :eof

:test_script
python run_tests.py --backend=%backend%
goto :eof
