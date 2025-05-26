---@meta
--luacheck: ignore

---@class yaml
local yaml = {}


---@return yaml
function yaml.new() end

---Convert a Lua object to a YAML string
---@param lua_value any
---@return string
function yaml.encode(lua_value) end

---Convert a YAML string to a Lua object.
---@param string string
---@return table
function yaml.decode(string) end

---@class yaml.cfg
---@field encode_invalid_numbers ?boolean (true) A flag saying whether to enable encoding of NaN and Inf numbers
---@field encode_number_precision ?number (14) Precision of floating point numbers
---@field encode_load_metatables ?boolean (true) A flag saying whether the serializer will follow __serialize metatable field
---@field encode_use_tostring ?boolean (false) A flag saying whether to use tostring() for unknown types
---@field encode_invalid_as_nil ?boolean (false) A flag saying whether to use NULL for non-recognized types
---@field encode_sparse_convert ?boolean (true) A flag saying whether to handle excessively sparse arrays as maps
---@field encode_sparse_ratio ?number (2) 1/encode_sparse_ratio is the permissible percentage of missing values in a sparse array
---@field encode_sparse_safe ?number (10) A limit ensuring that small Lua arrays are always encoded as sparse arrays (instead of generating an error or encoding as map)
---@field decode_invalid_numbers ?boolean (true) A flag saying whether to enable decoding of NaN and Inf numbers
---@field decode_save_metatables ?boolean (true) A flag saying whether to set metatables for all arrays and maps

---@param cfg yaml.cfg
function yaml.cfg(cfg) end

---A value comparable to Lua “nil” which may be useful as a placeholder in a tuple.
yaml.NULL = box.NULL

return yaml
