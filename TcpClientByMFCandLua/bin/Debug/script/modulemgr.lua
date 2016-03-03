

modulemgr = {}


local meta = modulemgr

meta.recv_event_list = {}

function meta:init()
	require("module.user")
	require("module.active")
end


function meta:send(protono, data)
	local msg = {}
	msg.m = protono
	msg.p = data
	net:send(msg)
end

function meta:reg_recv_callback(msgno, callback, desc)
	if not self.recv_event_list[msgno] then
		self.recv_event_list[msgno] = {}  
        self.recv_event_list[msgno].callback = callback
        self.recv_event_list[msgno].desc = desc
	else
		print("reg resv msgno:" .. protono .. " is already reg")
	end
end

function meta:recv_pkg_callback(params)
	local event = self.recv_event_list[params.m]
	if event then
		if event.desc then
			print("recv msgno " .. params.m .. " desc " .. event.desc)
		end
		event.callback(params.p)
	end
end

modulemgr:init()

return modulemgr