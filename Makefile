# a small Makefile to build ccache for your platform
#
#
CCACHE       := ccache-2.4
BUILD_CFLAGS := -O2 -fomit-frame-pointer

all:
	@echo  make clean / make unpack / make build

clean:
	rm -rf build ccache

unpack:
	rm -rf build
	mkdir -p build
	cd build && tar xzf ../archive/$(CCACHE).tar.gz
	cd build/$(CCACHE) && patch -p1 < ../../patches/$(CCACHE)-dependency-output.patch
	cd build/$(CCACHE) && patch -p1 < ../../patches/$(CCACHE)-win32-fixes.patch

.PHONY: build
build:
	cd build/$(CCACHE) && CFLAGS="$(BUILD_CFLAGS)" ./configure && make
	strip build/$(CCACHE)/ccache
	cp build/$(CCACHE)/ccache .
	@echo "Please copy the file 'ccache' to your prebuilt directory"
	
