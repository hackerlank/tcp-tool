
-- /////////////////////
-- 公会模块
-- /////////////////////

-------------------------
-- 注册接收回调,已注册过的则无法注册
function init_reg_recv_callback()
	local event = {}
	event[protocolno.GUILD_CAN_GET_BANQUET_NOTICE] = "guild_can_get_banquet_notice"
	-- 注册回调
	for msgno,callback in pairs(event) do
		modulemgr:regRecvCallback(msgno, callback)
	end
end


-- 初始化命令
function init_cmd()
	print("init_cmd")
	command.reg(cmdno.A, Test_get_guild_num)
	command.reg(cmdno.B, Test_show_guild_list)
	command.reg(cmdno.C, Test_show_guild_from_id)
	command.reg(cmdno.D, Test_create_guild)
	command.reg(cmdno.E, Test_delete_guild)
end


-- 请求显示公会个数 GUILD_SHOW_NUM 6401
function Test_get_guild_num()
	print("Test_get_guild_num")	
	data =  {m=6401, p = {}}
	modulemgr:send(data.m,data.p, tableutil.print_table, "on_get_guild_num")
end
-------------------------------
-- 请求显示公会列表 GUILD_SHOW_GUILD_LIST  6402
function Test_show_guild_list()
	print("Test_show_guild_list")	 
	data = {m=6402, p = {begin = 1, tail = 4}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 请求显示公会列表 GUILD_SHOW_FORM_ID  6403
function Test_show_guild_from_id() -- 请求显示公会列表
	print("Test_show_guild_from_id")	 
	data = {m=6403, p = {guild_name = "first guild"}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 请求创建公会 GUILD_CREATE 6404
function Test_create_guild()
	print("Test_create_guild")
	data = {m=6404, p =  {guild_name = "first guild公会",  guild_icon = 2}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 请求解散公会 GUILD_DISSOLVE 6405
function Test_delete_guild()
	print("Test_delete_guild")	
	data = {m=6405, p =  {}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end

--/////////////////////////////////////////////////////////////
-------------------------------
-- 请求显示申请列表 GUILD_SHOW_APPLY_LIST 6407
function Test_show_apply()
	print("Test_show_apply")
	data = {m=6407, p =  {}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 清空公会申请列表 GUILD_EMPTY_APPLY_LIST 6408
function Test_empty_apply()
	print("Test_empty_apply")  
	data = {m=6408, p =  {}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 申请加入工会 GUILD_APPLY_GUILD 6409
function Test_apply_guild()
	print("Test_apply_guild")
	data = {m=6409, p =  {guild_id = 10002}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 邀请玩家加入公会 GUILD_APPLY_GUILD 6410
function Test_invite_apply_guild() -- 邀请玩家加入公会
	print("Test_invite_apply_guild")
	data = {m=6410, p =  {targe_id = 970002}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 查看公会邀请 GUILD_GET_INVITE_LIST 6426
function Test_get_invite_apply_list() -- 查看公会邀请
	print("Test_get_invite_apply_list")
	data = {m=6426, p =  {}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 忽略公会邀请 GUILD_IGNORE_INVITE 6427
function Test_ignore_invite_apply() -- 忽略公会邀请
	print("Test_ignore_invite_apply")
	data = {m=6427, p =  {guild_id = 40002, inviter_id = 470002}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 接受公会邀请 GUILD_ACCEPT_INVITE 6428
function Test_accept_invite_apply() -- 接受公会邀请
	print("Test_accept_invite_apply")
	data = {m=6428, p =  {guild_id = 40002, inviter_id = 470002}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 批准加入公会 GUILD_APPLY_TO_GUILD 6411
function Test_apply_to_guild()
	print("Test_apply_to_guild")
	data = {m=6411, p =  {targe_id = 620002}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 拒绝玩家加入公会 GUILD_REFUSE_TO_GUILD 6412
function Test_refuse_to_guild() -- 拒绝玩家加入公会
	print("Test_refuse_to_guild")
	data = {m=6412, p =  {targe_id = 620002}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 踢出公会 GUILD_DELETE_MEMBER 6413
function Test_delete_member() -- 踢出公会
	print("Test_delete_member")
	data = {m=6413, p =  {targe_id = 620002}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 主动退出公会 GUILD_EXIT_MEMBER 6414
function Test_exit_guild()
	print("Test_exit_guild")
	data = {m=6414, p =  {}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
--/////////////////////////////////////////////////////////////////
-------------------------------
-- 显示玩家公会ID跟权限 GUILD_SHOW_POWER 6415
function Test_show_power()
	print("Test_show_power")
	data = {m=6415, p =  {}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 获取公会信息 GUILD_GET_INFO 6416
function Test_get_guild_info()
	print("Test_get_guild_info")
	data = {m=6416, p =  {}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 获取成员列表（权利） GUILD_SHOW_MEMBER_POWER 6417
function Test_show_member_power()
	print("Test_show_member_power")
	data = {m=6417, p =  {}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 获取成员列表（等级） GUILD_SHOW_MEMBER_LV 6418
function Test_show_member_lv()
	print("Test_show_member_lv")
	data = {m=6418, p =  {}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 修改权限 GUILD_UP_POWER 6419
function Test_up_member_power() -- 修改权限
	print("Test_up_member_power")
	data = {m=6419, p = {guild_member_id = 620002, power = 2}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
--//////////////////////////////////////////////////////////////////
-------------------------------
-- 修改宣言 GUILD_WRITE_ANNOUNCEMENET 6420
function Test_write_announcement() -- 修改宣言
	print("Test_write_announcement")	
	data = {m=6420, p =  {announcement = " fight and fight !!! "}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 发布日志 GUILD_PUBLISH_LOG 6421
function Test_publish_guild_log() -- 发布日志
	print("Test_publish_guild_log")	
	data = {m=6421, p =  {content = " hello everybody!!! "}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end

-------------------------------
-- 设宴（会长） GUILD_GIVE_BANQUET 6422
function Test_give_banquet()
	print("Test_give_banquet")	
	data = {m=6422, p =  {}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 领取宴会体力 GUILD_GET_BANQUET_ENERGY 6423
function Test_get_banquet_energy()
	print("Test_get_banquet_energy")	
	data = {m=6423, p =  {}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 获取宴会信息 GUILD_GET_BANQUET_INFO 6429
function Test_on_get_banquet_info()
	print("Test_on_get_banquet_info")	
	data = {m=6429, p =  {}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end
-------------------------------
-- 查询公会事件 GUILD_QUERY_EVENT 6425
function Test_guild_event() -- 查询公会事件
	print("Test_guild_event")
	data = {m=6425, p =  {}}
	modulemgr:send(data.m, data.p, tableutil.print_table)
end


------------------------------------------
init_reg_recv_callback()
init_cmd()
--------------------------------------------------------------------------------
