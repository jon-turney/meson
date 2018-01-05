goto %1

:install
docker pull --disable-content-trust jturney/mesonci-cygwin
goto :eof

:build_script
docker run jturney/mesonci-cygwin 'ninja --version'
goto :eof

:test_script
docker run -v %APPVEYOR_BUILD_FOLDER%:%APPVEYOR_BUILD_FOLDER% -w %APPVEYOR_BUILD_FOLDER% jturney/mesonci-cygwin 'python3 run_tests.py --backend=%backend%'
goto :eof
