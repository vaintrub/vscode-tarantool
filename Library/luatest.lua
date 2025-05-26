---@meta
---@module 'luatest'
---Tool for testing tarantool applications.
---Highlights:
---executable to run tests in directory or specific files,
---before/after suite hooks,
---before/after test group hooks,
---output capturing,
---helpers for testing tarantool applications,
---luacov integration.
--luacheck: ignore

---@class luatest
local luatest = {}

---Add after suite hook.
---@param func fun()
function luatest.after_suite(func) end

---Add before suite hook.
---@param func fun()
function luatest.before_suite(func) end

---
---@param name string?
---@param params? table[]
---@return luatest.group
function luatest.group(name, params) end

--#region assert

---Check that value is truthy.
---@generic T
---@param value? T`
---@param message? string
---@param ... any
---@return T
---@return any ...
function luatest.assert(value, message, ...) end

---Check that value is falsy.
---@param value any
---@param message? string
function luatest.assert_not(value, message) end

---Check that two floats are close by margin.
---@param actual number
---@param expected number
---@param margin number
---@param message string?
function luatest.assert_almost_equals(actual, expected, margin, message) end

---Checks that actual map includes expected one.
---@param actual table
---@param expected table
---@param message string?
function luatest.assert_covers(actual, expected, message) end

---Check that two values are equal.
---@param actual any
---@param expected any
---@param message? string
---@param deep_analysis? any
function luatest.assert_equals(actual, expected, message, deep_analysis) end

---Check that calling fn raises an error.
---@param func fun(...)
---@param ... any?
function luatest.assert_error(func, ...) end

---Check that calling fn raises an error that contains `expected_partial`
---@param expected_partial string
---@param func fun(...)
---@param ... any
function luatest.assert_error_msg_contains(expected_partial, func, ...) end

---Strips location info from message text.
---@param expected string
---@param func fun(...)
---@param ... any
function luatest.assert_error_msg_content_equals(expected, func, ...) end

---Checks full error: location and text.
---@param expected string
---@param func fun(...)
---@param ... any
function luatest.assert_error_msg_equals(expected, func, ...) end

---Check that calling fn raises an error that match `pattern`
---@param pattern string
---@param func fun(...)
---@param ... any
function luatest.assert_error_msg_matches(pattern, func, ...) end

luatest.assert_eval_to_false = luatest.assert_not
luatest.assert_eval_to_true = luatest.assert

---Compare numbers
---@param left number
---@param right number
---@param message? string
function luatest.assert_ge(left, right, message) end
---Compare numbers
---@param left number
---@param right number
---@param message? string
function luatest.assert_gt(left, right, message) end
---Compare numbers
---@param left number
---@param right number
---@param message? string
function luatest.assert_le(left, right, message) end
---Compare numbers
---@param left number
---@param right number
---@param message? string
function luatest.assert_lt(left, right, message) end

function luatest.assert_inf() end
function luatest.assert_minus_inf() end
function luatest.assert_minus_zero() end
function luatest.assert_not_inf() end
function luatest.assert_not_minus_inf() end
function luatest.assert_not_minus_zero() end
function luatest.assert_nan(value, message) end
function luatest.assert_not_nan() end
function luatest.assert_not_plus_inf() end
function luatest.assert_not_plus_zero() end
function luatest.assert_plus_inf() end
function luatest.assert_plus_zero() end

---Check that values are the same.
---@param actual any
---@param expected any
---@param message string?
function luatest.assert_is(actual, expected, message) end

---Check that values are not the same.
---@param actual any
---@param expected any
---@param message string?
function luatest.assert_is_not(actual, expected, message) end

---Checks that two tables contain the same items, irrespective of their keys.
---@param actual table
---@param expected table
---@param message? string
function luatest.assert_items_equals(actual, expected, message) end

---Checks that one table includes all items of another, irrespective of their keys.
---@param actual table
---@param expected table
---@param message string?
function luatest.assert_items_include(actual, expected, message) end

---Check that two floats are not close by margin
---@param actual number
---@param expected number
---@param margin number
---@param message? string
---@return boolean
function luatest.assert_not_almost_equals(actual, expected, margin, message) end

---Checks that map does not contain the other one.
---@param actual table
---@param expected table
---@param message string?
function luatest.assert_not_covers(actual, expected, message) end

---Check that two values are not equal.
---@param actual any
---@param expected any
---@param message? string
function luatest.assert_not_equals(actual, expected, message) end

---Case-sensitive strings comparison.
---@param actual string
---@param expected string
---@param is_pattern boolean?
---@param message string?
function luatest.assert_not_str_contains(actual, expected, is_pattern, message) end

---Case-sensitive strings comparison.
---@param value string
---@param expected string
---@param is_pattern boolean?
---@param message string?
function luatest.assert_str_contains(value, expected, is_pattern, message) end

---Case-insensitive strings comparison.
---@param value string
---@param expected string
---@param message string?
function luatest.assert_not_str_icontains(value, expected, message) end

---Case-insensitive strings comparison.
---@param value string
---@param expected string
---@param message string?
function luatest.assert_str_icontains(value, expected, message) end

---Verify a full match for the string.
---@param value string
---@param pattern string
---@param start number? default: 1
---@param final number? default: #value
---@param message string?
function luatest.assert_str_matches(value, pattern, start, final, message) end

---Check value’s type.
---@param value any
---@param expected_type string
---@param message? string
function luatest.assert_type(value, expected_type, message) end

--#endregion assert

---Stops a test due to a failure.
---@param message string
function luatest.fail(message) end

---Stops a test due to a failure if condition is met.
---@param condition any
---@param message string
function luatest.fail_if(condition, message) end

---Mark test as xfail.
---
---The xfail mark makes test results to be interpreted vice versa:
---it’s threated as passed when an assertion fails, and it fails if no errors are raised.
---
---It allows one to mark a test as temporarily broken due to a bug in some other component
---which can’t be fixed immediately.
---It’s also a good practice to keep xfail tests in sync with an issue tracker.
---
---XFail only applies to the errors raised by the luatest assertions. Regular Lua errors still cause the test failure.
---@param message string
function luatest.xfail(message) end

---Mark test as xfail if condition is met.
---@param condition any
---@param message string
function luatest.xfail_if(condition, message) end

---Skip a running test.
---@param message string
function luatest.skip(message) end

---Skip a running test if condition is met.
---@param condition any
---@param message string
function luatest.skip_if(condition, message) end

---Stops a test with a success.
function luatest.success() end

---Stops a test with a success if condition is met.
---@param condition any
function luatest.success_if(condition) end

---@class luatest.helpers
---@field RETRYING_TIMEOUT number default timeout
---@field RETRYING_DELAY number default delay
luatest.helpers = {}

---Builds Cartesian product of parameters
---@param vectors table<any,table>
---@return table[]
function luatest.helpers.matrix(vectors) end

---Keep calling fn until it returns without error.
---
---Default options are taken from helpers.RETRYING_TIMEOUT and helpers.RETRYING_DELAY
---@param config {timeout: number, delay: number}
---@param func fun(...)
---@param ... any
function luatest.helpers.retrying(config, func, ...) end

function luatest.helpers.uuid(a, ...) end

---@diagnostic disable: redundant-parameter
---@class luatest.group: { [string]: fun(cg?: table) } test_*
---Tests group.
---To add new example add function at key starting with test .
---Group hooks run always when test group is changed. So it may run multiple times when --shuffle option is used.
local group = {}

---Add callback to run once after all tests in the group.
---@param func fun(cg?: table)
function group.after_all(func) end

---Add callback to run once after all tests in the group when `param` met
---@param param table
---@param func fun(cg?: table)
function group.after_all(param, func) end

---Add callback to run after each test in the group.
---@param func fun(cg?: table)
function group.after_each(func) end

---Add callback to run after each test in the group when `param` met.
---@param param table
---@param func fun(cg?: table)
function group.after_each(param, func) end

---Add callback to run once before all tests in the group.
---@param func fun(cg?: table)
function group.before_all(func) end

---Add callback to run once before all tests in the group when `param` met.
---@param param table
---@param func fun(cg?: table)
function group.before_all(param, func) end

---Add callback to run before each test in the group.
---@param func fun(cg?: table)
function group.before_each(func) end

---Add callback to run before each test in the group when `param` met.
---@param param table
---@param func fun(cg?: table)
function group.before_each(param, func) end

---Add callback to run before named `test_name` test.
---@param test_name string
---@param func fun(cg?: table)
function group.before_test(test_name, func) end

---Add callback to run before named `test_name` test when `param` met.
---@param test_name string
---@param param table
---@param func fun(cg?: table)
function group.before_test(test_name, param, func) end

---Add callback to run after named `test_name` test.
---@param test_name string
---@param func fun(cg?: table)
function group.after_test(test_name, func) end

---Add callback to run after named `test_name` test when `param` met.
---@param test_name string
---@param param table
---@param func fun(cg?: table)
function group.after_test(test_name, param, func) end

---Class to manage Tarantool instances.
---@class luatest.server
---@field alias string
local server = {}

luatest.Server = server

---Build a listen URI based on the given server alias. For now, only UNIX sockets are supported.
---@param server_alias string
---@param extra_alias? string
---@return string
function server.build_listen_uri(server_alias, extra_alias) end

---Assert that the server follows the source node with the given ID.
---Meaning that it replicates from the remote node normally, and has already joined and subscribed.
---@param server_id number
function server:assert_follows_upstream(server_id) end

---Call remote function on the server by name.
---
---This is a shortcut for server.net_box:call()
---@param func_name string
---@param args table?
---@param options table?
---@return any ...
function server:call(func_name, args, options) end

---Clean the server’s working directory. Should be invoked only for a stopped server.
function server:clean() end

---Establish net.box connection. It’s available in net_box field.
function server:connect_net_box() end

---Stop the server and clean its working directory.
function server:drop() end

---Evaluate Lua code on the server.
---This is a shortcut for server.net_box:eval() .
---@param code string
---@param args table?
---@param options table?
---@return any ...
function server:eval(code, args, options) end

---Run given function on the server.
---
---Much like Server:eval , but takes a function instead of a string.
---The executed function must have no upvalues (closures).
---Though it may use global functions and modules (like box , os , etc.)
---@param func fun(...: any): ...
---@param args table?
---@param options table?
---@return any ...
function server:exec(func, args, options) end

---A simple wrapper around the Server:exec() method to get the box.cfg value from the server.
---@return BoxCfg
function server:get_box_cfg() end

---Get vclock acknowledged by another node to the current server.
---@param server_id number
---@return table<number, uint64_t>
function server:get_downstream_vclock(server_id) end

---Get the election term as seen by the server.
---@return number
function server:get_election_term() end

---Get ID of the server instance.
---@return number
function server:get_instance_id() end

---Get UUID of the server instance.
---@return string
function server:get_instance_uuid() end

---Get the synchro term as seen by the server.
---@return number
function server:get_synchro_queue_term() end

---Get the server’s own vclock, including the local component.
---@return table<number,uint64_t>
function server:get_vclock() end

---Search a string pattern in the server’s log file. If the server has crashed, opts.filename is required.
---@param pattern string String pattern to search in the server’s log file.
---@param bytes_num number? Number of bytes to read from the server’s log file. (optional)
---@param opts? { reset: boolean?, filename: string } Reset the result when Tarantool %d+.%d+.%d+-.*%d+-g.* pattern is found, which means that the server was restarted.Defaults to true
---Path to the server’s log file.Defaults to box.cfg.log . (optional)
---@return string?
function server:grep_log(pattern, bytes_num, opts) end

---@class luatest.server.http_request_options
---@field body string request body (optional)
---@field json any data to encode as JSON into request body (optional)
---@field http ClientHTTPRequestOptions other options for HTTP-client (optional)
---@field raise boolean raise error when status is not in 200..299. Default to true. (optional)

---Perform HTTP request.
---@param method string
---@param path string
---@param options luatest.server.http_request_options
---@return table
function server:http_request(method, path, options) end

---@class luatest.server.options
---@field command string? Executable path to run a server process with.Defaults to the internal server_instance.lua script.
---If a custom pathis provided, it should correctly process all env variables listed belowto make constructor parameters work. (optional)
---@field args table? Arbitrary args to run object.command with. (optional)
---@field env? table<string,string|number|boolean> Pass the given env variables into the server process. (optional)
---@field chdir? string Change to the given directory before runningthe server process. (optional)
---@field alias? string Alias for the new server and the value of the `TARANTOOL_ALIAS` env variable which is passed into the server process.Defaults to ‘server’.
---@field workdir string Working directory for the new server and thevalue of the TARANTOOL_WORKDIR env variable which is passed into theserver process.
---Defaults to <vardir>/<alias>-<random id>. (optional)
---@field datadir? string Directory path whose contents will be recursively copied into object.workdir during initialization. (optional)
---@field http_port? number Port for HTTP connection to the new server andthe value of the TARANTOOL_HTTP_PORT env variable which is passed intothe server process.
---Not supported in the default server_instance.lua script. (optional)
---@field net_box_port? number Port for the net.box connection to the newserver and the value of the TARANTOOL_LISTEN env variable which is passed into the server process. (optional)
---@field net_box_uri? string URI for the net.box connection to the newserver and the value of the TARANTOOL_LISTEN env variable which is passed into the server process. (optional)
---@field net_box_credentials? table Override the default credentials for the net.box connection to the new server.
---@field box_cfg? BoxCfg Extra options for box.cfg() and the value of the TARANTOOL_BOX_CFG env variable which is passed into the server process.

---Build a server object.
---@param options luatest.server.options
---@return luatest.server
function server:new(options) end

---Restart the server with the given parameters. Optionally waits until the server is ready.
---@param params luatest.server.options
---@param opts? { wait_until_ready: boolean? } Wait until the server is ready.Defaults to true unless a custom executable path was provided whilebuilding the server object
function server:restart(params, opts) end

---Start a server. Optionally waits until the server is ready.
---@param opts? { wait_until_ready: boolean? } Wait until the server is ready.Defaults to true unless a custom executable was provided while buildingthe server object. (optional)
function server:start(opts) end

---Stop the server. Waits until the server process is terminated.
function server:stop() end

return luatest
