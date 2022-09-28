---@meta
--luacheck: ignore

---@class BoxError
---@field PROC_LUA number
local box_error = {}

---@class BoxErrorObject
---@field public type string (usually ClientError)
---@field public base_type string (usually ClientError)
---@field public code number number of error
---@field public message any message of error given during `box.error.new`

---Instances new BoxError
---@param code_or_type number
---@param args any
---@return BoxErrorObject
function box_error.new(code_or_type, args) end
