---@meta
--luacheck: ignore

box.backup = {}

---Informs the server that activities related to the removal of outdated
---backups must be suspended.
---
---To guarantee an opportunity to copy these files, Tarantool will
---not delete them.
---But there will be no read-only mode and checkpoints will continue by
---schedule as usual.
---@param n? number optional argument that indicates the checkpoint to use
---relative to the latest checkpoint.
---For example `n = 0` means “backup will be based on the latest checkpoint”,
---`n = 1` means “backup will be based on the first checkpoint before the
---latest checkpoint (counting backwards)”, and so on.
---The __default value for n is 0__.
---@return string[] # a table with the names of snapshot and vinyl files that should be copied
function box.backup.start(n) end

---Informs the server that normal operations may resume.
function box.backup.stop() end
