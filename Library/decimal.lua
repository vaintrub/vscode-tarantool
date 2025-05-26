---@meta
--luacheck: ignore

local decimal = {}

---@class decimal
---@operator unm: decimal
---@operator add(decimal|number|string): decimal
---@operator sub(decimal|number|string): decimal
---@operator mul(decimal|number|string): decimal
---@operator div(decimal|number|string): decimal
---@operator mod(decimal|number|string): decimal
---@operator pow(decimal|number|string): decimal
local decimal_obj = {}

---@param n decimal|string|number
---@return decimal
function decimal.abs(n) end

---@param n decimal|string|number
---@return decimal
function decimal.exp(n) end

---@param n decimal|string|number
---@return boolean
function decimal.is_decimal(n) end

---@param n decimal|string|number
---@return decimal
function decimal.ln(n) end

---@param n decimal|string|number
---@return decimal
function decimal.new(n) end

---@param n decimal|string|number
---@return integer
function decimal.precision(n) end

---@param n decimal
---@param new_scale number
---@return decimal
function decimal.rescale(n, new_scale) end

---@param n decimal|string|number
---@return number scale
function decimal.scale(n, new_scale) end

---@param n decimal|string|number
---@return decimal
function decimal.log10(n) end

---@param n decimal|string|number
---@param digits? number
---@return decimal
function decimal.round(n, digits) end

---@param n decimal|string|number
---@return decimal
function decimal.sqrt(n) end

---@param n decimal
---@return decimal
function decimal.trim(n) end

return decimal
