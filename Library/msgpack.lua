---@meta
--luacheck: ignore
---The msgpack module decodes raw MsgPack strings by converting them to Lua objects,
---and encodes Lua objects by converting them to raw MsgPack strings.
---@module 'msgpack'

local msgpack = {}

function msgpack.new()
  return msgpack
end

---@type metatable
msgpack.array_mt = {}

---@type metatable
msgpack.map_mt = {}

---@class msgpackCfg
---@field encode_max_depth? integer (default: 128) Max recursion depth for encoding
---@field encode_deep_as_nil? boolean (default: false) A flag saying whether to crop tables with nesting level deeper than cfg.encode_max_depth. Not-encoded fields are replaced with one null. If not set, too deep nesting is considered an error.
---@field encode_invalid_numbers? boolean (deafult: true) A flag saying whether to enable encoding of NaN and Inf numbers
---@field encode_number_precision? number (default: 14) Precision of floating point numbers
---@field encode_load_metatables? boolean (default: true) A flag saying whether the serializer will follow __serialize metatable field
---@field encode_use_tostring? boolean (default: false) A flag saying whether to use `tostring()` for unknown types
---@field encode_invalid_as_nil? boolean (default: false) A flag saying whether use NULL for non-recognized types
---@field encode_sparse_convert? boolean (default: true) A flag saying whether to handle excessively sparse arrays as maps. See detailed description below.
---@field encode_sparse_ratio? number (default: 2) 1/`encode_sparse_ratio` is the permissible percentage of missing values in a sparse array.
---@field encode_sparse_safe? number (default: 10) A limit ensuring that small Lua arrays are always encoded as sparse arrays (instead of generating an error or encoding as a map)
---@field encode_error_as_ext boolean (default: true) Specify how error objects (box.error.new()) are encoded in the MsgPack format
---@field decode_invalid_numbers? boolean (default: true) A flag saying whether to enable decoding of NaN and Inf numbers
---@field decode_save_metatables? boolean (default: true) A flag saying whether to set metatables for all arrays and maps
---@field decode_max_depth? integer (default: 128) Max recursion depth for decoding
---Set values that affect the behavior of `msgpack.encode` and `msgpack.decode`
---@overload fun(cfg: msgpackCfg)
msgpack.cfg = {}

---Convert a Lua object to a MsgPack string
---@param value any either a scalar value or a Lua table value.
---@return string # raw MsgPack string
function msgpack.encode(value) end

---Convert a Lua object to a raw MsgPack string in an ibuf, which is a buffer such as `buffer.ibuf()` creates.
---As with encode(lua_value), the result is a raw MsgPack string, but it goes to the ibuf output instead of being returned.
---
---    ibuf = require('buffer').ibuf()
---    msgpack_string_size = require('msgpack').encode({'a'}, ibuf)
---    msgpack_string = require('ffi').string(ibuf.rpos, msgpack_string_size)
---    string.hex(msgpack_string)
---@param value any either a scalar value or a Lua table value.
---@param ibuf BufferObject (output parameter) where the result raw MsgPack string goes
---@return integer # number of bytes in the output
function msgpack.encode(value, ibuf) end

---Convert a MsgPack string to a Lua object.
---@param msgpack_string string a raw MsgPack string.
---@param start_position? integer where to start, minimum = 1, maximum = string length, default = 1.
---@return any (if `msgpack_string` is a valid raw MsgPack string) the original contents of msgpack_string, formatted as a Lua object, usually a Lua table, (otherwise) a scalar value, such as a string or a number;
---@return integer? next_start_position If `decode` stops after parsing as far as byte N in `msgpack_string`,
---then `next_start_position` will equal N + 1, and `decode(msgpack_string, next_start_position)` will continue parsing from where the previous decode stopped, plus 1.
---Normally decode parses all of msgpack_string, so “next_start_position” will equal string.len(msgpack_string) + 1.
function msgpack.decode(msgpack_string, start_position) end

---@param c_style_string_pointer ffi.cdata*
---@param size integer
---@return any (if `c_style_string_pointer` is a valid raw MsgPack string) the original contents of `msgpack_string`, formatted as a Lua object, usually a Lua table, (otherwise) a scalar value, such as a string or a number;
---@return ffi.cdata* returned_pointer = a C-style pointer to the byte after what was passed, so that `c_style_string_pointer` + `size` = `returned_pointer`
function msgpack.decode(c_style_string_pointer, size) end

---Convert a MsgPack string to a Lua object.
---@param msgpack_string string a raw MsgPack string.
---@param start_position? integer where to start, minimum = 1, maximum = string length, default = 1.
---@return any (if `msgpack_string` is a valid raw MsgPack string) the original contents of msgpack_string, formatted as a Lua object, usually a Lua table, (otherwise) a scalar value, such as a string or a number;
---@return integer? next_start_position If `decode` stops after parsing as far as byte N in `msgpack_string`,
---then `next_start_position` will equal N + 1, and `decode(msgpack_string, next_start_position)` will continue parsing from where the previous decode stopped, plus 1.
---Normally decode parses all of msgpack_string, so “next_start_position” will equal string.len(msgpack_string) + 1.
function msgpack.decode_unchecked(msgpack_string, start_position) end

---Input and output are the same as for `decode(C_style_string_pointer)`, except that size is not needed.
---Some checking is skipped, and `decode_unchecked(C_style_string_pointer)` can operate with string pointers to buffers which `decode(C_style_string_pointer)` cannot handle.
---@param c_style_string_pointer ffi.cdata*
---@return any (if `c_style_string_pointer` is a valid raw MsgPack string) the original contents of `msgpack_string`, formatted as a Lua object, usually a Lua table, (otherwise) a scalar value, such as a string or a number;
---@return ffi.cdata* returned_pointer = a C-style pointer to the byte after what was passed, so that `c_style_string_pointer` + `size` = `returned_pointer`
function msgpack.decode_unchecked(c_style_string_pointer) end

---Call the MsgPuck’s `mp_decode_array` function and return the array size and a pointer to the first array component.
---A subsequent call to `msgpack_decode` can decode the component instead of the whole array.
---@param byte_array ffi.cdata* a pointer to a raw MsgPack string.
---@param size integer a number greater than or equal to the string’s length
---@return integer # the size of the array
---@return ffi.cdata* # a pointer to after the array header
function msgpack.decode_array_header(byte_array, size) end

---Call the MsgPuck’s `mp_decode_map` function and return the map size and a pointer to the first map component.
---A subsequent call to `msgpack_decode` can decode the component instead of the whole map.
---@param byte_array ffi.cdata* a pointer to a raw MsgPack string.
---@param size integer a number greater than or equal to the raw MsgPack string’s length
---@return integer # the size of the map
---@return ffi.cdata* # a pointer to after the map header
function msgpack.decode_map_header(byte_array, size) end

---Encode an arbitrary Lua object into the MsgPack format.
---@param lua_object any
---@return msgpackObject # encoded MsgPack data encapsulated in a MsgPack object.
function msgpack.object(lua_object) end

---Create a MsgPack object from a raw MsgPack string.
---@param msgpack_string string
---@return msgpackObject # a MsgPack object
function msgpack.object_from_raw(msgpack_string) end

---Create a MsgPack object from a raw MsgPack string.
---The address of the MsgPack string is supplied as a C-style string pointer such as the `rpos` pointer inside an `ibuf` that the `buffer.ibuf()` creates.
---A C-style string pointer may be described as `cdata<char *>` or `cdata<const char *>`.
---@param c_style_string_pointer ffi.cdata* a pointer to a raw MsgPack string.
---@param size integer number of bytes in the raw MsgPack string.
---@return msgpackObject # a MsgPack object
function msgpack.object_from_raw(c_style_string_pointer, size) end

---Check if the given argument is a MsgPack object.
---@param some_argument any
---@return boolean # `true` if the argument is a MsgPack object; otherwise, `false`
function msgpack.is_object(some_argument) end

---A MsgPack object that stores arbitrary MsgPack data.
---To create a MsgPack object from a Lua object or string, use the following methods:
---`msgpack.object` `msgpack.object_from_raw`
---@class msgpackObject
---@field [integer|string] any
local msgpack_object = {}

---Decode MsgPack data in the MsgPack object.
---@param key integer|string
---@return any
function msgpack_object:get(key) end

---Decode MsgPack data in the MsgPack object.
---@return any
function msgpack_object:decode() end

---Create an iterator over the MsgPack data.
---@return msgpackIteratorObject # an iterator object over the MsgPack data
function msgpack_object:iterator() end

---An iterator over a MsgPack array.
---@class msgpackIteratorObject
local msgpack_iterator_object = {}

---Decode a MsgPack array header under the iterator cursor and advance the cursor.
---After calling this function, the iterator points to the first element of the array or to the value following the array if the array is empty.
---@return integer # number of elements in the array
function msgpack_iterator_object:decode_array_header() end

---Decode a MsgPack map header under the iterator cursor and advance the cursor.
---After calling this function, the iterator points to the first key stored in the map or to the value following the map if the map is empty.
---@return integer # number of key-value pairs in the map
function msgpack_iterator_object:decode_map_header() end

---Decode a MsgPack value under the iterator cursor and advance the cursor.
---@return any # a Lua object corresponding to the MsgPack value
function msgpack_iterator_object:decode() end

---Return a MsgPack value under the iterator cursor as a MsgPack object without decoding and advance the cursor.
---The method doesn’t copy MsgPack data. Instead, it takes a reference to the original object.
---@return msgpackObject
function msgpack_iterator_object:take() end

---Copy the specified number of MsgPack values starting from the iterator’s cursor position to a new MsgPack array object and advance the cursor.
---@param count integer the number of MsgPack values to copy
---@return msgpackObject # a new MsgPack object
function msgpack_iterator_object:take_array(count) end

---Advance the iterator cursor by skipping one MsgPack value under the cursor. Returns nothing.
function msgpack_iterator_object:skip() end

---A value comparable to Lua “nil” which may be useful as a placeholder in a tuple.
msgpack.NULL = box.NULL

return msgpack
