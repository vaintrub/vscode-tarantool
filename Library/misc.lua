---@meta
--luacheck: ignore

local misc = {}

---https://www.tarantool.io/en/doc/latest/reference/tooling/luajit_getmetrics/
---@class misc.metrics
---@field gc_allocated number (monotonic) number of bytes of allocated memory
---@field gc_cdatanum number (non-monotonic) number of allocated cdata objects
---@field gc_freed number (monotonic) number of bytes of freed memory
---@field gc_steps_atomic number (monotonic) number of steps of garbage collector, atomic phases, incremental
---@field gc_steps_finalize number (monotonic) number of steps of garbage collector, finalize
---@field gc_steps_pause number (monotonic) number of steps of garbage collector, pauses
---@field gc_steps_propagate number (monotonic) number of steps of garbage collector, propagate
---@field gc_steps_sweep number (monotonic) number of steps of garbage collector, sweep phases (see the Sweep phase description)
---@field gc_steps_sweepstring number (monotonic) number of steps of garbage collector, sweep phases for strings
---@field gc_strnum number (non-monotonic) number of allocated string objects
---@field gc_tabnum number (non-monotonic) number of allocated table objects
---@field gc_total number (non-monotonic) number of bytes of currently allocated memory (normally equals gc_allocated minus gc_freed)
---@field gc_udatanum number (non-monotonic) number of allocated udata objects
---@field jit_mcode_size number (non-monotonic) total size of all allocated machine code areas
---@field jit_snap_restore number (monotonic) overall number of snap restores, based on the number of guard assertions leading to stopping trace executions (see external Snap tutorial)
---@field jit_trace_abort number (monotonic) overall number of aborted traces
---@field jit_trace_num number (non-monotonic) number of JIT traces
---@field strhash_hit number (monotonic) number of strings being interned because, if a string with the same value is found via the hash, a new one is not created / allocated
---@field strhash_miss number (monotonic) total number of strings allocations during the platform lifetime


---Get the metrics values into a table.
---@return misc.metrics
function misc.getmetrics() end

return misc
