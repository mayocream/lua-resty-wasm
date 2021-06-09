local ffi = require "ffi"
local cpath = package.cpath
print("cpath: ", cpath)

local wasmedge = ffi.load("/root/repos/mayocream/lua-resty-wasm/libwasmedge.so")

ffi.cdef[[
    char *WasmEdge_VersionGet();
]]

local ver = wasmedge.WasmEdge_VersionGet()
print(ffi.string(ver))