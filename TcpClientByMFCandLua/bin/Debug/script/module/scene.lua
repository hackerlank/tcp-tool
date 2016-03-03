-- 用户模块

local class = require("util.middleclass")
local Base = require("ModuleBase")

local Scene = class("Scene", Base)

meta = Scene

-- 构造函数
function meta:initalize()
	Base.initalize(self, "Scene") 
end

-- 注册事件
function meta:reg()
	print("Scene module reg....")
	local event = {send = {}, recv = {}}
	-- function(params) meta:func(params) end
	-- 发送事件
	event.send[protocolno.COMMON_SCENE_COMPLETE] =  scene_complete
	event.send[protocolno.COMMON_ENTER_GAME] = enter_game 
	event.send[protocolno.COMMON_FIRST_IN_SCENE] = first_in_scene

	event.send[protocolno.COMMON_SCENE_ENTER_ONE_ECTYPE] = enter_one_scene
	event.send[protocolno.COMMON_SCENE_MOPUP] = enter_mopup_scene


	-- 接收事件
	event.recv[protocolno.COMMON_SCENE_COMPLETE] = on_scene_complete
	event.recv[protocolno.COMMON_ENTER_GAME] = on_enter_game
	event.recv[protocolno.COMMON_FIRST_IN_SCENE] = on_first_in_scene

	event.recv[protocolno.COMMON_SCENE_ENTER_ONE_ECTYPE] = on_enter_one_scene
	event.recv[protocolno.COMMON_SCENE_MOPUP] = on_enter_mopup_scene

	event.recv[protocolno.SCENE_STATISTICS_UPDATE] = function(params) meta:on_scene_statistics_update(params) end

	Base:reg(event) 
end

---------------------------------------------------------

-- 切换场景完成 COMMON_SCENE_COMPLETE 502
function scene_complete(params)
	print("scene_complete")	 
	local msgdata = params
	if not msgdata then
		msgdata = {}
	end
	Base:send(protocolno.COMMON_SCENE_COMPLETE, msgdata, nil)
end
function on_scene_complete(params)
	print("on_scene_complete")
	print_table(params)
	
end
--------------------------------
-- 进入游戏 COMMON_ENTER_GAME 503
function enter_game()
	print("enter_game")	 
	local msgdata = params 
	if not msgdata then
		msgdata = {[1]=protocolno.PROTOCOL_VERSIONS_NO}
	end
	Base:send(protocolno.COMMON_ENTER_GAME, msgdata)
end
function on_enter_game(params)
	print("on_enter_game")
	print_table(data)
	Base:sendEx(protocolno.COMMON_SCENE_COMPLETE, {})
end
-------------------------------
-- 玩家第一次进入场景 COMMON_FIRST_IN_SCENE 504
function first_in_scene(params)
	print("first_in_scene")	
	local msgdata = params
	if not msgdata then
		--msgdata = {[1]=player_id,[2]=name,[3]=profession,[4]=lv,[5]=vip,[6]=x,[7]=y,[8]=direction,[9]=HP}
	end
	Base:send(protocolno.COMMON_FIRST_IN_SCENE, msgdata, nil)
end
function on_first_in_scene(params)
	print("on_first_in_scene")
	print_table(data)
	CacheMgr.connect.num = CacheMgr.connect.num + 1
	--print u'登陆游戏完成,现在可以添加测试代码了%s %s %s'%(num['num'], num['dis'], time.time() - num['time'])
	-- msgno = protocolno.COMMON_SCENE_COMPLETE 
	-- msgdata = {}
	-- Base:send(msgno, msgdata, nil)
end

--------------------------------
-- 收到场景更新数据 SCENE_STATISTICS_UPDATE 8000
function meta:on_scene_statistics_update(params)
	print("on_scene_statistics_update")
	print_table(data)
end


-----------------------------------
-- 场景中要求进入单人副本 或地下城 COMMON_SCENE_ENTER_ONE_ECTYPE 509
function enter_one_scene(params)
	print("enter_one_scene")	  
	local msgdata = params
	if not msgdata then
		-- 单人副本挑战
		--msgdata = {chapter_id=201,map_id=20101,team_id=1}
		-- 地下城挑战
		msgdata = {chapter_id=301,map_id=30101}
	end
	Base:send(protocolno.COMMON_SCENE_ENTER_ONE_ECTYPE, msgdata)
end
function on_enter_one_scene(params)
	print("on_enter_one_scene")
	print_table(data)
end

----------------------------------
-- 扫荡 COMMON_SCENE_MOPUP 510
function enter_mopup_scene(params)
	print("enter_mopup_scene")	  
	local msgdata = params
	if not msgdata then
		-- 单人副本扫荡
		msgdata = {chapter_id=201,map_id=20101,num=1}
		-- 地下城扫荡
		--msgdata = {chapter_id=301, num=1}
	end
	Base:send(protocolno.COMMON_SCENE_MOPUP, msgdata)
end
function on_enter_mopup_scene(params)
	print("on_enter_mopup_scene")
	print_table(data)
end
-----------------------------------

return Scene