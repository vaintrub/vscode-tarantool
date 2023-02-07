---@meta
--luacheck: ignore
---@module 'key_def'
---The key_def module has a function for defining the field numbers and types of a tuple.
---The definition is usually used with an index definition to extract or compare the index key values.

local key_def = {}

---@class key_def_object
local key_def_object = {}

---Return a tuple containing only the fields of the key_def object.
---@param tuple box.tuple
---@return box.tuple
function key_def_object:extract_key(tuple) end

---Compare the key fields of tuple_1 with the key fields of tuple_2.
---It is a tuple-by-tuple comparison so users do not have to write code that compares one field at a time.
---Each field’s type and collation will be taken into account.
---In effect it is a comparison of `extract_key(tuple_1)` with `extract_key(tuple_2)`.
---@param tuple_1 box.tuple
---@param tuple_2 box.tuple
---@return number # tuple_1 - tuple_2
function key_def_object:compare(tuple_1, tuple_2) end

---Compare the key fields of tuple_1 with all the fields of key_tuple.
---This is the same as key_def_object:compare() except that tuple_2
---contains only the key fields.
---In effect it is a comparison of extract_key(tuple_1) with tuple_2.
---@param tuple box.tuple
---@param key_tuple box.tuple
---@return number # tuple_1 - key_tuple
function key_def_object:compare_with_key(tuple, key_tuple) end

---Combine the main `key_def_object` with `other_key_def_object`.
---The return value is a new `key_def_object` containing all the fields
---of the main `key_def_object`, then all the fields of `other_key_def_object`
---which are not in the main `key_def_object`.
---@param other_key_def_object key_def_object
---@return key_def_object
function key_def_object:merge(other_key_def_object) end

---Returns a table containing the fields of the key_def_object.
---This is the reverse of key_def.new()
---@return tuple_type[]
function key_def_object:totable() end

---@param parts IndexPart[]
---@return key_def_object
function key_def.new(parts) end


return key_def
