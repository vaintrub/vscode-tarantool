---@meta
--luacheck: ignore

box.slab = {}

---@class boxSlabInfo
---@field quota_size integer memory limit for slab allocator
---@field quota_used integer used by slab allocator
---@field quota_used_ratio string
---@field arena_size integer allocated for both tuples and indexes
---@field arena_used integer used for both tuples and indexes
---@field arena_used_ratio string
---@field items_size integer allocated only for tuples
---@field items_used integer used only for tuples
---@field items_used_ratio string

---@return boxSlabInfo
function box.slab.info() end

---@class boxSlabStat
---@field mem_free integer is the allocated, but currently unused memory;
---@field mem_used integer is the memory used for storing data items (tuples and indexes);
---@field item_count integer is the number of stored items;
---@field item_size integer is the size of each data item;
---@field slab_count integer is the number of slabs allocated;
---@field slab_size integer is the size of each allocated slab.

---@return boxSlabStat[]
function box.slab.stats() end
