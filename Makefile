INST_PREFIX ?= /usr
INST_LIBDIR ?= $(INST_PREFIX)/lib64/lua/5.1
INST_LUADIR ?= $(INST_PREFIX)/share/lua/5.1
LOCAL_LIB = $(PWD)/lib

.PHONY: all deps install-cmake install run

default:
	echo "nothing"

clean:
	rm -rf deps

deps:
	mkdir deps | true
	cd deps \
	&& wget https://github.com/WasmEdge/WasmEdge/releases/download/0.8.0/WasmEdge-0.8.0-manylinux2014_x86_64.tar.gz \
	&& tar zxvf WasmEdge-0.8.0-manylinux2014_x86_64.tar.gz \
	&& cp WasmEdge-0.8.0-Linux/lib64/libwasmedge_c.so ../lib/

install-cmake:
	chmod +x utils/install-cmake.sh && sudo sh utils/install-cmake.sh

install:
	install -d $(INST_LUADIR)/wasm/
	install -m 644 lib/resty/wasm/*.lua $(INST_LUADIR)/wasm/

	install -m 644 lib/*.so $(INST_LUADIR)

run:
	LD_LIBRARY_PATH=$(pwd)/lib /usr/local/openresty/luajit/bin/luajit lib/resty/wasm/wasm.lua