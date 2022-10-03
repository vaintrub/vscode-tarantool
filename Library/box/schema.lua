---@meta
--luacheck: ignore

---@class box.schema
box.schema = {}

box.schema.space = {}

---@class SpaceCreateOptions
---@field engine "memtx"|"vinyl" (Default: ‘memtx’)
---@field field_count number fixed count of fields: for example if field_count=5, it is illegal to insert a tuple with fewer than or more than 5 fields
---@field format boxSpaceFormat
---@field id number (Default: last space’s id, +1) unique identifier: users can refer to spaces with the id instead of the name
---@field if_not_exists boolean (Default: false) create space only if a space with the same name does not exist already, otherwise do nothing but do not cause an error
---@field is_local boolean (Default: false) space contents are replication-local: changes are stored in the write-ahead log of the local node but there is no replication.
---@field is_sync boolean (Default: false) any transaction doing a DML request on this space becomes synchronous
---@field temporary boolean (Default: false) space contents are temporary: changes are not stored in the write-ahead log and there is no replication. Note regarding storage engine: vinyl does not support temporary spaces.
---@field user string (Default: current user’s name) name of the user who is considered to be the space’s owner for authorization purposes

---@param space_name string
---@param options SpaceCreateOptions|nil
---@return boxSpaceObject
function box.schema.space.create(space_name, options) end

box.schema.user = {}

---@alias boxSchemaGrantObjectType
---| "universe"
---| "space"
---| "function"
---| "sequence"
---| "role"

---@class boxSchemaGrantOptions
---@field if_not_exists boolean
---@field grantor string

---Grant privileges to a user or to another role.
---@param user_name string
---@param priv_or_role string
---@param object_type? boxSchemaGrantObjectType
---@param object_name? string
---@param options? boxSchemaGrantOptions
function box.schema.user.grant(user_name, priv_or_role, object_type, object_name, options) end


return box.schema