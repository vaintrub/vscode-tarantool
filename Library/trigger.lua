---@meta
---To create the trigger, you need to:
--- 1. Provide an event name used to associate the trigger with.
--- 2. Define the trigger name.
--- 3. Provide a trigger handler function.

local trigger = {}

---@alias trigger_func fun(value: any)

---Registers trigger for event `event_name` under name `trigger_name`
---
---If other trigger is defined for the pair {event_name, trigger_name} it will be replaced
---@generic F:trigger_func
---@param event_name string
---@param trigger_name string
---@param func F
---@return F
function trigger.set(event_name, trigger_name, func) end

---Unregisters trigger with name `trigger_name` for event `event_name`
---@param event_name string
---@param trigger_name string
function trigger.del(event_name, trigger_name) end

---@alias trigger_generator (fun(): string, trigger_func)

---Returns Lua Generator for given `event_name`
---
---Usage:
---```lua
---for name, func in trigger.pairs('box.ctl.on_election') do ... end
---```
---@param event_name string
---@return trigger_generator, any? param
function trigger.pairs(event_name) end

---@param event_name? string
---@return table<string,{[1]: string, [2]: trigger_func }[]>
function trigger.info(event_name) end

---May raise exception if trigger raises an exception
---@param event_name string
---@param ... any arguments of the event
function trigger.call(event_name, ...) end

return trigger
