---@meta

--luacheck:ignore
---@class net.box
local m = {}

---@class NetBoxConnectOptions
---@field public wait_connected boolean|number
---@field public timeout number
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
---@return nil, BoxError
function fut:result() end

--- Waits for result and returns it or raises box.error.TIMEOUT
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
---@field public on_push fun() callback for each inbound message
---@field public on_push_ctx any ctx for on_push callback

---@param func string
---@param args any[]
---@param opts NetBoxCallOptions
---@return table
function conn:call(func, args, opts) end

---@param expression string
---@param args any[]
---@param opts NetBoxCallOptions
---@return table
function conn:eval(expression, args, opts) end


---@return boolean
function conn:ping() end

---@param new_callback fun(conn: NetBoxConnection):nil
---@param old_callback (fun(conn: NetBoxConnection):nil)|nil
function conn:on_connect(new_callback, old_callback) end

---@param new_callback fun(conn: NetBoxConnection):nil
---@param old_callback (fun(conn: NetBoxConnection):nil)|nil
function conn:on_disconnect(new_callback, old_callback) end

---Creates connection to Tarantool
---@param endpoint string
---@param options NetBoxConnectOptions
---@return NetBoxConnection
function m.connect(endpoint, options) end

return m