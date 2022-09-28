---@meta
--luacheck: ignore
--TODO:

local fio = {}

---Form a path name from one or more partial strings
function fio.pathjoin() end

---Get a file name
function fio.basename() end

---Get a directory name
function fio.dirname() end

---Get a directory and file name
function fio.abspath() end

---Check if file or directory exists
function fio.path.exists() end

---Check if file or directory is a directory
function fio.path.is_dir() end

---Check if file or directory is a file
function fio.path.is_file() end

---Check if file or directory is a link
function fio.path.is_link() end

---Check if file or directory exists
function fio.path.lexists() end

---Set mask bits
function fio.umask() end

---Get information about a file object
function fio.lstat() end

---Get information about a file object
function fio.stat() end

---Create directory
function fio.mkdir() end

---Delete a directory
function fio.rmdir()	end

---Change working directory
function fio.chdir() end

---List files in a directory
function fio.listdir() end

---Get files whose names match a given string
function fio.glob() end

---Get the name of a directory for storing temporary files
function fio.tempdir() end

---Get the name of the current working directory
function fio.cwd() end

---Create directories
function fio.copytree() end

------Create directories
function fio.mktree() end

---Delete directories
function fio.rmtree() end

---Create and delete links
function fio.link() end

---Create and delete links
function fio.symlink() end

---Create and delete links
function fio.readlink() end

---Create and delete links
function fio.unlink() end

---Rename a file or directory
function fio.rename() end

---Change file update time
function fio.utime() end

---Copy a file
function fio.copyfile() end

---Manage rights to and ownership of file objects
function fio.chown() end

---Manage rights to and ownership of file objects
function fio.chmod() end

---Reduce the file size
function fio.truncate() end

---Ensure that changes are written to disk
function fio.sync() end

---Open a file
function fio.open() end


---@class FileHandle
local file_handle = {}

---Close a file
function file_handle:close() end

---Perform random-access read on a file
function file_handle:pread() end

---Perform random-access write on a file
function file_handle:pwrite() end

---Perform non-random-access read on a file
function file_handle:read() end

---Perform non-random-access write on a file
function file_handle:write() end

---Change the size of an open file
function file_handle:truncate() end

---Change position in a file
function file_handle:seek() end

---Get statistics about an open file
function file_handle:stat() end

---Ensure that changes made to an open file are written to disk
function file_handle:fsync() end

---Ensure that changes made to an open file are written to disk
function file_handle:fdatasync() end

---@alias seek
---| 'SEEK_SET'
---| 'SEEK_DATA'
---| 'SEEK_HOLE'
---| 'SEEK_END'
---| 'SEEK_CUR'

---@alias mode
---| 'S_IWGRP'
---| 'S_IXGRP'
---| 'S_IROTH'
---| 'S_IXOTH'
---| 'S_IRUSR'
---| 'S_IXUSR'
---| 'S_IRWXU'
---| 'S_IRWXG'
---| 'S_IWOTH'
---| 'S_IRWXO'
---| 'S_IWUSR'
---| 'S_IRGRP'

---@alias flags
---| 'O_EXCL'
---| 'O_NONBLOCK'
---| 'O_RDONLY'
---| 'O_CLOEXEC'
---| 'O_SYNC'
---| 'O_NDELAY'
---| 'O_WRONLY'
---| 'O_TRUNC'
---| 'O_NOFOLLOW'
---| 'O_RDWR'
---| 'O_ASYNC'
---| 'O_CREAT'
---| 'O_APPEND'
---| 'O_DIRECTORY'
---| 'O_NOCTTY'


fio.c = {
    seek = {
        SEEK_SET = 0,
        SEEK_DATA = 4,
        SEEK_HOLE = 3,
        SEEK_END = 2,
        SEEK_CUR = 1,
    },
    mode = {
        S_IWGRP = 16,
        S_IXGRP = 8,
        S_IROTH = 4,
        S_IXOTH = 1,
        S_IRUSR = 256,
        S_IXUSR = 64,
        S_IRWXU = 448,
        S_IRWXG = 56,
        S_IWOTH = 2,
        S_IRWXO = 7,
        S_IWUSR = 128,
        S_IRGRP = 32,
    },
    flag = {
        O_EXCL = 2048,
        O_NONBLOCK = 4,
        O_RDONLY = 0,
        O_CLOEXEC = 16777216,
        O_SYNC = 128,
        O_NDELAY = 4,
        O_WRONLY = 1,
        O_TRUNC = 1024,
        O_NOFOLLOW = 256,
        O_RDWR = 2,
        O_ASYNC = 64,
        O_CREAT = 512,
        O_APPEND = 8,
        O_DIRECTORY = 1048576,
        O_NOCTTY = 131072,
    }
}

return fio
