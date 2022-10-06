---@meta
--luacheck: ignore

--TODO:
---@class errno: table
---@operator call: number
local errno = {}

---Return a string, given an error number.
---@param code number?
---@return string
function errno.strerror(code) end


return errno
