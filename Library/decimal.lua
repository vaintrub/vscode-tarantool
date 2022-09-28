---@meta
--luacheck: ignore
--TODO:

local decimal = {}

---@class Decimal
local decimal_obj = {}

---@param n Decimal|string|number
---@return Decimal
function decimal.abs(n) end

---@param n Decimal|string|number
---@return Decimal
function decimal.exp(n) end

---@param n Decimal|string|number
---@return boolean
function decimal.is_decimal(n) end

---@param n Decimal|string|number
---@return Decimal
function decimal.ln(n) end

---@param n Decimal|string|number
---@return Decimal
function decimal.new(n) end

---@param n Decimal|string|number
---@return number
function decimal.precision(n) end

---@param n Decimal
---@param new_scale number
---@return Decimal
function decimal.rescale(n, new_scale) end

---@param n Decimal|string|number
---@return number scale
function decimal.scale(n, new_scale) end

---@param n Decimal|string|number
---@return Decimal
function decimal.log10(n) end

---@param n Decimal|string|number
---@return Decimal
function decimal.round(n) end

---@param n Decimal|string|number
---@return Decimal
function decimal.sqrt(n) end

---@param n Decimal
---@return Decimal
function decimal.trim(n) end

return decimal
