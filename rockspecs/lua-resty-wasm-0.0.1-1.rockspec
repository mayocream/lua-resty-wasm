package = "lua-resty-wasm"
version = "0.11.1-1"
source = {
   url = "gitrec+https://github.com/mayocream/lua-resty-wasm",
}
description = {
   summary = "Lua ffi wasm lib",
   homepage = "https://github.com/mayocream/lua-resty-wasm",
   license = "Apache 2.0",
   maintainer = "Mayo <mayocream39@yahoo.co.jp>"
}
dependencies = {
   "lua >= 5.1"
}
build = {
   type = "make",
   install_target = "install",
}