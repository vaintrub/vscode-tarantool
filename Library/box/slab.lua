---@meta
--luacheck: ignore

box.slab = {}

---@class boxSlabInfo
---@field quota_size number memory limit for slab allocator
---@field quota_used number used by slab allocator
---@field quota_used_ratio string
---@field arena_size number allocated for both tuples and indexes
---@field arena_used number used for both tuples and indexes
---@field arena_used_ratio string
---@field items_size number allocated only for tuples
---@field items_used number used only for tuples
---@field items_used_ratio string

---@return boxSlabInfo
function box.slab.info() end