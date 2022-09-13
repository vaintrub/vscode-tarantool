---@meta

--luacheck:ignore
---@class fun
local m = {}

---@class Iterator
local i = {}

---Returns number of elemenths
---@param tbl table
---@return number length of the items
function m.length(tbl) end

---Builds iterator from incoming type
---@generic T
---@param tbl T[]
---@return Iterator
function m.iter(tbl) end

---Checks that all items accepts given condition
---@generic T
---@param items T[] list of items
---@param func fun(T):boolean acceptor
---@return boolean
function m.all(func, items) end

--- Returns iterator of range numbers
---@param a number
---@param b number
---@return Iterator
function m.range(a, b) end

--- Returns infinite iterator of 0's
---@return Iterator<number>
function m.zeros() end

---Remaps content of iterator
---Returns iterator
---@generic T,E
---@param mapper fun(item: T):E
---@return Iterator
function i:map(mapper) end

---Filters original iterator with given predicate
---@generic T
---@param grepper fun(item: T): boolean
---@return Iterator
function i:grep(grepper) end

---Counts length of iterator (reducer)
---@return number
function i:length() end

---Builds list of iterator (reducer)
---@generic T
---@return T[]
function i:totable() end

---Builds kv map of the iterator (reducer)
---@return table<any, any>
function i:tomap() end

---Indexes iterator with given index (reducer)
---@param idx number
---@return any
function i:nth(idx) end

---Summarizes iterator items
---@return number
function i:sum() end

---Zips 2 iterators into one
---@generic E
---@param iter Iterator<E>
---@return Iterator
function i:zip(iter) end

return m