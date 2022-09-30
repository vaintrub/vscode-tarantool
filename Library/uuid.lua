---@meta
--luacheck: ignore

---@module 'uuid'
---@operator call: uuid
local uuid = {}

---@class uuid: ffi.cdata*
local uuid_obj = {}

---Since version 2.4.1. Create a UUID sequence. You can use it in an index over a uuid field.
---@return uuid
function uuid.new() end

---@param byte_order? "l"|"b"|"h"|"n"|"host"|"network" Byte order of the resulting UUID
---@return string uuid 16-byte string
function uuid.bin(byte_order) end

---@param byte_order? "l"|"b"|"h"|"n"|"host"|"network" Byte order of the resulting UUID
---@return string uuid 16-byte string
function uuid_obj:bin(byte_order) end

---@return string uuid 36-byte binary string
function uuid.str() end

---@return string uuid 36-byte binary string
function uuid_obj:str() end

---@param uuid_str string UUID in 36-byte hexadecimal string
---@return uuid uuid converted UUID
function uuid.fromstr(uuid_str) end

---@param uuid_bin string UUID in 16-byte binary string
---@param byte_order? "l"|"b"|"h"|"n"|"host"|"network" Byte order of the resulting UUID
---@return uuid uuid converted UUID
function uuid.frombin(uuid_bin, byte_order) end

---Since version 2.6.1.
---@param value any
---@return boolean is_uuid true if the specified value is a uuid, and false otherwise
function uuid.is_uuid(value) end

return uuid