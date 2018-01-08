goto %1

:install
docker pull --disable-content-trust jturney/mesonci-cygwin
echo FROM jturney/mesonci-cygwin >Dockerfile
echo ADD %APPVEYOR_BUILD_FOLDER% %APPVEYOR_BUILD_FOLDER% >>Dockerfile
docker built -t withgit .
goto :eof

:build_script
goto :eof

:test_script
docker run -w %APPVEYOR_BUILD_FOLDER% withgit 'python3 run_tests.py --backend=%backend%'
goto :eof
