set CACHE=C:\cache
set CYGWIN_MIRROR=http://cygwin.mirror.constant.com

if _%arch%_ == _x64_ set SETUP=setup-x86_64.exe && set CYGWIN_ROOT=C:\cygwin64
if _%arch%_ == _x86_ set SETUP=setup-x86.exe && set CYGWIN_ROOT=C:\cygwin

if not exist %CACHE% mkdir %CACHE%

echo Updating Cygwin and installing ninja and test prerequisites
%CYGWIN_ROOT%\%SETUP% -qnNdO -R "%CYGWIN_ROOT%" -s "%CYGWIN_MIRROR%" -l "%CACHE%" -g -P ^
flex,^
gcc-fortran,^
gcc-objc++,^
gcc-objc,^
gobject-introspection,^
libQt5Core-devel,^
libQt5Gui-devel,^
libSDL2-devel,^
libboost-devel,^
libglib2.0-devel,^
libgtk3-devel,^
itstool,^
libllvm-devel,^
libllvm-devel-static,^
libncurses-devel,^
libopenmpi-devel,^
libprotobuf-devel,^
libwmf-devel,^
nasm,^
ninja,^
python3-cython,^
python3-devel,^
python3-gi,^
python3-pip,^
vala,^
zlib-devel

echo Install done
