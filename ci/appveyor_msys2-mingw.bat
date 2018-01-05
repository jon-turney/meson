goto %1

:install
powershell (new-object net.webclient).DownloadFile('http://nirbheek.in/files/binaries/ninja/win32/ninja.exe', 'C:\projects\meson\ninja.exe')

powershell If($Env:arch -eq 'x86') {^
            C:\msys64\usr\bin\pacman -S --noconfirm mingw32/mingw-w64-i686-python3;^
          } Else {^
            C:\msys64\usr\bin\pacman -S --noconfirm mingw64/mingw-w64-x86_64-python3;^
          }

if %arch%==x86 (set MESON_PYTHON_PATH=C:\msys64\mingw32\bin) else (set MESON_PYTHON_PATH=C:\msys64\mingw64\bin)
set "PATH=%cd%;%MESON_PYTHON_PATH%;%PATH%;"

goto :eof

:build_script
ninja --version
goto :eof

:test_script
python3 run_tests.py --backend=%backend%"
goto :eof
