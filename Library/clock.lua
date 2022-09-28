---@meta
---@module 'clock'
--luacheck: ignore
--TODO:

---@class Clock
local clock = {}

--- Get the wall clock time in seconds
function clock.time() end

--- Get the wall clock time in seconds
function clock.realtime() end

--- Get the wall clock time in nanoseconds
function clock.time64() end

--- Get the wall clock time in nanoseconds
function clock.realtime64()	end

--- Get the monotonic time in seconds
function clock.monotonic() end

--- Get the monotonic time in nanoseconds
function clock.monotonic64() end

--- Get the processor time in seconds
function clock.proc() end

--- Get the processor time in nanoseconds
function clock.proc64() end

--- Get the thread time in seconds
function clock.thread() end

--- Get the thread time in nanoseconds
function clock.thread64() end

--- Measure the time a function takes within a processor
function clock.bench(func, args) end

return clock
