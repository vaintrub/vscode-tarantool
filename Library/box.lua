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

--TODO: Возможно лучше использовать generic
--- Execute a function, acting as if the function starts with an implicit box.begin() and ends with an implicit box.commit() if successful, or ends with an implicit box.rollback() if there is an error.
---
--- **Possible errors:**
--- * Error and abort the transaction in case of a conflict.
--- * Error if the operation fails to write to disk.
--- * Error if for some reason memory cannot be allocated.
---@generic T
---@param tx_function fun(...: any): ...: T
---@param ... any
---@return ...? The result of the function passed to atomic() as an argument.
function box.atomic(tx_function, ...) end

---@param trigger_func fun()
---@param old_trigger_func fun()
function box.on_commit(trigger_func, old_trigger_func) end

---@alias boxIterator boxTableIterator

---@class boxTableIterator
---@field iterator "GE"|"GT"|"LT"|"LE"|"EQ"|"REQ"|"BITS_ALL_NOT_SET"|"BITS_ALL_SET"|"BITS_ANY_SET"|"OVERLAPS"|"NEIGHBOR"|"ALL"|boxIndexIterator

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

---When called without arguments, box.error() re-throws whatever the last error was.
---@return BoxErrorObject
function box.error() end

---Throw an error. When called with a Lua-table argument, the code and reason have any user-desired values. The result will be those values.
---@param err { reason: string, code: number? } reason is description of an error, defined by user; code is numeric code for this error, defined by user
---@return BoxErrorObject
function box.error(err) end

---Throw an error. This method emulates a request error, with text based on one of the pre-defined Tarantool errors defined in the file errcode.h in the source tree.
---@param code number number of a pre-defined error
---@param errtext string part of the message which will accompany the error
---@param ... string part of the message which will accompany the error
function box.error(code, errtext, ...) end

---@class BoxErrorObject: ffi.cdata*
---@field type string (usually ClientError)
---@field base_type string (usually ClientError)
---@field code number number of error
---@field message any message of error given during `box.error.new`
local box_error_object = {}

---@class BoxErrorTrace
---@field file string Tarantool source file
---@field line number Tarantool source file line number

---@class BoxErrorObjectTable
---@field code number error’s number
---@field type string error’s C++ class
---@field message string error’s message
---@field base_type string usually ClientError or CustomError
---@field custom_type string? present if custom ErrorType was passed
---@field trace BoxErrorTrace[]? backtrace

---@return BoxErrorObjectTable
function box_error_object:unpack() end

---Raises error
function box_error_object:raise() end

---Instances new BoxError
---@param code number number of a pre-defined error
---@param errtxt string part of the message which will accompany the error
---@return BoxErrorObject
function box.error.new(code, errtxt, ...) end

---Instances new BoxError
---@param err { reason: string, code: number?, type: string? } custom error
---@return BoxErrorObject
function box.error.new(err) end

---@return BoxErrorObject
function box.error.last() end

return box
