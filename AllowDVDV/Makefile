IOP_BIN = AllowDVDV.irx
IOP_OBJS = AllowDVDV.o imports.o

IOP_CFLAGS += -D_IOP

# A rule to build imports.lst.
%.o : %.lst
	$(ECHO) "#include \"irx_imports.h\"" > build-imports.c
	cat $< >> build-imports.c
	$(IOP_CC) $(IOP_CFLAGS) -fno-toplevel-reorder -I. -c build-imports.c -o $@
	-rm -f build-imports.c

all: $(IOP_BIN)

clean:
	rm -f $(IOP_BIN) $(IOP_OBJS)

include $(PS2SDK)/Defs.make
include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.iopglobal
