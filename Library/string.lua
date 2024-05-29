---@meta
--luacheck: ignore

---Split `input_string` into one or more output strings in a table.
---
---The places to split are the places where `split_string` occurs.
---@param input_string string the string to split
---@param split_string? string the string to find within `input_string`. Default = space.
---@param max? integer  maximum number of delimiters to process counting from the beginning of the input string. Result will contain max + 1 parts maximum.
---@return string[] # table of strings that were split from `input_string`
---@nodiscard
function string.split(input_string, split_string, max) end

---Return the string left-justified in a string of length width.
---@param input_string string the string to left-justify
---@param width integer the width of the string after left-justifying
---@param char? string a single character, default = 1 space
---@return string # left-justified string (unchanged if width <= string length)
---@nodiscard
function string.ljust(input_string, width, char) end

---Return the string right-justified in a string of length width.
---@param input_string string the string to right-justify
---@param width integer the width of the string after right-justifying
---@param char? string a single character, default = 1 space
---@return string # right-justified string (unchanged if width <= string length)
---@nodiscard
function string.rjust(input_string, width, char) end

---Center string in a field of given width.
---Prepend and append "(width - len(input_string))/2" chars to given string.
---@param input_string string original string
---@param width integer width at least bytes to be returned
---@param char? string a single character, default = 1 space
---@return string # centered string
---@nodiscard
function string.center(input_string, width, char) end

---Return `true` if `input_string` starts with `start_string`, otherwise return `false`.
---
---`start_pos` and `end_pos` may be negative, meaning the position should be calculated from the end of the string.
---@param input_string string the string where `start_string` should be looked for
---@param start_string string the string to look for
---@param start_pos? integer position: where to start looking within `input_string`
---@param end_pos? integer position: where to end looking within `input_string`
---@return boolean
---@nodiscard
function string.startswith(input_string, start_string, start_pos, end_pos) end

---Return `true` if `input_string` ends with `end_string`, otherwise return `false`.
---
---`start_pos` and `end_pos` may be negative, meaning the position should be calculated from the end of the string.
---@param input_string string the string where `end_string` should be looked for
---@param end_string string the string to look for
---@param start_pos? integer position: where to start looking within `input_string`
---@param end_pos? integer position: where to end looking within `input_string`
---@return boolean
---@nodiscard
function string.endswith(input_string, end_string, start_pos, end_pos) end

---Return the hexadecimal value of the input string.
---@param input_string string the string where `start_string` should be looked for
---@return string # hexadecimal, 2 hex-digit characters for each input character
---@nodiscard
function string.hex(input_string) end

---Given a string containing pairs of hexadecimal digits, return a string with one byte for each pair.
---This is the reverse of `string.hex()`.
---The `hexadecimal_input_string` must contain an even number of hexadecimal digits.
---@param hexadecimal_input_string string string with pairs of hexadecimal digits
---@return string # string with one byte for each pair of hexadecimal digits
---@nodiscard
function string.fromhex(hexadecimal_input_string) end

---Return the value of the `input_string`, after removing characters on the left.
---The optional `list_of_characters` parameter is a set not a sequence,
---so `string.lstrip(...,'ABC')` does not mean strip `'ABC'`, it means strip `'A'` or `'B'` or `'C'`.
---@param input_string string the string to process
---@param list_of_characters? string what characters can be stripped. Default = space.
---@return string # result after stripping characters from input string
---@nodiscard
function string.lstrip(input_string, list_of_characters) end

---Return the value of the `input_string`, after removing characters on the right.
---The optional `list_of_characters` parameter is a set not a sequence,
---so `string.rstrip(...,'ABC')` does not mean strip `'ABC'`, it means strip `'A'` or `'B'` or `'C'`.
---@param input_string string the string to process
---@param list_of_characters? string what characters can be stripped. Default = space.
---@return string # result after stripping characters from input string
---@nodiscard
function string.rstrip(input_string, list_of_characters) end

---Return the value of the `input_string`, after removing characters on the left and the right.
---The optional `list_of_characters` parameter is a set not a sequence,
---so `string.strip(...,'ABC')` does not mean strip `'ABC'`, it means strip `'A'` or `'B'` or `'C'`.
---@param input_string string the string to process
---@param list_of_characters? string what characters can be stripped. Default = space.
---@return string # result after stripping characters from input string
---@nodiscard
function string.strip(input_string, list_of_characters) end
