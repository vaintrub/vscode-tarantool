---@meta
--luacheck: ignore
--TODO:

local fiber = {}

---Create and start a fiber
---@param func fun(...:any) the function to be associated with the fiber
---@vararg ... what will be passed to function
---@return Fiber
function fiber.create(func, ...) end

---Create but do not start a fiber
---@param func fun(...:any) the function to be associated with the fiber
---@vararg ... what will be passed to function
---@return Fiber
---@nodiscard
function fiber.new(func, ...) end

---Get a fiber object
---@return Fiber
function fiber.self() end

---Get a fiber object by ID
function fiber.find() end

---Make a fiber go to sleep
---@param timeout number number of seconds to sleep.
function fiber.sleep(timeout) end

---Yield control
function fiber.yield() end

---Get the current fiber’s status
function fiber.status() end

---Get information about all fibers
function fiber.info() end

---Return a table of alive fibers and show their CPU consumption
function fiber.top() end

---Cancel a fiber
function fiber.kill() end

---Check if the current fiber has been cancelled
function fiber.testcancel() end

---Get the system time in seconds as Lua number
---
---tarantool> fiber.time(), fiber.time()
---
--- - 1448466279.2415
--- - 1448466279.2415
---@return number
function fiber.time() end

---Get the system time in microseconds
---@return ffi.cdata*
function fiber.time64() end

---Get the monotonic time in seconds
function fiber.clock() end

---Get the monotonic time in microseconds
function fiber.clock64() end

function fiber.top_enable() end

function fiber.top_disable() end

---@class Fiber: userdata
local fiber_object = {}

---Get a fiber’s ID
function fiber_object:id() end

---Get a fiber’s name
---@param name? string
---@param options? {truncate: boolean}
function fiber_object:name(name, options) end

---Get a fiber’s status
function fiber_object:status() end

---Cancel a fiber
function fiber_object:cancel() end

---Local storage within the fiber
fiber_object.storage = {}

---Make it possible for a new fiber to join
function fiber_object:set_joinable() end

---Wait for a fiber’s state to become ‘dead’
function fiber_object:join() end

---@class fiber.channel
local channel_object = {}

---Create a communication channel
---@param capacity? number the maximum number of slots (spaces for channel:put messages) that can be in use at once. The default is 0.
---@return fiber.channel
function fiber.channel(capacity) end

---Send a message via a channel
---@param message any
---@param timeout? number
---@return boolean success If timeout is specified, and there is no free slot in the channel for the duration of the timeout, then the return value is false. If the channel is closed, then the return value is false. Otherwise, the return value is true, indicating success.
function channel_object:put(message, timeout) end

---Close a channel
function channel_object:close() end

---Fetch a message from a channel
---@param timeout? number maximum number of seconds to wait for a message. Default: infinity.
---@return any message
function channel_object:get(timeout) end

---Check if a channel is empty
function channel_object:is_empty() end

---Count messages in a channel
function channel_object:count() end

---Check if a channel is full
function channel_object:is_full() end

---Check if an empty channel has any readers waiting
function channel_object:has_readers() end

---Check if a full channel has any writers waiting
function channel_object:has_writers() end

---Check if a channel is closed
function channel_object:is_closed() end

---@class fiber.cond:userdata
local cond_object = {}

---Create a condition variable
---@return fiber.cond
function fiber.cond() end

---Make a fiber go to sleep until woken by another fiber
---@param timeout? number number of seconds to wait, default = forever.
---@return boolean was_signalled If timeout is provided, and a signal doesn’t happen for the duration of the timeout, wait() returns false. If a signal or broadcast happens, wait() returns true.
function cond_object:wait(timeout) end

---Wake up a single fiber
function cond_object:signal() end

---Wake up all fibers
function cond_object:broadcast() end

return fiber
