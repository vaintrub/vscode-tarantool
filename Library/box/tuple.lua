---@meta
--luacheck: ignore
---@class box.tuple: ffi.cdata*
box.tuple = {}

---Construct a new tuple from either a scalar or a Lua table. Alternatively, one can get new tuples from Tarantool’s select or insert or replace or update requests, which can be regarded as statements that do new() implicitly.
---@overload fun(...: tuple_type): box.tuple
---@param value tuple_type[]
---@return box.tuple tuple
function box.tuple.new(value) end

---Since versions 2.2.3, 2.3.2, and 2.4.1. A function to check whether a given object is a tuple cdata object. Never raises nor returns an error.
---@param object any
---@return boolean is_tuple returns true if given object is box.tuple
function box.tuple.is(object) end

---If t is a tuple instance, t:bsize() will return the number of bytes in the tuple. With both the memtx storage engine and the vinyl storage engine the default maximum is one megabyte (memtx_max_tuple_size or vinyl_max_tuple_size). Every field has one or more “length” bytes preceding the actual contents, so bsize() returns a value which is slightly greater than the sum of the lengths of the contents.
---The value does not include the size of “struct tuple” (for the current size of this structure look in the tuple.h file in Tarantool’s source code).
---@return number bytes
function box.tuple:bsize() end

---If t is a tuple instance, t:find(search-value) will return the number of the first field in t that matches the search value, and t:findall(search-value [, search-value ...]) will return numbers of all fields in t that match the search value. Optionally one can put a numeric argument field-number before the search-value to indicate “start searching at field number field-number.”
---@param field_number_or_search_value? number
---@param search_value? any
---@return number
function box.tuple:find(field_number_or_search_value, search_value) end

---If t is a tuple instance, t:find(search-value) will return the number of the first field in t that matches the search value, and t:findall(search-value [, search-value ...]) will return numbers of all fields in t that match the search value. Optionally one can put a numeric argument field-number before the search-value to indicate “start searching at field number field-number.”
---@param field_number_or_search_value? number
---@param search_value? any
---@return number
function box.tuple:findall(field_number_or_search_value, search_value) end

---An analogue of the Lua next() function, but for a tuple object. When called without arguments, tuple:next() returns the first field from a tuple. Otherwise, it returns the field next to the indicated position.

---However tuple:next() is not really efficient, and it is better to use `box.tuple:pairs()`/`box.tuple:ipairs()`.
---@see box.tuple:pairs
---@see box.tuple:ipairs
---@param pos? number
---@return number field_number, any value
function box.tuple:next(pos) end

---@return fun() ctx, any tuple_value, nil
function box.tuple:pairs() end

---If t is a tuple instance, t:totable() will return all fields, t:totable(1) will return all fields starting with field number 1, t:totable(1,5) will return all fields between field number 1 and field number 5.
---It is preferable to use t:totable() rather than t:unpack().
---@param start_field_number? number
---@param end_field_number? number
---@return any[]
function box.tuple:totable(start_field_number, end_field_number) end

---The tuple_object:totable() function only returns a table containing the values. But the tuple_object:tomap() function returns a table containing not only the values, but also the key:value pairs.
---This only works if the tuple comes from a space that has been formatted with a format clause.
---@param options {names_only: true} | {names_only: false} | {} | nil
---@return table<number|string, any>
function box.tuple:tomap(options) end

---Update a tuple.
---
---@param update_operations { [1]: update_operation, [2]: number|string, [3]: tuple_type }[]
---@return box.tuple
function box.tuple:update(update_operations) end

return box.tuple