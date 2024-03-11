---@meta
--luacheck: ignore
---@module 'msgpack'
local msgpack = {}

---Convert a Lua object to a raw MsgPack string
---@param value any either a scalar value or a Lua table value.
---@return string # the original contents formatted as a raw MsgPack string;
function msgpack.encode(value) end

---Convert a Lua object to a raw MsgPack string in an ibuf
---
---    ibuf = require('buffer').ibuf()
---    msgpack_string_size = require('msgpack').encode({'a'}, ibuf)
---    msgpack_string = require('ffi').string(ibuf.rpos, msgpack_string_size)
---    string.hex(msgpack_string)
---@param value any either a scalar value or a Lua table value.
---@param ibuf BufferObject (output parameter) where the result raw MsgPack string goes
---@return number # number of bytes in the output
function msgpack.encode(value, ibuf) end

---Convert a raw MsgPack string to a Lua object.
---@param msgpack_string string a raw MsgPack string.
---@param start_position integer? where to start, minimum = 1, maximum = string length, default = 1.
---@return any
function msgpack.decode(msgpack_string, start_position) end

---Convert a raw MsgPack string, whose address is supplied as a C-style string pointer
---such as the rpos pointer which is inside an ibuf such as buffer.ibuf() creates, to a Lua object.
---A C-style string pointer may be described as cdata<char *> or cdata<const char *>.
---@param C_style_string_pointer ffi.cdata* a pointer to a raw MsgPack string.
---@param size number a pointer to a raw MsgPack string.
---@return any
function msgpack.decode(C_style_string_pointer, size) end


return msgpack
