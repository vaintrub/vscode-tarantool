---@meta
--luacheck: ignore
--TODO:

local fiber = {}

---Create and start a fiber
---@return Fiber
function fiber.create() end

---Create but do not start a fiber
---@return Fiber
function fiber.new() end

---Get a fiber object
function fiber.self() end

---Get a fiber object by ID
function fiber.find() end

---Make a fiber go to sleep
function fiber.sleep() end

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

---Get the system time in seconds
function fiber.time() end

---Get the system time in microseconds
function fiber.time64() end

---Get the monotonic time in seconds
function fiber.clock() end

---Get the monotonic time in microseconds
function fiber.clock64() end

function fiber.top_enable() end

function fiber.top_disable() end

---@class Fiber
local fiber_object = {}

---Get a fiber’s ID
function fiber_object:id() end

---Get a fiber’s name
function fiber_object:name() end

---Set a fiber’s name
function fiber_object:name(name) end

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

---@class Channel
local channel_object = {}

---Create a communication channel
---@return Channel
function fiber.channel() end

---Send a message via a channel
function channel_object:put() end

---Close a channel
function channel_object:close() end

---Fetch a message from a channel
function channel_object:get() end

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

---@class Cond
local cond_object = {}

---Create a condition variable
---@return Cond
function fiber.cond() end

---Make a fiber go to sleep until woken by another fiber
function cond_object:wait() end

---Wake up a single fiber
function cond_object:signal() end

---Wake up all fibers
function cond_object:broadcast() end

return fiber
