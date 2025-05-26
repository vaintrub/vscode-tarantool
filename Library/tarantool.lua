---@meta
--luacheck: ignore

---@alias integer64 ffi.cdata*
---@alias float64 ffi.cdata*

---@alias scalar
---| nil # box.NULL or Lua nil
---| boolean # true/false
---| string # lua string
---| integer # lua number
---| integer64 # luajit cdata
---| number # lua number
---| float64 # luajit cdata
---| decimal # Tarantool decimal
---| datetime # Tarantool datetime
---| interval # Tarantool interval
---| uuid # Tarantool uuid

---@alias tuple_type scalar|compound

---@alias map table<string, tuple_type> Tarantool kv map, keys are always strings
---@alias array tuple_type[] Tarantool array

---@alias compound
---| map # Tarantool map
---| array # Tarantool array

---Convert a string or a Lua number to a 64-bit integer.
---@param value string|number|ffi.cdata*
---@return ffi.cdata*|number
function tonumber64(value) end

---Allocates new Lua table
---@param narr number
---@param nrec number
---@return table
function table.new(narr, nrec) end

---Compare two lua tables
---Supports __eq metamethod for comparing custom tables with metatables
---@param a table
---@param b table
---@return boolean
function table.equals(a, b) end

---Deepcopy lua table (all levels)
---Supports __copy metamethod for copying custom tables with metatables
---@param t table
---@return table deepcopy
function table.deepcopy(t) end

---Copy any table (only top level)
---Supports __copy metamethod for copying custom tables with metatables
---@param t table
---@return table copy
function table.copy(t) end

---Removes all keys from table
---@param t table
function table.clear(t) end

---@type ffi.cdata*
box.NULL = {}

---Parse and execute an arbitrary chunk of Lua code. This function is mainly useful to define and run Lua code without having to introduce changes to the global Lua environment.
---@param lua_chunk_string string Lua code
---@param ... any zero or more scalar values which will be appended to
---@return any ... whatever is returned by the Lua code chunk.
function dostring(lua_chunk_string, ...) end

---@class int64_t: ffi.cdata*
---@operator add(int64_t|number): int64_t
---@operator sub(int64_t|number): int64_t
---@operator mul(int64_t|number): int64_t
---@operator div(int64_t|number): int64_t
---@operator unm: int64_t
---@operator mod(int64_t|number): int64_t
---@operator pow(int64_t|number): int64_t

---@class uint64_t: ffi.cdata*
---@operator add(int64_t|number|uint64_t): uint64_t
---@operator sub(int64_t|number|uint64_t): uint64_t
---@operator mul(int64_t|number|uint64_t): uint64_t
---@operator div(int64_t|number|uint64_t): uint64_t
---@operator unm: uint64_t
---@operator mod(int64_t|number|uint64_t): uint64_t
---@operator pow(int64_t|number|uint64_t): uint64_t

---Returns path of the library
---@param name string
---@return string?
function package.search(name) end

function package.searchroot() end

---sets root for require
---@param path ?string
function package.setsearchroot(path) end
