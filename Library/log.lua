---@meta
--luacheck: ignore
---@module 'log'

---@class log: table
local log = {}

---@class logCfg
---@field level? log_level Specifies the level of detail the log has.
---@field log? string Specifies where to send the log’s output, for example, to a file, pipe, or system logger.
---@field nonblock? boolean If `true`, Tarantool does not block during logging when the system is not ready for writing, and drops the message instead.
---@field format? log_format pecifies the log format: ‘plain’ or ‘json’.
---@field modules? { [string]: string } Configures the specified log levels for different modules.
---@overload fun(cfg: logCfg)
log.cfg = {}

---Log a message with the `WARN` level
---@param s any
---@param ... any
function log.warn(s, ...) end

---Log a message with the `INFO` level
---@param s any
---@param ... any
function log.info(s, ...) end

---Log a message with the `ERROR` level
---@param s any
---@param ... any
function log.error(s, ...) end

---Log a message with the `VERBOSE` level
---@param s any
---@param ... any
function log.verbose(s, ...) end

---Log a message with the `DEBUG` level
---@param s any
---@param ... any
function log.debug(s, ...) end

---sets log level
---@param lvl? integer
function log.level(lvl) end

---A PID of a logger. You can use this PID to send a signal to a log rotation program, so it can rotate logs.
---@return integer
function log.pid() end

---Rotate the log.
---For example, you need to call this function to continue logging after a log rotation program renames or moves a file with the latest logs.
function log.rotate() end

---Since 2.11.0
---Create a new logger with the specified name.
---You can configure a specific log level for a new logger using the log_modules configuration property.
---@param name string
---@return log
function log.new(name) end

return log
