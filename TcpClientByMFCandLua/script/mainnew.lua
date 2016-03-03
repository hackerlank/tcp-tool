

require("util.bit")
local msgpack = require("util.msgpack")
local tableutil = require("util.tableutil")
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

print("###############################################")

local data = {m=5002,g=100001,p = {plat=0, token= "1111"}}
tableutil.print_table(data)
local buff = msgpack.pack(data)
print("msgpack", buff, #buff)
buff = _text_pack(buff)
print("text pack", buff, #buff)

print("###############################################")