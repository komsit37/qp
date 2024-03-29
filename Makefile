PREFIX = /usr/local
NOTHREETWO = 
ifndef PREFIX
$(error PREFIX is not set)
endif

BINF = $(PREFIX)/bin
LIBF = $(PREFIX)/lib

all: 

install: install32 install64 installqpm

uninstall: uninstall32 uninstall64 uninstallqpm

install64: installcommon
ifneq "$(and $(LIC), $(SIXFOUR))" ""
	cp bin/l64/q $(BINF)/q64
	cp -r lic $(LIBF)/q
	chmod 755 $(BINF)/q64
endif

install32: installcommon
ifndef NOTHREETWO
	cp bin/l32/q $(BINF)/q32
	chmod 755 $(BINF)/q32
endif

installqpm: installcommon
	cp -r qpm $(LIBF)/q
	rm -f $(BINF)/qpm.q
	ln -s $(LIBF)/q/qpm/qpm.q $(BINF)/qpm.q
	chmod 755 $(BINF)/qpm.q
	chmod 755 $(LIBF)/q/qpm/qpm.q

installcommon:
	@if [ ! -w "$(PREFIX)" ]; then echo "$(PREFIX) is not writeable - maybe you need to run this with sudo"; exit 1; fi
	mkdir -p $(LIBF)/q
	cp -r q $(LIBF)
	rm -rf $(BINF)/q
	cp bin/q $(BINF)/q
	chmod 755 $(BINF)/q

uninstall32: uninstallcommon
ifndef NOTHREETWO
	rm -rf $(BINF)/q32
endif

uninstall64: uninstallcommon
ifneq "$(and $(LIC), $(SIXFOUR))" ""
	rm -rf $(BINF)/q64
endif

uninstallqpm: uninstallcommon
	rm -f $(BINF)/qpm.q

uninstallcommon:
	@if [ ! -w "$(PREFIX)" ]; then echo "$(PREFIX) is not writeable - maybe you need to run this with sudo"; exit 1; fi
	rm -rf $(BINF)/q
	rm -rf $(LIBF)/q

print-%: ; @echo $*=$($*)

#build:
#	cp bin/l32/q $(BINF)/q32
#	cp bin/l64/q $(BINF)/q64
#	cp bin/q $(BINF)/q
#	cp -r q $(LIBF)
#	chmod 755 $(BINF)/q
#	chmod 755 $(BINF)/q32
#	chmod 755 $(BINF)/q64

	#check for git

	#$? ldd bin/l32/q - check 32bit dependencies

