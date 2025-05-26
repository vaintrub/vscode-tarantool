---@meta
--luacheck: ignore

---@type table<string|number, boxSpaceObject>
box.space = {}

---@class boxSpaceObject: table
---@field id number Ordinal space number. Spaces can be referenced by either name or number
---@field name string name of the space
---@field enabled boolean Whether or not this space is enabled. The value is false if the space has no index.
---@field engine string
---@field is_sync boolean
---@field is_local boolean
---@field temporary boolean
---@field field_count number (Default: 0) The required field count for all tuples in this space
---@field index table<number|string, boxIndex> kv and list of indexes of space
local boxSpaceObject = {}

---Create an index.
---It is mandatory to create an index for a space before trying to insert tuples into it, or select tuples from it. The first created index will be used as the primary-key index, so it must be unique.
---@param index_name string name of index, which should conform to the rules for object names
---@param options boxIndexOptions
---@return boxIndex
function boxSpaceObject:create_index(index_name, options) end

---@class SpaceAlterOptions
---@field name? string name of the space
---@field field_count? number fixed count of fields: for example if field_count=5, it is illegal to insert a tuple with fewer than or more than 5 fields
---@field format? boxSpaceFormat
---@field is_sync? boolean (Default: false) any transaction doing a DML request on this space becomes synchronous
---@field temporary? boolean (Default: false) space contents are temporary: changes are not stored in the write-ahead log and there is no replication. Note regarding storage engine: vinyl does not support temporary spaces.
---@field user? string (Default: current user’s name) name of the user who is considered to be the space’s owner for authorization purposes


---Since version 2.5.2. Alter an existing space. This method changes certain space parameters.
---@param options SpaceAlterOptions
function boxSpaceObject:alter(options) end

---Number of bytes in the space. This number, which is stored in Tarantool’s internal memory, represents the total number of bytes in all tuples, not including index keys
---@return number bytes
function boxSpaceObject:bsize() end

---Return the number of tuples. If compared with len(), this method works slower because count() scans the entire space to count the tuples.
---@param key? box.tuple|tuple_type[]|scalar
---@param iterator? boxIterator
---@return integer number_of_tuples
function boxSpaceObject:count(key, iterator) end

---@class boxSpaceFieldFormat
---@field name? string value may be any string, provided that two fields do not have the same name
---@field type? "any" | "unsigned" | "string" | "integer" | "number" | "varbinary" | "boolean" | "double" | "decimal" | "uuid" | "array" | "map" | "scalar" value may be any of allowed types
---@field is_nullable? boolean (Default: false value specifies whether nil can be used as a field value.
---@field collation? string value specifies the collation used to compare field values.
---@field constraint? string specifies the constraints that the field value must satisfy.
---@field foreign_key? string specifies the foreign keys for the field.

---@alias boxSpaceFormat boxSpaceFieldFormat[]
---field names and types: See the illustrations of format clauses in the space_object:format() description and in the box.space._space example. Optional and usually not specified.

---Possible errors:

---`ER_TRANSACTION_CONFLICT` if a transaction conflict is detected in the MVCC transaction mode.
---@param key box.tuple|tuple_type[]|scalar
---@return box.tuple? tuple the deleted tuple
function boxSpaceObject:delete(key) end

---Drop a space. The method is performed in background and doesn’t block consequent requests.
function boxSpaceObject:drop() end

---Declare field names and types.
---@param format_clause? boxSpaceFormat a list of field names and types
---@return nil|boxSpaceFormat nothing_or_existing_format returns current format if format_clause is not given
function boxSpaceObject:format(format_clause) end

---Returns current format
---@return boxSpaceFormat format
function boxSpaceObject:format() end

---Search for a tuple in the given space.
---@param key box.tuple|tuple_type[]|scalar
---@return box.tuple? tuple the tuple whose index key matches key, or nil.
function boxSpaceObject:get(key) end

---Insert a tuple into a space.
---@param tuple box.tuple|tuple_type[] tuple to be inserted.
---@return box.tuple tuple the inserted tuple
function boxSpaceObject:insert(tuple) end

---Return the number of tuples in the space. If compared with count(), this method works faster because len() does not scan the entire space to count the tuples.
---@return number number_of_tuples Number of tuples in the space.
function boxSpaceObject:len() end

---@alias replaceTrigger
---| fun(old_tuple: box.tuple, new_tuple: box.tuple, space_name: string, request_type: "INSERT" | "UPDATE" | "REPLACE" | "UPSERT"): box.tuple?
---| fun(old_tuple: nil, new_tuple: box.tuple, space_name: string, request_type: "INSERT" | "UPDATE" | "REPLACE" | "UPSERT"): box.tuple?
---| fun(old_tuple: box.tuple, new_tuple: nil, space_name: string, request_type: "DELETE"): box.tuple?

---Create a “replace trigger”. The trigger-function will be executed whenever a replace() or insert() or update() or upsert() or delete() happens to a tuple in <space-name>.
---@param trigger_func replaceTrigger|nil
---@param old_trigger_func? replaceTrigger
---@return replaceTrigger? func the old trigger if it was replaced or deleted
function boxSpaceObject:on_replace(trigger_func, old_trigger_func) end

---Create a “replace trigger”. The trigger-function will be executed whenever a replace() or insert() or update() or upsert() or delete() happens to a tuple in <space-name>.
---@param trigger_func replaceTrigger|nil
---@param old_trigger_func? replaceTrigger
---@return replaceTrigger? func the old trigger if it was replaced or deleted
function boxSpaceObject:before_replace(trigger_func, old_trigger_func) end

---Search for a tuple or a set of tuples in the given space, and allow iterating over one tuple at a time.
---@param key box.tuple|tuple_type[]|scalar value to be matched against the index key, which may be multi-part
---@param iterator? boxIterator (Default: 'EQ') defines iterator order
---@return boxSpaceIterator,boxSpaceIteratorParam,boxSpaceIteratorState
function boxSpaceObject:pairs(key, iterator) end

---@class boxSpaceIterator: fun.iterator
---@class boxSpaceIteratorParam: string
---@class boxSpaceIteratorState: ffi.cdata*

---Rename a space.
---@param space_name string
function boxSpaceObject:rename(space_name) end

---Insert a tuple into a space.
---@param tuple box.tuple|tuple_type[] tuple to be inserted.
---@return box.tuple tuple the inserted tuple
function boxSpaceObject:replace(tuple) end

---Insert a tuple into a space (synonym for replace).
---@param tuple box.tuple|tuple_type[] tuple to be inserted.
---@return box.tuple tuple the inserted tuple
function boxSpaceObject:put(tuple) end

---At the time that a trigger is defined, it is automatically enabled - that is, it will be executed. Replace triggers can be disabled with box.space.space-name:run_triggers(false) and re-enabled with box.space.space-name:run_triggers(true).
---@param flag boolean
function boxSpaceObject:run_triggers(flag) end

---@class boxSpaceSelectOptions: boxTableIterator
---@field limit? number maximum number of tuples
---@field offset? number number of tuples to skip
---@field fetch_pos? boolean if `true`, the select method returns the position of the last selected tuple as the second value.

---Search for a tuple or a set of tuples in the given space. This method doesn’t yield (for details see Cooperative multitasking).
---@param key box.tuple|tuple_type[]|scalar
---@param options? boxSpaceSelectOptions
---@return box.tuple[] list the tuples whose primary-key fields are equal to the fields of the passed key. If the number of passed fields is less than the number of fields in the primary key, then only the passed fields are compared, so select{1,2} will match a tuple whose primary key is {1,2,3}.
---@return string? pos
function boxSpaceObject:select(key, options) end

---Deletes all tuples. The method is performed in background and doesn’t block consequent requests.
function boxSpaceObject:truncate() end

---@alias update_operation string
---| '+' # for addition. values must be numeric, e.g. unsigned or decimal
---| '-' # for subtraction. values must be numeric
---| '&' # for bitwise AND. values must be unsigned numeric
---| '|' # for bitwise OR. values must be unsigned numeric
---| '^' # for bitwise XOR. values must be unsigned numeric
---| ':' # for string splice.
---| '!' # for insertion of a new field.
---| '#' # for deletion.
---| '=' # for assignment.

---Update a tuple.
---
---The update function supports operations on fields — assignment, arithmetic (if the field is numeric), cutting and pasting fragments of a field, deleting or inserting a field.
---Multiple operations can be combined in a single update request, and in this case they are performed atomically and sequentially.
---Each operation requires specification of a field identifier, which is usually a number.
---When multiple operations are present, the field number for each operation is assumed to be relative to the most recent state of the tuple, that is, as if all previous operations in a multi-operation update have already been applied.
---In other words, it is always safe to merge multiple update invocations into a single invocation, with no change in semantics.
---@param key box.tuple|tuple_type[]|scalar
---@param update_operations { [1]: update_operation, [2]: integer|string, [3]: tuple_type }[]
---@return box.tuple? tuple the updated tuple if it was found
function boxSpaceObject:update(key, update_operations) end

---Update or insert a tuple.
---If there is an existing tuple which matches the key fields of tuple, then the request has the same effect as space_object:update() and the {{operator, field_identifier, value}, ...} parameter is used.
---If there is no existing tuple which matches the key fields of tuple, then the request has the same effect as space_object:insert() and the {tuple} parameter is used.
---However, unlike insert or update, upsert will not read a tuple and perform error checks before returning – this is a design feature which enhances throughput but requires more caution on the part of the user.
---@param tuple box.tuple|tuple_type[]
---@param update_operations { [1]: update_operation, [2]: integer|string, [3]: tuple_type }[]
function boxSpaceObject:upsert(tuple, update_operations) end

---Converts table to tuple if it is satisfied by format
---@param tbl table<string,any>
---@return box.tuple
function boxSpaceObject:frommap(tbl) end

return box.space
