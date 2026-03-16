# Taipan v0.9
# A text adventure game for Linux and Windows.
# Copyright (c) 1978-2002 - All Rights Reserved
#
# Created by:
#   Art Canfil
#
# Programmed by:
#   Jay Link <jlink@ilbbs.com>
#
# Apple ][ program coded by:
#   Ronald J. Berg
#

# targets recognized by this makefile:
#   all                 - compiles taipan
#   clean               - remove all .o files and binaries
#   install             - installs taipan (Linux only)

# --- Platform detection ---
ifeq ($(OS),Windows_NT)
    # Building on Windows with MinGW
    CC      = gcc
    LIBS    = -lpdcurses
    EXE     = taipan.exe
    RM      = del /Q
    INSTALL = echo "Use cmake --install or copy taipan.exe manually."
else
    # Building on Linux/macOS
    CC      = gcc
    LIBS    = -lncurses
    EXE     = taipan
    RM      = rm -f
    prefix  = /usr/local
    bindir  = $(prefix)/games
    INSTALL = install -m 4755 -o root -g root -s $(EXE) $(bindir)
endif

CFLAGS  = -Wall
OBJECTS = taipan.o

all: CFLAGS += -O3
all: $(EXE)

debug: CFLAGS += -ggdb3 -DDEBUG
debug: $(EXE)

.PHONY: clean
clean:
	$(RM) $(EXE) $(OBJECTS)

.PHONY: install
install: $(EXE)
	$(INSTALL)

$(EXE): $(OBJECTS)
	$(CC) $(CFLAGS) -o $(EXE) $(OBJECTS) $(LIBS)

taipan.o: taipan.c
	$(CC) $(CFLAGS) -c taipan.c -o taipan.o
