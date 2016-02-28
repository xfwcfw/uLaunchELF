
IOP_OBJS_DIR = obj/
IOP_BIN_DIR  = irx/
IOP_SRC_DIR  = src/
IOP_INC_DIR  = include/

IOP_BIN  = $(IOP_BIN_DIR)SMSTCPIP.irx

IOP_OBJS = ps2ip.o inet.o ip.o ip_addr.o ip_frag.o etharp.o \
           tcp_in.o tcp_out.o tcp.o tcpip.o mem.o api_lib.o \
		   api_msg.o exports.o imports.o sockets.o netif.o \
		   udp.o memp.o icmp.o pbuf.o
IOP_OBJS := $(IOP_OBJS:%=$(IOP_OBJS_DIR)%)

all: $(IOP_OBJS_DIR) $(IOP_BIN_DIR) $(IOP_BIN)

clean:
	rm -rf $(IOP_OBJS_DIR) $(IOP_BIN_DIR)

include $(PS2SDKSRC)/Defs.make
include $(PS2SDKSRC)/iop/Rules.make
include $(PS2SDKSRC)/iop/Rules.release

IOP_CFLAGS  += -DLWIP_NOASSERT -Wno-packed-bitfield-compat -fno-builtin-printf
IOP_LDFLAGS += -s
