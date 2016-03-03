
-- 用户模块

local class = require("util.middleclass")
local Base = require("ModuleBase")

local Dungeon = class("Dungeon", Base)

meta = Dungeon

-- 构造函数
function meta:initalize()
	Base.initalize(self, "Dungeon") 
end

-- 注册事件
function meta:reg()
	print("Dungeon module reg....")
	local event = {send = {}, recv = {}}
	-- function(params) meta:func(params) end
	-- 发送事件
	event.send[protocolno.DUNGEON_RESET_CHALLENGE] =  reset_dungeon_challenge
	event.send[protocolno.DUNGEON_START_CHALLENGE] = start_dungeon_challenge 
	event.send[protocolno.DUNGEON_MONSTER_RECHARGE] = recharge_dungeon_monsters 
	event.send[protocolno.DUNGEON_MONSTER_POSITION_CHANGE] = change_dungeon_monsters_position 

	-- 接收事件
	event.recv[protocolno.COMMON_Dungeon_COMPLETE] = recharge_dungeon_monsters
	event.recv[protocolno.DUNGEON_START_CHALLENGE] = on_start_dungeon_challenge
	event.recv[protocolno.DUNGEON_MONSTER_RECHARGE] = on_recharge_dungeon_monsters
	event.recv[protocolno.DUNGEON_MONSTER_POSITION_CHANGE] = on_change_dungeon_monsters_position

	Base:reg(event) 
end


--------------------------------
-- 重新挑战,解除章节锁定 DUNGEON_RESET_CHALLENGE 38001
function reset_dungeon_challenge(params)
	print("reset_dungeon_challenge")	 
	local msgdata = params 
	if not msgdata then
		msgdata = {gold = nil} -- glod为不为nil时表示使用钻石进行挑战
	end
	Base:send(protocolno.DUNGEON_RESET_CHALLENGE, msgdata)
end
function on_reset_dungeon_challenge(params)
	print("on_reset_dungeon_challenge")
	print_table(data)
	
end
--------------------------------
-- 开始挑战，恢复数据，绑定章节 DUNGEON_START_CHALLENGE 38002
function start_dungeon_challenge(params)
	print("start_dungeon_challenge")	 
	local msgdata = params 
	if not msgdata then
		msgdata = {chapter_id = 301}
	end
	Base:send(protocolno.DUNGEON_START_CHALLENGE, msgdata)
end
function on_start_dungeon_challenge(params)
	print("on_start_dungeon_challenge")
	print_table(data)
	
end
--------------------------------
-- 地下城一键补兵 DUNGEON_MONSTER_RECHARGE 38003
function recharge_dungeon_monsters(params)
	print("recharge_dungeon_monsters")	 
	local msgdata = params 
	if not msgdata then
		msgdata = {chapter_id = 301， gold = nil }
	end
	Base:send(protocolno.DUNGEON_MONSTER_RECHARGE, msgdata)
end
function on_recharge_dungeon_monsters(params)
	print("on_recharge_dungeon_monsters")
	print_table(data)
	
end
--------------------------------
-- 改变布阵 DUNGEON_MONSTER_POSITION_CHANGE 38004
function change_dungeon_monsters_position(params)
	print("change_dungeon_monsters_position")	 
	local msgdata = params 
	if not msgdata then
		msgdata = {101，0，0，0，0，0}
	end
	Base:send(protocolno.DUNGEON_MONSTER_POSITION_CHANGE, msgdata)
end
function on_change_dungeon_monsters_position(params)
	print("change_dungeon_monsters_position")
	print_table(data)
end
--------------------------------



return Dungeon
