# _____     ___ ____     ___ ____
#  ____|   |    ____|   |        | |____|
# |     ___|   |____ ___|    ____| |    \    PS2DEV Open Source Project.
#-----------------------------------------------------------------------
# Copyright 2001-2004, ps2dev - http://www.ps2dev.org
# Licenced under Academic Free License version 2.0
# Review ps2sdk README & LICENSE files for further details.
#

IOP_BIN	 = hdl_info.irx
IOP_OBJS = main.o hdd.o apa.o hdl.o imports.o exports.o

IOP_CFLAGS  += -fno-builtin
IOP_LDFLAGS += -L$(PS2SDK)/iop/lib

# compiling with iop-gcc 3.2.3 causes weird problems in ps2ftpd
# temporary solution is to turn off compiler optimization

# IOP_CFLAGS += $(CFLAGS_TARGET) -O2 -G0 -c $(IOP_INCS) -Wall -fno-builtin

# A rule to build imports.lst.
%.o : %.lst
	$(ECHO) "#include \"irx_imports.h\"" > build-imports.c
	cat $< >> build-imports.c
	$(IOP_CC) $(IOP_CFLAGS) -fno-toplevel-reorder -I. -c build-imports.c -o $@
	-rm -f build-imports.c

# A rule to build exports.tab.
%.o : %.tab
	$(ECHO) "#include \"irx.h\"" > build-exports.c
	cat $< >> build-exports.c
	$(IOP_CC) $(IOP_CFLAGS) -fno-toplevel-reorder -I. -c build-exports.c -o $@
	-rm -f build-exports.c

all: $(IOP_BIN)

clean:
	rm -f -r $(IOP_OBJS) $(IOP_BIN)

include $(PS2SDK)/Defs.make
include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.iopglobal
