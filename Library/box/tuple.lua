---@meta
--luacheck: ignore
---@class box.tuple: ffi.cdata*
---@field [string] any
---@field [integer] any
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
---@return integer bytes
function box.tuple:bsize() end

---If t is a tuple instance, t:find(search-value) will return the number of the first field in t that matches the search value, and t:findall(search-value [, search-value ...]) will return numbers of all fields in t that match the search value. Optionally one can put a numeric argument field-number before the search-value to indicate “start searching at field number field-number.”
---@param field_number integer
---@param search_value any
---@return integer?
function box.tuple:find(field_number, search_value) end

---@param search_value any
---@return integer?
function box.tuple:find(search_value) end

---If `t` is a tuple instance, `t:find(search-value)` will return the number of the first field in t that matches the search value, and t:findall(search-value [, search-value ...]) will return numbers of all fields in t that match the search value. Optionally one can put a numeric argument field-number before the search-value to indicate “start searching at field number field-number.”
---@param field_number integer
---@param search_value any
---@return integer ...
function box.tuple:findall(field_number, search_value) end

---@param search_value any
---@return integer ...
function box.tuple:findall(search_value) end

---An analogue of the Lua next() function, but for a tuple object. When called without arguments, tuple:next() returns the first field from a tuple. Otherwise, it returns the field next to the indicated position.

---However `tuple:next()` is not really efficient, and it is better to use `box.tuple:pairs()`/`box.tuple:ipairs()`.
---@see box.tuple:pairs
---@see box.tuple:ipairs
---@param pos? integer
---@return integer field_number, any value
function box.tuple:next(pos) end

---@return fun.iterator, box.tuple
function box.tuple:pairs() end

---@return fun.iterator, box.tuple
function box.tuple:ipairs() end

---If `t` is a tuple instance, `t:totable()` will return all fields,
---`t:totable(1)` will return all fields starting with field number 1,
---`t:totable(1,5)` will return all fields between field number 1 and field number 5.
---It is preferable to use t:totable() rather than t:unpack().
---@param start_field_number? integer
---@param end_field_number? integer
---@return any[]
function box.tuple:totable(start_field_number, end_field_number) end

---If `t` is a tuple instance, `t:unpack()` will return all fields,
---`t:unpack(1)` will return all fields starting with field number 1,
---`t:unpack(1,5)` will return all fields between field number 1 and field number 5.
---@param start_field_number? integer
---@param end_field_number? integer
---@return any ...
function box.tuple:unpack(start_field_number, end_field_number) end

---The `tuple_object:totable()` function only returns a table containing the values. But the `tuple_object:tomap()` function returns a table containing not only the values, but also the key:value pairs.
---This only works if the tuple comes from a space that has been formatted with a format clause.
---@param options {names_only: true} | {names_only: false} | {} | nil
---@return table<integer|string, any>
function box.tuple:tomap(options) end

---If `t` is a tuple instance, `t:transform(start_field_number,fields_to_remove)` will return a tuple where, starting from field `start_field_number`, a number of fields (fields-to-remove) are removed.
---Optionally one can add more arguments after `fields_to_remove` to indicate new values that will replace what was removed.
---If the original tuple comes from a space that has been formatted with a format clause, the formatting will not be preserved for the result tuple.
---@param start_field_number integer
---@param fields_to_remove integer
---@param ... tuple_type
---@return box.tuple
function box.tuple:transform(start_field_number, fields_to_remove, ...) end

---Update a tuple.
---This function updates a tuple which is not in a space. Compare the function `box.space.space-name:update(key, {{format, field_no, value}, ...})` which updates a tuple in a space.
---For details: see the description for `operator`, `field_no`, and `value` in the section box.space.space-name:update{key, format, {field_number, value}…).
---If the original tuple comes from a space that has been formatted with a format clause, the formatting will be preserved for the result tuple.
---@param update_operations {[1]: update_operation, [2]: integer|string, [3]: tuple_type }[]
---@return box.tuple
function box.tuple:update(update_operations) end

---The same as `tuple_object:update()`, but ignores errors.
---In case of an error the tuple is left intact, but an error message is printed. Only client errors are ignored, such as a bad field type, or wrong field index/name.
---System errors, such as OOM, are not ignored and raised just like with a normal `update()`. Note that only bad operations are ignored. All correct operations are applied.
---@param update_operations {[1]: update_operation, [2]: integer|string, [3]: tuple_type }[]
---@return box.tuple
function box.tuple:upsert(update_operations) end

return box.tuple
