---@meta
--luacheck: ignore
---@module 'log'

---@class log: table
local log = {}

---
---@param s any
---@param ... any
function log.warn(s, ...) end

---
---@param s any
---@param ... any
function log.info(s, ...) end

---
---@param s any
---@param ... any
function log.error(s, ...) end

---
---@param s any
---@param ... any
function log.verbose(s, ...) end

---
---@param s any
---@param ... any
function log.debug(s, ...) end

---sets log level
---@param lvl? number
---@return number?
function log.level(lvl) end

---Since 2.11.0
---@param name string
---@return log
function log.new(name) end

return log