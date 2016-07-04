# _____     ___ ____     ___ ____
#  ____|   |    ____|   |        | |____|
# |     ___|   |____ ___|    ____| |    \    PS2DEV Open Source Project.
#-----------------------------------------------------------------------
# Copyright 2001-2004, ps2dev - http://www.ps2dev.org
# Licenced under Academic Free License version 2.0
# Review ps2sdk README & LICENSE files for further details.
#

IOP_BIN = ps2ftpd.irx
IOP_OBJS = main.o FileSystem.o FtpServer.o FtpClient.o FtpCommands.o FtpMessages.o imports.o

IOP_CFLAGS += -fno-builtin
#IOP_CFLAGS +=  -DDEBUG

# A rule to build imports.lst.
%.o : %.lst
	$(ECHO) "#include \"irx_imports.h\"" > build-imports.c
	cat $< >> build-imports.c
	$(IOP_CC) $(IOP_CFLAGS) -fno-toplevel-reorder -I. -c build-imports.c -o $@
	-rm -f build-imports.c

all: $(IOP_BIN)

clean:
	rm -f -r $(IOP_OBJS) $(IOP_BIN)

include $(PS2SDK)/Defs.make
include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.iopglobal
