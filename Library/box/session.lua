---@meta
--luacheck: ignore

---@class boxSession: table
box.session = {}

---the unique identifier (ID) for the current session. The result can be 0 or -1 meaning there is no session.
---@return number
function box.session.id() end


---Checks if session exists
---@param id number
---@return boolean exists true if the session exists, false if the session does not exist.
function box.session.exists(id) end

---This function works only if there is a peer, that is, if a connection has been made to a separate Tarantool instance.
---@param id? number
---@return string|nil peer The host address and port of the session peer, for example “127.0.0.1:55457”.
function box.session.peer(id) end

---the value of the sync integer constant used in the binary protocol. This value becomes invalid when the session is disconnected.
---@return number
function box.session.sync() end

---@return string user the name of current user
function box.session.user() end

---@alias SessionType
---| "binary"     # if the connection was done via the binary protocol
---| "console"    # if the connection was done via the administrative console
---| "repl"       # if the connection was done directly
---| "applier"    # if the action is due to replication, regardless of how the connection was done
---| "background" # if the action is in a background fiber

---@return SessionType
function box.session.type() end

---Change Tarantool’s current user – this is analogous to the Unix command su.
---@param user string name of a target user
---@param func? string name of a function, or definition of a function
---@return any? ... result of the function
function box.session.su(user, func) end

---@return number uid the user ID of the current user.
function box.session.uid() end

---The first case: if the call to box.session.euid() is within a function invoked by box.session.su(user-name, function-to-execute) – in that case, box.session.euid() returns the ID of the changed user (the user who is specified by the user-name parameter of the su function) but box.session.uid() returns the ID of the original user (the user who is calling the su function).
---The second case: if the call to box.session.euid() is within a function specified with box.schema.func.create(function-name, {setuid= true}) and the binary protocol is in use – in that case, box.session.euid() returns the ID of the user who created “function-name” but box.session.uid() returns the ID of the the user who is calling “function-name”.
---@return number euid the effective user ID of the current user.
function box.session.euid() end

---@type table<number|string,any>
---A Lua table that can hold arbitrary unordered session-specific names and values, which will last until the session ends.
box.session.storage = {}

---Define a trigger for execution when a new session is created due
---@param trigger_func fun()
---@param old_trigger_func fun()
---@return fun()? removed_trigger If the parameters are (nil, old-trigger-function), then the old trigger is deleted.
function box.session.on_connect(trigger_func, old_trigger_func) end

---@param trigger_func fun()
---@param old_trigger_func fun()
---@return fun()? removed_trigger If the parameters are (nil, old-trigger-function), then the old trigger is deleted.
function box.session.on_disconnect(trigger_func, old_trigger_func) end

---@param trigger_func fun()
---@param old_trigger_func fun()
---@return fun()? removed_trigger If the parameters are (nil, old-trigger-function), then the old trigger is deleted.
function box.session.on_auth(trigger_func, old_trigger_func) end

---@param trigger_func fun()
---@param old_trigger_func fun()
---@return fun()? removed_trigger If the parameters are (nil, old-trigger-function), then the old trigger is deleted.
function box.session.on_access_denied(trigger_func, old_trigger_func) end

---Generate an out-of-band message.
---@param message tuple_type what to send
---@param sync? number deprecated
function box.session.push(message, sync) end
