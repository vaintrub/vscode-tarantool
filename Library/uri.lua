---@meta
--luacheck: ignore
local uri = {}

---@class URIFormat
---@field fragment? string string after #
---@field host? string host (same as Host header in HTTP)
---@field ipv4? string ipv4 address if was parsed
---@field ipv6? string ipv6 address if was parsed
---@field login? string login as for basic auth if was parsed
---@field password? string password as for basic auth if was parsed
---@field path? string path in HTTP URI if was parsed
---@field query? table<string,string[]> query of arguments. values are a list of strings
---@field scheme? string scheme
---@field service? string port if was given
---@field unix? string path to unix socket if was parsed

---Get a table of URI components
---@param uri_string string a Uniform Resource Identifier
---@return URIFormat
function uri.parse(uri_string) end

---Form a URI string from its components
---@param uri_format URIFormat a series of name=value pairs, one for each component
---@param include_password boolean? If this is supplied and is true, then the password component is rendered in clear text, otherwise it is omitted.
---@return string
function uri.format(uri_format, include_password) end

return uri