---@meta
--luacheck: ignore

local metrics = {
    http_middleware = {}
}

---@class CollectorObj
local collector_obj = {}


---Collecting HTTP request latency statistics
---metrics also provides middleware for monitoring HTTP (set by the http module) latency statistics.
---
---Register a collector for the middleware and set it as default.
---
--- **Possible errors:**
---
--- * A collector with the same type and name already exists in the registry.
---@param type_name string collector type: histogram or summary. The default is histogram.
---@param name string collector name. The default is http_server_request_latency.
---@param help string collector description. The default is HTTP Server Request Latency.
function metrics.http_middleware.configure_default_collector(type_name, name, help) end



--- Register and return a collector for the middleware.
---
--- **Possible errors:**
---
--- * A collector with the same type and name already exists in the registry.
---@param type_name string collector type: histogram or summary. The default is histogram.
---@param name string collector name. The default is http_server_request_latency.
---@param help string? collector description. The default is HTTP Server Request Latency.
---@return CollectorObj
function metrics.http_middleware.build_default_collector(type_name, name, help) end



---Set the default collector.
---@param collector CollectorObj middleware collector object.
function metrics.http_middleware.set_default_collector(collector) end

--- Return the default collector. If the default collector hasn’t been set yet,
--- register it (with default `http_middleware.build_default_collector(...) parameters)` and set it as default.
---@return CollectorObj
function metrics.http_middleware.get_default_collector() end

---Latency measuring wrap-up for the HTTP ver. 1.x.x handler. Returns a wrapped handler.
---@param handler function handler function
---@param collector any middleware collector object. If not set, the default collector is used (like in http_middleware.get_default_collector()). **Usage:** `httpd:route(route, http_middleware.v1(request_handler, collector))`
function metrics.http_middleware.v1(handler, collector) end


return metrics.http_middleware
