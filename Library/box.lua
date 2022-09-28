---@meta
--luacheck: ignore

---@class box
---@field cfg BoxCfg
box = {}


---@param box_cfg BoxCfg
---@return nil
function box.cfg(box_cfg) end

---@alias txn_isolation
---| 'best-effort'
---| 'read-committed'
---| 'read-confirmed'

--- Begin the transaction. Disable implicit yields until the transaction ends.
--- Signal that writes to the write-ahead log will be deferred until the transaction ends.
--- In effect the fiber which executes box.begin() is starting an “active multi-request transaction”, blocking all other fibers
---
--- **Possible errors:**
---
---   - Error if this operation is not permitted because there is already an active transaction.
---
---   - Error if for some reason memory cannot be allocated.
---@param txn_isolation? { txn_isolation: txn_isolation }  (Default: 'best-effort') Transaction isolation level
function box.begin(txn_isolation) end

--- End the transaction, and make all its data-change operations permanent.
---
--- **Possible errors:**
---
--- - Error and abort the transaction in case of a conflict.
---
--- - Error if the operation fails to write to disk.
---
--- - Error if for some reason memory cannot be allocated.
function box.commit() end

--- End the transaction, but cancel all its data-change operations.
--- An explicit call to functions outside box.space that always yield, such as fiber.sleep() or fiber.yield(), will have the same effect.
function box.rollback() end

--TODO: BoxError не хватает корректной обработки
--- Return a descriptor of a savepoint (type = table), which can be used later by box.rollback_to_savepoint(savepoint).
--- Savepoints can only be created while a transaction is active, and they are destroyed when a transaction ends
---
--- **Possible errors:**
---
--- * Error if for some reason memory cannot be allocated.
---@return table|BoxError savepoint
function box.savepoint() end

--- Do not end the transaction, but cancel all its data-change and box.savepoint() operations that were done after the specified savepoint.
---
--- **Possible errors:**
--- 
--- * Error if the savepoint does not exist.
--- @param savepoint table
--- @return BoxError error
function box.rollback_to_savepoint(savepoint) end

--TODO: Возмодно лучше использовать generic
--- Execute a function, acting as if the function starts with an implicit box.begin() and ends with an implicit box.commit() if successful, or ends with an implicit box.rollback() if there is an error.
---
--- **Possible errors:**
--- * Error and abort the transaction in case of a conflict.
--- * Error if the operation fails to write to disk.
--- * Error if for some reason memory cannot be allocated.
---@param tx_function fun(...): any...
---@param func_args table
---@return any result The result of the function passed to atomic() as an argument.
function box.atomic(tx_function, func_args)


---@param trigger_func any
---@param old_trigger_func any
function box.on_commit(trigger_func, old_trigger_func)

return box
