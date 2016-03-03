-- 用户模块

local class = require("util.middleclass")
local Base = require("ModuleBase")

local Equip = class("Equip", Base)

meta = Equip

-- 构造函数
function meta:initalize()
	Base.initalize(self, "Equip") 
end

-- 注册事件
function meta:reg()
	print("Equip module reg....")
	local event = {send = {}, recv = {}}
	-- function(params) meta:func(params) end
	-- 发送事件
	event.send[protocolno.EQUIP_EXCHANGE] =  equip_exchange
	event.send[protocolno.EQUIP_EQUIP] = equip_equip 
	event.send[protocolno.EQUIP_REMOVE] = equip_remove


	-- 接收事件
	event.recv[protocolno.EQUIP_EXCHANGE] = on_equip_exchange
	event.recv[protocolno.EQUIP_EQUIP] = on_equip_equip
	event.recv[protocolno.EQUIP_REMOVE] = equip_remove

	Base:reg(event) 
end

---------------------------------------------------------

-- 兑换装备 EQUIPMENT_EXCHANGE 41001
-- {m = 41001, p={equip_id = 40011}}
function equip_exchange(params)
	print("equip_exchange")	 
	local msgdata = params
	if not msgdata then
		msgdata = {equip_id = 15090001}
	end
	Base:send(protocolno.EQUIP_EXCHANGE, msgdata, nil)
end
function on_equip_exchange(params)
	print("on_equip_exchange")
	print_table(params)
	
end
--------------------------------
-- 装备装备 EQUIP_EQUIP 41002
-- {m = 41002, p={bag_index=1, dress_location = 1}}
function equip_equip()
	print("equip_equip")	 
	local msgdata = params 
	if not msgdata then
		msgdata = {bag_index=1, dress_location = 1}
	end
	Base:send(protocolno.EQUIP_EQUIP, msgdata)
end
function on_equip_equip(params)
	print("on_equip_equip")
	print_table(data)
	-- Base:sendEx(protocolno.COMMON_Equip_COMPLETE, {})
end
----------------------------------
-- 脱下装备 EQUIP_REMOVE 41004
-- {m = 41003, p={equip_index = "100000000360002"}}
function equip_remove()
	print("equip_remove")	 
	local msgdata = params 
	if not msgdata then
		msgdata = {[1]=protocolno.EQUIP_REMOVE}
	end
	Base:send(protocolno.EQUIP_REMOVE, msgdata)
end
function on_equip_remove(params)
	print("on_equip_remove")
	print_table(data)
	-- Base:sendEx(protocolno.COMMON_Equip_COMPLETE, {})
end
----------------------------------

----------------------------------
-- 强化装备 EQUIP_STRENGTHEN 41005
-- {m = 41004, p={pos = 1, index = 1, type = 1}}
-- pos:1表示背包 2表示人物身上
-- index：在pos上的索引位置 
-- type: 1表示单次强化，2表示自动强化
function equip_remove()
	print("equip_remove")	 
	local msgdata = params 
	if not msgdata then
		msgdata = {[1]=protocolno.EQUIP_REMOVE}
	end
	Base:send(protocolno.EQUIP_REMOVE, msgdata)
end
function on_equip_remove(params)
	print("on_equip_remove")
	print_table(data)
	-- Base:sendEx(protocolno.COMMON_Equip_COMPLETE, {})
end
----------------------------------



return Equip