---@meta
--luacheck: ignore

box.backup = {}

---Informs the server that activities related to the removal of outdated backups must be suspended.
---
---To guarantee an opportunity to copy these files, Tarantool will not delete them.
---But there will be no read-only mode and checkpoints will continue by schedule as usual.
---@param n? number
---@return string[]
function box.backup.start(n) end

---Informs the server that normal operations may resume.
function box.backup.stop() end
