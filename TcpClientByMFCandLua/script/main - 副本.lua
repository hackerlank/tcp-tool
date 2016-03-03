-- set search path
package.path = 'script/?.lua;' 


local config = require("config")
local net = require("util.net")
require("modulemgr")
------------------------------------------------------------------------------
-- The method must be implemented
------------------------------------------------------------------------------
local username = "1111"

function on_connect()
	print("on connect!!!")
	-- {m=5002,p = {plat=0, token= "1111"}}
	modulemgr:send(5002, {plat=0, token= username})
end

function on_disconnect()
	print("on disconnect!!!")
end

function on_recv(buf)
	print("on recv")
	net:on_recv(buf)
end


function on_send(proto, buf)
	print("on_send", buf)
	local data = load("return " .. buf)()
	if type(data) == "table" then
		net:send(data)
	else
		print("params is not table type!!!")
	end
end

function on_heart()
	-- print("on heart")
end

function on_get_proto_list()
	local result = {}
	result["MessagePack"] = "MessagePack"
	return result
end

function send_string(str, len)
	print("send_string", str, len)
	sendString(str)
end
--------------------------------------------------------------------------------
function require_ex( _mname )
  -- print( string.format("require_ex = %s", _mname) )
  	if package.loaded[_mname] then
    	-- print( string.format("require_ex module[%s] reload", _mname))
	end
	package.loaded[_mname] = nil
	require( _mname )
end



function __G__TRACKBACK__(msg)
 	local debug_traceback = debug.traceback()
 	print("----------------------------------------")
 	print("LUA ERROR: " .. tostring(msg) .. "\n")
 	print(debug_traceback)
 	print("----------------------------------------")
end

local traceback = __G__TRACKBACK__

function main()
	net:init(modulemgr.recv)
end

xpcall(main, traceback)




