---@meta
--luacheck: ignore
--TODO:

local client = {}


---@class ClientHTTP
local client_object = {}


---@return ClientHTTP
function client.new() end

function client_object:patch() end

function client_object:options() end

function client_object:request() end

function client_object:put() end

function client_object:connect() end

function client_object:delete() end

function client_object:post() end

function client_object:trace() end

function client_object:head() end

function client_object:get() end

return client
