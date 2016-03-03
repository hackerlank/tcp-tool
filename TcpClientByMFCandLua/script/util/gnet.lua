-- gnet
-- 网络模块, 负责和服务端通讯, 消息协议
--[[
使用方法:
1 初始化: gnet.init()
2 注册消息ID: gnet.reg(msgid, func)
func参数: 数据, 调用结果
function func(p, r) {...}
3 循环调用gnet.update()来驱动运作

]]--
local socket = require("socket")
local msgpack = require("util.msgpack")
require("util.bit")

local traceback = __G__TRACKBACK__

local _M = {}

local PKG_HEAD_LEN = 2

local L = {
    socket  = nil,      -- LuaSocket的tcp对象
    recv    = '',
    pkgLen  = -1,
    isWait  = false,    -- 等待消息包内容
    ip      = '',
    port    = -1,
    cbObj   = nil,      -- 回调对象
    cbRecv  = nil,      -- 接收数据回调
    cbClose = nil,      -- 断线回调
    cbConnectOK = nil,  -- 连接成功回调
    cbConnectFail = nil,-- 连接失败回调
}

-- 清理
local function _clear()
    L.socket = nil
    L.recv = ''
    L.pkgLen = -1
    L.isWait = false
end

-- 客户端被断开连接
local function _onCloseByServer()
    L.cbClose(L.cbObj)
    _clear()
end

-- send出错断开连接
local function _onCloseBySending()
    L.socket:close()
    L.cbClose(L.cbObj)
    _clear()
end

local function _skynet_text_pack_head(length)
    -- uint8_t head[2];
    -- head[0] = (n >> 8) & 0xff;
    -- head[1] = n & 0xff;

    local n = length
    local t1 = bit:_and( bit:_rshift(n, 8), 0xff)
    local t2 = bit:_and( n, 0xff)
    local t = string.char(t1)..string.char(t2)
    return t
end

local function _skynet_text_unpack_head(head)
    -- size_t len = header[0] << 8 | header[1];

    local t1 = string.byte(head, 1)
    local t2 = string.byte(head, 2)
    local n = bit:_or( bit:_lshift(t1, 8), t2)
    return n
end

-- skynet TEXT协议头 长度加密
local function _skynet_text_pack(msg)
    local head = _skynet_text_pack_head(#msg)
    return head..msg
end

-- 接收到数据
local function _recv(buff)
    -- print('gnet>[RECV raw '..#buff..'] '..buff)
    local data = msgpack.unpack(buff)
    -- 调用逻辑回调
    -- print('gnet>[RECV] '..data.m)
    -- dump(data)
    xpcall(function () L.cbRecv(L.cbObj, data) end, traceback)
    --pcall(function () L.cbRecv(L.cbObj, data) end)
end

-- 发送原始数据
local function _send(buff)
    if buff == nil or type(buff) ~= 'string' or #buff <= 0 then
        return false
    end
    buff = _skynet_text_pack(buff)  -- 转成skynet数据
    if #buff >= 65500 then
        traceback('gnet>send ERROR: message is too large')
        return false
    end
    local res, err, len = L.socket:send( buff )
    -- 一次发送成功
    if type(res) == 'number' and res == #buff then
        return true
    end
    -- 断线/超时退出
    if err == 'closed' then
        print('gnet>send ERROR:disconnect in _send()')
        return false
    end

    --[[
    if err == 'timeout' then
        print('gnet>send ERROR:timeout in _send()')
        return false
    end
    ]]

    -- timeout 或者其他情况则继续重试
    local s = res or len -- s:已发送的位置
    local function __send_loop ()
        local cnt = 0
        while(s < #buff) do
            -- 最多循环1000次退出
            cnt = cnt + 1
            if cnt >= 1000 then return false end

            res, err, len = L.socket:send( buff, s+1 )
            if err == 'closed' then
                print('gnet>send ERROR:disconnect in __send_loop()')
                return false
            end

            s = res or len -- 更新已发送
        end -- while
        return true
    end -- __send_loop

    local isOk, ret = pcall(__send_loop)
    -- 发送出错
    if not isOk or (isOK and ret == false) then
        print('gnet>__send_loop ERROR:'..tostring(ret))
        _onCloseBySending()
    end

    -- print('gnet>[SEND raw '..#buff..'] '..buff)
end

---------------------- public ----------------------

--初始化
function _M:init(ip, port, cbObj, cbRecv, cbClose, cbConnectOK, cbConnectFail)
    L.ip = ip
    L.port = port
    L.cbObj = cbObj
    L.cbRecv = cbRecv
    L.cbClose = cbClose
    L.cbConnectOK = cbConnectOK
    L.cbConnectFail = cbConnectFail
    -- 如果在连接的时候初始化, 先close
    if self:isconnect() then
        self:close()
    end
    self:connect()
end

-- 检测是否已经在连接
function _M:isconnect()
    return (L.socket ~= nil)
end

-- 连接
function _M:connect()
    -- 检测是否已经在连接
    if self:isconnect() then
        print('gnet>already connected, can NOT do connect()')
        return
    end
    local s, err = socket.tcp()
    if not s then
        print('gnet>create socket.tcp ERROR:'..err)
        L.cbConnectFail(L.cbObj)
        _clear()
        return
    else
        print('gnet>create socket.tcp OK')
    end
    -- set connect timeout
    s:settimeout(1)

    print('socket.connect: '..L.ip..':'..tostring(L.port))
    local res, err = s:connect(L.ip, L.port)
    if not res then
        print('gnet>connet ERROR:'..err)
        L.cbConnectFail(L.cbObj)
        return
    end

    print('gnet>connet OK ['..L.ip..':'..L.port..']')

    --tcp:setoption
    s:settimeout(0)
    L.socket = s
    L.cbConnectOK(L.cbObj)
end

-- 发送数据
function _M:send(data)
    print('gnet>[SEND] '..data.m)
    if type(data) ~= type({}) then
        print('gnet>send ERROR: data not a table')
        return false
    end

    if not self:isconnect() then
        print('gnet>socket is not connect!!')
        return false
    end

    local buff = msgpack.pack(data)
    if buff == nil or type(buff) ~= type('') or #buff <= 0 then
        return false
    end

    return pcall(function() return _send(buff) end)
end

-- 驱动循环
function _M:update()
    if not L.socket then return end

    local res, err = socket.select({L.socket,}, nil, 0)
    if #res == 0 then return end

    local s = res[1]

    local res, err, partial = s:receive('*a')
    res = res or partial

    if (not res) or (#res == 0) then
        if err == 'closed' then
            print('gnet>closed by server')
            _onCloseByServer()
        elseif err == 'timeout' then
            -- 
        end
        return
    end


    --print('gnet>[RECV update res '..#res..'] '..res)
    L.recv = L.recv..res

    -- print('--------------------------- handler -------------------------'..os.time())    
    local pkgs = {}

    while true do
        if #L.recv < PKG_HEAD_LEN then break end -- 必须大于head长度

        if L.pkgLen == -1 then
            L.pkgLen = _skynet_text_unpack_head( string.sub(L.recv, 1, PKG_HEAD_LEN) )
        end

        local l = #L.recv - (L.pkgLen+PKG_HEAD_LEN)
        if l < 0 then break end -- 长度不足, 不能切

        table.insert(pkgs, string.sub(L.recv, PKG_HEAD_LEN+1, PKG_HEAD_LEN+L.pkgLen))

        if l == 0 then
            L.recv = ''
        elseif l > 0 then -- 切掉之后还有多, 继续循环
            L.recv = string.sub(L.recv, PKG_HEAD_LEN+L.pkgLen+1)
        end
        L.pkgLen = -1 -- 重新计算长度
    end

    -- 执行
    for _, pkg in pairs(pkgs) do
        _recv(pkg)
    end
    -- print('--------------------------- handler end -------------------------'..os.time())

end

-- 客户端主动关闭网络连接
function _M:close()
    L.socket:close()
    _clear()
end



return _M