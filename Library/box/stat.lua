---@meta
--luacheck: ignore

---@class BoxStatDefault
---@field total number
---@field rps number

---@class BoxStatDefaultWithCurrent:BoxStatDefault
---@field current number

---@class BoxStatNet
---@field SENT BoxStatDefault sent bytes to iproto
---@field RECEIVED BoxStatDefault received bytes from iproto
---@field CONNECTIONS BoxStatDefaultWithCurrent iproto connections statistics
---@field REQUESTS BoxStatDefaultWithCurrent iproto requests statistics

---@class BoxStat
---@field reset fun() # resets current statistics
---@field net fun(): BoxStatNet
---@overload fun(): BoxStatInfo

---@class BoxStatInfo
---@field INSERT BoxStatDefault
---@field DELETE BoxStatDefault
---@field SELECT BoxStatDefault
---@field REPLACE BoxStatDefault
---@field UPDATE BoxStatDefault
---@field UPSERT BoxStatDefault
---@field CALL BoxStatDefault
---@field EVAL BoxStatDefault
---@field AUTH BoxStatDefault
---@field ERROR BoxStatDefault

---@type BoxStat
box.stat = {}
