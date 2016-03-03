-- set search path
package.path = 'script/?.lua;' 

config = require("config")
protocolno = require("proto.protocolno")
tableutil = require("util.tableutil")


--------------------------------------------------------------------------------
function require_ex( _mname )
  -- print( string.format("require_ex = %s", _mname) )
  	if package.loaded[_mname] then
    	-- print( string.format("require_ex module[%s] reload", _mname))
	end
	package.loaded[_mname] = nil
	require( _mname )
end

function print_table(params)
	print("print_table start....................")
	tableutil.print_table(params)
	print("print_table end  ....................")
end

function __G__TRACKBACK__(msg)
 	local debug_traceback = debug.traceback()
 	print("----------------------------------------")
 	print("LUA ERROR: " .. tostring(msg) .. "\n")
 	print(debug_traceback)
 	print("----------------------------------------")
end

local traceback = __G__TRACKBACK__

------------------------------------------------------------------------------
-- The method must be implemented
------------------------------------------------------------------------------
function on_connect()
	print("on connect!!!")
	function send_auth()
		print("send_auth")
		-- {m = 5002, p = {plat=0, token= "1111"}}
		local proto = protocolno.AUTH_REGISTER
		local data = {plat=config.plat, token= config.username}
		--modulemgr:send(5002, data)
		net:send({m = 5002, p = {plat=0, token= "1111"}})
	end
	xpcall(function () send_auth() end, traceback)
end

function on_disconnect()
	print("on disconnect!!!")
end

function on_recv(buf)
	-- print("on recv buff", buf)
	xpcall(function () net:on_recv(buf) end, traceback)
end

function on_send(proto, buf)
	-- print("on_send buff", buf)
	function send_buff(proto, buf)
		local data = load("return " .. buf)()
		if type(data) == "table" then
			net:send(data)
		else
			print("params is not table type!!!") 
		end
	end
	xpcall(function () send_buff(proto, buf) end, traceback)
end

function on_heart()
	-- print("on heart")
end

function on_get_proto_list()
	local result = {}
	function get_proto_list()
		result["MessagePack"] = "MessagePack"  
	end
	xpcall(function () get_proto_list()  end, traceback)
	return result
end

function send_string(str)
	sendData(str, #str)
end


function main()
	cache = require("cache")
	net = require("util.net")
	modulemgr = require("modulemgr")
	net:init(modulemgr, modulemgr.recv_pkg_callback)
end

xpcall(main, traceback)





