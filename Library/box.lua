---@meta
--luacheck: ignore

---@class box
---@field cfg BoxCfg
box = {}

---returns whether fiber is in transaction
---@return boolean is_in_txn
function box.is_in_txn() end

---@param box_cfg BoxCfg
---@return nil
function box.cfg(box_cfg) end

---@alias txn_isolation
---| 'best-effort'
---| 'read-committed'
---| 'read-confirmed'
---| 'linearizable'

---@class begin_options
---@field txn_isolation? txn_isolation the transaction isolation level (default: best-effort)
---@field timeout? number a timeout (in seconds), after which the transaction is rolled back

--- Begin the transaction. Disable implicit yields until the transaction ends.
--- Signal that writes to the write-ahead log will be deferred until the transaction ends.
--- In effect the fiber which executes box.begin() is starting an “active multi-request transaction”, blocking all other fibers
---
--- **Possible errors:**
---
---   - Error if this operation is not permitted because there is already an active transaction.
---
---   - Error if for some reason memory cannot be allocated.
---@param opts? begin_options
function box.begin(opts) end

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
---@return table|BoxErrorObject savepoint
function box.savepoint() end

--- Do not end the transaction, but cancel all its data-change and box.savepoint() operations that were done after the specified savepoint.
---
--- **Possible errors:**
---
--- * Error if the savepoint does not exist.
--- @param savepoint table
--- @return BoxErrorObject error
function box.rollback_to_savepoint(savepoint) end

---#if _TARANTOOL<2.10.0

--- Execute a function, acting as if the function starts with an implicit box.begin() and ends with an implicit box.commit()
---if successful, or ends with an implicit box.rollback() if there is an error.
---
--- **Possible errors:**
--- * Error and abort the transaction in case of a conflict.
--- * Error if the operation fails to write to disk.
--- * Error if for some reason memory cannot be allocated.
---@param tx_function fun(...: any): ...
---@param ... any
---@return ...? The result of the function passed to atomic() as an argument.
function box.atomic(tx_function, ...) end
---#else

---Starting with 2.10.1
---@param opts { txn_isolation: txn_isolation }
---@param tx_function fun(...: any): ...?
---@param ... any
---@return ...? The result of the function passed to atomic() as an argument.
function box.atomic(opts, tx_function, ...) end
---#end

---@alias onCommitIterator fun():(number, box.tuple|nil, box.tuple|nil, number) request_id, old_tuple, new_tuple, space_id

---@alias onCommitTriggerFunc fun(iterator: onCommitIterator?)

---@param trigger_func onCommitTriggerFunc
---@param old_trigger_func? onCommitTriggerFunc
function box.on_commit(trigger_func, old_trigger_func) end

---@alias boxIterator boxTableIterator

---@class boxTableIterator
---@field iterator? "GE"|"GT"|"LT"|"LE"|"EQ"|"REQ"|"BITS_ALL_NOT_SET"|"BITS_ALL_SET"|"BITS_ANY_SET"|"OVERLAPS"|"NEIGHBOR"|"ALL"|boxIndexIterator
---@field after string|nil? position in index (starting from Tarantool ≥ 2.11)

---@enum boxIndexIterator
box.index = {
  EQ = 0,
  REQ = 1,
  ALL = 2,
  LT = 3,
  LE = 4,
  GE = 5,
  GT = 6,
  BITS_ALL_SET = 7,
  BITS_ANY_SET = 8,
  BITS_ALL_NOT_SET = 9,
  OVERLAPS = 10,
  NEIGHBOR = 11,
}

---Execute a function, provided it has not been executed before.
---@param key string a value that will be checked
---@param fnc fun(...) function to be executed
---@vararg any ... arguments to the function
function box.once(key, fnc, ...) end

---@async
---Creates new snapshot of the data and executes checkpoint.gc process
function box.snapshot() end

---@class box.watcher
local watcher = {}

---unregisters the watcher
function watcher:unregister() end

---@since 2.10.0
---Update the value of a particular key and notify all key watchers of the update.
---@param key string
---@param value any
function box.broadcast(key, value) end

---2.10.0
---Subscribe to events broadcast by a local host.
---@param key string
---@param func fun(key: string, value: any)
---@return box.watcher
function box.watch(key, func) end

---@since 2.10.0
---Subscribe to events broadcast by a local host.
---
---Automatically unsubscribe when event is delivered
---@param key string
---@param func fun(key: string, value: any)
---@return box.watcher
function box.watch_once(key, func) end

return box
