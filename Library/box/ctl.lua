---@meta
--luacheck: ignore

---@class boxCtl
box.ctl = {}

---Wait, then choose new replication leader.
---For synchronous transactions it is possible that a new leader
---will be chosen but the transactions of the old leader have not been completed.
---
---Therefore to finalize the transaction, the function box.ctl.promote() should be called,
---as mentioned in the notes for leader election.
---The old name for this function is box.ctl.clear_synchro_queue().
function box.ctl.promote() end

---Since version 2.10.0.
---Revoke the leader role from the instance.
function box.ctl.demote() end


---Wait until box.info.ro is false.
---@async
---@param timeout? number
function box.ctl.wait_rw(timeout) end

---Wait until box.info.ro is true.
---@async
---@param timeout? number
function box.ctl.wait_ro(timeout) end

function box.ctl.on_shutdown() end

---Since: 3.0.0.
---Make the instance a bootstrap leader of a replica set.
function box.ctl.make_bootstrap_leader() end

---Since version 2.5.3.
---Check whether the recovery process has finished.
---Until it has finished, space changes such as insert or update are not possible.
---@return boolean is_recovery_finished
function box.ctl.is_recovery_finished() end

---@alias box.ctl.recovery_state
--- | "snapshot_recovered" the node has recovered the snapshot files.
--- | "wal_recovered" the node has recovered the WAL files.
--- | "indexes_built" the node has built secondary indexes for memtx spaces.
---This stage might come before any actual data is recovered.
---This means that the indexes are available right after the first tuple is recovered.
--- | "synced" the node has synced with enough remote peers.
---This means that the node changes the state from orphan to running.

---@alias box.ctl.on_recover_state_trigger fun(state: box.ctl.recovery_state)

---Since: 2.11.0
---Create a trigger executed on different stages of a node recovery or initial configuration.
---Note that you need to set the box.ctl.on_recovery_state trigger
---before the initial box.cfg call.
---@param trigger box.ctl.on_recover_state_trigger
function box.ctl.on_recovery_state(trigger) end

---Since: 2.10.0
---Create a trigger executed every time the current state of a replicaset
---node in regard to leader election changes.
---The current state is available in the box.info.election table.
---@param trigger function
function box.ctl.on_election(trigger) end
