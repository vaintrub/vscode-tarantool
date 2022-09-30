---@meta
--luacheck: ignore

---@class boxIndex
local boxIndex = {}

---@alias IndexPart
---| { field: number, type: 'unsigned'|'string'|'boolean'|'number'|'integer'|'decimal'|'varbinary'|'uuid'|'scalar'|'array', is_nullable: boolean, collation: string, path: string }
---| { field: string, is_nullable: boolean, collation: string, path: string }
---| { [1]: number|string, [2]: 'unsigned'|'string'|'boolean'|'number'|'integer'|'decimal'|'varbinary'|'uuid'|'scalar'|'array', is_nullable: boolean, collation: string, path: string }

---@class boxIndexOptions: table
---@field type "TREE" | "HASH" | "BITSET" | "RTREE" (Default: TREE) type of index
---@field id number (Default: last index’s id + 1) unique identifier
---@field unique boolean (Default: true) index is unique
---@field if_not_exists boolean (Default: false) no error if duplicate name
---@field parts IndexPart[] field numbers + types
---@field dimension number (Default: 2) affects RTREE only
---@field distance "euclid"|"manhattan" (Default: euclid) affects RTREE only
---@field bloom_fpr number (Default: vinyl_bloom_fpr) affects vinyl only
---@field page_size number (Default: vinyl_page_size) affects vinyl only
---@field range_size number (Default: vinyl_range_size) affects vinyl only
---@field run_count_per_level number (Default: vinyl_run_count_per_level) affects vinyl only
---@field run_size_ratio number (Default: vinyl_run_size_ratio) affects vinyl only
---@field sequence string|number
---@field func string functional index
---@field hint boolean (Default: true) affects TREE only. true makes an index work faster, false – index size is reduced by half

