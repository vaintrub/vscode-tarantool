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
