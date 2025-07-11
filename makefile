# this is the build file for project CapsLang
# it is autogenerated by the xmake build system.
# do not edit by hand.

!if "$(VERBOSE)" != "1"
VV=@
!endif

CXX=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.44.35207\bin\HostX64\x64\cl.exe
AS=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.44.35207\bin\HostX64\x64\ml64.exe
MRC=C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\rc.exe
CC=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.44.35207\bin\HostX64\x64\cl.exe

AR=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.44.35207\bin\HostX64\x64\link.exe
SH=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.44.35207\bin\HostX64\x64\link.exe
LD=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.44.35207\bin\HostX64\x64\link.exe

capslang_LD=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.44.35207\bin\HostX64\x64\link.exe
capslang_CC=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.44.35207\bin\HostX64\x64\cl.exe
caps-mini_LD=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.44.35207\bin\HostX64\x64\link.exe
caps-mini_CC=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.44.35207\bin\HostX64\x64\cl.exe

capslang_CCFLAGS=-nologo -MD -TP -DNDEBUG -UDEBUG
capslang_LDFLAGS=-nologo -dynamicbase -nxcompat -machine:x64 /opt:ref /opt:icf kernel32.lib user32.lib gdi32.lib
caps-mini_CCFLAGS=-nologo -MD -TP -DNDEBUG -UDEBUG
caps-mini_LDFLAGS=-nologo -dynamicbase -nxcompat -machine:x64 /opt:ref /opt:icf kernel32.lib user32.lib gdi32.lib

default:  capslang caps-mini

all:  capslang caps-mini

.PHONY: default all  capslang caps-mini

capslang: build\windows\x64\release\capslang.exe
build\windows\x64\release\capslang.exe: build\.objs\capslang\windows\x64\release\src\capslang.c.obj
	@echo linking.release capslang.exe
	-@mkdir build\windows\x64\release > NUL 2>&1
	$(VV)"C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\VC\\Tools\\MSVC\\14.44.35207\\bin\\HostX64\\x64\\link.exe" $(capslang_LDFLAGS) -out:build\windows\x64\release\capslang.exe build\.objs\capslang\windows\x64\release\src\capslang.c.obj

build\.objs\capslang\windows\x64\release\src\capslang.c.obj: src\capslang.c
	@echo compiling.release src\capslang.c
	-@mkdir build\.objs\capslang\windows\x64\release\src > NUL 2>&1
	$(VV)"C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\VC\\Tools\\MSVC\\14.44.35207\\bin\\HostX64\\x64\\cl.exe" -c $(capslang_CCFLAGS) -Fobuild\.objs\capslang\windows\x64\release\src\capslang.c.obj src\capslang.c

caps-mini: build\windows\x64\release\caps-mini.exe
build\windows\x64\release\caps-mini.exe: build\.objs\caps-mini\windows\x64\release\src\caps-mini.c.obj
	@echo linking.release caps-mini.exe
	-@mkdir build\windows\x64\release > NUL 2>&1
	$(VV)"C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\VC\\Tools\\MSVC\\14.44.35207\\bin\\HostX64\\x64\\link.exe" $(caps-mini_LDFLAGS) -out:build\windows\x64\release\caps-mini.exe build\.objs\caps-mini\windows\x64\release\src\caps-mini.c.obj

build\.objs\caps-mini\windows\x64\release\src\caps-mini.c.obj: src\caps-mini.c
	@echo compiling.release src\caps-mini.c
	-@mkdir build\.objs\caps-mini\windows\x64\release\src > NUL 2>&1
	$(VV)"C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\VC\\Tools\\MSVC\\14.44.35207\\bin\\HostX64\\x64\\cl.exe" -c $(caps-mini_CCFLAGS) -Fobuild\.objs\caps-mini\windows\x64\release\src\caps-mini.c.obj src\caps-mini.c

clean:  clean_capslang clean_caps-mini

clean_capslang: 
	@del /F /Q build\windows\x64\release\capslang.exe > NUL 2>&1 || rmdir /S /Q build\windows\x64\release\capslang.exe > NUL 2>&1
	@del /F /Q build\windows\x64\release\capslang.pdb > NUL 2>&1 || rmdir /S /Q build\windows\x64\release\capslang.pdb > NUL 2>&1
	@del /F /Q build\.objs\capslang\windows\x64\release\src\capslang.c.obj > NUL 2>&1 || rmdir /S /Q build\.objs\capslang\windows\x64\release\src\capslang.c.obj > NUL 2>&1

clean_caps-mini: 
	@del /F /Q build\windows\x64\release\caps-mini.exe > NUL 2>&1 || rmdir /S /Q build\windows\x64\release\caps-mini.exe > NUL 2>&1
	@del /F /Q build\windows\x64\release\caps-mini.pdb > NUL 2>&1 || rmdir /S /Q build\windows\x64\release\caps-mini.pdb > NUL 2>&1
	@del /F /Q build\.objs\caps-mini\windows\x64\release\src\caps-mini.c.obj > NUL 2>&1 || rmdir /S /Q build\.objs\caps-mini\windows\x64\release\src\caps-mini.c.obj > NUL 2>&1

