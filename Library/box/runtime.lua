---@meta
--luacheck: ignore

box.runtime = {}

---@class BoxRuntimeInfo
---@field lua integer
---@field tuple integer
---@field maxalloc integer
---@field used integer

---@return BoxRuntimeInfo
function box.runtime.info() end
