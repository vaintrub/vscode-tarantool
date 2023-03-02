---@meta
--luacheck: ignore


---@class Storage
local storage = {}


---@param cfg VshardCfg
---@param name string
function storage.cfg(cfg, name) end

function storage.info() end

function storage.call(bucket_id, mode, function_name, argument_list) end

function storage.sync(timeout) end

function storage.bucket_pin(bucket_id) end

function storage.bucket_unpin(bucket_id) end

function storage.bucket_ref(bucket_id, mode) end

function storage.bucket_refro() end

function storage.bucket_refrw() end

function storage.bucket_unref(bucket_id, mode) end

function storage.bucket_unrefro() end

function storage.bucket_unrefrw() end

function storage.find_garbage_bucket(bucket_index, control) end

function storage.rebalancer_disable() end

function storage.rebalancer_enable() end

function storage.is_locked() end

function storage.rebalancing_is_in_progress() end

function storage.buckets_info() end

function storage.buckets_count() end

function storage.sharded_spaces() end


-- Storage internal API
function storage.bucket_stat(bucket_id) end

function storage.bucket_recv(bucket_id, from, data) end

function storage.bucket_delete_garbage(bucket_id) end

function storage.bucket_collect(bucket_id) end

function storage.bucket_force_create(first_bucket_id, count) end

function storage.bucket_force_drop(bucket_id, to) end

function storage.bucket_send(bucket_id, to) end

function storage.buckets_discovery() end

function storage.rebalancer_request_state() end

return storage
