#update this to point to the location of gslib
#GSLIB = /ps2dev/gslib

EE_BIN = example.elf
EE_OBJS = example.o

EE_LDFLAGS += -L../lib -L$(GSKIT)/lib
EE_LIBS += -lkernel -lcdvdfs -lgs -lgcc -lsupc++ -lpad
EE_INCS += -I $(GSKIT)/source -I ../ee

all: $(EE_BIN)

clean:
	rm -f *.elf *.o *.a

include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.eeglobal
