---@meta
--luacheck: ignore

---@alias boxIndexPartType
---| "datetime"
---| "number"
---| "double"
---| "boolean"
---| "decimal"
---| "scalar"
---| "uuid"
---| "integer"
---| "unsigned"
---| "string"
---| "varbinary"
---| "array"

---@class boxIndex: boxIndexOptions
---@field parts boxIndexPart[] list of index parts
local boxIndex = {}

---@class boxIndexPart
---@field type boxIndexPartType type of the field
---@field is_nullable boolean false if field not-nullable, otherwise true
---@field exclude_null? boolean
---@field fieldno integer position in tuple of the field
---@field path? string

---@alias IndexPart
---| { field: integer, type: boxIndexPartType, is_nullable: boolean, exclude_null: boolean, collation: string, path: string, fieldno: integer }
---| { field: string, is_nullable: boolean, exclude_null: boolean, collation: string, path: string, fieldno: integer }
---| { [1]: integer|string, [2]: boxIndexPartType, is_nullable: boolean, exclude_null: boolean, collation: string, path: string, fieldno: integer }

---@class boxIndexOptions: table
---@field name? string name of the index
---@field type? "TREE" | "HASH" | "BITSET" | "RTREE" | "tree" | "hash" | "bitset" | "rtree" (Default: TREE) type of index
---@field id? number (Default: last index’s id + 1) unique identifier
---@field unique? boolean (Default: true) index is unique
---@field if_not_exists? boolean (Default: false) no error if duplicate name
---@field parts? IndexPart[]|string[] field numbers + types
---@field dimension? number (Default: 2) affects RTREE only
---@field distance? "euclid"|"manhattan" (Default: euclid) affects RTREE only
---@field bloom_fpr? number (Default: vinyl_bloom_fpr) affects vinyl only
---@field page_size? number (Default: vinyl_page_size) affects vinyl only
---@field range_size? number (Default: vinyl_range_size) affects vinyl only
---@field run_count_per_level? number (Default: vinyl_run_count_per_level) affects vinyl only
---@field run_size_ratio? number (Default: vinyl_run_size_ratio) affects vinyl only
---@field sequence? string|number
---@field func? string functional index
---@field hint? boolean (Default: true) affects TREE only. true makes an index work faster, false – index size is reduced by half

---Search for a tuple in the given space.
---@param key box.tuple|tuple_type[]|scalar
---@return box.tuple? tuple the tuple whose index key matches key, or nil.
function boxIndex:get(key) end

---Search for a tuple or a set of tuples in the given space. This method doesn’t yield (for details see Cooperative multitasking).
---@param key box.tuple|tuple_type[]|scalar
---@param options? boxSpaceSelectOptions
---@return box.tuple[] list the tuples whose primary-key fields are equal to the fields of the passed key. If the number of passed fields is less than the number of fields in the primary key, then only the passed fields are compared, so select{1,2} will match a tuple whose primary key is {1,2,3}.
---@return string? pos
function boxIndex:select(key, options) end

---Search for a tuple or a set of tuples in the given space, and allow iterating over one tuple at a time.
---@param key box.tuple|tuple_type[]|scalar value to be matched against the index key, which may be multi-part
---@param iterator? boxIterator (Default: 'EQ') defines iterator order
---@return fun.iterator
function boxIndex:pairs(key, iterator) end

---Update a tuple.
---
---The update function supports operations on fields — assignment, arithmetic (if the field is numeric), cutting and pasting fragments of a field, deleting or inserting a field.
---Multiple operations can be combined in a single update request, and in this case they are performed atomically and sequentially.
---Each operation requires specification of a field identifier, which is usually a number.
---When multiple operations are present, the field number for each operation is assumed to be relative to the most recent state of the tuple, that is, as if all previous operations in a multi-operation update have already been applied.
---In other words, it is always safe to merge multiple update invocations into a single invocation, with no change in semantics.
---@param key box.tuple|tuple_type[]|scalar
---@param update_operations { [1]: update_operation, [2]: number|string, [3]: tuple_type }[]
---@return box.tuple? tuple the updated tuple if it was found
function boxIndex:update(key, update_operations) end

---Find the maximum value in the specified index.
---@param key box.tuple|tuple_type[]|scalar
---@return box.tuple? tuple result
function boxIndex:max(key) end

---Find the minimum value in the specified index.
---@param key box.tuple|tuple_type[]|scalar
---@return box.tuple? tuple result
function boxIndex:min(key) end

---Return the number of tuples. If compared with len(), this method works slower because count() scans the entire space to count the tuples.
---@param key? box.tuple|tuple_type[]|scalar
---@param iterator? boxIterator
---@return integer number_of_tuples
function boxIndex:count(key, iterator) end

---Return the number of tuples in the space. If compared with count(), this method works faster because len() does not scan the entire space to count the tuples.
---@return integer number_of_tuples
function boxIndex:len() end

---Returns total bsize of tuples in index
---@return integer
function boxIndex:bsize() end

---@param key box.tuple|tuple_type[]|scalar
---@return box.tuple? tuple the deleted tuple
function boxIndex:delete(key) end

---Alter an index.
---It is legal in some circumstances to change one or more of the index characteristics,
---for example its type, its sequence options, its parts, and whether it is unique.
---
---Usually this causes rebuilding of the space, except for the simple case
---where a part’s is_nullable flag is changed from false to true.
---@param opts boxIndexOptions
function boxIndex:alter(opts) end

---Rename an index.
---@param index_name string new name for index
function boxIndex:rename(index_name) end

---Drop an index. Dropping a primary-key index has a side effect: all tuples are deleted.
function boxIndex:drop() end

---Return a tuple’s position for an index.
---
---This value can be passed to the after option of the select and pairs methods
---
---Note that tuple_pos does not work with functional and multikey indexes.
---@param tuple scalar|table
---@return string # base64-encoded string (a tuple’s position in a space)
function boxIndex:tuple_pos(tuple) end

---Drop an index.
---
---Dropping a primary-key index has a side effect: all tuples are deleted.
function boxIndex:drop() end
