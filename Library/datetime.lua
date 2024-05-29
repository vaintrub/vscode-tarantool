---@meta
--luacheck: ignore
--TODO:

local datetime = {}

---@class datetime: ffi.cdata*
---@field nsec integer (Default: 0) (usec, msec) Fractional part of the last second. You can specify either nanoseconds (nsec), or microseconds (usec), or milliseconds (msec). Specifying two of these units simultaneously or all three ones lead to an error
---@field sec integer (Default: 0) Seconds. Value range: 0 - 60
---@field min integer (Default: 0) Minutes. Value range: 0 - 59
---@field hour integer (Default: 0) Hours. Value range: 0 - 23
---@field day integer (Default: 1) Day number. Value range: 1 - 31. The special value -1 generates the last day of a particular month (see example below)
---@field month	integer (Default: 1) Month number. Value range: 1 - 12
---@field year integer (Default: 1970) Year.
---@field timestamp	integer (Default: 0) Timestamp, in seconds. Similar to the Unix timestamp, but can have a fractional part which is converted in nanoseconds in the resulting datetime object. If the fractional part for the last second is set via the nsec, usec, or msec units, the timestamp value should be integer otherwise an error occurs. Timestamp is not allowed if you already set time and/or date via specific units, namely, sec, min, hour, day, month, and year
---@field tzoffset integer (Default: 0) Time zone offset from UTC, in minutes. If both tzoffset and tz are specified, tz has the preference and the tzoffset value is ignored
---@field tz string Time zone name according to the tz database
---@field wday integer Days since the beginning of the week
---@field yday integer Days since the beginning of the year
---@field isdst	boolean Is the DST (Daylight saving time) applicable for the date. Boolean.
local datetime_obj = {}

--- Create a datetime object from a table of time units.
---
---**Default values:**
---
--- * nsec: 0
--- * sec: 0
--- * min: 0
--- * hour: 1
--- * day: 1
--- * year: 1970
--- * timestamp: 0
--- * tzoffset: 0
--- * tz: nil
---@param units? { nsec?: integer, sec?: integer, min?: integer, hour?: integer, day?: integer, year?: integer, timestamp?: integer, tzoffset?: integer, tz?: string}
---@return datetime datetime_obj
function datetime.new(units) end

--- Convert the standard presentation of a datetime object into a formatted string
---@param input_string? string (Default: '%FT%T.%f%z') String consisting of zero or more conversion specifications and ordinary characters
---@return string
function datetime_obj:format(input_string) end

--- Convert the information from a datetime object into the table format
function datetime_obj:totable() end

--- Update the field values in the existing datetime object
function datetime_obj:set() end

--- Convert an input string with the date and time information into a datetime object
function datetime_obj:parse() end

--- Modify an existing datetime object by adding values of the input arguments
function datetime_obj:add() end

--- Modify an existing datetime object by subtracting values of the input arguments
function datetime_obj:sub() end

datetime.interval = {}

---@class interval: ffi.cdata*
---@field nsec integer (Default: 0) (usec, msec)	Fractional part of the last second. You can specify either nanoseconds (nsec), or microseconds (usec), or milliseconds (msec). Specifying two of these units simultaneously or all three ones lead to an error
---@field sec integer (Default: 0) Seconds
---@field min integer (Default: 0) Minutes
---@field hour integer (Default: 0) Hours
---@field day integer (Default: 0) Day number
---@field week integer (Default: 0) Week number
---@field month integer (Default: 0) Month number
---@field year integer (Default: 0) Year
---@field adjust string (Default: 'none') Defines how to round days in a month after an arithmetic operation
---@operator add(interval): interval
---@operator sub(interval): interval
local interval_obj = {}

--- Create an interval object from a table of time units
---
---**Default values:**
---
--- * nsec: 0
--- * sec: 0
--- * min: 0
--- * hour: 1
--- * day: 1
--- * week: 0
--- * month: 0
--- * year: 0
--- * adjust: 'none'
---@param units? { nsec?: integer, sec?: integer, min?: integer, hour?: integer, day?: integer, week?: integer, month?: integer, year?: integer, adjust: string}
---@return interval interval_obj
function datetime.interval.new(units) end

--- Convert the information from an interval object into the table format
function interval_obj:totable() end

return datetime
