cmake_minimum_required(VERSION 3.15)
project(taipan C)

set(CMAKE_C_STANDARD 99)

# Source files
add_executable(taipan taipan.c)

# Compiler warnings
target_compile_options(taipan PRIVATE -Wall)

# Release build optimizations
if(CMAKE_BUILD_TYPE STREQUAL "Release")
    target_compile_options(taipan PRIVATE -O3)
endif()

# Debug build
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_definitions(taipan PRIVATE DEBUG)
endif()

# --- Curses library ---
if(WIN32)
    # Windows: use PDCurses (install via vcpkg: vcpkg install pdcurses)
    # or MinGW: pacman -S mingw-w64-x86_64-pdcurses
    find_library(PDCURSES_LIB NAMES pdcurses pdcurses_wincon REQUIRED)
    target_link_libraries(taipan PRIVATE ${PDCURSES_LIB})
    message(STATUS "Windows build: linking PDCurses (${PDCURSES_LIB})")
else()
    # Linux/macOS: use ncurses
    find_package(Curses REQUIRED)
    target_include_directories(taipan PRIVATE ${CURSES_INCLUDE_DIR})
    target_link_libraries(taipan PRIVATE ${CURSES_LIBRARIES})
    message(STATUS "Unix build: linking ${CURSES_LIBRARIES}")
endif()

# --- Install target ---
if(UNIX)
    install(TARGETS taipan DESTINATION games)
else()
    install(TARGETS taipan DESTINATION bin)
endif()
