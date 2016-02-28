# _____     ___ ____     ___ ____
#  ____|   |    ____|   |        | |____|
# |     ___|   |____ ___|    ____| |    \    PS2DEV Open Source Project.
#-----------------------------------------------------------------------
# Copyright 2001-2004, ps2dev - http://www.ps2dev.org
# Licenced under Academic Free License version 2.0
# Review ps2sdk README & LICENSE files for further details.
#

# include dir
IOP_INCS := $(IOP_INCS) -I$(PS2SDK)/common/include -Iinclude

# C compiler flags
# -fno-builtin is required to prevent the GCC built-in functions from being included,
#   for finer-grained control over what goes into each IRX.
# -msoft-float is to "remind" GCC/Binutils that the soft-float ABI is to be used. This is due to a bug, which
#   results in the ABI not being passed correctly to binutils and iop-as defaults to the hard-float ABI instead.
# -mno-explicit-relocs is required to work around the fact that GCC is now known to
#   output multiple LO relocs after one HI reloc (which the IOP kernel cannot deal with).
IOP_CFLAGS  := $(CFLAGS_TARGET) -fno-builtin -msoft-float -mno-explicit-relocs -O2 -G0 -c $(IOP_INCS) $(IOP_CFLAGS)
# Linker flags
IOP_LDFLAGS := $(LDFLAGS_TARGET) -nostdlib $(IOP_LDFLAGS)
# Assembler flags
IOP_ASFLAGS := $(ASFLAGS_TARGET) -msoft-float -EL -G0 $(IOP_ASFLAGS)

# Externally defined variables: IOP_BIN, IOP_OBJS, IOP_LIB

$(IOP_OBJS_DIR)%.o : $(IOP_SRC_DIR)%.c
	$(IOP_CC) $(IOP_CFLAGS) $< -o $@

$(IOP_OBJS_DIR)%.o : $(IOP_SRC_DIR)%.s
	$(IOP_AS) $(IOP_ASFLAGS) $< -o $@

# A rule to build imports.lst.
$(IOP_OBJS_DIR)%.o : $(IOP_SRC_DIR)%.lst
	echo "#include \"irx_imports.h\"" > $(IOP_OBJS_DIR)build-imports.c
	cat $< >> $(IOP_OBJS_DIR)build-imports.c
	$(IOP_CC) $(IOP_CFLAGS) -fno-toplevel-reorder -I$(IOP_SRC_DIR) $(IOP_OBJS_DIR)build-imports.c -o $@
	-rm -f $(IOP_OBJS_DIR)build-imports.c

# A rule to build exports.tab.
$(IOP_OBJS_DIR)%.o : $(IOP_SRC_DIR)%.tab
	echo "#include \"irx.h\"" > $(IOP_OBJS_DIR)build-exports.c
	cat $< >> $(IOP_OBJS_DIR)build-exports.c
	$(IOP_CC) $(IOP_CFLAGS) -fno-toplevel-reorder -I$(IOP_SRC_DIR) $(IOP_OBJS_DIR)build-exports.c -o $@
	-rm -f $(IOP_OBJS_DIR)build-exports.c

$(IOP_OBJS_DIR):
	mkdir $(IOP_OBJS_DIR)

$(IOP_BIN_DIR):
	mkdir $(IOP_BIN_DIR)

$(IOP_BIN) : $(IOP_OBJS)
	$(IOP_CC) $(IOP_LDFLAGS) -o $(IOP_BIN) $(IOP_OBJS) $(IOP_LIBS)

$(IOP_LIB) : $(IOP_OBJS)
	$(IOP_AR) cru $(IOP_LIB) $(IOP_OBJS)

