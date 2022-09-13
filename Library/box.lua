---@meta

---@class BoxCfg
---@field listen string|number URI to bind tarantool
---@field read_only boolean (default: false) should this instance be RO
---@field replication_connect_quorum number (default: _cluster:len()) required number of connected replicas to start bootstrap
---@field replication_connect_timeout number (default: 30) timeout in seconds to expect replicas in replication to fail bootstrap
---@field replication string[] list of URI of replicas to connect to
---@field election_mode string (default: off) enables RAFT. Possible values: candidate, voter, off
---@field replication_synchro_quorum string|number (default: 1) number or formula of synchro quorum. possible: "N/2+1"
---@field wal_dir string path to dir with xlogs
---@field work_dir string path to work dir of tarantool
---@field memtx_dir string path to dir with memtx snapshots
local box_cfg = {}


---@class BoxError
---@field PROC_LUA number
local box_error = {}


---@class BoxErrorObject
---@field public type string (usually ClientError)
---@field public base_type string (usually ClientError)
---@field public code number number of error
---@field public message any message of error given during `box.error.new`

---Instances new BoxError
---@param code_or_type number
---@param args any
---@return BoxErrorObject
function box_error.new(code_or_type, args) end

return {cfg = box_cfg, error = box_error}