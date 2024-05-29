---@meta
---@module 'clock'
--luacheck: ignore
--TODO:

---@class Clock
local clock = {}

--- Get the wall clock time in seconds
---@return number
function clock.time() end

--- Get the wall clock time in seconds
---@return number
function clock.realtime() end

--- Get the wall clock time in nanoseconds
---@return uint64_t
function clock.time64() end

--- Get the wall clock time in nanoseconds
---@return uint64_t
function clock.realtime64() end

--- Get the monotonic time in seconds
---@return number
function clock.monotonic() end

--- Get the monotonic time in nanoseconds
---@return uint64_t
function clock.monotonic64() end

--- Get the processor time in seconds
---@return number
function clock.proc() end

--- Get the processor time in nanoseconds
---@return uint64_t
function clock.proc64() end

--- Get the thread time in seconds
---@return number
function clock.thread() end

--- Get the thread time in nanoseconds
---@return uint64_t
function clock.thread64() end

--- Measure the time a function takes within a processor
---@param func fun(...: any): ...:any
---@return table
function clock.bench(func, ...) end

return clock
