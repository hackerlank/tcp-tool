--[["
	desc: 科技点
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
	event[protocolno.SCIENCE_INFO_UPDATE] = "on_science_info_update"
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
	command.reg(cmdno.A, Test_explore_science)
	command.reg(cmdno.B, Test_research_science)
	-- command.reg(cmdno.C, Test_get_guild_num)
	-- command.reg(cmdno.D, Test_get_guild_num)
	-- command.reg(cmdno.E, Test_get_guild_num)
end
-----------------------------
-----------------------------------测试函数--------------------------------------
-------------------------------
-- 请求探索科技点 SCIENCE_EXPLORE 35002
-- sample:{m=35002, p = {science_id=108,explore_type=1}}
function Test_explore_science()
	print("#:Test_explore_science")	
	data =  {m=protocolno.SCIENCE_EXPLORE, p = {science_id=2,explore_type=1}}
	modulemgr:send(data.m, data.p, print_table, "Test_explore_science")
end
-------------------------------
-- 请求研发特殊科技点 SCIENCE_RESEARCH 35003
-- sample:{m=35003, p = {science_id = 13,research_type = 1}}
function Test_research_science()
	print("#:Test_research_science")	
	data =  {m=protocolno.SCIENCE_RESEARCH, p = {science_id = 16,research_type = 1}}
	modulemgr:send(data.m, data.p, print_table, "Test_research_science")
end
-------------------------------




init_reg_recv_callback()
init_cmd()