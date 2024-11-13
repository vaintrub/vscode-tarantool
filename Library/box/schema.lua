---@meta
--luacheck: ignore

---@class box.schema
box.schema = {}

box.schema.space = {}

---@class SpaceCreateOptions
---@field engine? "memtx"|"vinyl" (Default: ‘memtx’)
---@field field_count? number fixed count of fields: for example if field_count=5, it is illegal to insert a tuple with fewer than or more than 5 fields
---@field format? boxSpaceFormat
---@field id? number (Default: last space’s id, +1) unique identifier: users can refer to spaces with the id instead of the name
---@field if_not_exists? boolean (Default: false) create space only if a space with the same name does not exist already, otherwise do nothing but do not cause an error
---@field is_local? boolean (Default: false) space contents are replication-local: changes are stored in the write-ahead log of the local node but there is no replication.
---@field is_sync? boolean (Default: false) any transaction doing a DML request on this space becomes synchronous
---@field temporary? boolean (Default: false) space contents are temporary: changes are not stored in the write-ahead log and there is no replication. Note regarding storage engine: vinyl does not support temporary spaces.
---@field user? string (Default: current user’s name) name of the user who is considered to be the space’s owner for authorization purposes
---@field constraint? table|string the constraints that space tuples must satisfy.
---@field foreign_key? table the foreign keys for space fields.

---@param space_name string
---@param options SpaceCreateOptions|nil
---@return boxSpaceObject
function box.schema.space.create(space_name, options) end

---@deprecated
---@param space_name string
---@param options SpaceCreateOptions|nil
---@return boxSpaceObject
function box.schema.create_space(space_name, options) end

box.schema.user = {}

---@alias boxSchemaGrantObjectType
---| "universe"
---| "space"
---| "function"
---| "sequence"
---| "role"

---@class boxSchemaGrantOptions
---@field if_not_exists? boolean
---@field grantor? string

---Grant privileges to a user or to another role.
---@param user_name string
---@param priv_or_role string
---@param object_type? boxSchemaGrantObjectType
---@param object_name? string
---@param options? boxSchemaGrantOptions
function box.schema.user.grant(user_name, priv_or_role, object_type, object_name, options) end

box.schema.func = {}

---@class box.schema.func.create.options
---@field exports? string[] (Default: {'LUA'}) Specify the languages that can call the function.
---@field language? 'LUA'|'SQL_EXPR'|'C' (Default: 'LUA') Specify the function language.
---@field body? string Specify a function body.
---@field param_list? string[] Specify the Lua type names for each parameter of the function.
---@field returns? string Specify the Lua type name for a function’s return value.
---@field if_not_exists? boolean (Default: false) Specify whether there should be no error if the function already exists.
---@field setuid? boolean (Default: false) Make Tarantool treat the function’s caller as the function’s creator, with full privileges.
---@field is_sandboxed? boolean (Default: false) Whether the function should be executed in an isolated environment.
---@field is_deterministic? boolean (Default: false) Specify whether a function should be deterministic.
---@field is_multikey? boolean (Default: false) If `true` is set in the function definition for a functional index, the function returns multiple keys.
---@field takes_raw_args? boolean (Default: false) If set to `true` the function arguments are passed being wrapped in a MsgPack object

---Create a function
---@param func_name string
---@param function_options? box.schema.func.create.options
function box.schema.func.create(func_name, function_options) end

---Return true if a function tuple exists; return false if a function tuple does not exist.
---@param func_name string
function box.schema.func.call(func_name) end

---Reload a C module with all its functions without restarting the server.
---@param module_name? string the name of the module to reload
function box.schema.func.reload(module_name) end

---Drop a function tuple.
---@param func_name string
---@param options? { if_exists?: boolean }
function box.schema.func.drop(func_name, options) end

---Return true if a function tuple exists; return false if a function tuple does not exist.
---@param func_name string
function box.schema.func.exist(func_name) end

return box.schema
