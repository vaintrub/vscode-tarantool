---@meta

-- luacheck:ignore
---@class net.box
local m = {}

---@class NetBoxConnectOptions
---@field public wait_connected boolean|number
---@field public reconnect_after number
---@field public user string
---@field public password string
---@field public connect_timeout number

---@class NetBoxConnection
---@field public host string
---@field public port string
---@field public state string
---@field public error string
---@field public peer_uuid string|nil
local conn = {}

---@class NetBoxFuture
local fut = {}

---Checks if result is recieved
---@return boolean
function fut:is_ready() end

---@return table result
---@return nil, BoxErrorObject
function fut:result() end

--- Waits for result and returns it or raises box.error.TIMEOUT
---@async
---@param timeout number
---@return table result
function fut:wait_result(timeout) end

---discards result
function fut:discard() end

---@class NetBoxRequestOptions
---@field public is_async boolean
---@field public timeout number

---@class NetBoxCallOptions
---@field public timeout number Timeout of Call
---@field public is_async boolean makes request asynchronous
---@field public return_raw boolean returns raw msgpack (since version 2.10.0)
---@field public on_push fun(ctx: any?, msg: any) callback for each inbound message
---@field public on_push_ctx any ctx for on_push callback

---@async
---@param func string
---@param args? any[]
---@param opts? NetBoxCallOptions
---@return table
function conn:call(func, args, opts) end

---@async
---@param expression string
---@param args any[]
---@param opts NetBoxCallOptions
---@return ...
function conn:eval(expression, args, opts) end


---@async
---@return boolean
function conn:ping() end

---@param new_callback fun(conn: NetBoxConnection):nil
---@param old_callback (fun(conn: NetBoxConnection):nil)|nil
function conn:on_connect(new_callback, old_callback) end

---@param new_callback fun(conn: NetBoxConnection):nil
---@param old_callback (fun(conn: NetBoxConnection):nil)|nil
function conn:on_disconnect(new_callback, old_callback) end

---Wait for connection to be active or closed.
---@async
---@param wait_timeout number
---@return boolean is_connected true when connected, false on failure.
function conn:wait_connected(wait_timeout) end

---is a wrapper which sets a timeout for the request that follows it.
---Since version 1.7.4 this method is deprecated – it is better to pass a timeout value for a method’s {options} parameter.
---@param request_timeout number
---@return NetBoxConnection
---@deprecated
function conn:timeout(request_timeout) end

---Close a connection.
---Connection objects are destroyed by the Lua garbage collector, just like any other objects in Lua, so an explicit destruction is not mandatory. However, since close() is a system call, it is good programming practice to close a connection explicitly when it is no longer needed, to avoid lengthy stalls of the garbage collector.
function conn:close() end

---Creates connection to Tarantool
---@async
---@param endpoint string
---@param options? NetBoxConnectOptions
---@return NetBoxConnection
function m.connect(endpoint, options) end

---Creates connection to Tarantool
---@async
---@param endpoint string
---@param options NetBoxConnectOptions
---@return NetBoxConnection
function m.new(endpoint, options) end

return m
