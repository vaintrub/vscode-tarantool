---@meta
--luacheck: ignore

---@class Storage
local storage = {}

---@param cfg VshardCfg
---@param name string
function storage.cfg(cfg, name) end

function storage.info() end

function storage.call(bucket_id, mode, function_name, argument_list) end

---Wait until the dataset is synchronized on replicas
---@param timeout? number
---@return boolean?, VshardError?
function storage.sync(timeout) end

---Pin a bucket to a replicaset. Pinned bucket can not be sent
---even if is breaks the cluster balance.
---@param bucket_id integer Identifier of a bucket to pin.
---@return boolean?, VshardError?
function storage.bucket_pin(bucket_id) end

---Return a pinned bucket back into active state.
---@param bucket_id integer Identifier of a bucket to unpin.
---@return boolean?, VshardError?
function storage.bucket_unpin(bucket_id) end

---Ref shortcut for an obscure mode.
---@param bucket_id integer Identifier of a bucket to ref.
---@param mode 'read'|'write'
function storage.bucket_ref(bucket_id, mode) end

---Take Read-Only reference on the bucket identified by
---`bucket_id`. Under such reference a bucket can not be deleted
---from the storage. Its transfer still can start, but can not
---finish until ref == 0.
---@param bucket_id integer Identifier of a bucket to ref.
---@return boolean?, VshardError?
function storage.bucket_refro(bucket_id) end

---Same as bucket_refro, but more strict - the bucket transfer
---can not start until a bucket has such refs. And if the bucket
---is already scheduled for transfer then it can not take new RW
---refs. The rebalancer waits until all RW refs gone and starts transfer.
---@param bucket_id integer Identifier of a bucket to ref.
---@return boolean?, VshardError?
function storage.bucket_refrw(bucket_id) end

-- Unref shortcut for an obscure mode.
---@param bucket_id integer Identifier of a bucket to unref.
---@param mode 'read'|'write'
function storage.bucket_unref(bucket_id, mode) end

---Remove one RO reference.
---@param bucket_id integer Identifier of a bucket to unref.
---@return boolean?, BucketIsCorrupted?
function storage.bucket_unrefro(bucket_id) end

---Remove one RW reference.
---@param bucket_id integer Identifier of a bucket to unref.
---@return boolean?, BucketIsCorrupted?
function storage.bucket_unrefrw(bucket_id) end

---Disable rebalancing. Disabled rebalancer sleeps until it
---is enabled back. If not a rebalancer node is disabled, it does
---not sends its state to rebalancer.
function storage.rebalancer_disable() end

---Enable rebalancing. Disabled rebalancer sleeps until it
---is enabled back. If not a rebalancer node is disabled, it does
---not sends its state to rebalancer.
function storage.rebalancer_enable() end

---Check if this replicaset is locked. It means be invisible for the rebalancer.
---@return boolean
function storage.is_locked() end

---Check if a rebalancing is in progress. It is true, if the node
---applies routes received from a rebalancer node in the special fiber
---@return boolean
function storage.rebalancing_is_in_progress() end

---@param bucket_id? integer
---@return { [integer]: { id: integer, status: string, destination?: string, ref_ro?: integer, ref_rw?: integer, ro_lock: true|nil, rw_lock: true|nil } }
function storage.buckets_info(bucket_id) end

---Get number of buckets stored on this storage. Regardless of their state.
---@return integer
function storage.buckets_count() end

---List of sharded spaces.
---@return { [integer]: boxSpaceObject }
function storage.sharded_spaces() end

---Return information about bucket
---@param bucket_id integer
---@return { is_transfering?: boolean, id: integer, status: string, destination?: string }?, VshardError?
function storage.bucket_stat(bucket_id) end

---Receive bucket data. If the bucket is not presented here, it is created as RECEIVING.
---@param bucket_id integer Bucket to receive.
---@param from UUID from Source UUID
---@param data any
---@return boolean?, VshardError?
function storage.bucket_recv(bucket_id, from, data) end

---Delete data of a specified garbage bucket. If a bucket is not
---garbage, then force option must be set. A bucket is not deleted from _bucket space.
---@param bucket_id integer Identifier of a bucket to delete data from.
---@param opts? { force?: boolean }. Can contain only 'force' flag to delete a bucket regardless of is it garbage or not.
function storage.bucket_delete_garbage(bucket_id, opts) end

---Collect content of the readable bucket.
---@param bucket_id integer
---@return { [1]: string, [2]: box.tuple[] }[], WrongBucket?
function storage.bucket_collect(bucket_id) end

---Create bucket range manually for initial bootstrap, tests or
---emergency cases. Buckets id, id + 1, id + 2, ..., id + count
---are inserted.
---@param first_bucket_id integer Identifier of a first bucket in a range.
---@param count? integer Bucket range length to insert. By default is 1.
---@return boolean?, VshardError?
function storage.bucket_force_create(first_bucket_id, count) end

---Drop bucket manually for tests or emergency cases
---@param bucket_id integer
---@return boolean?
function storage.bucket_force_drop(bucket_id) end

---Send a bucket to other replicaset.
---@param bucket_id integer
---@param destination UUID other replicaset UUID
---@param opts? { timeout: number }
---@return boolean?, VshardError?
function storage.bucket_send(bucket_id, destination, opts) end

---Collect array of active bucket identifiers for discovery.
---@return integer[]
function storage.buckets_discovery() end

---Check all buckets of the host storage to have SENT or ACTIVE
---state, return active bucket count.
---return not `nil` Count of active buckets.
---return     `nil` Not SENT or not ACTIVE buckets were found.
---@return { bucket_active_count:integer, bucket_pinned_count: integer }?
function storage.rebalancer_request_state() end

---Immediately wakeup rebalancer, if it exists on the current node.
function storage.rebalancer_wakeup() end

return storage
