---@meta
--luacheck: ignore

---@class boxCtl
box.ctl = {}


---Wait until box.info.ro is false.
---@param timeout? number
function box.ctl.wait_rw(timeout) end

---Wait until box.info.ro is true.
---@param timeout? number
function box.ctl.wait_ro(timeout) end
