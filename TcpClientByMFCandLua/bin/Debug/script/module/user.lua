--[["
	desc: 测试用户模块
	author: jinzhentao
	modify: 
	since: 2015-10-18
"]]



-------------------------------
-- 注册接收回调事件
function init_reg_recv_callback()
	print("User module reg....")
	local event = {}
	event[protocolno.AUTH_LOGIN] = on_auth_login
	event[protocolno.AUTH_REGISTER] = on_auth_register
	event[protocolno.AUTH_ALLOW] = on_auth_allow
	event[protocolno.ACCOUNT_ROLES_GET] = on_get_account_roles
	event[protocolno.ACCOUNT_ROLES_CREATE] = on_create_account_roles
	event[protocolno.ACCOUNT_ROLES_USE] = on_use_account_roles
	event[protocolno.PLAYER_UPDATE_BASIC] = on_player_basic_update

	-- 注册回调
	for msgno,callback in pairs(event) do
		modulemgr:reg_recv_callback(msgno, callback)
	end
end
-------------------------------


-- 账号验证 AUTH_LOGIN 5001
function on_auth_login(params)
	print("on_auth_login")
	-- 账号验证成功 发送获取角色列表
	modulemgr:send(protocolno.ACCOUNT_ROLES_GET, {})
end
------------------------------
-- 收到账号注册消息 AUTH_REGISTER 5002
function on_auth_register(params)
	print("on_auth_register")
	-- 发送登陆命令

	local msgdata = {[1]=protocolno.PROTOCOL_VERSIONS_NO}
	modulemgr:send(protocolno.AUTH_LOGIN, msgdata)
end
-----------------------------------
-- 收到使用角色登陆消息 AUTH_ALLOW 5003
function on_auth_allow(data)
	print("on_auth_allow")
end
--------------------------------------
-- 收到获取角色消息 ACCOUNT_ROLES_GET 5501
function on_get_account_roles(params)
	print("on_get_account_roles")
	print_table(params)
	if tableutil.gettablelen(params.listrole) == 0 then
		-- 角色列表为空, 需要创建一个新角色
		print("-->user role list nil, create new role")
		modulemgr:send(protocolno.ACCOUNT_ROLES_CREATE, {name=CacheMgr.player.username, sex = 1})
	else
		-- 获取角色列表成功，使用一个角色登陆游戏
		print("-->get role list sucess, use role login")
		cache.player.player_id = tonumber(params.player_id)
		local msgdata = {playerid = cache.player.player_id}
		-- {m = 5503, p = {playerid = 50002}}
		modulemgr:send(protocolno.ACCOUNT_ROLES_USE, msgdata)
	end
end
----------------------------------
-- 收到创建角色 ACCOUNT_ROLES_CREATE 5502
function on_create_account_roles(params)
	print("on_create_account_roles")
	print_table(params)
	-- 创建角色成功,再次获取角色列表
	modulemgr:send(protocolno.ACCOUNT_ROLES_GET, {})
end
----------------------------------
-- 收到使用某个角色进入游戏 ACCOUNT_ROLES_USE 5503
function on_use_account_roles(params)
	print("on_use_account_roles")
	print_table(params)
end
---------------------------------
-- 收到角色数据更新 PLAYER_UPDATE_BASIC 6002
function on_player_basic_update(params)
	print("on_player_basic_update")
	print_table(params)
end
---------------------------------


-- 初始化
init_reg_recv_callback()