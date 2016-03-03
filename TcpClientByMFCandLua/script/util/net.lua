require("util.bit")
local msgpack = require("util.msgpack")
local tableutil = require("util.tableutil")

local net = {}
net.recv_buff = ''  -- 接收缓冲


local meta = net
-- 包长
local PKG_HEAD_LEN = 2


function meta:init(on_recv_pkg)
	self.on_recv_pkg = on_recv_pkg -- 接收完整数据包回调
	self.gid = 100000
end

-- 根据包头获取数据包长
local function _text_unpack(head)
    local t1 = string.byte(head, 1)
    local t2 = string.byte(head, 2)
    local n = bit:_or( bit:_lshift(t1, 8), t2)
    return n
end

-- TEXT协议头 长度加密
local function _text_pack(msg)
	function pack_head(length)
	    local n = length
	    local t1 = bit:_and( bit:_rshift(n, 8), 0xff)
	    local t2 = bit:_and( n, 0xff)
	    local t = string.char(t1)..string.char(t2)
	    return t
	end
    local head = pack_head(#msg)
    return head..msg
end


function meta:send(data)
    -- print('gnet>[SEND] '..data.m)
    if type(data) ~= type({}) then
        print('gnet>send ERROR: data not a table')
        return false
    end
	
	self.gid = self.gid + 1
    data.g = self.gid 
    --print("#### before msgpack")
    --tableutil.print_table(data)
	
    local buff = msgpack.pack(data)
    if buff == nil or type(buff) ~= type('') or #buff <= 0 then
        return false
    end

    function _send(buff)
	    if buff == nil or type(buff) ~= 'string' or #buff <= 0 then
	        return false
	    end
			
		-- print("#### old", buff, #buff)
	    buff = _text_pack(buff)  -- 转成skynet数据
		-- print("#### new", buff, #buff)
	    if #buff >= 65500 then
	        traceback('gnet>send ERROR: message is too large')
	        return false
	    end
		send_string(buff, #buff)
	end
    return pcall(function() return _send(buff) end)
end

function meta:on_recv(buff)
	-- 添加到缓冲区
	print("net_on_recv")
	self.recv_buff = self.recv_buff .. buff 
	local pkgs = {} -- 数据包列表
	local pkgLen = -1 -- 数据包长，不包括数据包头（head长度）
    while true do
        if #self.recv_buff < PKG_HEAD_LEN then break end -- 必须大于head长度
        if pkgLen == -1 then
            pkgLen = _text_unpack( string.sub(self.recv_buff, 1, PKG_HEAD_LEN) ) -- 计算当前包长度
        end
		print("&&&&&")
        local remain_len = #self.recv_buff - (pkgLen+PKG_HEAD_LEN) -- 剩余长度
        if remain_len < 0 then break end -- 长度不足, 不能切
		
		print("$$$$$")
        -- 添加当前包到数据包列表
        table.insert(pkgs, string.sub(self.recv_buff, PKG_HEAD_LEN+1, PKG_HEAD_LEN+pkgLen))

        if remain_len == 0 then
            self.recv_buff = ''
        elseif remain_len > 0 then -- 切掉之后还有多, 继续循环
            self.recv_buff = string.sub(self.recv_buff, PKG_HEAD_LEN+pkgLen+1)
        end
        pkgLen = -1 -- 重新计算长度
    end
	print("########")
    -- 执行
    for _, pkg in pairs(pkgs) do
        local data = msgpack.unpack(pkg)
		tableutil.print_table(data)
    	xpcall(function () self.on_recv_pkg(data) end, traceback)
    end
end


return net