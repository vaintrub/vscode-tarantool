---@meta
--luacheck: ignore

local xlog = {}

---@param path_name string Open a file, and allow iterating over one file entry at a time.
---@return fun.iterator
function xlog.pairs(path_name) end

return xlog