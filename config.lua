configs = {
    {
        key    = 'Lua.runtime.version',
        action = 'set',
        value  = 'LuaJIT',
    },
    {
        key = 'Lua.diagnostics.globals',
        action = 'add',
        value = '_TARANTOOL',
    },
    {
        key = 'Lua.diagnostics.globals',
        action = 'remove',
        value = 'ngx',
    },
}
