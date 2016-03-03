

-- server.lua
local socket = require("socket")
require("util.bit")
local msgpack = require("util.msgpack")
local tableutil = require("util.tableutil")

-------------------------------------------------------
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
-------------------------------------------------------


local host = "127.0.0.1"
local port = "8888"
local server = assert(socket.bind(host, port, 1024))
server:settimeout(0)
local client_tab = {}
local conn_count = 0
 
print("Server Start " .. host .. ":" .. port) 
 
while 1 do
    local conn = server:accept()
    if conn then
        conn_count = conn_count + 1
        client_tab[conn_count] = conn
        print("A client successfully connect!") 
    end
  
    for conn_count, client in pairs(client_tab) do
        local recvt, sendt, status = socket.select({client}, nil, 1)
        if #recvt > 0 then
            local receive, receive_status, partial = client:receive('*a')
            receive = receive or partial
            if receive_status ~= "closed" then
                if receive then
                    assert(client:send("Client " .. conn_count .. " Send : "))
                    assert(client:send(receive .. "\n"))
                    print("Receive Client " .. conn_count .. " : ", receive)  




                end
            else
                table.remove(client_tab, conn_count) 
                client:close() 
                print("Client " .. conn_count .. " disconnect!") 
            end
        end
         
    end
end