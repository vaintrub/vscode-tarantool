---@meta
--luacheck: ignore

---When called without arguments, box.error() re-throws whatever the last error was.
---@return BoxErrorObject
function box.error() end

---Throw an error. When called with a Lua-table argument, the code and reason have any user-desired values. The result will be those values.
---@param err { reason: string, code: number? } reason is description of an error, defined by user; code is numeric code for this error, defined by user
---@return BoxErrorObject
function box.error(err) end

---Throw an error. This method emulates a request error, with text based on one of the pre-defined Tarantool errors defined in the file errcode.h in the source tree.
---@param code number number of a pre-defined error
---@param errtext string part of the message which will accompany the error
---@param ... string part of the message which will accompany the error
function box.error(code, errtext, ...) end

---@class BoxErrorObject: ffi.cdata*
---@field type string (usually ClientError)
---@field base_type string (usually ClientError)
---@field code number number of error
---@field prev? BoxErrorObject previous error
---@field message any message of error given during `box.error.new`
local box_error_object = {}

---@class BoxErrorTrace
---@field file string Tarantool source file
---@field line number Tarantool source file line number

---@class BoxErrorObjectTable
---@field code number error’s number
---@field type string error’s C++ class
---@field message string error’s message
---@field prev? BoxErrorObject previous error
---@field base_type string usually ClientError or CustomError
---@field custom_type string? present if custom ErrorType was passed
---@field trace BoxErrorTrace[]? backtrace

---@return BoxErrorObjectTable
function box_error_object:unpack() end

---Raises error
function box_error_object:raise() end

---Instances new BoxError
---@param code number number of a pre-defined error
---@param errtxt string part of the message which will accompany the error
---@return BoxErrorObject
function box.error.new(code, errtxt, ...) end

---Instances new BoxError
---@param err { reason: string, code: number?, type: string? } custom error
---@return BoxErrorObject
function box.error.new(err) end

---@return BoxErrorObject
function box.error.last() end