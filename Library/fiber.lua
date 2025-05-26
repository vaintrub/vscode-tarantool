---@meta
---A fiber is a set of instructions which are executed with cooperative multitasking.
---Fibers managed by the fiber module are associated with a user-supplied function called the fiber function.
---A fiber has three possible states, detectable by fiber.status(): running, suspended or dead.
---When a fiber is created with fiber.create(), it is running.
---When a fiber is created with fiber.new() or yields control with fiber.sleep(), it is suspended.
---When a fiber ends (because the fiber function ends), it is dead.
---All fibers are part of the fiber registry.
---This registry can be searched with fiber.find() - via fiber id (fid), which is a numeric identifier.
---A runaway fiber can be stopped with fiber_object.cancel.
---However, fiber_object.cancel is advisory — it works only if the runaway fiber calls fiber.testcancel() occasionally.
---Most box.* functions, such as box.space…delete() or box.space…update(), do call fiber.testcancel() but box.space…select{} does not.
---In practice, a runaway fiber can only become unresponsive if it does many computations and does not check whether it has been cancelled.
---Like all Lua objects, dead fibers are garbage collected.
---The Lua garbage collector frees pool allocator memory owned by the fiber, resets all fiber data,
---and returns the fiber (now called a fiber carcass) to the fiber pool.
---The carcass can be reused when another fiber is created.
---A fiber has all the features of a Lua coroutine and all the programming concepts
---that apply for Lua coroutines will apply for fibers as well.
---However, Tarantool has made some enhancements for fibers and has used fibers internally.
---So, although use of coroutines is possible and supported, use of fibers is recommended.
---@module 'fiber'

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
function fiber.new(func, ...) end

---Get a fiber object
---@return Fiber
function fiber.self() end

---Get a fiber object by ID
---@param id integer numeric identifier of the fiber.
---@return Fiber
function fiber.find(id) end

---Yield control to the scheduler and sleep for the specified number of seconds.
---Only the current fiber can be made to sleep.
---@async
---@param timeout number number of seconds to sleep.
function fiber.sleep(timeout) end

---Yield control to the scheduler. Equivalent to `fiber.sleep(0)`.
---@async
function fiber.yield() end

---Return the status of the current fiber.
---Or, if optional fiber_object is passed, return the status of the specified fiber.
---@param fiber_object? Fiber
---@return "running"|"dead"|"supspected"
function fiber.status(fiber_object) end

---@class FiberInfo
---@field csw number number of context switches.
---@field memory { total: number, used: number } `total` is memory occupied by the fiber as a C structure, its stack, etc. `actual` is memory used by the fiber.
---@field time number duplicates the “time” entry from fiber.top().cpu for each fiber. (Only shown if fiber.top is enabled.)
---@field name string name of the fiber
---@field fid number id of the fiber
---@field backtrace { C: string, L: string }[] fiber’s stack trace

---Get information about all fibers
---@param opts? {backtrace:boolean, bt:boolean}`
---@return table<number, FiberInfo>
function fiber.info(opts) end

---@return integer fiber_id returns current fiber id
function fiber.id() end

---@class FiberTop
---@field instant number  (in percent), which indicates the share of time the fiber was executing during the previous event loop iteration.
---@field average number (in percent), which is calculated as an exponential moving average of instant values over all the previous event loop iterations.
---@field time number (in seconds), which estimates how much CPU time each fiber spent processing during its lifetime.

---Return a table of alive fibers and show their CPU consumption
---@return { cpu: table<string,FiberTop>, cpu_misses: number }
function fiber.top() end

---Cancel a fiber
---@param fiber_object Fiber
---@overload fun(fiber_id: integer)
function fiber.kill(fiber_object) end

---Check if the current fiber has been cancelled
function fiber.testcancel() end

---Get the system time in seconds as Lua number
---```
---tarantool> fiber.time(), fiber.time()
--- - 1448466279.2415
--- - 1448466279.2415
---```
---@return number
function fiber.time() end

---Get the system time in microseconds
---@return int64_t
function fiber.time64() end

---Get the monotonic time in seconds
---@return number
function fiber.clock() end

---Get the monotonic time in microseconds
---@return ffi.cdata*
function fiber.clock64() end

function fiber.top_enable() end

function fiber.top_disable() end

---Check whether a slice for the current fiber is over.
---
---A fiber slice limits the time period of executing a fiber without yielding control.
function fiber.check_slice() end

---@class fiber.slice
---@field warn number
---@field err number

---Set a slice for the current fiber execution.
---
---A fiber slice limits the time period of executing a fiber without yielding control.
---@param slice fiber.slice|number a time period (in seconds) that specifies the error slice
function fiber.set_slice(slice) end

---Set the default maximum slice for all fibers.
---
---A fiber slice limits the time period of executing a fiber without yielding control.
---@param slice fiber.slice|number a time period (in seconds) that specifies the error slice
function fiber.set_max_slice(slice) end

---Extend a slice for the current fiber execution.
---For example, if the default error slice is set using fiber.set_max_slice() to 3 seconds, extend_slice(1)
---extends the error slice to 4 seconds.
---@param slice fiber.slice|number a time period (in seconds) that specifies the error slice
function fiber.extend_slice(slice) end

---@class Fiber: userdata
local fiber_object = {}

---Get a fiber’s ID
---@return integer # fiber id
function fiber_object:id() end

---Gets or changes a fiber’s name
---@param name? string
---@param options? {truncate: boolean}
---@return string name
function fiber_object:name(name, options) end

---Gets or changes a fiber’s name
---@param name? string
---@param options? {truncate: boolean}
---@return string name
function fiber.name(name, options) end

---Get a fiber’s status
---@return "dead"|"running"|"suspended"
function fiber_object:status() end

---Cancel a fiber
function fiber_object:cancel() end

---Wakeup a fiber
function fiber_object:wakeup() end

---returns csw of the fiber
---@return number
function fiber_object:csw() end

---Local storage within the fiber
fiber_object.storage = {}

---Make it possible for a new fiber to join
---`fiber_object:set_joinable(true)` makes a fiber joinable;
---
---`fiber_object:set_joinable(false)` makes a fiber not joinable; the default is `false`.
---
---A joinable fiber can be waited for, with fiber_object:join().
---
---
---@param true_or_false boolean
function fiber_object:set_joinable(true_or_false) end

---@async
---“Join” a joinable fiber. That is, let the fiber’s function run and wait until the fiber’s status is ‘dead’ (normally a status becomes ‘dead’ when the function execution finishes).
---
---Joining will cause a yield, therefore, if the fiber is currently in a suspended state, execution of its fiber function will resume.
---
---This kind of waiting is more convenient than going into a loop and periodically checking the status;
---
---however, it works only if the fiber was created with `fiber.new()` and was made joinable with `fiber_object:set_joinable()`.
---Wait for a fiber’s state to become ‘dead’
---@return boolean success, any ...
function fiber_object:join() end

---@class fiber.channel
local channel_object = {}

---Create a communication channel
---@param capacity? integer the maximum number of slots (spaces for channel:put messages) that can be in use at once. The default is 0.
---@return fiber.channel
function fiber.channel(capacity) end

---Send a message via a channel
---@async
---@param message any
---@param timeout? number
---@return boolean success If timeout is specified, and there is no free slot in the channel for the duration of the timeout, then the return value is false. If the channel is closed, then the return value is false. Otherwise, the return value is true, indicating success.
function channel_object:put(message, timeout) end

---Close a channel
function channel_object:close() end

---Fetch a message from a channel
---@async
---@param timeout? number maximum number of seconds to wait for a message. Default: infinity.
---@return any message
function channel_object:get(timeout) end

---Check if a channel is empty
---@return boolean # is_empty
function channel_object:is_empty() end

---Count messages in a channel
---@return integer
function channel_object:count() end

---Returns size of channel
---@return integer
function channel_object:size() end

---Check if a channel is full
---@return boolean # is_full
function channel_object:is_full() end

---Check if an empty channel has any readers waiting
---@return boolean
function channel_object:has_readers() end

---Check if a full channel has any writers waiting
---@return boolean
function channel_object:has_writers() end

---Check if a channel is closed
---@return boolean # is_closed
function channel_object:is_closed() end

---@class fiber.cond:userdata
local cond_object = {}

---Create a condition variable
---@return fiber.cond
function fiber.cond() end

---Make a fiber go to sleep until woken by another fiber
---@async
---@param timeout? number number of seconds to wait, default = forever.
---@return boolean was_signalled If timeout is provided, and a signal doesn’t happen for the duration of the timeout, wait() returns false. If a signal or broadcast happens, wait() returns true.
function cond_object:wait(timeout) end

---Wake up a single fiber
function cond_object:signal() end

---Wake up all fibers
function cond_object:broadcast() end

return fiber
