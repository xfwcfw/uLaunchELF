# _____     ___ ____     ___ ____
#  ____|   |    ____|   |        | |____|
# |     ___|   |____ ___|    ____| |    \    PS2DEV Open Source Project.
#-----------------------------------------------------------------------
# Copyright 2001-2004, ps2dev - http://www.ps2dev.org
# Licenced under Academic Free License version 2.0
# Review ps2sdk README & LICENSE files for further details.
#

IOP_OBJS_DIR = obj/
IOP_BIN_DIR = bin/
IOP_SRC_DIR = src/
IOP_INC_DIR = include/

IOP_BIN  = $(IOP_BIN_DIR)vmc_fs.irx
IOP_OBJS = vmc_fs.o vmc_io.o vmc_misc.o vmc_fat.o vmc_ps2.o imports.o
IOP_OBJS := $(IOP_OBJS:%=$(IOP_OBJS_DIR)%)

IOP_CFLAGS  += -Wall -fno-builtin
IOP_LDFLAGS += -s

all: $(IOP_OBJS_DIR) $(IOP_BIN_DIR) $(IOP_BIN)

clean:
	rm -f -r $(IOP_OBJS_DIR) $(IOP_BIN_DIR)

include $(PS2SDKSRC)/Defs.make
include $(PS2SDKSRC)/iop/Rules.make
#include $(PS2SDKSRC)/Rules.release
#include $(PS2SDK)/samples/Makefile.iopglobal