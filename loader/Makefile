# _____     ___ ____     ___ ____
#  ____|   |    ____|   |        | |____|
# |     ___|   |____ ___|    ____| |    \    PS2DEV Open Source Project.
#-----------------------------------------------------------------------
# Copyright 2001-2004, ps2dev - http://www.ps2dev.org
# Licenced under Academic Free License version 2.0
# Review ps2sdk README & LICENSE files for further details.
#

EE_CFLAGS  := -ffreestanding -fno-builtin \
		-fshort-double -mhard-float -mno-abicalls -EL \
#EE_CFLAGS  := -G0 -EL

EE_ASFLAGS := -EL $(EE_ASFLAGS)

###dlanor: adjust these three, for PS2Link compatibility tests
###dlanor: old LaunchELF used LA=0x90000, SA=0xB0000, SS=0x08000
###dlanor: The values below were implemented in LaunchELF v3.50
LOADADDR  = 0x90000
STACKADDR = 0xA8000
STACKSIZE = 0x04000

ifeq ($(DEBUG),1)
LOADADDR  = 0x1700000
STACKADDR = 0x1720000
STACKSIZE = 0x08000
endif

LDPARAMS := -Wl,--defsym -Wl,_stack_size=$(STACKSIZE) -Wl,--defsym -Wl,_stack=$(STACKADDR)

EE_LDFLAGS += -Wl,-Ttext -Wl,$(LOADADDR) -s $(LDPARAMS)

EE_LDFLAGS := $(EE_LDFLAGS) -L$(PS2SDK)/sbv/lib \

EE_BIN = loader.elf
EE_OBJS = loader.o

EE_LIBS = -lfileXio -lpatches
ifeq ($(DEBUG),1)
EE_LIBS += -ldebug
endif

all: $(EE_BIN)

clean:
	rm -f -r $(EE_OBJS) $(EE_BIN)

include $(PS2SDK)/Defs.make
include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.eeglobal
