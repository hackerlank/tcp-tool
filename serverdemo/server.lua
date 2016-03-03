

-- server.lua
local socket = require("socket")
require("util.bit")
local msgpack = require("util.msgpack")
local tableutil = require("util.tableutil")

require("util.class")

-------------------------------------------------------
local PKG_HEAD_LEN = 2

local TcpServer = class()
local meta = TcpServer
function meta:ctor(ip, port)
    self.sock = assert(socket.bind(ip, port, 1024))
    self.sock:settimeout(2)
    self.client_tab = {}
    self.conn_count = 0
    print("server bind sucess!!!", ip, port)
end

-- 根据包头获取数据包长
function meta:_unpack_head(head)
    local t1 = string.byte(head, 1)
    local t2 = string.byte(head, 2)
    local n = bit:_or( bit:_lshift(t1, 8), t2)
    return n
end

-- TEXT协议头 长度加密
function meta:_pack_data(msg)
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



function meta:accept(conn)
    conn:settimeout(0) -- set client 
    self.conn_count = self.conn_count + 1
    local client_id = self.conn_count
    self.client_tab[client_id] = {id = client_id, sock = conn,  buff = ''} 
    print("A client successfully connect!", client_id) 
end

function meta:recv_pkg(client_id, pkg)
    print("recv_pkg")
    tableutil.print_table(pkg)

    self:send_pkg(client_id, pkg)

end

function meta:send_pkg(client_id, data)
    print(client_id)
    local client = self.client_tab[client_id]

    if type(data) ~= type({}) then
        print('gnet>send ERROR: data not a table')
        return false
    end
    local buff = msgpack.pack(data)
    if buff == nil or type(buff) ~= type('') or #buff <= 0 then
        return false
    end
    buff = self:_pack_data(buff)  
    if #buff >= 65500 then
        traceback('gnet>send ERROR: message is too large')
        return false
    end
    client.sock:send(buff)
end

function meta:_recv_buff(client_id, buff)
    local client = self.client_tab[client_id]
    client.buff = client.buff .. buff
    -- print('--------------------------- handler -------------------------'..os.time())    
    local pkg_list = {}
    local pkgLen = -1
    while true do
        if #client.buff < PKG_HEAD_LEN then break end -- 必须大于head长度
        if pkgLen == -1 then
            pkgLen = self:_unpack_head(string.sub(client.buff, 1, PKG_HEAD_LEN))
        end
        local len = #client.buff - (pkgLen + PKG_HEAD_LEN)
        if len < 0 then break end -- 长度不足, 不能切
        table.insert(pkg_list, string.sub(client.buff, PKG_HEAD_LEN+1, PKG_HEAD_LEN+pkgLen))
        if len == 0 then
            client.buff = ''
        elseif len > 0 then -- 切掉之后还有多, 继续循环
            client.buff = string.sub(client.buff, PKG_HEAD_LEN + pkgLen + 1)
        end
        pkgLen = -1 -- 重新计算长度
    end
    -- 执行
    for _, pkg in pairs(pkg_list) do
        local data = msgpack.unpack(pkg)
        self:recv_pkg(client_id, data)
    end
end

function meta:disconnect(client_id)
     print('client closed connect' .. client_id)
     self.client_tab[client_id] = nil
end

function meta:close()
    
end

function meta:loop()
    print("waiting for client connect and send data")
    while true do
        local conn = self.sock:accept()
		print("###", conn)
        if conn then
            self:accept(conn)
        end
        for client_id, client in pairs(self.client_tab) do
            local res, err = socket.select({client.sock}, nil, 1)
            if #res ~= 0 then 
                local receive, receive_status, partial = client.sock:receive('*a')
                receive = receive or partial
                if (not receive) or (#receive == 0) then
                    if receive_status == 'closed' then
                        self:disconnect(client_id)
                    elseif receive_status == 'timeout' then
                        print("client timeout")
                    end
                else -- recv data
                    print("recv buff from client", client_id)
                    self:_recv_buff(client_id, receive)
                end
            end
        end
    end
end


local server = TcpServer.new("127.0.0.1", 8888)
server:loop()




