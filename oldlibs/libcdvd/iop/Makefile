# _____     ___ ____     ___ ____
#  ____|   |    ____|   |        | |____|
# |     ___|   |____ ___|    ____| |    \    PS2DEV Open Source Project.
#-----------------------------------------------------------------------
# Copyright 2001-2005, ps2dev - http://www.ps2dev.org
# Licenced under Academic Free License version 2.0
# Review ps2sdk README & LICENSE files for further details.
#

#IOP_LDFLAGS += -m mipsirx 
IOP_BIN_DIR = ../irx/
IOP_BIN = $(IOP_BIN_DIR)cdvd.irx

IOP_OBJS = cdvd_iop.o iop_cdvdman.o imports.o

all: $(IOP_BIN_DIR) $(IOP_BIN)

$(IOP_BIN_DIR):
	mkdir -p $(IOP_BIN_DIR)

# A rule to build imports.lst.
%.o : %.lst
	$(ECHO) "#include \"irx_imports.h\"" > build-imports.c
	cat $< >> build-imports.c
	$(IOP_CC) $(IOP_CFLAGS) -fno-toplevel-reorder -I. -c build-imports.c -o $@
	-rm -f build-imports.c

clean:
	rm -f -r $(IOP_BIN_DIR) $(IOP_OBJS)

include $(PS2SDK)/Defs.make
include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.iopglobal
