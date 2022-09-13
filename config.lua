name    = 'tarantool'

words   = {'box%.%w+'}

configs = {
    {
        key    = 'Lua.runtime.version',
        action = 'set',
        value  = 'LuaJIT',
    },
}
