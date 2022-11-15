---@meta
--luacheck: ignore

---Split input-string into one or more output strings in a table.
---
---The places to split are the places where split-string occurs.
---@param input_string string the string to split
---@param split_string? string the string to find within input-string. Default = space.
---@param max? number  maximum number of delimiters to process counting from the beginning of the input string. Result will contain max + 1 parts maximum.
---@return string[] # list of strings
function string.split(input_string, split_string, max) end