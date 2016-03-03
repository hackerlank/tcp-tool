--[["
	desc: 领奖中心测试
	author: jinzhentao
	modify: 
	since: 2015-12-07
"]]

------------------------------
-- 打印接收到的消息数据
function print_table(params)
	print("print_table start....................")
	tableutil.print_table(params)
	print("print_table end  ....................")
end
----------------------------
-- 注册接收回调事件
function init_reg_recv_callback()
	print("User module reg....")
	local event = {}
	-- 收到服务器推送玩家所有活动数据列表
	event[protocolno.CONTACT_ACTIVE_REWARD_LIST] = "on_push_active_reward_list"
	-- 收到服务器推送玩家指定活动数据发生改变
	event[protocolno.ACTIVE_REWARD_STATUS_CHANGE] = "on_push_active_reward_status_change"
	-- 收到服务器推送活动通知
	event[protocolno.ACTIVE_MSG] = "on_push_active_msg"
	-- 注册回调
	local callback = print_table
	for msgno,callback_desc in pairs(event) do
		modulemgr:regRecvCallback(msgno, callback, callback_desc)
	end
end
-----------------------------
-- 注册初始化命令
function init_cmd()
	print("init_cmd")
	command.reg(cmdno.A, Test_get_activity_reward)
	command.reg(cmdno.B, Test_get_activity_remain_time)
	-- command.reg(cmdno.E, Test_get_guild_num)
end
-----------------------------



-----------------------------------测试函数--------------------------------------

-------------------------------
-- 请求领取活动奖励 ACTIVE_GET_REWARD 11001
-- sample:{m=10004, p = {activity_id = 2, instance_id = 0}}
function Test_get_activity_reward()
	print("#:Test_get_activity_reward")	
	data =  {m=protocolno.ACTIVE_GET_REWARD, p = {activity_id = 2, instance_id = 0}}
	modulemgr:send(data.m, data.p, print_table, "on_get_activity_reward")
end
-------------------------------
-- 请求获取活动剩余时间 ACTIVE_GET_REMAIN_TIME 10003
-- sample:{m=10003, p = {}}
function Test_get_activity_remain_time()
	print("#:Test_get_activity_remain_time")	
	data =  {m=protocolno.ACTIVE_GET_REMAIN_TIME, p = {}}
	modulemgr:send(data.m, data.p, print_table, "on_get_activity_remain_time")
end
-------------------------------
-- 请求获取活动剩余时间 ACTIVE_GET_REMAIN_TIME 10003
-- sample:{m=10007, p = {}}
function Test_get_buy_level_fund()
	print("#:Test_get_buy_level_fund")	
	data =  {m=protocolno.ACTIVE_BUY_LEVEL_FUND, p = {}}
	modulemgr:send(data.m, data.p, print_table, "on_get_buy_level_fund")
end
-------------------------------


init_reg_recv_callback()
init_cmd()