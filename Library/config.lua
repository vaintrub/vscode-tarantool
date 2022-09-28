---@meta

---@class LoadedConfig
---@field public box BoxCfg config of box.cfg
---@field public etcd EtcdCfg config of etcd connector
---@field public app table application cfg
---@field public sys config system configuration


---@class EtcdCfg
---@field endpoints string[] http URI to etcd nodes
---@field prefix string (required) prefix in etcd of cluster configuration
---@field instance_name string (required) name of the instance
---@field login string (optional) username to etcd
---@field password string (optional) password to etcd
---@field boolean_auto boolean (default: false) casts each string 'true' and 'false' to boolean
---@field print_config boolean (default: false) prints loaded etcd config after first fetch
---@field uuid string (default: nil) if uuid == 'auto' config autogenerates instance_uuid/replicaset_uuid from instance_name

---@class config
---@field public file string path to file with conf.lua
---@field public mkdir boolean (default:false) flag which enables creation dirs for tarantool application
---@field public instance_name string name of the instance
---@field public default_readonly boolean (default: false) sets read_only=default_read_only for `etcd.instance.read_only` if cfg.read_only not specified
---@field public master_selection_policy string (for ETCD only) sets `etcd.cluster.master` if /clusters/ found otherwise sets `etcd.instance.single`
---@field public bypass_non_dynamic boolean disables checks for dynamic changes in box.cfg (default: false)
---@field public tidy_load boolean (default: true) for ETCD only: runs box.cfg{read_only=true} if instance already bootstrapped
---@field public wrap_box_cfg fun(cfg: BoxCfg) wrapper instead box.cfg performing tidy_load
---@field public boxcfg fun(cfg: BoxCfg) callback to call instead tidy_load and other logic
---@field public on_load fun(conf: config, cfg: LoadedConfig) callback to be called each time cfg changes
---@field public on_before_cfg fun(conf: config, cfg: LoadedConfig) callback to be called right before instance bootstrap (before mkdir) or recovery (once)
---@field public on_after_cfg fun(conf: config, cfg: LoadedConfig) callback will be called after box completely configured (once)
local conf = {}

return conf