---@meta
--luacheck: ignore
--TODO:

local console = {}

--- Connect to an instance
function console.connect(uri) end

--- Listen for incoming requests
function console.listen(uri) end

--- Start the console
function console.start() end

--- Set the auto-completion flag
function console.ac(auto_completion_flag) end

--- Set a delimiter
function console.delimiter(marker) end

--- Get default output format
function console.get_default_output() end

--- Set default output format
function console.set_default_output(format) end

--- Set or get end-of-output string
function console.eos(str) end

return console
