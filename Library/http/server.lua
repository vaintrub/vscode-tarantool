---@meta
--luacheck: ignore
--TODO:

local server = {}

---@return ServerHTTP
---@param host ?string
---@param port ?number
function server.new(host, port) end


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

function server_object:start() end

function server_object:stop() end

function server_object:route() end

function server_object:match() end

function server_object:helper() end

function server_object:hook() end

function server_object:url_for() end


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
