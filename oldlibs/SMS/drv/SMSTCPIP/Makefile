# _____     ___ ____     ___ ____
#  ____|   |    ____|   |        | |____|
# |     ___|   |____ ___|    ____| |    \    PS2DEV Open Source Project.
#-----------------------------------------------------------------------
# Copyright 2001-2004, ps2dev - http://www.ps2dev.org
# Licenced under Academic Free License version 2.0
# Review ps2sdk README & LICENSE files for further details.
#

IOP_SRC_DIR  = src/
IOP_INC_DIR  = include/

IOP_BIN  = SMSTCPIP.irx

IOP_OBJS = ps2ip.o inet.o ip.o ip_addr.o ip_frag.o etharp.o \
	tcp_in.o tcp_out.o tcp.o tcpip.o mem.o api_lib.o \
	api_msg.o sockets.o netif.o udp.o \
	memp.o icmp.o pbuf.o imports.o exports.o
IOP_OBJS := $(IOP_OBJS:%=$(IOP_SRC_DIR)%)
IOP_INCS += -I$(IOP_INC_DIR)

IOP_CFLAGS  += -DLWIP_NOASSERT -Wno-packed-bitfield-compat -fno-builtin-printf

all: $(IOP_BIN)

clean:
	rm -f -r $(IOP_OBJS) $(IOP_BIN)

# A rule to build imports.lst.
$(IOP_SRC_DIR)%.o : $(IOP_SRC_DIR)%.lst
	$(ECHO) "#include \"irx_imports.h\"" > $(IOP_SRC_DIR)build-imports.c
	cat $< >> $(IOP_SRC_DIR)build-imports.c
	$(IOP_CC) $(IOP_CFLAGS) -fno-toplevel-reorder -I$(IOP_SRC_DIR) -c $(IOP_SRC_DIR)build-imports.c -o $@
	-rm -f $(IOP_SRC_DIR)build-imports.c

# A rule to build exports.tab.
$(IOP_SRC_DIR)%.o : $(IOP_SRC_DIR)%.tab
	$(ECHO) "#include \"irx.h\"" > $(IOP_SRC_DIR)build-exports.c
	cat $< >> $(IOP_SRC_DIR)build-exports.c
	$(IOP_CC) $(IOP_CFLAGS) -fno-toplevel-reorder -I$(IOP_SRC_DIR) -c $(IOP_SRC_DIR)build-exports.c -o $@
	-rm -f $(IOP_SRC_DIR)build-exports.c

include $(PS2SDK)/Defs.make
include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.iopglobal
