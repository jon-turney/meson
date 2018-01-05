if _%arch%_ == _x64_ set CYGWIN_ROOT=C:\cygwin64
if _%arch%_ == _x86_ set CYGWIN_ROOT=C:\cygwin
set PATH=%CYGWIN_ROOT%\bin;%SYSTEMROOT%\system32

goto %1

:install
if _%arch%_ == _x64_ set SETUP=setup-x86_64.exe
if _%arch%_ == _x86_ set SETUP=setup-x86.exe

set PKGCACHE=C:\cache
set CYGWIN_MIRROR="http://cygwin.mirror.constant.com"

%CYGWIN_ROOT%\%SETUP% -qnNdO -R "%CYGWIN_ROOT%" -s "%CYGWIN_MIRROR%" -l "%PKGCACHE%" -g -P "ninja,gcc-objc,gcc-objc++,libglib2.0-devel,zlib-devel,python3-pip"

goto :eof

:build_script
ninja --version
goto :eof

:test_script
env -- python3 run_tests.py --backend=%backend%"
goto :eof
