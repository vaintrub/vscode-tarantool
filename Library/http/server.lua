---@meta
--luacheck: ignore
--TODO:

local server = {}

---@class ServerHTTPNewOptions
---@field disable_keepalive string[]? default {}
---@field idle_timeout number? default 0s
---@field max_header_size number? default 4096
---@field header_timeout number? default 100s
---@field handler fun(ServerHTTP, Request)
---@field app_dir string? default '.'
---@field charset string? default 'utf-8'
---@field cache_templates boolean? default true
---@field cache_controllers boolean? default true
---@field cache_static boolean? default true
---@field log_requests boolean? default true
---@field log_errors boolean? default true
---@field display_errors boolean? default false

---@param host string
---@param port number
---@param options? table
---@return ServerHTTP
function server.new(host, port, options) end


---@class ServerHTTP
---@field host string
---@field port number
---@field is_run boolean
---@field routes table
---@field iroutes any --TODO: type?
---@field helpers any --TODO: type?
---@field hooks any --TODO: type?
---@field cache any --TODO: type?
local server_object = {}

---@return ServerHTTP
function server_object:start() end

function server_object:stop() end

function server_object:route() end

function server_object:match() end

function server_object:helper() end

function server_object:hook() end

function server_object:url_for() end

---comment
---@param opts any
---@param sub any
---@return ServerHTTP
function server_object:route(opts, sub) end


---@class Request
local request_object = {}

function request_object:render() end

function request_object:cookie() end

function request_object:redirect_to() end

function request_object:iterate() end

function request_object:stash() end

function request_object:url_for() end

function request_object:content_type() end

function request_object:request_line() end

function request_object:read_cached() end

function request_object:query_param() end

function request_object:post_param() end

function request_object:param() end

function request_object:read() end

function request_object:json() end

return server
