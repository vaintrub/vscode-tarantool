---@meta
--luacheck: ignore
--TODO:

local digest = {}

function digest.sha512_hex(string) end
function digest.sha1_hex(string) end

digest.xxhash64 = {}
function digest.xxhash64.new() end

---Returns a number made with consistent hash.
---@param state number
---@param bucket number
---@return number
function digest.guava(state, bucket) end

---@param string string
---@return string
function digest.base64_decode(string) end

---@param string string
---@return string
function digest.sha384(string) end

digest.xxhash32 = {}
function digest.xxhash32.new() end

function digest.sha224(string) end

digest.aes256cbc = {}
function digest.aes256cbc.encrypt(string, key, iv) end
function digest.aes256cbc.decrypt(string, key, iv) end


function digest.urandom(integer) end
function digest.sha256_hex(string) end
function digest.sha512(string) end
function digest.crc32_update() end
function digest.sha256(string) end
function digest.md4(string) end
function digest.sha1(string) end
function digest.sha384_hex(string) end
function digest.md4_hex(string) end

digest.murmur = {}
digest.default_seed = 13
function digest.murmur.new() end

function digest.pbkdf2_hex() end

---Returns base64 encoding from a regular string.
---
---nopad – result must not include ‘=’ for padding at the end,
---
---nowrap – result must not include line feed for splitting lines after 72 characters,
---
---urlsafe – result must not include ‘=’ or line feed, and may contain ‘-‘ or ‘_’ instead of ‘+’ or ‘/’ for positions 62 and 63 in the index table.
---@param string_variable string
---@param b64opts? { nopad: boolean, nowrap: boolean, urlsafe: boolean }
function digest.base64_encode(string_variable, b64opts) end

digest.crc32 = {}
digest.crc32.crc_begin = 4294967295
function digest.crc32.new() end

function digest.pbkdf2() end
function digest.md5_hex(string) end
function digest.sha224_hex(string) end
function digest.md5(string) end


return digest
