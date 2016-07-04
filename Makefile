SMB = 0
#set SMB to 1 to build uLe with smb support

EE_BIN = BOOT.ELF
EE_BIN_PKD = ULE.ELF
EE_OBJS = main.o pad.o config.o elf.o draw.o loader.o filer.o \
	poweroff.o iomanx.o filexio.o ps2atad.o ps2dev9.o smsutils.o ps2ip.o\
	ps2smap.o ps2hdd.o ps2fs.o ps2netfs.o usbd.o usbhdfsd.o mcman.o mcserv.o\
	cdvd.o ps2ftpd.o ps2host.o vmc_fs.o fakehost.o ps2kbd.o\
	hdd.o hdl_rpc.o hdl_info.o editor.o timer.o jpgviewer.o icon.o lang.o\
	font_uLE.o makeicon.o chkesr.o sior.o allowdvdv.o
ifeq ($(SMB),1)
	EE_OBJS += smbman.o
endif

EE_INCS := -I$(PS2DEV)/gsKit/include -I$(PS2SDK)/ports/include -Ioldlibs/libcdvd/ee

EE_LDFLAGS := -L$(PS2DEV)/gsKit/lib -L$(PS2SDK)/ports/lib -Loldlibs/bin -s
EE_LIBS = -lpad -lgskit -ldmakit -ljpeg -lmc -lhdd -lcdvdfs -lkbd -lmf -lcdvd -lc -lfileXio -lpatches -lpoweroff -ldebug -lc -lsior
ifeq ($(SMB),1)
	EE_CFLAGS += -DSMB
endif
# EE_CFLAGS += -DDEBUG
EE_CFLAGS += -DDEBUG

IRX_BIN = mcman.c mcserv.c usbd.c usbhdfsd.c cdvd.c poweroff.c iomanx.c \
	filexio.c ps2dev9.c ps2ip.c ps2smap.c smsutils.c ps2ftpd.c ps2atad.c \
	ps2atad.c ps2hdd.c ps2fs.c ps2netfs.c fakehost.c hdl_info.c ps2host.c \
	smbman.c vmc_fs.c loader.c ps2kbd.c sior.c allowdvdv.c

all:	 $(EE_BIN)
	ps2-packer $(EE_BIN) $(EE_BIN_PKD)

run: all
	ps2client -h 192.168.0.10 -t 1 execee host:BOOT.ELF

reset: clean
	ps2client -h 192.168.0.10 reset

mcman.c:
	bin2c $(PS2SDK)/iop/irx/mcman.irx mcman.c mcman_irx

mcserv.c:
	bin2c $(PS2SDK)/iop/irx/mcserv.irx mcserv.c mcserv_irx

usbd.c:
	bin2c $(PS2SDK)/iop/irx/usbd.irx usbd.c usbd_irx

usbhdfsd.c:
	bin2c $(PS2SDK)/iop/irx/usbhdfsd.irx usbhdfsd.c usb_mass_irx

cdvd.c:
	bin2c oldlibs/bin/cdvd.irx cdvd.c cdvd_irx

poweroff.c:
	bin2c $(PS2SDK)/iop/irx/poweroff.irx poweroff.c poweroff_irx

iomanx.c:
	bin2c $(PS2SDK)/iop/irx/iomanX.irx iomanx.c iomanx_irx

filexio.c:
	bin2c $(PS2SDK)/iop/irx/fileXio.irx filexio.c filexio_irx

ps2dev9.c:
	bin2c $(PS2SDK)/iop/irx/ps2dev9.irx ps2dev9.c ps2dev9_irx

ps2ip.c:
	bin2c oldlibs/bin/SMSTCPIP.irx ps2ip.c ps2ip_irx

ps2smap.c:
	bin2c oldlibs/bin/SMSMAP.irx ps2smap.c ps2smap_irx

smsutils.c:
	bin2c oldlibs/bin/SMSUTILS.irx smsutils.c smsutils_irx

ps2ftpd.c:
	bin2c oldlibs/bin/ps2ftpd.irx ps2ftpd.c ps2ftpd_irx

ps2atad.c:
	bin2c $(PS2SDK)/iop/irx/ps2atad.irx ps2atad.c ps2atad_irx

ps2hdd.c:
	bin2c $(PS2SDK)/iop/irx/ps2hdd.irx ps2hdd.c ps2hdd_irx

ps2fs.c:
	bin2c $(PS2SDK)/iop/irx/ps2fs.irx ps2fs.c ps2fs_irx

ps2netfs.c:
	bin2c $(PS2SDK)/iop/irx/ps2netfs.irx ps2netfs.c ps2netfs_irx

fakehost.c:
	bin2c $(PS2SDK)/iop/irx/fakehost.irx fakehost.c fakehost_irx

hdl_info.c:
	$(MAKE) -C hdl_info
	bin2c hdl_info/hdl_info.irx hdl_info.c hdl_info_irx

ps2host.c:
	$(MAKE) -C ps2host
	bin2c ps2host/ps2host.irx ps2host.c ps2host_irx

ifeq ($(SMB),1)
smbman.c:
	bin2c $(PS2SDK)/iop/irx/smbman.irx smbman.c smbman_irx
endif

vmc_fs.c:
	$(MAKE) -C vmc_fs
	bin2c vmc_fs/vmc_fs.irx vmc_fs.c vmc_fs_irx

loader.c:
	$(MAKE) -C loader
	bin2c loader/loader.elf loader.c loader_elf

ps2kbd.c:
	bin2c $(PS2SDK)/iop/irx/ps2kbd.irx ps2kbd.c ps2kbd_irx

sior.c:
	bin2c $(PS2SDK)/iop/irx/sior.irx sior.c sior_irx

allowdvdv.c:
	$(MAKE) -C AllowDVDV
	bin2c AllowDVDV/AllowDVDV.irx allowdvdv.c allowdvdv_irx

clean:
	$(MAKE) -C hdl_info clean
	$(MAKE) -C ps2host clean
	$(MAKE) -C loader clean
	$(MAKE) -C vmc_fs clean
	$(MAKE) -C AllowDVDV clean
	rm -f -r $(EE_OBJS) $(IRX_BIN) $(EE_BIN) $(EE_BIN_PKD)

include $(PS2SDK)/Defs.make
include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.eeglobal
