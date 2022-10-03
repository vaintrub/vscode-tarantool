---@meta
--luacheck: ignore

---@class log: table
local log = {}

---
---@param s any
---@param ... any
---@return string
function log.warn(s, ...) end

---
---@param s any
---@param ... any
---@return string
function log.info(s, ...) end

---
---@param s any
---@param ... any
---@return string
function log.error(s, ...) end

---
---@param s any
---@param ... any
---@return string
function log.verbose(s, ...) end

---
---@param s any
---@param ... any
---@return string
function log.debug(s, ...) end

return log