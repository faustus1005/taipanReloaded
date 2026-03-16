# Building Taipan on Windows

Taipan uses the [curses](https://en.wikipedia.org/wiki/Curses_(programming_library)) API for its
terminal UI. On Windows you need **PDCurses** as the curses implementation, plus either MinGW-w64
or MSVC as the C compiler.

---

## Option A – MinGW-w64 + MSYS2 (recommended)

1. **Install MSYS2** from <https://www.msys2.org/> and open the *MSYS2 MinGW 64-bit* shell.

2. **Install the toolchain and PDCurses:**

   ```bash
   pacman -Syu
   pacman -S mingw-w64-x86_64-gcc mingw-w64-x86_64-pdcurses make
   ```

3. **Clone and build:**

   ```bash
   git clone https://github.com/faustus1005/taipanReloaded
   cd taipanReloaded
   make
   ```

4. **Run:**

   ```bash
   ./taipan.exe
   ```

---

## Option B – CMake + vcpkg (works with MSVC or MinGW)

1. **Install vcpkg** (<https://vcpkg.io>) and integrate it:

   ```powershell
   git clone https://github.com/microsoft/vcpkg
   .\vcpkg\bootstrap-vcpkg.bat
   .\vcpkg\vcpkg install pdcurses:x64-windows
   ```

2. **Configure and build with CMake:**

   ```powershell
   cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=path\to\vcpkg\scripts\buildsystems\vcpkg.cmake ^
         -DCMAKE_BUILD_TYPE=Release
   cmake --build build --config Release
   ```

3. **Run:**

   ```powershell
   .\build\Release\taipan.exe
   ```

---

## Notes

- The game runs in a Windows Console window. For the best experience use **Windows Terminal**
  (<https://aka.ms/terminal>) with a font that supports line-drawing characters (e.g. *Cascadia Code*
  or *Consolas*).
- A minimum console size of **80×25** is required (the default for Windows Terminal).
- PDCurses renders into the current console window; no external window manager is needed.
