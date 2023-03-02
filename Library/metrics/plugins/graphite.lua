---@meta
--luacheck: ignore

---@class options
---@field prefix string metrics prefix ('tarantool' by default)
---@field host string Graphite server host ('127.0.0.1' by default)
---@field port number Graphite server port (2003 by default)
---@field send_interval number metrics collection interval in seconds (2 by default)
---@field This function creates a background fiber that periodically sends all metrics to a remote Graphite server.

local graphite = {}

--- This function creates a background fiber that periodically sends all metrics to a remote Graphite server.
---
--- Exported metric names are formatted as follows: <prefix>.<metric_name>
---@param options options
function graphite.init(options) end

return graphite
