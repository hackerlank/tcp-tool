local net = require("util.net")
local tableutil = require("util.tableutil")
-- golbal
modulemgr = {}


local meta = modulemgr

meta.callback_list = {}

function meta:init()
	require("module.user")
end


function meta:send(protono, data)
	local msg = {}
	msg.m = protono
	msg.p = data
	net:send(msg)
end

function meta:regRecvCallback(protono, callback)
	self.callback_list[protono] = callback
end

function meta:recv(params)
	print("recv msg")
	tableutil.print_table(params)
	local callback = self.callback_list[params.m]
	if not callback then return end
	callback(params)
end