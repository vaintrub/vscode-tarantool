---@meta
--luacheck: ignore

---@module 'buffer'
--TODO:

---@class Buffer
local buffer = {}

--- Create a new buffer
---@return Buffer buf_obj
function buffer.ibuf() end

function buffer:alloc(size) end

function buffer:capacity() end

function buffer:checksize(size) end

function buffer:pos() end

function buffer:read(size) end

function buffer:recycle() end

function buffer:reset() end

function buffer:reserve(size) end

function buffer:size() end

function buffer:unused() end

return buffer
