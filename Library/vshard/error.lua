---@meta
--luacheck: ignore

local error = {}

---@alias VshardErrCode
---| 1 #  WRONG_BUCKET
---| 2 #  NON_MASTER
---| 3 #  BUCKET_ALREADY_EXISTS
---| 4 #  NO_SUCH_REPLICASET
---| 5 #  MOVE_TO_SELF
---| 6 #  MISSING_MASTER
---| 7 #  TRANSFER_IS_IN_PROGRESS
---| 8 #  UNREACHABLE_REPLICASET
---| 9 #  NO_ROUTE_TO_BUCKET
---| 10 # NON_EMPTY
---| 11 # UNREACHABLE_MASTER
---| 12 # OUT_OF_SYNC
---| 13 # HIGH_REPLICATION_LAG
---| 14 # UNREACHABLE_REPLICA
---| 15 # LOW_REDUNDANCY
---| 16 # INVALID_REBALANCING
---| 17 # SUBOPTIMAL_REPLICA
---| 18 # UNKNOWN_BUCKETS
---| 19 # REPLICASET_IS_LOCKED
---| 20 # OBJECT_IS_OUTDATED
---| 21 # ROUTER_ALREADY_EXISTS
---| 22 # BUCKET_IS_LOCKED
---| 23 # INVALID_CFG
---| 24 # BUCKET_IS_PINNED
---| 25 # TOO_MANY_RECEIVING
---| 26 # STORAGE_IS_REFERENCED
---| 27 # STORAGE_REF_ADD
---| 28 # STORAGE_REF_USE
---| 29 # STORAGE_REF_DEL
---| 30 # BUCKET_RECV_DATA_ERROR
---| 31 # MULTIPLE_MASTERS_FOUND
---| 32 # REPLICASET_IN_BACKOFF
---| 33 # STORAGE_IS_DISABLED
---| 34 # BUCKET_IS_CORRUPTED
---| 35 # ROUTER_IS_DISABLED
---| 36 # BUCKET_GC_ERROR
---| 37 # STORAGE_CFG_IS_IN_PROGRESS
---| 38 # ROUTER_CFG_IS_IN_PROGRESS

---@alias ShardingErrors
---| WrongBucket
---| NonMaster
---| NoSuchReplicaset
---| MoveToSelf
---| MissingMaster
---| TransferIsInProgress
---| UnreachableReplicaset
---| NoRouteToBucket
---| NonEmpty
---| UnreachableMaster
---| OutOfSync
---| HighReplicationLag
---| UnreachableReplica
---| LowRedundancy
---| InvalidRebalancing
---| SuboptimalReplica
---| UnknownBuckets
---| ReplicasetIsLocked
---| ObjectIsOutdated
---| BucketIsLocked
---| InvalidCfg
---| BucketIsPinned
---| TooManyReceiving
---| StorageIsReferenced
---| StorageRefAdd
---| StorageRefUse
---| StorageRefDel
---| BucketRecvDataError
---| MultipleMastersFound
---| ReplicasetInBackoff
---| StorageIsDisabled
---| BucketIsCorrupted
---| RouterIsDisabled
---| BucketGcError
---| StorageCfgIsInProgress
---| RouterCfgIsInProgress

--- It is created on sharding errors like
--- replicaset unavailability, master absence etc. It has type =
--- 'ShardingError'.
---@class VshardError
---@field message string
---@field type "ShardingError"
---@field code VshardErrCode
---@field name string

---@class WrongBucket: VshardError
---@field name "WRONG_BUCKET"
---@field code 1
---@field bucket_id number
---@field reason string
---@field destination string

---@class NonMaster: VshardError
---@field name "NON_MASTER"
---@field code 2
---@field replica_uuid UUID
---@field replicaset_uuid UUID
---@field master_uuid UUID

---@class BucketAlreadyExists: VshardError
---@field name "BUCKET_ALREADY_EXISTS"
---@field code 3
---@field bucket_id number

---@class NoSuchReplicaset: VshardError
---@field name "NO_SUCH_REPLICASET"
---@field code 4
---@field replicaset_uuid UUID

---@class MoveToSelf: VshardError
---@field name "MOVE_TO_SELF"
---@field code 5
---@field bucket_id number
---@field replicaset_uuid UUID

---@class MissingMaster: VshardError
---@field name "MISSING_MASTER"
---@field code 6
---@field replicaset_uuid UUID

---@class TransferIsInProgress: VshardError
---@field name "TRANSFER_IS_IN_PROGRESS"
---@field code 7
---@field destination string
---@field bucket_id number

---@class UnreachableReplicaset: VshardError
---@field name "UNREACHABLE_REPLICASET"
---@field code 8
---@field unreachable_uuid UUID
---@field bucket_id number

---@class NoRouteToBucket: VshardError
---@field name "NO_ROUTE_TO_BUCKET"
---@field code 9
---@field bucket_id number

---@class NonEmpty: VshardError
---@field name "NON_EMPTY"
---@field code 10

---@class UnreachableMaster: VshardError
---@field name "UNREACHABLE_MASTER"
---@field code 11
---@field reason string
---@field uuid UUID

---@class OutOfSync: VshardError
---@field name "OUT_OF_SYNC"
---@field code 12

---@class HighReplicationLag: VshardError
---@field name "HIGH_REPLICATION_LAG"
---@field code 13
---@field lag number

---@class UnreachableReplica: VshardError
---@field name "UNREACHABLE_REPLICA"
---@field code 14
---@field unreachable_uuid UUID

---@class LowRedundancy: VshardError
---@field name "LOW_REDUNDANCY"
---@field code 15

---@class InvalidRebalancing: VshardError
---@field name "INVALID_REBALANCING"
---@field code 16

---@class SuboptimalReplica: VshardError
---@field name "SUBOPTIMAL_REPLICA"
---@field code 17

---@class UnknownBuckets: VshardError
---@field name "UNKNOWN_BUCKETS"
---@field code 18
---@field not_discovered_cnt number

---@class ReplicasetIsLocked: VshardError
---@field name "REPLICASET_IS_LOCKED"
---@field code 19

---@class ObjectIsOutdated: VshardError
---@field name "OBJECT_IS_OUTDATED"
---@field code 20

---@class RouterAlreadyExists: VshardError
---@field name "ROUTER_ALREADY_EXISTS"
---@field code 21
---@field router_name string

---@class BucketIsLocked: VshardError
---@field name "BUCKET_IS_LOCKED"
---@field code 22
---@field bucket_id number

---@class InvalidCfg: VshardError
---@field name "INVALID_CFG"
---@field code 23
---@field reason string

---@class BucketIsPinned: VshardError
---@field name "BUCKET_IS_PINNED"
---@field code 24
---@field bucket_id number

---@class TooManyReceiving: VshardError
---@field name "TOO_MANY_RECEIVING"
---@field code 25

---@class StorageIsReferenced: VshardError
---@field name "STORAGE_IS_REFERENCED"
---@field code 26

---@class StorageRefAdd: VshardError
---@field name "STORAGE_REF_ADD"
---@field code 27
---@field reason string

---@class StorageRefUse: VshardError
---@field name "STORAGE_REF_USE"
---@field code 28
---@field reason string

---@class StorageRefDel: VshardError
---@field name "STORAGE_REF_DEL"
---@field code 29
---@field reason string

---@class BucketRecvDataError: VshardError
---@field name "BUCKET_RECV_DATA_ERROR"
---@field code 30
---@field bucket_id number
---@field space string
---@field tuple table
---@field reason string

---@class MultipleMastersFound: VshardError
---@field name "MULTIPLE_MASTERS_FOUND"
---@field code 31
---@field replicaset_uuid UUID
---@field master1 string
---@field master2 string

---@class ReplicasetInBackoff: VshardError
---@field name "REPLICASET_IN_BACKOFF"
---@field code 32
---@field replicaset_uuid UUID
---@field error table

---@class StorageIsDisabled: VshardError
---@field name "STORAGE_IS_DISABLED"
---@field code 33

--- That is similar to WRONG_BUCKET, but the latter is not critical. It
--- usually can be retried. Corruption is a critical error, it requires
--- more attention.
---@class BucketIsCorrupted: VshardError
---@field name "BUCKET_IS_CORRUPTED"
---@field code 34
---@field reason string

---@class RouterIsDisabled: VshardError
---@field name "ROUTER_IS_DISABLED"
---@field code 35
---@field reason string

---@class BucketGcError: VshardError
---@field name "BUCKET_GC_ERROR"
---@field code 36
---@field reason string

---@class StorageCfgIsInProgress: VshardError
---@field name "STORAGE_CFG_IS_IN_PROGRESS"
---@field code 37

---@class RouterCfgIsInProgress: VshardError
---@field name "ROUTER_CFG_IS_IN_PROGRESS"
---@field code 38
---@field router_name string

error.code = {
    WRONG_BUCKET = 1,
    NON_MASTER = 2,
    BUCKET_ALREADY_EXISTS = 3,
    NO_SUCH_REPLICASET = 4,
    MOVE_TO_SELF = 5,
    MISSING_MASTER = 6,
    TRANSFER_IS_IN_PROGRESS = 7,
    UNREACHABLE_REPLICASET = 8,
    NO_ROUTE_TO_BUCKET = 9,
    NON_EMPTY = 10,
    UNREACHABLE_MASTER = 11,
    OUT_OF_SYNC = 12,
    HIGH_REPLICATION_LAG = 13,
    UNREACHABLE_REPLICA = 14,
    LOW_REDUNDANCY = 15,
    INVALID_REBALANCING = 16,
    SUBOPTIMAL_REPLICA = 17,
    UNKNOWN_BUCKETS = 18,
    REPLICASET_IS_LOCKED = 19,
    OBJECT_IS_OUTDATED = 20,
    ROUTER_ALREADY_EXISTS = 21,
    BUCKET_IS_LOCKED = 22,
    INVALID_CFG = 23,
    BUCKET_IS_PINNED = 24,
    TOO_MANY_RECEIVING = 25,
    STORAGE_IS_REFERENCED = 26,
    STORAGE_REF_ADD = 27,
    STORAGE_REF_USE = 28,
    STORAGE_REF_DEL = 29,
    BUCKET_RECV_DATA_ERROR = 30,
    MULTIPLE_MASTERS_FOUND = 31,
    REPLICASET_IN_BACKOFF = 32,
    STORAGE_IS_DISABLED = 33,
    BUCKET_IS_CORRUPTED = 34,
    ROUTER_IS_DISABLED = 35,
    BUCKET_GC_ERROR = 36,
    STORAGE_CFG_IS_IN_PROGRESS = 37,
    ROUTER_CFG_IS_IN_PROGRESS = 38,
}

--- Unpacking and and adding serialization meta table to json
---@param err BoxErrorObject
---@return BoxErrorObject
function error.box(err) end

-- Construct an vshard error.
---@param code VshardErrCode Vshard error code
---@param ... any From `error_message_template` `args` field. Caller have to pass at least as many arguments as `msg` field requires.
---@return VshardError
function error.vshard(code, ...) end

-- Convert error object from pcall to lua, box or vshard error object.
---@param err any
---@return VshardError|BoxErrorObject
function error.make(err) end

--- Restore an error object from its string serialization.
---@param err_str string
---@return VshardError
function error.from_string(err_str) end

---Make alert message
---@param code number
---@param ... any
---@return table
function error.alert(code, ...) end

--- Create a timeout error object
---@return BoxErrorObject
function error.timeout() end

return error
