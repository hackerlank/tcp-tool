--[["
	desc: vip充值
	author: jinzhentao
	modify: 
	since: 2015-12-09
"]]

------------------------------
-- 打印接收到的消息数据
-- function tableutil.print_table(params)
-- 	print("tableutil.print_table start....................")
-- 	tableutil.tableutil.print_table(params)
-- 	print("tableutil.print_table end  ....................")
-- end
----------------------------
-- 注册接收回调事件
function init_reg_recv_callback()
	print("User module reg....")
	local event = {}
	event[protocolno.RECHARGE_RECHARGE] = "on_recharge_recharge"
	-- 注册回调
	local callback = tableutil.print_table
	for msgno,callback_desc in pairs(event) do
		modulemgr:regRecvCallback(msgno, callback, callback_desc)
	end
end
-----------------------------
-- 注册初始化命令
function init_cmd()
	print("init_cmd")
	command.reg(cmdno.A, Test_recharge_recharge)
	command.reg(cmdno.B, Test_open_recharge_page)
	-- command.reg(cmdno.C, Test_get_guild_num)
	-- command.reg(cmdno.D, Test_get_guild_num)
	-- command.reg(cmdno.E, Test_get_guild_num)
end
-----------------------------
-----------------------------------测试函数--------------------------------------
-------------------------------
-- 请求充值 RECHARGE_RECHARGE_TEST 22000
-- sample:{m=22000, p = {recharge_id = 1}}
function Test_recharge_recharge()
	print("#:Test_recharge_recharge")	
	data =  {m=protocolno.RECHARGE_RECHARGE_TEST, p = {recharge_id = 3}}
	modulemgr:send(data.m, data.p, tableutil.print_table, "on_recharge_recharge")
end
-------------------------------
-- 请求打开充值 RECHARGE_OPEN_RECHARGE_PAGE 22002
-- sample:{m=22002, p = {}}
function Test_open_recharge_page()
	print("#:Test_open_recharge_page")	
	data =  {m=protocolno.RECHARGE_OPEN_RECHARGE_PAGE, p = {}}
	modulemgr:send(data.m, data.p, tableutil.print_table, "on_open_recharge_page")
end
-------------------------------




init_reg_recv_callback()
init_cmd()