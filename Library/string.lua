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

---Return the string left-justified in a string of length width.
---@param input_string string the string to left-justify
---@param width number the width of the string after left-justifying
---@param pad_character? string a single character, default = 1 space
---@return string
function string.ljust(input_string, width, pad_character) end

---Return the string right-justified in a string of length width.
---@param input_string string the string to right-justify
---@param width number the width of the string after right-justifying
---@param pad_character? string a single character, default = 1 space
---@return string
function string.rjust(input_string, width, pad_character) end

---Return the hexadecimal value of the input string.
---@param input_string string
---@return string
function string.hex(input_string) end

---Given a string containing pairs of hexadecimal digits, return a string with one byte for each pair.
---This is the reverse of string.hex().
---The hexadecimal-input-string must contain an even number of hexadecimal digits.
---@param input_string string
---@return string
function string.fromhex(input_string) end

---Return True if input-string starts with start-string, otherwise return False.
---@param input_string string the string where start-string should be looked for
---@param start_string string the string to look for
---@param start_pos? integer position: where to start looking within input-string
---@param end_pos? integer position: where to end looking within input-string
---@return boolean
function string.startswith(input_string, start_string, start_pos, end_pos) end

---Return True if input-string ends with end-string, otherwise return False.
---@param input_string string the string where start-string should be looked for
---@param start_string string the string to look for
---@param start_pos? integer position: where to start looking within input-string
---@param end_pos? integer position: where to end looking within input-string
---@return boolean
function string.endswith(input_string, start_string, start_pos, end_pos) end
