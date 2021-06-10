local ffi = require "ffi"
local cpath = package.cpath
print("cpath: ", cpath)

local wasmedge = ffi.load("/root/repos/mayocream/lua-resty-wasm/libwasmedge.so")

ffi.cdef[[
    enum WasmEdge_ValType {
        WasmEdge_ValType_I32 = 0x7FU,
        WasmEdge_ValType_I64 = 0x7EU,
        WasmEdge_ValType_F32 = 0x7DU,
        WasmEdge_ValType_F64 = 0x7CU,
        WasmEdge_ValType_V128 = 0x7BU,
        WasmEdge_ValType_FuncRef = 0x70U,
        WasmEdge_ValType_ExternRef = 0x6FU
    };

    typedef struct WasmEdge_Result {
        uint8_t Code;
    } WasmEdge_Result;

    typedef struct WasmEdge_String {
        uint32_t Length;
        const char *Buf;
    } WasmEdge_String;

    typedef struct WasmEdge_Value {
    } WasmEdge_Value;

    typedef struct WasmEdge_VMContext WasmEdge_VMContext;
    typedef struct WasmEdge_ConfigureContext WasmEdge_ConfigureContext;
    typedef struct WasmEdge_StoreContext WasmEdge_StoreContext;

    WasmEdge_ConfigureContext *WasmEdge_ConfigureCreate();

    WasmEdge_String WasmEdge_StringCreateByCString(const char *Str);

    WasmEdge_VMContext *
    WasmEdge_VMCreate(const WasmEdge_ConfigureContext *ConfCxt,
                      WasmEdge_StoreContext *StoreCxt);

    const char *WasmEdge_VersionGet();
    void WasmEdge_LogSetDebugLevel();
    
    WasmEdge_Result WasmEdge_VMRunWasmFromFile(
        WasmEdge_VMContext *Cxt, const char *Path, const WasmEdge_String FuncName,
        const WasmEdge_Value *Params, const uint32_t ParamLen,
        WasmEdge_Value *Returns, const uint32_t ReturnLen);
]]

local test_wasm_add_path = "/root/repos/mayocream/lua-resty-wasm/test/wasm/add/add.wasm"

wasmedge.WasmEdge_LogSetDebugLevel()
local ver = wasmedge.WasmEdge_VersionGet()
print(ffi.string(ver))

local vmconf = wasmedge.WasmEdge_ConfigureCreate()
local vmctx = wasmedge.WasmEdge_VMCreate(vmconf, ffi.NULL)
local result = wasmedge.WasmEdge_VMRunWasmFromFile(vmctx, test_wasm_add_path, 
        wasmedge.WasmEdge_StringCreateByCString("add"), nil,
        0, nil, 0)