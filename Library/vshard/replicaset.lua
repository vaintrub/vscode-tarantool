---@meta
--luacheck: ignore

---@class Replica
---@field uri string
---@field name string
---@field uuid UUID
---@field conn NetBoxConnection
---@field zone number
---@field next_by_priority Replica replica object of the same type
---@field weight number
---@field down_ts number timestamp of disconnect from the replica
---@field backoff_ts number timestamp when was sent into backoff state
---@field backoff_err table error object caused the backoff
---@field net_timeout number current network timeout for calls doubled on each network fail until max value, and reset to minimal value on each success
---@field net_sequential_ok number count of sequential success requests to the replica
---@field net_sequential_fail number count of sequential failed requests to the replica
---@field is_outdated nil|true


---@class Replicaset
---@field replicas Replica[]
---@field master Replica Master server from the array above
---@field master_cond fiber.cond Condition variable signaled when the replicaset finds or changes its master
---@field is_auto_master boolead true when is configured to find the master on its own
---@field replica Replica nearest available replica object
---@field balance_i number index of a next replica in priority_list to use for a load-balanced request
---@field replica_up_ts number timestamp updated on each attempt to connect to the nearest replica, and on each connect event
---@field uuid UUID replicaset_uuid
---@field weight number
---@field priority_list Replica[] list of replicas, sorted by weight asc
---@field etalon_bucket_count number bucket count, that must be stored on this replicaset to reach the balance in a cluster
---@field is_outdated true|nil
local replicaset_object = {}


--- Call a function on a nearest available master (distances are defined using replica.zone and `cfg.weights` matrix) with specified arguments
---The `replicaset_object:call` method is similar to `replicaset_object:callrw`
---@param function_name string A function to execute
---@param argument_list table An array of the function’s arguments
---@param options NetBoxCallOptions net.box options. `timeout` - if the router cannot identify a shard with the specified bucket_id, the operation will be repeated until the timeout is reached.
---@return any # Result of function_name on success or nil otherwise
---@return ShardingErrors? # Error on failure
function replicaset_object:call(function_name, argument_list, options) end


---Call a function on the nearest available replica (distances are defined using `replica.zone` and `cfg.weights` matrix) with specified arguments. It is recommended to use `replicaset_object:callro()` for calling only read-only functions, as the called functions can be executed not only on a master, but also on replicas
---@param function_name string A function to execute
---@param argument_list table An array of the function’s arguments
---@param options NetBoxCallOptions net.box options. `timeout` - if the router cannot identify a shard with the specified bucket_id, the operation will be repeated until the timeout is reached.
---@return any # Result of function_name on success or nil otherwise
---@return ShardingErrors? # Error on failure
function replicaset_object:callro(function_name, argument_list, options) end


---Call a function on a nearest available master (distances are defined using `replica.zone` and `cfg.weights` matrix) with a specified arguments
---The `replicaset_object:callrw` method is similar to `replicaset_object:call`
---@param function_name string A function to execute
---@param argument_list table An array of the function’s arguments
---@param options? NetBoxCallOptions net.box options. `timeout` - if the router cannot identify a shard with the specified bucket_id, the operation will be repeated until the timeout is reached.
---@return any # Result of function_name on success or nil otherwise
---@return ShardingErrors? # Error on failure
function replicaset_object:callrw(function_name, argument_list, options) end


---Call a function on the nearest available replica (distances are defined using `replica.zone` and `cfg.weights` matrix) with specified arguments, with preference for a replica rather than a master (similar to calling `vshard.router.call` with `prefer_replica = true`). It is recommended to use `replicaset_object:callre()` for calling only read-only functions, as the called function can be executed not only on a master, but also on replicas
---@param function_name string A function to execute
---@param argument_list table An array of the function’s arguments
---@param options NetBoxCallOptions net.box options. `timeout` - if the router cannot identify a shard with the specified bucket_id, the operation will be repeated until the timeout is reached.
---@return any # Result of function_name on success or nil otherwise
---@return ShardingErrors? # Error on failure
function replicaset_object:callre(function_name, argument_list, options) end
