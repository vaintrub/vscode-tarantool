---@meta
--luacheck: ignore

---@alias BoxInfoStatusRunning "running" the instance is loaded
---@alias BoxInfoStatusLoading "loading" the instance is either recovering xlogs/snapshots or bootstrapping
---@alias BoxInfoStatusOrphan "orphan" the instance has not (yet) succeeded in joining the required number of masters
---@alias BoxInfoStatusHotStandBy "hot_standby" the instance is standing by another instance

---@alias BoxInfoElectionStateLeader "leader"
---@alias BoxInfoElectionStateFollower "follower"
---@alias BoxInfoElectionStateCandidate "candidate"

---@class BoxInfoElection
---@field public state BoxInfoElectionStateLeader | BoxInfoElectionStateFollower | BoxInfoElectionStateCandidate election state (mode) of the node
---@field public vote integer ID of a node the current node votes for. If the value is 0, it means the node hasn’t voted in the current term yet.
---@field public leader integer  leader node ID in the current term. If the value is 0, it means the node doesn’t know which node is the leader in the current term.
---@field public term integer current election term.

---@class BoxInfoCluster
---@field public uuid string replicaset_uuid of the replicaset this instance belong

---@class BoxInfoSynchroQueue
---@field public owner integer ID of the replica that owns the synchronous transaction queue.
---@field public term integer current queue term.
---@field public len integer the number of entries that are currently waiting in the queue.
---@field public busy boolean the instance is processing or writing some system request that modifies the queue

---@class BoxInfoSynchro
---@field public queue BoxInfoSynchroQueue
---@field public quorum integer the resulting value of the replication_synchro_quorum configuration option.

---@class BoxInfo: table
---The box.info submodule provides access to information about server instance variables.
---@field public id integer is a short numeric identifier of instance n within the replica set. This value is stored in the box.space._cluster system space.
---@field public uuid string is a globally unique identifier of instance n.
---@field public pid integer is the process ID.
---@field public listen string real address to which an instance was bound.
---@field public uptime integer is the number of seconds since the instance started.
---@field public status BoxInfoStatusRunning | BoxInfoStatusLoading | BoxInfoStatusOrphan | BoxInfoStatusHotStandBy is the current state of the instance.
---@field public lsn integer is the log sequence number (LSN) for the latest entry in instance n’s write ahead log (WAL)
---@field public version string is the Tarantool version
---@field public schema_version integer database schema version.
---@field public ro boolean is true if the instance is in “read-only” mode
---@field public package string
---@field public vclock integer[] is a table with the vclock values of all instances in a replica set which have made data changes.
---@field public replication table<integer,ReplicaInfo>
---@field public replication_anon { count: integer } list all the anonymous replicas following the instance.
---@field public election BoxInfoElection shows the current state of a replica set node regarding leader election
---@field public signature integer is the sum of all lsn values from each vector clock (vclock) for all instances in the replica set
---@field public cluster BoxInfoCluster
---@field public synchro BoxInfoSynchro
---@field public ro_reason string
---@overload fun(): BoxInfo
box.info = {}

---@class ReplicaInfo
---@field public id integer is a short numeric identifier of instance n within the replica set
---@field public uuid string is a globally unique identifier of instance n
---@field public lsn integer is the log sequence number (LSN) for the latest entry in instance n’s write ahead log (WAL)
---@field public upstream UpstreamInfo|nil
---@field public downstream DownstreamInfo|nil

---@return { [string]: ReplicaInfo }
function box.info.replication_anon() end

---@alias UpstreamStatusAuth "auth" means that authentication is happening.
---@alias UpstreamStatusConnecting "connecting" means that connection is happening.
---@alias UpstreamStatusDisconected "disconected" means that it is not connected to the replica set (due to network problems, not replication errors)
---@alias UpstreamStatusFollow "follow" means that the current instance’s role is “replica” (read-only, or not read-only but acting as a replica for this remote peer in a master-master configuration), and is receiving or able to receive data from instance n’s (upstream) master
---@alias UpstreamStatusStopped "stopped" means that replication was stopped due to a replication error (for example duplicate key).
---@alias UpstreamStatusSync "sync" means that the master and replica are synchronizing to have the same data.

---@alias DownstreamStatusFollow "follow" means that downstream replication is in progress
---@alias DownstreamStatusStopped "stopped" means that downstream replication has stopped

---@class UpstreamInfo
---@field public peer string contains instance n’s URI for example 127.0.0.1:3302.
---@field public status UpstreamStatusAuth | UpstreamStatusConnecting | UpstreamStatusDisconected | UpstreamStatusFollow | UpstreamStatusStopped | UpstreamStatusSync
---@field public idle number is the time (in seconds) since the last event was received. This is the primary indicator of replication health
---@field public lag number is the time difference between the local time of instance n, recorded when the event was received, and the local time at another master recorded when the event was written to the write ahead log on that master
---@field public message string|nil contains an error message in case of a degraded state, otherwise it is nil.

---@class DownstreamInfo
---appears (is not nil) with data about an instance that is following instance n or is intending to follow it
---@field public status DownstreamStatusFollow | DownstreamStatusStopped
---@field public idle number is the time (in seconds) since the last time that instance n sent events through the downstream replication
---@field public lag number is the time difference between the local time at the master node, recorded when a particular transaction was written to the write ahead log, and the local time recorded when it receives an acknowledgement for this transaction from a replica
---@field public vclock integer[] may be the same as the current instance’s vclock
---@field public message string|nil
---@field public system_message string|nil

---@class BoxInfoMemory
---@field public cache number number of bytes used for caching user data. The memtx storage engine does not require a cache, so in fact this is the number of bytes in the cache for the tuples stored for the vinyl storage engine.
---@field public data number number of bytes used for storing user data (the tuples) with the memtx engine and with level 0 of the vinyl engine, without taking memory fragmentation into account.
---@field public index number number of bytes used for indexing user data, including memtx and vinyl memory tree extents, the vinyl page index, and the vinyl bloom filters.
---@field public lua number number of bytes used for Lua runtime.
---@field public net number number of bytes used for network input/output buffers.
---@field public tx number number of bytes in use by active transactions. For the vinyl storage engine, this is the total size of all allocated objects (struct txv, struct vy_tx, struct vy_read_interval) and tuples pinned for those objects.

---The memory function of box.info gives the admin user a picture of the whole Tarantool instance.
---@return BoxInfoMemory
function box.info.memory() end

---@class BoxInfoGCCheckpoint
---@field public references table[] a list of references to a checkpoint
---@field public vclock integer[] a checkpoint’s vclock value
---@field public signature integer a sum of a checkpoint’s vclock’s components

---@class BoxInfoGC
---@field public vclock integer[] the garbage collector’s vclock
---@field public signature integer the sum of the garbage collector’s checkpoint’s components
---@field public checkpoint_is_in_progress boolean true if a checkpoint is in progress, otherwise false
---@field public consumers table[] a list of users whose requests might affect the garbage collector
---@field public checkpoints BoxInfoGCCheckpoint[] a list of preserved checkpoints

---The gc function of box.info gives the admin user a picture of the factors that affect the Tarantool garbage collector. The garbage collector compares vclock (vector clock) values of users and checkpoints, so a look at box.info.gc() may show why the garbage collector has not removed old WAL files, or show what it may soon remove.
---@return BoxInfoGC
function box.info.gc() end
