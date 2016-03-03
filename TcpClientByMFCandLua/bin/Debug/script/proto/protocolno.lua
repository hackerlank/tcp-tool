--[["
	desc: 接口协议约定(for 客户端)
	author: oyxz
	since: 2014-01-13
 "]]

protocolno = {}

-- 协议版本号(主要修改了协议，就得改变这个值,请不断的累加上去)
protocolno.PROTOCOL_VERSIONS_NO = 13

-- 供客户端调用的接口服务分段id定义表,建议一个功能预留100个id号段,5000以内预留给系统

-- 5000以内为系统保留号段
-- 分配500~600号段给场景管理使用
protocolno.COMMON_SCENE_RESERVED = 500

-- 心跳
-- req:{g=guid,m=protocolno.COMMON_DO_HEART, p={}}
-- response:{m=protocolno.COMMON_DO_HEART,g=guid,r=msgno,p={}}
protocolno.COMMON_DO_HEART = protocolno.COMMON_SCENE_RESERVED + 0

-- 切场景
-- req:{g=guid,m=protocolno.COMMON_SCENE_CHANGE, p={map_id=0}} 如果map_id=nil，那么意思是回到主城，否则map_id必须等于某个场景的ID
-- response:{m=protocolno.COMMON_SCENE_CHANGE,g=guid,r=msgno,p={}}
protocolno.COMMON_SCENE_CHANGE = protocolno.COMMON_SCENE_RESERVED + 1
-- 切场景完成
-- req:{g=guid,m=protocolno.COMMON_SCENE_COMPLETE, p={}}
protocolno.COMMON_SCENE_COMPLETE = protocolno.COMMON_SCENE_RESERVED + 2
-- 客户端..收到进入某场景的命令
--[[
scene_type = 
define.SCENE_TYPE_TOWN			= 0 -- 主城
define.SCENE_TYPE_ONE			= 1 -- 单人关卡
--]]
-- response:{m=protocolno.COMMON_SCENE_CHANGE,g=guid,r=msgno,p={map_id=0,scene_type=0}}
protocolno.COMMON_ENTER_GAME = protocolno.COMMON_SCENE_RESERVED + 3

-- 玩家第一次进入场景
-- response:{m=protocolno.COMMON_FIRST_IN_SCENE,g=guid,r=msgno,p={enemy=敌方阵容,allies_list=援军,oneself=已方阵容,map_other_info=场景其他信息}}
protocolno.COMMON_FIRST_IN_SCENE = protocolno.COMMON_SCENE_RESERVED +4
 
-- 关卡结算
-- req:{g=guid,m=protocolno.COMMON_ECTYPE_RESULT, p={player_win=输赢,attack_report=战报,attack_hurt=攻击统计,monster_data=敌方剩余兵量,monster_entitys=已方剩余兵量,monster_count=最终回合,anger=已方最终怒气}}
-- response:{m=protocolno.COMMON_ECTYPE_RESULT,g=guid,r=msgno,p=data}
 --[[
data = 
{
   player_win=玩家是否赢了true为赢
   map_id			= int,			   -- 地图ID
   rewardsTable    = table,           -- 道具奖励的id {道具ID1=num，道具ID2=num，...}

}  
--]]
protocolno.COMMON_ECTYPE_RESULT = protocolno.COMMON_SCENE_RESERVED + 8
 
-- 场景中要求进入单人副本(就是单人关卡)
-- req:{g=guid,m=protocolno.COMMON_SCENE_ENTER_ONE_ECTYPE, p={chapter_id=章节id,map_id=副本id,team_id=战队id}
protocolno.COMMON_SCENE_ENTER_ONE_ECTYPE = protocolno.COMMON_SCENE_RESERVED + 9
-- 场景中请求扫荡
-- req:{g=guid,m=protocolno.COMMON_SCENE_MOPUP, p={chapter_id=章节id, num=次数,map_id=副本id}
-- response:{g=guid,m=protocolno.COMMON_SCENE_MOPUP, p={}}
protocolno.COMMON_SCENE_MOPUP = protocolno.COMMON_SCENE_RESERVED + 10
 
-- 分配给GM管理使用
-- 分配700~800号段给GM管理使用
protocolno.COMMON_GM_RESERVED = 700

-- GM关服
-- req:{g=guid,m=protocolno.COMMON_GM_SHUT_DOWN, p={}
protocolno.COMMON_GM_SHUT_DOWN = protocolno.COMMON_GM_RESERVED + 0
-- GM强行关服
-- req:{g=guid,m=protocolno.COMMON_GM_FORCE_SHUT_DOWN, p={}
protocolno.COMMON_GM_FORCE_SHUT_DOWN = protocolno.COMMON_GM_RESERVED + 1


-- 5000以上为功能模块号段
protocolno.MODULE_SVR_RESERVED = 5000

-- 推荐每个功能模块预留100的id号段

-- login 账号验证
-- req:{g=guid,m=protocolno.AUTH_LOGIN, p={1=protocolno.PROTOCOL_VERSIONS_NO}} -- 3=xx表示协议版本号,请填写protocolno.PROTOCOL_VERSIONS_NO，gmlogin=true表示GM账号登陆,前端的同学可以无视
-- response:{m=protocolno.AUTH_LOGIN,g=guid,r=msgno,p={role_max_count=4}} role_max_count最大创建角色数量
protocolno.AUTH_LOGIN = protocolno.MODULE_SVR_RESERVED + 1
-- register 账号注册
-- req:{g=guid,m=protocolno.AUTH_REGISTER, p={plat=平台编号, token=平台的token, uid =平台账号,username=平台昵称如无则用uid}}
-- response:{m=protocolno.AUTH_REGISTER,g=guid,r=msgno,p={}}
protocolno.AUTH_REGISTER = protocolno.MODULE_SVR_RESERVED + 2
--
-- response:{m=protocolno.AUTH_ALLOW,g=guid,r=msgno,p={}}
protocolno.AUTH_ALLOW = protocolno.MODULE_SVR_RESERVED + 3

--[["
-- demo 
protocolno.DEMO_XX = protocolno.MODULE_SVR_RESERVED + 101"]]

-- quest 任务
--查询任务列表
-- req: {}
-- response:p={ [quest_id]=quest_obj }
--[[
local quest_status = {
	CANNOT_ACCEPT = 0, -- 不可领取
	CAN_ACCEPT = 1,  -- 可以领取任务
	ACCEPTED = 2,    -- 已领取任务
	COMPLETE = 3,    -- 已任务完成
	ACCEPT_INVALID = 4,  -- 任务失效
	GET_REWARD = 5,  -- 已领取奖励
}

local quest_class = class()
function quest_class:ctor()
	self.quest_id = 0  -- 任务id
	self.status = quest_status.CANNOT_ACCEPT -- 任务状态
	self.type = 0  -- 任务类型
	self.target_type = 0 -- 目标类型
	self.final_data = {}  -- 目标数据
	self.data = {} -- 进度数据
	self.aeept_time = os.time()  -- 领取时间
end
--]]
protocolno.QUEST_QUERY_LIST = protocolno.MODULE_SVR_RESERVED + 201
-- 任务状态更新
-- req: nil
-- response: p = {[quest_id]=quest_obj}
protocolno.QUEST_DATA_UPDATE = protocolno.MODULE_SVR_RESERVED + 202
-- 提交任务(领取任务奖励)
-- req: {quest_id=}
-- response: {[quest_id]=quest_obj}
protocolno.QUEST_SUBMIT = protocolno.MODULE_SVR_RESERVED + 203

-- BAG
--[[-- 获取背包道具信息接口
	req: {g=guid,m=protocolno.BAG_GET_ITEM_LIST,}
	response:{m=protocolno.BAG_GET_ITEM_LIST,r=msgno.BAG_GET_ITEM_LIST_SUC,p = {[index]= {type_id,count},....}}
]]--
protocolno.BAG_GET_ITEM_LIST = protocolno.MODULE_SVR_RESERVED + 301
--[[-- 使用道具接口
	req: {g=guid,m=protocolno.BAG_USE_ITEM,p={bag_index,count}}
	response:success -> {m=protocolno.BAG_USE_ITEM,r=msgno.BAG_USE_ITEM_SUC,}
			fail -> {m=protocolno.BAG_USE_ITEM,r=errno,}
]]--
protocolno.BAG_USE_ITEM = protocolno.MODULE_SVR_RESERVED + 302
--[[-- 出售道具接口
	req: {g=guid,m=protocolno.BAG_SELL_ITEM,p={bag_index,count}}
	response:success -> {m=protocolno.BAG_SELL_ITEM,r=msgno.BAG_SELL_ITEM_SUC,}
			fail -> {m=protocolno.BAG_SELL_ITEM,r=errno,}
]]--
protocolno.BAG_SELL_ITEM = protocolno.MODULE_SVR_RESERVED + 303
--[[-- 背包道具数量改变 -- 服务端主动推送给客户端
	req: {g=guid,m=protocolno.BAG_ITEM_CHANGE,r= msgno.BAG_CHANGE_ITEM_SUC, p={bag_index={[1] = type_id, [2] = count } .....}}
]]
protocolno.BAG_ITEM_CHANGE = protocolno.MODULE_SVR_RESERVED + 306

--[[-- 整理背包道具信息接口
	req: {g=guid,m=protocolno.BAG_COLLATING_ITEM_LIST,}
	response:{m=protocolno.BAG_COLLATING_ITEM_LIST,r=msgno.BAG_COLLATING_ITEM_LIST_SUCC,p = item_infor}
]]--
protocolno.BAG_COLLATING_ITEM_LIST = protocolno.MODULE_SVR_RESERVED + 310
--[[-- 一键出售接口
	req: {g=guid,m=protocolno.BAG_QUICK_SELL_ITEM,p={[1]={index1,index2 ..... }}
	response:success -> {m=protocolno.BAG_QUICK_SELL_ITEM,r=msgno.BAG_QUICKSELL_ITEM_SUCC,}
			fail -> {m=protocolno.BAG_QUICK_SELL_ITEM, r=errno,p={index}}
]]--
protocolno.BAG_QUICK_SELL_ITEM = protocolno.MODULE_SVR_RESERVED + 311
-- 开启道具礼包的通知
--[[
req: {g=guid,m=protocolno.ITEM_GIFT_OPEN,r= msgno.ITEM_GIFT_OPEN_SUCC,p={item_id=count,... }}
]]--
protocolno.ITEM_GIFT_OPEN = protocolno.MODULE_SVR_RESERVED + 312
-- 合成道具
--req:{g,m,p={new_item_id=,count=}}
--response:{g,m,r,p=nil}
protocolno.BAG_ITEM_MERGE = protocolno.MODULE_SVR_RESERVED + 313
-- 背包扩充
--req:{g,m,p=nil}
--response:{g,m,r,p={}}
protocolno.BAG_EXTEND = protocolno.MODULE_SVR_RESERVED + 314
-- 背包容量
--req:{g,m,p=nil}
--response:{g,m,r,p={extend_count=, max_count=}}
protocolno.BAG_COUNT_UPDATE = protocolno.MODULE_SVR_RESERVED + 315



-- 选择角色 & 创建角色
-- 请求获取角色列表
-- req::{g=guid,m=protocolno.ACCOUNT_ROLES_GET, p={}}
-- response:{m=protocolno.ACCOUNT_ROLES_LIST,g=0,r=msgno.SUCCESS,p={listrole= {{playerid=0,name="",profession=0,lv=0,vip=0},{playerid=0,name="",profession=0,lv=0,vip=0}...}}, playerid=最后登录的ＩＤ}
protocolno.ACCOUNT_ROLES_GET = protocolno.MODULE_SVR_RESERVED + 501
-- 创建角色
-- req::{g=guid,m=protocolno.ACCOUNT_ROLES_CREATE, p={name=xx,sex=0}}   0 男 1 女
-- response:{m=protocolno.ACCOUNT_ROLES_CREATE,g=0,r=msgno.SUCCESS,p={{playerid=0,name="",sex=0,vip=0}}}
protocolno.ACCOUNT_ROLES_CREATE = protocolno.MODULE_SVR_RESERVED + 502
-- 使用某个角色进入游戏
-- req::{g=guid,m=protocolno.ACCOUNT_ROLES_USE, p={playerid=xx}}
-- response:{m=protocolno.ACCOUNT_ROLES_USE,g=0,r=msgno.SUCCESS,p={playerid=0,name=""}}
protocolno.ACCOUNT_ROLES_USE = protocolno.MODULE_SVR_RESERVED + 503
--主动推动玩家排队的位置
-- response:{m=protocolno.ACCOUNT_LIST_SEAT,g=0,r=msgno.SUCCESS,p={seat = 1}}
protocolno.ACCOUNT_LIST_SEAT = protocolno.MODULE_SVR_RESERVED + 505

-- shop
-- 购买商品
-- req:{g=,m=, p={position=,count=1}}
-- response:{g,m,r,p}
protocolno.SHOP_BUY = protocolno.MODULE_SVR_RESERVED + 701
-- 查询商品/打开商店
-- req::{g=,m=, p=}
-- response:{g,m,r,p}
protocolno.SHOP_OPEN = protocolno.MODULE_SVR_RESERVED + 702
-- 刷新商品
-- req::{g=, m=, p=}
-- response:{g,m,r,p}
protocolno.SHOP_REFRESH = protocolno.MODULE_SVR_RESERVED + 703
-- 更新商品信息
-- req::{g=,m=,p={goods={[position]={status=,goods_id=}}, left_time=, cost_refresh_count=}
-- response:{g,m,r,p}
protocolno.SHOP_UPDATE = protocolno.MODULE_SVR_RESERVED + 704


 
------------------player 人物数据信息
-- 获取角色的属性
-- req::{g=guid,m=protocolno.PLAYER_GET_INFOR, p={"lev",}}
-- response:{m=protocolno.PLAYER_GET_INFOR,r=msgno.PLAYER_GET_INFOR_SUC,p={lev = 1 , ...}}
protocolno.PLAYER_GET_INFOR = protocolno.MODULE_SVR_RESERVED + 1001
-- 角色属性发生改变接口-- 服务端主动推送给客户端
-- req::{g=guid,m=protocolno.PLAYER_UPDATE_BASIC, r =nil, p={name=xxx, exp=123, gold = 123 }}
protocolno.PLAYER_UPDATE_BASIC = protocolno.MODULE_SVR_RESERVED + 1002 --更新角色基础信息接口
--[[ 领取VIP礼包接口
req::{g=guid,m=protocolno.PLAYER_GET_VIP_AWARDS, p={player_id= 1, [1]=vip_lev}}
response:success -> {m=protocolno.PLAYER_GET_VIP_AWARDS,r=msgno.PLAYER_GET_VIP_AWARDS_SUC}
			fail-> {m=protocolno.PLAYER_GET_VIP_AWARDS,r=msgno.PLAYER_GET_VIP_AWARDS_FAL,p= errno}
]]--
protocolno.PLAYER_GET_VIP_AWARDS  = protocolno.MODULE_SVR_RESERVED + 1003
--[[ 获取装备信息接口
req::{g=guid,m=protocolno.PLAYER_GET_EQUIP_DATA, p=}
response:success -> {m=protocolno.PLAYER_GET_EQUIP_DATA,r=msgno.PLAYER_GET_EQUIP_DATA_SUC,p =equip_data
			fail-> {m=protocolno.PLAYER_GET_EQUIP_DATA,r= errno}
]]--
protocolno.PLAYER_GET_EQUIP_DATA = protocolno.MODULE_SVR_RESERVED + 1004
--[[ 查看其他玩家信息接口
req::{g=guid,m=protocolno.PLAYER_GET_OTHER_INFOR, p={1]=other_player_id}
response:success -> {m=protocolno.PLAYER_GET_OTHER_INFOR,r=msgno.PLAYER_GET_OTHER_INFOR
         p = {[1] = player_infor是一个table,[2]={equipdata是一个table}}
         fail-> {m=protocolno.PLAYER_GET_OTHER_INFOR,r= errno}
]]--
protocolno.PLAYER_GET_OTHER_INFOR = protocolno.MODULE_SVR_RESERVED + 1005


--[[ 更新新手引导
response:success -> {m=protocolno.PLAYER_GET_NEWBIE_GUIDE_INFOR,r=msgno.PLAYER_GET_KEY_SEAT_SUC, p ={guide_list={},cur_guide}
]]--
protocolno.PLAYER_GET_NEWBIE_GUIDE_INFOR = protocolno.MODULE_SVR_RESERVED + 1006
--[[ 更新新手引导数据
req::{g=guid,m=protocolno.PLAYER_SET_NEWBIE_GUIDE_INFOR, p={guide_id = guide_id, guide_type =1/2}
]]--
protocolno.PLAYER_SET_NEWBIE_GUIDE_INFOR = protocolno.MODULE_SVR_RESERVED + 1007
--[[ 主动推送打开的图标
response:success -> {m=protocolno.PLAYER_GET_OPEN_ICON,r=msgno.PLAYER_GET_KEY_SEAT_SUC, p ={}
]]--
protocolno.PLAYER_GET_OPEN_ICON = protocolno.MODULE_SVR_RESERVED + 1008
--[[ 更新打开的图标
response:success -> {m=protocolno.PLAYER_GET_OPEN_ICON,r=msgno.PLAYER_SET_OPEN_ICON, p ={icon_name= ""}
]]--
protocolno.PLAYER_SET_OPEN_ICON = protocolno.MODULE_SVR_RESERVED + 1009
--[[ 更新货币变化
response:success -> {m=protocolno.PLAYER_UPDATE_CURRENCY,r=msgno.SUCCESS, p ={exp=xx, gold=xx,...}
]]--
protocolno.PLAYER_UPDATE_CURRENCY = protocolno.MODULE_SVR_RESERVED + 1010
 
--[[ 更新建筑
response:success -> {m=protocolno.PLAYER_UPDATE_BUILDING,r=msgno.SUCCESS, p ={{buildId:buildId,buildLv,buildType}}
]]--
protocolno.PLAYER_UPDATE_BUILDING = protocolno.MODULE_SVR_RESERVED + 1011

--[[ 更新统帅
response:success -> {m=protocolno.PLAYER_UPDATE_MONSTER,r=msgno.SUCCESS, p ={{monsterId:monsterId(统帅id),monsterNum(当前兵量),step(统帅阶数),skills(技能列表table)}}
]]--
protocolno.PLAYER_UPDATE_MONSTER = protocolno.MODULE_SVR_RESERVED + 1012

--[[ 饰品
response:success -> {m=protocolno.PLAYER_UPDATE_DECORATION,r=msgno.SUCCESS, p ={{holeId:status=(1未开启,2已开启),itemId}}
]]--
protocolno.PLAYER_UPDATE_DECORATION = protocolno.MODULE_SVR_RESERVED + 1013
--[[ 饰品穿戴
req:{g=guid,m=protocolno.EQUIP_DECORATION, p={seat_id=孔位id,decorate_id=饰品id}}
response:success -> {m=protocolno.EQUIP_DECORATION,r=msgno.SUCCESS, p ={}
]]--
protocolno.EQUIP_DECORATION = protocolno.MODULE_SVR_RESERVED + 1014
--[[ 
饰品脱下
req:{g=guid,m=protocolno.UNEQUIP_DECORATION, p={seat_id=孔位id}}
response:success -> {m=protocolno.UNEQUIP_DECORATION,r=msgno.SUCCESS, p ={}
]]--
protocolno.UNEQUIP_DECORATION = protocolno.MODULE_SVR_RESERVED + 1015
--[[ 
更新封地
response:success -> {m=protocolno.PLAYER_UPDATE_FIEF,r=msgno.SUCCESS, p ={fief_obj={[章节id][封地id]={store(封地仓库和产量)={[道具id或者关键字money]= 产量},cells(格子里的建筑0为默认建筑)={[格子id]={buildId=建筑id,buildLv=建筑等级,storeNum=单建筑的容量,produce=生产信息[数量,分钟数,生产的资源]},storeNum=所有建筑的仓库总和,getCd=单封地的领取cd}}},getCd=封地的领取cd}
]]--
protocolno.PLAYER_UPDATE_FIEF = protocolno.MODULE_SVR_RESERVED + 1016
--[[ 
银矿战个人信息
req:{g=guid,m=protocolno.PLAYER_UPDATE_SILVER, p={silver_item=秘银数量,mine_status={[矿区id]=true},mine_point{mine_point_id=自己占领的矿点,mine_area_id=自己占领的矿点所在矿区,pos=位置,hold_timestamp=公共矿区采集时间点},player_layout(防守阵容)={[pos]=monsterob(与统帅数据一致)},auto_recharge=自己的防守阵容自动补兵,attack_layout(出战阵容)={},attack_auto_recharge=出战阵容自动补兵,rice_item={[itemid]=item数量}(该系统中的粮草数量)}}
response:success -> {m=protocolno.UNEQUIP_DECORATION,r=msgno.SUCCESS, p ={}
]]--
protocolno.PLAYER_UPDATE_SILVER = protocolno.MODULE_SVR_RESERVED + 1017

--[[ 购买体力
req::{g=guid,m=protocolno.PLAYER_BUY_ENERGY, }
response:success -> {m=protocolno.PLAYER_BUY_ENERGY,r=msgno.PLAYER_BUY_ENERGY_SUC}
		fail-> {m=protocolno.PLAYER_BUY_ENERGY,r= errno}
]]--
protocolno.PLAYER_BUY_ENERGY = protocolno.MODULE_SVR_RESERVED + 1009

---------------------- player 人物数据信息 结束


-- mail
-- 邮件格式
-- mail: mail_id={}
-- self.type      = ""               --邮件类型
-- self.title     = ""               --邮件标题
-- self.context   = ""               --邮件描述
-- self.time      = 0                --时间
-- self.open_state= mail_state.OPEN_STATE_NO   --打开状态 0未打开,1打开
-- self.sender    = {name="", send_player_id=0}     -- 发件人信息

-- -- 附件
-- self.attach = {
		-- gold      = 0,  --钻石
		-- money     = 0,  --银两
		-- atk_val   = 0,  --战功, 怪物攻城
		-- prestige  = 0,  --声望, 竞技场
		-- item      = {}, --背包道具
		-- monster   = {}, --统帅
		-- --rune      = {}, --符文
-- }
-- self.attach_state = mail_state.ATTACH_STATE_NO --附件状态  0没有附件,无法领取, 1可以领取,  2已经领取

-- 主动推送所有邮件
-- response: p={mail_list={[mail_id]=mail_obj}}
protocolno.MAIL_ALL = protocolno.MODULE_SVR_RESERVED + 1201
-- 新邮件,服务器推送
-- req:p=nil
-- response: p={mail_list={[mail_id]=mail_obj}}
protocolno.MAIL_NEW = protocolno.MODULE_SVR_RESERVED + 1202
-- 打开邮件
-- req: p={mail_id=}
-- response:p={mail_id=, open_state=}
protocolno.MAIL_OPEN = protocolno.MODULE_SVR_RESERVED + 1203
-- 领取附件
-- req: p={mail_id=}
-- response:p={mail_id=, attach_state=}
protocolno.MAIL_GET_ATTACH = protocolno.MODULE_SVR_RESERVED + 1204
-- 删除邮件
-- req: p={mail_id=}
-- response:p={mail_id=}
protocolno.MAIL_DELET = protocolno.MODULE_SVR_RESERVED + 1205
-- 一键领取, 会推送被删除的mail_id
-- req:
-- response: p = {del_list={[mail_id]=mail_id,}}
protocolno.MAIL_GET_ALL = protocolno.MODULE_SVR_RESERVED + 1206
-- 发送邮件
-- req: { title=, context=, target_player_id=}
-- response: p = nil
protocolno.MAIL_SEND_MAIL = protocolno.MODULE_SVR_RESERVED + 1207
-- 发送邮件给GM
-- req: { title=, context=, qq=, ask_type= }
-- response: p = nil
protocolno.MAIL_SEND_GM = protocolno.MODULE_SVR_RESERVED + 1208



-- chat
-- 通用聊天
-- req: p={type=, msg="我是XXX", t_player_id=} type=1系统,2世界,3工会,4私聊,5公告 , t_player_id私聊对象
-- response: p = {}
protocolno.CHAT_COMMON = protocolno.MODULE_SVR_RESERVED + 1320
-- 推送通用聊天
-- req: p={type=, msg="我是XXX", player=} type=1系统,2世界,3工会,4私聊,5公告
-- response: p = {}
protocolno.CHAT_COMMON_PUSH = protocolno.MODULE_SVR_RESERVED + 1321
-- 查看玩家阵容
-- req: p={t_player_id=,}
-- response: p = {}
protocolno.VIEW_PLAYER_MONSTERS = protocolno.MODULE_SVR_RESERVED + 1322
-- 查看玩家装备
-- req: p={t_player_id=,}
-- response: p = {}
protocolno.VIEW_PLAYER_EQUIP = protocolno.MODULE_SVR_RESERVED + 1323
-- 查看玩家建筑
-- req: p={t_player_id=,}
-- response: p={}
protocolno.VIEW_PLAYER_BUILDING = protocolno.MODULE_SVR_RESERVED + 1324


-- g id 自增长起始值10w
protocolno.GLOBAL_START_ID = 100000


-- 公会系统
-- guild_class:[guild_id] = {guild_num_n = 当前人书, 
--							guild_num = 公会总人数, 
--							president_name = 会长名字, 
--							guild_lv = 公会等级,
--							guild_name = 公会名字, 
--							common = 标识（1表示申请了 0表示没有申请 }
--显示公会个数
-- req:{g, m, r, p={}}
-- response:{g, m, r, p={num = 1}}
protocolno.GUILD_SHOW_NUM = protocolno.MODULE_SVR_RESERVED + 1401
--显示公会列表
-- req:{g, m, r, p={begin = 上限, tail = 下限}}
-- response:{g, m, r, p={guild= {guild_class,guild_class}}
protocolno.GUILD_SHOW_GUILD_LIST = protocolno.MODULE_SVR_RESERVED + 1402
--通过公会名或id获取公会（公会搜索）
-- req:{g, m, r, p={guild_name = ""}}
-- response:{g, m, r, p={guild = {guild_class}}
protocolno.GUILD_SHOW_FORM_ID = protocolno.MODULE_SVR_RESERVED + 1403
--创建公会
-- req:{g, m, r, p={guild_name = "", guild_icon = 2}}
-- response:{g, m, r, p=={guild_id = 101}}
protocolno.GUILD_CREATE = protocolno.MODULE_SVR_RESERVED + 1404
--解散公会(会长)
--req:{g, m, r, p={}}}
--response:{g, m, r, p=p={}}
protocolno.GUILD_DISSOLVE = protocolno.MODULE_SVR_RESERVED + 1405
-- 公会升级(自动，服务器推送)
--req:{g, m, r, p={}}}
--response:{g, m, r, p={}}
protocolno.GUILD_LEVELUP = protocolno.MODULE_SVR_RESERVED + 1406
-----------------------------加入、退出公会--------------------
--显示玩家申请加入本公会申请列表(会长、副会长)
--apply:[1] = {player_name = 'name', player_lv = 10,player_id = 101}
-- req:{g, m, r, p={}}
-- response:{g, m, r, p={apply = {apply,apply}}
protocolno.GUILD_SHOW_APPLY_LIST = protocolno.MODULE_SVR_RESERVED + 1407
--清空玩家申请加入公会列表(会长、副会长)
-- req:{g, m, r, p={}}
-- response:{g, m, r, p={}}
protocolno.GUILD_EMPTY_APPLY_LIST = protocolno.MODULE_SVR_RESERVED + 1408
-- 玩家申请加入公会
-- req:{g, m, r, p={guild_id = 101}}
-- response:{g, m, r, p={}}
protocolno.GUILD_APPLY_GUILD = protocolno.MODULE_SVR_RESERVED + 1409
-- 邀请玩家加入公会
-- req:{g, m, r, p={targe_id = 101}}
-- response:{g, m, r, p={}}
protocolno.GUILD_INVITE_APPLY_GUILD = protocolno.MODULE_SVR_RESERVED + 1410
-- 批准玩家加入公会(会长、副会长)
-- req:{g, m, r, p={targe_id = 101}}
-- response:{g, m, r, p={}}
protocolno.GUILD_APPLY_TO_GUILD = protocolno.MODULE_SVR_RESERVED + 1411
-- 拒绝玩家加入公会(会长、副会长)
-- req:{g, m, r, p={targe_id = 101}}
-- response:{g, m, r, p={}}
protocolno.GUILD_REFUSE_TO_GUILD = protocolno.MODULE_SVR_RESERVED + 1412
--踢出公会(会长、副会长)
--req:{g, m, r, p={targe_id = 101}}}
--response:{g, m, r, p={}}
protocolno.GUILD_DELETE_MEMBER = protocolno.MODULE_SVR_RESERVED + 1413
--主动退出公会
--req:{g, m, r, p={}}}
--response:{g, m, r, p={}}
protocolno.GUILD_EXIT_MEMBER = protocolno.MODULE_SVR_RESERVED + 1414
----------------------------------------------------
--显示玩家公会ID跟权限
--req:{g, m, r, p={player_id=玩家id}}}
--response:{g, m, r, p={guild_id= 0, power = 0, guild_name = ""/nil}}
protocolno.GUILD_SHOW_POWER = protocolno.MODULE_SVR_RESERVED + 1415
--获取公会基本信息
--info:{guild_lv = 公会等级, guild_announcement_time = 公告时间,guild_num_n = 当前人数,guild_announcement = 公告,guild_bank= 银库,guild_exp=公会经验,guild_num= 总人数,guild_con=个人贡献, guild_name= , guild_id = ,president_name=会长名字 }
-- req:{g, m, r, p={}}
-- response:{g, m, r, p={guild = info}}
protocolno.GUILD_GET_INFO = protocolno.MODULE_SVR_RESERVED + 1416
--玩家列表排序权限
--player_info:[1] = {player_name = 'abc', player_lv = 20, guild_con_day = 公会每日贡献 , is_online = 是否在线, player_id = 101, power = 1--会长 2--护法 3--长老 4 --成员}
--req:{g, m, r, p={}}}
--response:{g, m, r, p={guild_member = {player_info,player_info}}}
protocolno.GUILD_SHOW_MEMBER_POWER = protocolno.MODULE_SVR_RESERVED + 1417
--玩家列表排序等级
--req:{g, m, r, p={}}}
--response:{g, m, r, p={player_info,player_info}}
protocolno.GUILD_SHOW_MEMBER_LV = protocolno.MODULE_SVR_RESERVED + 1418
-- 修改玩家权限（会长）
--req:{g, m, r, p={guild_member_id = 101, power = 1}}}
--response:{g, m, r, p={player_id = 1, power = 1,}}
protocolno.GUILD_UP_POWER = protocolno.MODULE_SVR_RESERVED + 1419
--------------------------------------------------------------------------
--修改宣言
--req:{g, m, r, p={announcement = " "}}}
--response:{g, m, r, p={}}
protocolno.GUILD_WRITE_ANNOUNCEMENET = protocolno.MODULE_SVR_RESERVED + 1420
--发布日志
--req:{g, m, r, p={content = " "}}}
--response:{g, m, r, p={}}
-- 1:公会创建 p = {now,1,"会长名"}
-- 2:玩家加入帮派 p = {now,2,"玩家名"}
-- 3:玩家离开帮派 p = {now,3,"玩家名"}
-- 4:玩家被剔除帮派	p = {now,4, "会长或副会长名", "被踢玩家名"}
-- 5:玩家被提升或降下职位 p = {now,5, "玩家名", 2表示提升为副会长3表示将副会长降为成员}
-- 6:帮派升级 p = {now,6, 公会等级}
-- 7:发布日志 p = {now,7, "发布者名字", "日志内容"}
-- 8:帮派设宴 p = {now,8, "设宴者名字"，消耗金币，消耗钻石}
protocolno.GUILD_PUBLISH_LOG = protocolno.MODULE_SVR_RESERVED + 1421
--设宴（会长）
--req:{g, m, r, p={}}}
--response:{g, m, r, p={}}
protocolno.GUILD_GIVE_BANQUET = protocolno.MODULE_SVR_RESERVED + 1422
--领取宴会体力
--req:{g, m, r, p={}}}
--response:{g, m, r, p={}}
protocolno.GUILD_GET_BANQUET_ENERGY = protocolno.MODULE_SVR_RESERVED + 1423
--权限被动修改主动发（服务器推送）
--response:{g, m, r, p={power = 0, guild_id= 0,guild_name = ""/nil}}
protocolno.GUILD_SEND_POWER_CHANGE = protocolno.MODULE_SVR_RESERVED + 1424
--查询公会事件(查看日志)
--req:{g=guid,m=protocolno.GUILD_QUERY_EVENT, p={}
--response:{m=protocolno.GUILD_QUERY_EVENT,g=guid,r=msgno.SUCCESS ,p={{[1] = nowtime, [2] = type, [3] = content},}
protocolno.GUILD_QUERY_EVENT = protocolno.MODULE_SVR_RESERVED + 1425
-- 查看公会邀请
-- req:{g, m, r, p={}}
-- response:{g, m, r, p={}}
protocolno.GUILD_GET_INVITE_LIST = protocolno.MODULE_SVR_RESERVED + 1426
-- 忽略公会邀请
-- req:{g, m, r, p={guild_id = 101, inviter_id = 100}}
-- response:{g, m, r, p={}}
protocolno.GUILD_IGNORE_INVITE = protocolno.MODULE_SVR_RESERVED + 1427
-- 接受公会邀请, 如果是会长、副会长邀请则直接加入公会， 如果是普通玩家邀请则进行申请
-- req:{g, m, r, p={guild_id = 101, inviter_id = 100}}
-- response:{g, m, r, p={}}
protocolno.GUILD_ACCEPT_INVITE = protocolno.MODULE_SVR_RESERVED + 1428
--获取宴会信息
--req:{g, m, r, p={}}}
--response:{g, m, r, p={}}
-- p = {
-- 	banquet_time = banquet_time, 	--设宴时间
-- 	banquet_id  = banquet_id,	--设宴者id
-- 	banquet_name  = banquet_name,	--设宴者名字
-- 	banquet_status = 1, -- 1:未到宴会时间，2：到了宴会时间未设宴，3：已设宴未领取，4：已设宴已领取,5:宴会已无效
-- 	vaild_time = , -- 宴会剩余有效时间
-- }
protocolno.GUILD_GET_BANQUET_INFO = protocolno.MODULE_SVR_RESERVED + 1429

--推送能否领取宴会体力通知
--req:{g, m, r, p={}}}
--response:{g, m, r, p={status = 0}}  -- 1表示当前可领取宴会体力 2表示宴会过期无法领取
protocolno.GUILD_CAN_GET_BANQUET_NOTICE = protocolno.MODULE_SVR_RESERVED + 1430


--显示公会商店
--shop:[1] = { limit_num = 1,price = 0,goods_num = 100,item_id = 14000005,total_num=总值}
--req:{g=guid,m=protocolno.GUILD_SEND_SHOP, p={}}}
--response:{m=protocolno.GUILD_SEND_SHOP,g=guid,r=msgno.GUILD_SHOW_SHOP_SUCCESS ,p={shop = {shop,shop},con = 贡献值}}
--protocolno.GUILD_SHOW_SHOP = protocolno.MODULE_SVR_RESERVED + 1421
--购买公会商店
--req:{g=guid,m=protocolno.GUILD_BUY_SHOP, p={seat_id = 1, num = 1}}}
--response:{m=protocolno.GUILD_BUY_SHOP,g=guid,r=msgno.GUILD_BUY_SHOP_SUCCESS ,p={}}
-- protocolno.GUILD_BUY_SHOP = protocolno.MODULE_SVR_RESERVED + 1422
--------------------------------------------------------------------------




-- 更新场景统计信息
-- response:{m=protocolno.SCENE_STATISTICS_UPDATE,g=guid,r=msgno, p = {scene_type_one = {[章节id]={mapdata={[地图id]={challengecount=剩余挑战次数,star=星级，resetcount=购买过的挑战次数，startopen=是否是刚开启的副本，count=总通关次数，visit=隐藏副本拜访度}#单人关卡统计}},boxdata={[宝箱id]={state=宝箱状态(1刚开启,2已领取),pos=位置}}}}}
protocolno.SCENE_STATISTICS_UPDATE = protocolno.MODULE_SVR_RESERVED + 3000

-------------好友
-- 添加联系人1:好友、2:临时好友
-- req:{g=guid,m=protocolno.ADD_FRIEND,p={target_player_id=50001,friend_type=1}}
-- response:{g=guid,m=protocolno.ADD_FRIEND,r=msgno,p={target_player_id=目标角色id}单向好友添加成功返回目标角色信息}
protocolno.ADD_FRIEND = protocolno.MODULE_SVR_RESERVED + 4000
-- 删除联系人（好友、临时好友、仇人）
-- req:{g=guid,m=protocolno.DEL_FRIEND,p={target_player_id=50001}}
-- response:{g=guid,m=protocolno.DEL_FRIEND,r=msgno,p={target_player_id=目标角色id}}
protocolno.DEL_FRIEND = protocolno.MODULE_SVR_RESERVED + 4001
-- 把好友加入黑名单
-- req:{g=guid,m=protocolno.JOIN_BLACK,p={target_player_id=50001}}
-- response:{g=guid,m=protocolno.JOIN_BLACK,r=msgno}
protocolno.JOIN_BLACK = protocolno.MODULE_SVR_RESERVED + 4002
-- 把好友从黑名单移除
-- req:{g=guid,m=protocolno.JOIN_BLACK,p={target_player_id=50001}}
-- response:{g=guid,m=protocolno.JOIN_BLACK,r=msgno}
protocolno.DELETE_FROM_BLACK = protocolno.MODULE_SVR_RESERVED + 4003
-- 好友申请操作
-- req:{g=guid,m=protocolno.ASKING_ACTION_FRIEND,p={action={1同意 ,0拒绝},target_player_id=好友id}}
-- response:{g=guid,m=protocolno.ASKING_ACTION_FRIEND,r=msgno.SUCCESS,p={action={1同意 ,0拒绝},target_player_id=好友id}}
protocolno.ASKING_ACTION_FRIEND = protocolno.MODULE_SVR_RESERVED + 4004
-- 访问好友 赠送体力
-- req:{g=guid,m=protocolno.QUICK_ADD_FRIEND,p={target_player_id=好友id}}
-- response:{g=guid,m=protocolno.QUICK_ADD_FRIEND,r=msgno.SUCCESS,p={target_player_id=好友id}}
protocolno.VISIT_FRIEND = protocolno.MODULE_SVR_RESERVED + 4005
-- 访客领取体力
-- req:{g=guid,m=protocolno.VISITOR_GETAWARD_FRIEND,p={target_player_id=好友id}}
-- response:{g=guid,m=protocolno.VISITOR_GETAWARD_FRIEND,r=msgno.SUCCESS,p={sp_count=体力点数}}
protocolno.VISITOR_GETAWARD_FRIEND = protocolno.MODULE_SVR_RESERVED + 4006
-- 批量访客领取体力
-- req:{g=guid,m=protocolno.BATCH_VISITOR_GETAWARD_FRIEND,p={}}
-- response:{g=guid,m=protocolno.BATCH_VISITOR_GETAWARD_FRIEND,r=msgno.SUCCESS,p={sp_count=体力点数}}
protocolno.BATCH_VISITOR_GETAWARD_FRIEND = protocolno.MODULE_SVR_RESERVED + 4007
-- 好友批量同意拒绝申请操作
-- req:{g=guid,m=protocolno.BATCH_ASKING_ACTION_FRIEND,p={action={1同意 ,0拒绝}}}
-- response:{g=guid,m=protocolno.BATCH_ASKING_ACTION_FRIEND,r=msgno.SUCCESS,p={action={1同意 ,0拒绝},target_player_ids={成功的好友id}}
protocolno.BATCH_ASKING_ACTION_FRIEND = protocolno.MODULE_SVR_RESERVED + 4008
-- 查找角色 
-- req:{g=guid,m=protocolno.FIND_FRINED_BY_COLUMN,p={find_column=角色名或者playerid}}
-- response:{g=guid,m=protocolno.FIND_FRINED_BY_COLUMN,r=msgno.SUCCESS,p={id=?,name=?,,vip=?,black=?,enemy=?,lv=等级,asking=申请状态(1:在申请中 0：已通过 ,2 :被申请, 3:拒绝),is_vistor=今日是否访问过(0今天未访问 1 访问过  )}}
protocolno.FIND_FRINED_BY_COLUMN = protocolno.MODULE_SVR_RESERVED + 4009
-- 批量访问好友
-- req:{g=guid,m=protocolno.BATCH_VISIT_FRIEND,p={}}
-- response:{g=guid,m=protocolno.BATCH_VISIT_FRIEND,r=msgno.SUCCESS,p={target_player_ids={成功的好友id}}
protocolno.BATCH_VISIT_FRIEND = protocolno.MODULE_SVR_RESERVED + 4010


-- 推送联系人列表
-- response:{g=guid,m=protocolno.CONTACT_LIST,r=msgno.PUSH_CONTACT_LIST_SUC, p={get_energy_count=领取体力次数,friend_list(好友列表)=[playerid]={id=?,name=?,vip=?,black=?,enemy=?,lv=等级,,asking=申请状态(1:在申请中 0：已通过 ,2 :被申请, 3:拒绝),is_vistor=今日是否访问过(0今天未访问 1 访问过  ),be_vistor=被访问没,asking_time=上次申请时间,offline_time=离线时间,sex=性别,is_online=是否在线}}
protocolno.CONTACT_LIST = protocolno.MODULE_SVR_RESERVED + 4011
--推送操作
-- 推送好友删除
-- response:{g=guid,m=protocolno.PUSH_DELETE_FRIEND,p={target_player_id=谁把你删除了}}
protocolno.PUSH_DELETE_FRIEND = protocolno.MODULE_SVR_RESERVED + 4012
-- 推送访客请求
-- response:{g=guid,m=protocolno.PUSH_VISIT_INFO,r=msgno.SUCCESS,p={target_player_id=好友角色id}}
protocolno.PUSH_VISIT_INFO = protocolno.MODULE_SVR_RESERVED + 4013
--推送好友申请
-- response:{g=guid,m=protocolno.PUSH_ASKING_FRIEND,r=msgno,p={id=?,name=?,profession=?,vip=?,black=?,enemy=?,lv=等级,fight=战斗力,asking=申请状态(1:在申请中 0：已通过 ,2 :被申请, 3:拒绝),is_vistor=今日是否访问过(0今天未访问 1 访问过  2 领取过体力)}}
protocolno.PUSH_ASKING_FRIEND = protocolno.MODULE_SVR_RESERVED + 4014
--推送好友操作
-- response:{g=guid,m=protocolno.PUSH_ACTION_FRIEND,r=msgno,p={id=?,name=?,profession=?,vip=?,black=?,enemy=?,lv=等级,fight=战斗力,asking=申请状态( 0：已通过 , 3:拒绝),is_vistor=今日是否访问过(0今天未访问 ),action =(1同意 ,0拒绝)}}
protocolno.PUSH_ACTION_FRIEND = protocolno.MODULE_SVR_RESERVED + 4015


-- 活动
--推送奖励状态列表
--response:{g=0,m=protocolno.CONTACT_ACTIVE_REWARD_LIST,r=msgno.ACTIVE_REWARD_STATUS_CHANGE_SUCCESS, p={}}
protocolno.CONTACT_ACTIVE_REWARD_LIST = protocolno.MODULE_SVR_RESERVED + 5001
--获取指定类型活动数据(测试用)
-- req:{g, m, r, p={activity_type = }}
-- response:如protocolno.ACTIVE_REWARD_STATUS_CHANGE
protocolno.ACTIVE_GET_ACTIVITY_INFO = protocolno.MODULE_SVR_RESERVED + 5002
--活动   key =active_id v  = {}
--奖励状态改变主动推送给客户端
-- response:{g=0,m=protocolno.ACTIVE_REWARD_STATUS_CHANGE,r=msgno.ACTIVE_REWARD_STATUS_CHANGE_SUCCESS, 
--活动类型1 = {start_time =00，end_time = 00，last_reward_time = 000，child_actives = {active_id = {reward_status = 0,custom_data = {}},}
protocolno.ACTIVE_REWARD_STATUS_CHANGE = protocolno.MODULE_SVR_RESERVED + 5003
--领取活动奖励
-- req:{g=guid,m=protocolno.ACTIVE_GET_REWARD,p={activity_id=?,instance_id=?}}	--activity_id:子活动id intsance_id:区别同种活动的id
-- response:{g=guid,m=protocolno.ACTIVE_GET_REWARD,r=msgno}
protocolno.ACTIVE_GET_REWARD = protocolno.MODULE_SVR_RESERVED + 5004
--活动信息通知
-- 服务端主动推送
-- response: {g,m,r,p=nil}
protocolno.ACTIVE_MSG = protocolno.MODULE_SVR_RESERVED + 5005
-- 填写邀请码
-- response: {g,m,r,p={f_id=0}}
protocolno.ACTIVE_INVITE_FRIEND_CODE = protocolno.MODULE_SVR_RESERVED + 5006
-- 购买成长基金礼包
-- response: {g,m,r,p={f_id=0}}
protocolno.ACTIVE_BUY_LEVEL_FUND = protocolno.MODULE_SVR_RESERVED + 5007



-- GM客服
-- req:{g=guid,m=protocolno.GM_SERVICE,p={type=?,text=?}}
-- response:{g=guid,m=protocolno.GM_SERVICE,r=msgno.SUCCESS}
-- protocolno.GM_SERVICE = protocolno.MODULE_SVR_RESERVED + 7000

--GM命令
protocolno.GM_SEND_MAIL = protocolno.MODULE_SVR_RESERVED + 8001

-- 打印前端异常
--req:{g=guid,m=protocolno.LUA_PRINT,p={words = ""}}
protocolno.LUA_PRINT = protocolno.MODULE_SVR_RESERVED + 10000

-- 是否关闭打印前端异常
--req:{g=guid,m=protocolno.CLOSE_LUA_PRINT,p={}}
protocolno.CLOSE_LUA_PRINT = protocolno.MODULE_SVR_RESERVED + 10001

--跑马灯更新
--req:{g=guid,m=protocolno.CHAT_SYSTEM,p={seat = 0只发送一次 1替换跑马灯内容, message=""}}
protocolno.CHAT_SYSTEM = protocolno.MODULE_SVR_RESERVED + 10002


--战斗力排行榜数据
--req:{g=guild,m=protocolno.CHECK_FIGHT_RANK_INFO,p={upper = 1, lower = 20}}
--response:{g=guid,,m=protocolno.CHECK_FIGHT_RANK_INFO,p={list={[1] = {player_id = 10001, player_name= "ABC", player_lv = 10, fight = 10},myrank=自身排名(-1未上榜)}}
protocolno.CHECK_FIGHT_RANK_INFO = protocolno.MODULE_SVR_RESERVED + 13000
--等级排行榜数据
--req:{g=guild,m=protocolno.CHECK_LV_RANK_INFO,p={upper = 1, lower = 20}}
--response:{g=guid,,m=protocolno.CHECK_LV_RANK_INFO,p={list={[1] = {player_id = 10001, player_name= "ABC", player_lv = 10, fight = 10},myrank=自身排名(-1未上榜)}}
protocolno.CHECK_LV_RANK_INFO = protocolno.MODULE_SVR_RESERVED + 13001


 
-- 推送高战力装备
-- req: 服务器主动推送
-- response: {g=0, m=protocolno.PUSH_HIGHFIGHTING_EQUIP,r=msgno.SUCCESS,p={itemid={add_fighting=1,bag_index=1}}
protocolno.PUSH_HIGHFIGHTING_EQUIP = protocolno.MODULE_SVR_RESERVED + 16001


-- 推送充值
-- req: {g, m, r, p = {player_id=, recharge_id=1}}  读后台数据库,不直接和客户端联系
-- response: {g, m, r, p=nil}
protocolno.RECHARGE_RECHARGE = protocolno.MODULE_SVR_RESERVED + 17001

-- 打开充值面板
-- req: {g, m, r, p={player_id=}}
-- response: {g, m, r, p={vip_exp=100, recharge_data={[id]=count,}}}
protocolno.RECHARGE_OPEN_RECHARGE_PAGE = protocolno.MODULE_SVR_RESERVED + 17002

-- 签到
-- 请求签到数据
-- req: {g,m,r,p={}}
-- response: {g,m,r,p={today_can_sign=,reward=,dt=}}
-- reward = {[reward_day]=status} status 0未领取,1已领取普通, 2已领取vip翻倍
protocolno.SIGN_REQUEST_SIGN_DATA = protocolno.MODULE_SVR_RESERVED + 18001

-- 服务器推送,今日还可以进行签到
-- req: nil
-- response: {g,m,r,p=nil}
protocolno.SIGN_CAN_SIGN = protocolno.MODULE_SVR_RESERVED + 18002

-- 今日签到
-- req: {g,m,r,p={}}
-- response: {g,m,r,p={reward_day=,status=, reward_type=}}
protocolno.SIGN_SIGN_TODAY = protocolno.MODULE_SVR_RESERVED + 18003


-- 更新数据
-- req: {g,m,r,p={}}
-- response: {g,m,r,p={pub={}}}
protocolno.UPDATE_BASE_DATA = protocolno.MODULE_SVR_RESERVED + 21001

-- 酒馆
-- 设宴
-- req: {g,m,r,p={count=,type_id=}}
-- response: {g,m,r,p={base={},items={item_id=count,},monsters={monster_id=count}}}
protocolno.PUB_REWARD = protocolno.MODULE_SVR_RESERVED + 22001
-- 兑换
-- req: {g,m,r,p={monster_id=}}
-- response: {g,m,r,p={}}
protocolno.PUB_EXCHANGE_MONSTER = protocolno.MODULE_SVR_RESERVED + 22002
-- 请求酒馆数据
-- req: {g,m,r,p={}}
-- response: {g,m,r,p={left_free_time=, medal=2000, data={'1'=0}, total_count=0}}}
protocolno.PUB_GET_INFO = protocolno.MODULE_SVR_RESERVED + 22003
-- 推送酒馆数据
-- req: {g,m,r,p={}}
-- response: {g,m,r,p={left_free_time=, medal=2000, data={'1'=0}, total_count=0}}}
protocolno.PUB_PUSH_INFO = protocolno.MODULE_SVR_RESERVED + 22004

--------建筑相关
--升级建筑
-- req: {g,m,r,p={buildId=}}
-- response: {g,m,r,p={}}
protocolno.LEVELUP_BUILDING = protocolno.MODULE_SVR_RESERVED + 23001

----统帅相关
--增加带兵量
-- req: {g,m,r,p={monsterId=兵种id,num=添加数量}}
-- response: {g,m,r,p={}}
protocolno.ADD_MONSTER_NUM = protocolno.MODULE_SVR_RESERVED + 24001
-- 学院
-- 进阶
-- req: {g,m,r,p={monster_id=}}
-- response: {g,m,r,p={}}
protocolno.MONSTER_STEP_UP = protocolno.MODULE_SVR_RESERVED + 24002
-- 强化
-- req: {g,m,r,p={monster_id=, index=}}
-- response: {g,m,r,p={}}
protocolno.MONSTER_STRENGTHEN_UP = protocolno.MODULE_SVR_RESERVED + 24003
-- 重生
-- req: {g,m,r,p={monster_id=}}
-- response: {g,m,r,p={}}
protocolno.MONSTER_REBIRTH = protocolno.MODULE_SVR_RESERVED + 24004
-- 学院背包相关
-- 推送学院信息
-- req: p = nil
-- response: p = {bag={[id]=count}}
protocolno.COLLEGE_PUSH_DATA = protocolno.MODULE_SVR_RESERVED + 24005
-- 学院信息更新
-- req: p = nil
-- response: 同推送学院信息相同结构
protocolno.COLLEGE_UPDATE_DATA = protocolno.MODULE_SVR_RESERVED + 24006
-- 合成材料
-- req: p = {id=,count=}
-- response: 
protocolno.COLLEGE_MERGE = protocolno.MODULE_SVR_RESERVED + 24007
-- 分解材料
-- req: p = {id=,count=}
-- response: 
protocolno.COLLEGE_SPLIT = protocolno.MODULE_SVR_RESERVED + 24008


-- 布阵
-- 信息更新
-- req:
-- response: {g,m,r,p={team={}, open_position={[pos]=1,}, auto_recharge=}}
-- team = {[team_id]={position=monster_id,}}
protocolno.MONSTER_POSITION_UPDATE = protocolno.MODULE_SVR_RESERVED + 25001
-- 阵位变动
-- req: {g,m,r,p={team={[team_id]={[position]=monster_id, }}, auto_recharge=}
-- response:{g,m,r,p={}}
protocolno.MONSTER_POSITION_TEAM = protocolno.MODULE_SVR_RESERVED + 25002
-- 自动补兵通知
-- req:
-- response:{g,m,r,p={}}
protocolno.MONSTER_POSITION_AUTO_RECHARGE = protocolno.MODULE_SVR_RESERVED + 25003

-- 一键补兵
-- req: {g,m,r,p={monsters={[key]=monster_id}}}
-- response: {g,m,r,p={}}
protocolno.TEAM_MONSTER_RECHARGE = protocolno.MODULE_SVR_RESERVED + 26001


-- 副本数据
--重置挑战次数
-- response: {g,m,r,p={id=章节id,map_id=地图id}}
-- response: {g,m,r,p={}}
protocolno.RESET_CHALLENGE_COUNT = protocolno.MODULE_SVR_RESERVED + 27001
--隐藏副本领取统帅
-- response: {g,m,r,p={id=章节id,map_id=地图id}}
-- response: {g,m,r,p={}}
protocolno.GET_HIDDLEN_MONSTER = protocolno.MODULE_SVR_RESERVED + 27002
--领取章节宝箱
-- response: {g,m,r,p={id=章节id,pos = 宝箱位置}}
-- response: {g,m,r,p={}}
protocolno.GET_CHAPTE_TREASURE = protocolno.MODULE_SVR_RESERVED + 27003

--封地
--建造建筑
-- response: {g,m,r,p={id=章节id,fief_id = 封地id,pos=封地孔位,buildId=建筑id}}
-- response: {g,m,r,p={}}
protocolno.FIEF_BUILD_BUILDING = protocolno.MODULE_SVR_RESERVED + 28001
--拆分建筑
-- response: {g,m,r,p={id=章节id,fief_id = 封地id,pos=封地孔位}}
-- response: {g,m,r,p={}}
protocolno.FIEF_REMOVE_BUILDING = protocolno.MODULE_SVR_RESERVED + 28002
--领取资源
-- response: {g,m,r,p={id=章节id,fief_id = 封地id }(p为空则是领取所有建筑的封地)}
-- response: {g,m,r,p={}}
protocolno.FIEF_GET_RESOURCES = protocolno.MODULE_SVR_RESERVED + 28003
--封地升级
-- response: {g,m,r,p={id=章节id,fief_id = 封地id,pos=封地孔位 }}
-- response: {g,m,r,p={}}
protocolno.FIEF_LEVELUP_BUILDING = protocolno.MODULE_SVR_RESERVED + 28004

-- 市场
-- 领取金币
-- req: {g,m,p=}
-- response: {g,m,r,p=}
protocolno.MONEY_FACTORY_GET = protocolno.MODULE_SVR_RESERVED + 29001
-- 更新市场信息
-- req: {g,m,p=}
-- response: {g,m,r,p={cur_money=, max_money=, left_time=}}
protocolno.MONEY_FACTORY_UPDATE = protocolno.MODULE_SVR_RESERVED + 29002
-- 更新农民信息
-- req: {g,m,p=}
-- response: {g,m,r,p={cur_people=, max_people=}}
protocolno.MONEY_FACTORY_PEOPLE_UPDATE = protocolno.MODULE_SVR_RESERVED + 29003
-- 买金币
-- req: {g,m,p=}
-- response: {g,m,r,p={}}
protocolno.MONEY_FACTORY_BUY_MONEY = protocolno.MODULE_SVR_RESERVED + 29004

-- 庄园
-- 领取粮食
-- req: {g,m,p=}
-- response: {g,m,r,p=}
protocolno.MANOR_FACTORY_GET = protocolno.MODULE_SVR_RESERVED + 29020
-- 更新庄园信息
-- req: {g,m,p=}
-- response: {g,m,r,p={cur_rice=, max_rice=, left_time=}}
protocolno.MANOR_FACTORY_UPDATE = protocolno.MODULE_SVR_RESERVED + 29021
-- 买粮草
-- req: {g,m,p=}
-- response: {g,m,r,p={}}
protocolno.MANOR_FACTORY_BUY_RICE = protocolno.MODULE_SVR_RESERVED + 29022

-- 科技点
-- 推送科技点信息 
-- req: {g, m, r, p={}}
-- response: {g,m,r,p={}}
-- {
-- 	general_sciences = {1,2}, 
-- 	special_sciences = {
-- 		{
-- 			science_id = 16,
-- 			attr_id = 1606, -- 探索出的属性id
-- 			attr_value = "H0002", -- 属性值
--          free_times = 2,  -- 免费研发次数
--			research_count = 2 -- 累积研发计数
-- 		},
-- 	}
-- }
protocolno.SCIENCE_INFO_UPDATE = protocolno.MODULE_SVR_RESERVED + 30001
-- 研究、探索科技点
-- req: {g, m, r, p={science_id=,explore_type=1}}	-- 玩家id，科技点id，特殊科技点探索类型（1：金币，2：钻石）
-- response: {g, m, r, p={}} -- p 结构与推送科技点信息 回应结构一致
protocolno.SCIENCE_EXPLORE = protocolno.MODULE_SVR_RESERVED + 30002
-- 特殊科技点研发
-- req: {g, m, r, p={science_id = 16,research_type = 1}}	-- 玩家id，特殊科技点id,研发方式（1:免费研发，2:钻石）
-- response: {g,m,r,p={attr_value = "H0002",free_times=1}}
protocolno.SCIENCE_RESEARCH = protocolno.MODULE_SVR_RESERVED + 30003


--银矿战
--银矿战矿区信息
-- req: {g,m,p={}}
-- response: {g,m,r,p={inithighmine(活动开始时随机的矿点)={[矿区id]={[高级随机矿点id,高级随机矿点等级,矿点位置]}},now = 服务器当前时间点}}
protocolno.SILVER_MINE_INFO = protocolno.MODULE_SVR_RESERVED + 31000
--得到某个矿点的信息
-- req: {g,m,p={mine_area_id=矿区id,mine_point_ids={{pos=矿点位置,mine_point_id=矿点id}}}}
-- response: {g,m,r,p={now = 服务器当前时间点,silvermine={[mineid][pos]={mine_point_id=矿点id,lv=矿点等级,hold_player(占领信息)={{player_id=玩家id,player_name=玩家的名字,player_layout=玩家防守阵容}},hold_timestamp=占领时间点,collect_timestamp=占领空矿时间点} }}}
protocolno.SILVER_MINE_POINT_INFO = protocolno.MODULE_SVR_RESERVED + 31001
--占领矿点 
-- req: {g,m,p={mine_area_id=矿区id,pos=矿点位置,mine_point_id=矿点id ,auto_recharge=攻击阵容自动补兵项,monsters={monsterid1 ... monsterid6}}
-- response: {g,m,r,p={}}
protocolno.SILVER_INVASION_MINE = protocolno.MODULE_SVR_RESERVED + 31002
--放弃采集 
-- req: {g,m,p={mine_area_id=矿区id,pos=矿点位置,mine_point_id=矿点id}
-- response: {g,m,r,p={}}
protocolno.SILVER_OUT_MINE = protocolno.MODULE_SVR_RESERVED + 31003
--领取秘银 
-- req: {g,m,p={}
-- response: {g,m,r,p={}}
protocolno.SILVER_GET_MINE = protocolno.MODULE_SVR_RESERVED + 31004
--抢矿战报 
-- req: {g,m,p={}
-- response: {g,m,r,p={battle_report= {战报列表}}}
protocolno.SILVER_BATTLE_REPORT= protocolno.MODULE_SVR_RESERVED + 31005
--粮草仓库存取  
-- req: {g,m,p={rice_num=存取粮草(加减)}
-- response: {g,m,r,p={}}
protocolno.SILVER_RICE_STORE= protocolno.MODULE_SVR_RESERVED + 31006
--调整防守阵容  
-- req: {p={auto_recharge=(0不自动补 1 只用背包粮草自动补 2 只用子系统粮草自动补 3   先用子系统粮草再用背包粮草自动补4 先用背包粮草再用子系统粮草自动补)自动补兵项,monsters={monsterid1 ... monsterid6}}}
-- response: {g,m,r,p={}}
protocolno.SILVER_SAVE_DEFENCE_MONSTERS = protocolno.MODULE_SVR_RESERVED + 31007

-- 阵容一键补兵,攻击阵容才发怪物列表
-- req: {g,m,r,p={attack=(0攻击阵容,1防守阵容)},monsters={monsterid1 ... monsterid6}}
-- response: {g,m,r,p={}}
protocolno.SILVER_MONSTER_RECHARGE = protocolno.MODULE_SVR_RESERVED + 31008
-- 拿产量信息
-- req: {g,m,r}}
-- response: {g,m,r,p={}}
protocolno.SILVER_PERSON_STORE = protocolno.MODULE_SVR_RESERVED + 31009

 
-- 竞技场
-- 更新数据
-- req: {}
-- response: {g,m,r,p={}} 数据格式...
-- player_id = nil
-- robot_id = nil -- 机器人id
-- pvp_id = 0     -- 竞技场id/(角色id或者机器人id)
-- left_challenge_count = 0   -- 剩余挑战次数
-- buy_challenge_count = 0    -- 购买挑战次数
-- challenge_recover_time = 0 -- 自动恢复挑战次数的时间
-- refresh_rival_count = 0 -- 连续刷新对手次数
-- refresh_rival_time = 0  -- 进入刷新对手cd的时间
-- ranking = 0          -- 当前排名
-- history_ranking = 0  -- 历史最高排名
-- rival = {}  -- 对手                position -> {ranking,pvp_id}
-- prestige = 0         -- 声望
-- prestige_shop = {}   -- 商店数据   goods_id -> buy_count
-- pvp_record = {}  -- 最近战斗记录   id -> record
-- defence_monsters = {}  -- 防御阵容 monster_id -> monster_obj
-- update_time = 0  -- 上次更新时间
-- refresh_rival_cd = 0 -- 剩余时间
protocolno.PVP_UPDATE_INFO = protocolno.MODULE_SVR_RESERVED + 32001
-- req: {}
-- response: {g,m,r,p={}}
protocolno.PVP_QUERY_INFO = protocolno.MODULE_SVR_RESERVED + 32002
-- req: {p={pvp_id=,team_id=}}
-- response: {g,m,r,p={}}
protocolno.PVP_CHALLENGE = protocolno.MODULE_SVR_RESERVED + 32003
-- req: {}
-- response: {g,m,r,p={}}
protocolno.PVP_REFRESH_RIVAL = protocolno.MODULE_SVR_RESERVED + 32004
-- req: {}
-- response: {g,m,r,p={}}
protocolno.PVP_QUERY_RANKING = protocolno.MODULE_SVR_RESERVED + 32005
-- req: {p={pvp_id=}}
-- response: {g,m,r,p={}}
protocolno.PVP_VIEW_PLAYER = protocolno.MODULE_SVR_RESERVED + 32006
-- req: {}
-- response: {g,m,r,p={}}
protocolno.PVP_BUY_CHALLENGE_COUNT = protocolno.MODULE_SVR_RESERVED + 32007
-- req: {p={goods_id=, count=}}
-- response: {g,m,r,p={}}
protocolno.PVP_BUY_GOODS = protocolno.MODULE_SVR_RESERVED + 32008
-- req: {p={monsters={monsterid1 ... monsterid6}}}
-- response: {g,m,r,p={}}
protocolno.PVP_SAVE_DEFENCE_MONSTERS = protocolno.MODULE_SVR_RESERVED + 32009
-- req: {p={id=}}}
-- response: {g,m,r,p={}}
protocolno.PVP_VIEW_RECORD = protocolno.MODULE_SVR_RESERVED + 32010

-- 龙与地下城
-- 重新挑战,解除章节锁定
-- req: {g, m, r, p={gold = }} glod为不为nil时表示使用钻石进行挑战
-- response: {g, m, r, p={}} 
protocolno.DUNGEON_RESET_CHALLENGE = protocolno.MODULE_SVR_RESERVED + 33001
-- 开始挑战，恢复数据，绑定章节
-- req: {g, m, r, p={chapter_id = 301}} 
-- response: {g, m, r, p={}} 
protocolno.DUNGEON_START_CHALLENGE = protocolno.MODULE_SVR_RESERVED + 33002
-- 一键补兵
-- req: {g, m, r, p={chapter_id = 301， gold = }} glod为不为nil时表示使用钻石进行补兵
-- response: {g, m, r, p={}}
protocolno.DUNGEON_MONSTER_RECHARGE = protocolno.MODULE_SVR_RESERVED + 33003
-- 改变布阵
-- req: {g, m, r, p={self_layout = {1，2，3，4，5，6}} 
-- response: {g, m, r, p={"scene_type_dungeon":{"self_layout":{1，2，3，4，5，6}}}
protocolno.DUNGEON_MONSTER_POSITION_CHANGE = protocolno.MODULE_SVR_RESERVED + 33004


-- 改变符文
-- req: {g, m, r, p={data={[position]={[hole_id]=rune_id}}}}
-- response: {g,m,r,p={}}
protocolno.RUNE_CHANGE_DATA = protocolno.MODULE_SVR_RESERVED + 34001
-- req: {g, m, r, p={}}
-- response: {g,m,r,p={data={},open_rune_hole={}, rune_bag={}}}
protocolno.RUNE_UPDATE = protocolno.MODULE_SVR_RESERVED + 34002
-- req: {g, m, r, p={new_item_id=,count=}}
-- response: {g,m,r,p={}}
protocolno.RUNE_MERGE = protocolno.MODULE_SVR_RESERVED + 34003
-- req: {g, m, r, p={index=,count=}}
-- response: {g,m,r,p={}}
protocolno.RUNE_SELL = protocolno.MODULE_SVR_RESERVED + 34004


-- 怪物攻城
-- 协议格式
-- req: {g, m, r, p={}}
-- response: {g,m,r,p={}}
-- 数据更新
-- req: p = nil
-- response: p = { grow_lv=怪物成长等级,list={}, sp=精力,buy_sp=购买的精力,buy_sp_count=购买精力次数, shop_data=商店数据, is_share=是否分享, left_refresh_time=刷新的cd时间, status= }
-- shop_data -> {goods_id=buy_count}
-- list -> {f_player_id={id=怪物组id, blood=当前血量, refresh_time=刷新时间,left_time=逃跑时间, name=名字}}
protocolno.ATK_UPDATE = protocolno.MODULE_SVR_RESERVED + 35001
-- 购买精力
-- req: p = {sp=1} sp精力
-- response: p = {}
protocolno.ATK_BUY_SP = protocolno.MODULE_SVR_RESERVED + 35002
-- 购买商品
-- req: p = {goods_id="1", count=1}
-- response: p={atk_val=10, shop_data={}}  atk_val用来买商品的货币,   
protocolno.ATK_BUY_GOODS = protocolno.MODULE_SVR_RESERVED + 35003
-- 分享
-- req: p = {}
-- response: p = {}
protocolno.ATK_SHARE = protocolno.MODULE_SVR_RESERVED + 35004
-- 查询、刷新 一个
-- req: p = {f_player_id=1}
-- response: p = {}
protocolno.ATK_QUERY_ONE = protocolno.MODULE_SVR_RESERVED + 35005
-- 查询、刷新 所有
-- req: p = {}
-- response: p = {}
protocolno.ATK_QUERY_ALL = protocolno.MODULE_SVR_RESERVED + 35006
-- 挑战
-- req: p={f_player_id=1, team_id=1}  f_player_id好友id
-- response: p={f_player_id=好友id, fight_data=战报, hurt_ranking=伤害排行, hurt=本次伤害, feats=获得功勋, reward=获得其他奖励}
protocolno.ATK_CAHLLENGE = protocolno.MODULE_SVR_RESERVED + 35007
-- 被怪物攻击损失
-- req: p=nil
-- response: p={loss_people=损失的农民}
protocolno.ATK_LOSS_PEOPLE = protocolno.MODULE_SVR_RESERVED + 35008
-- 我的排名信息
-- req: p={}
-- response: p={hurt=, hurt_ranking=, feats=, feats_ranking=, feats_reward={}, hurt_ranking_len=, feats_ranking_len=}
protocolno.ATK_MY_RANKING = protocolno.MODULE_SVR_RESERVED + 35009
-- 查询排行
-- req: p={s=,e=, type=1}  s=star, e=end, type=1伤害排行,2功勋排行
-- response: p={list={[ranking]={hurt=,player_id=,name=,team=}, type=}
protocolno.ATK_RANKING = protocolno.MODULE_SVR_RESERVED + 35010
-- req: p={target_player_id=} 查询玩家当前布阵的信息
-- response: p={monsters={}}
protocolno.ATK_RANKING_PLAYER = protocolno.MODULE_SVR_RESERVED + 35011
-- 功勋兑换
-- req: p={id=}
-- response: p={id=}
protocolno.ATK_FEATS_REWARD = protocolno.MODULE_SVR_RESERVED + 35012
-- 领取奖励
-- req: p={}
-- response: p={}
protocolno.ATK_GET_REWARD = protocolno.MODULE_SVR_RESERVED + 35013


-- 装备系统 
-- 装备更新，装备是一种特殊道具，装备发生改变时同样需要推送protocolno.BAG_ITEM_CHANGE消息
--[[ 服务端主动推送给客户端
	req: {g=guid,m,r, p={bag_index={[1] = type_id, [2] = count,[3]=time,[4]=strengthen } .....}}
]]
protocolno.PLAYER_EQUIP_UPDATE = protocolno.MODULE_SVR_RESERVED + 36000
-- 兑换装备 
-- req: {g, m, r, p={equip_id = 1}} 
-- response: {g,m,r,p={}}  
protocolno.EQUIP_EXCHANGE = protocolno.MODULE_SVR_RESERVED + 36001
-- 装备装备 
-- req: {g, m, r, p={bag_index = 1}}  bag_index:装备在背包中的位置
-- response: {g,m,r,p={}}  
protocolno.EQUIP_EQUIP = protocolno.MODULE_SVR_RESERVED + 36002
-- 卸下装备 
-- req: {g, m, r, p={equip_index = 1}} equip_index：装备在人身上的位置
-- response: {g,m,r,p={}} 
protocolno.EQUIP_UNEQUIP = protocolno.MODULE_SVR_RESERVED + 36003
-- 强化装备（手动/自动） 
-- req: {g, m, r, p={pos = 1, index = 1, type = 1}} 
-- pos:1表示背包 2表示人物身上
-- index：在pos上的索引位置 
-- type: 1表示单次强化，2表示自动强化
-- response: {g,m,r,p={}}  
protocolno.EQUIP_STRENGTHEN = protocolno.MODULE_SVR_RESERVED + 36004
-- 熔炼装备 
-- req: {g, m, r, p={bag_index = 1}}  bag_index:装备在背包中的位置
-- response: {g,m,r,p={}} 
protocolno.EQUIP_SMELT = protocolno.MODULE_SVR_RESERVED + 36005
-- 分解装备 
-- req: {g, m, r, p={bag_index = 1}}  bag_index:装备在背包中的位置
-- response: {g,m,r,p={}}  
protocolno.EQUIP_RESOLVE = protocolno.MODULE_SVR_RESERVED + 36006
-- 推送道具统计信息
-- req: {g, m, r, p={}}  
-- response: {g,m,r,p={limit_purchase = {everyday_purchase = {}, permanent_purchase = {}}}}  
protocolno.ITEM_STATISTICS_INFO_UPDATE = protocolno.MODULE_SVR_RESERVED + 36007


-- 贸易
-- 买东西
-- req: p = { city_id=, goods_id=, count=, f_player_id=, }       count需要买多少
-- response: p = { goods_id=, boat_count=, city_id=, count=, f_player_id=, }  count还能买多少
protocolno.TRADE_BUY = protocolno.MODULE_SVR_RESERVED + 37001
-- 卖东西
-- req: p = { city_id=, goods_id=, count=, }
-- response: p = { goods_id=, boat_count=, }
protocolno.TRADE_SALE = protocolno.MODULE_SVR_RESERVED + 37002
-- 一键卖出
-- req: p = { city_id=, }
-- response: p = { city_id=, }
protocolno.TRADE_SALE_ALL = protocolno.MODULE_SVR_RESERVED + 37003
-- 升级船
--[[
function player_cls:ctor()
	self.player_id = 0
	self.name = ""
	self.lv = 0
	self.vip = 0
	self.agent_name = ""
	self.online = 0

	self.left_attack_count = 0  -- 剩余[攻击次数]
	self.left_buy_atk_count= 0  -- 购买的[攻击次数]还剩多少次
	self.buy_attack_count = 0   -- 购买了多少次[攻击次数]
	self.reset_time = 0         -- 重置购买次数的时间

	self.be_match_lock = 0 -- 被别人匹配锁定中,此时玩家数据无法被删除. 0没有锁定, 1锁定

	self.boat = {
		id = 0,  -- 船id

		--
		speed = 0,       -- 速度
		defence_add = 0, -- 防御百分比
		space = 0,       -- 总空间,
		left_space = 0,  -- 剩余空间

		cur_city = 0, -- 处于哪个城市(船停港状态时,此值才有效)
		from = 0,     -- 出发地
		to = 0,       -- 目的地
		status = 0,   -- 状态 (0停港, 1航行, 2返航, 3暂停航行)
		left_distance = 0, -- 剩余距离
		update_time = 0,   -- 剩余距离更新时间
		
		pause_time = 0,    -- 暂停开始时间
		pause_status = 0,  -- 暂停前船的状态

		defence_monsters = {}, -- 防御部队
		attacked_count = 0,    -- 被攻击次数
		attacked_money = 0,	   -- 被攻击,攻击方胜利可以获得的金币

		goods = {},  -- 贸易物品
	}

	self.unlock_city = {}  -- 已解锁城市
end
--]]
-- req: p = {}
-- response: p = { boat_id=, speed=, defence_add=, space=, left_space=} 更新船的信息
protocolno.TRADE_UP_BOAT = protocolno.MODULE_SVR_RESERVED + 37004
-- 更新防御整容
-- req: p = {monsters={monster_id,,,,,}}  6个统帅id的数组, 没有则设为0
-- response: p = {monsters={}} 新船的id   6个统帅的具体信息
protocolno.TRADE_CHANGE_DEFENCE = protocolno.MODULE_SVR_RESERVED + 37005
-- 攻击城市
-- req: p = {team_id=}
-- response: p = {win, attack_report, money, goods}
protocolno.TRADE_ATTACK_CITY = protocolno.MODULE_SVR_RESERVED + 37006
-- 搜索对手
-- req: p = {}
-- response: p = {}  5个对手的数组 index={rival_id=,name=,lv=,monsters={},boat_id=,}
protocolno.TRADE_SEARCH_RIVAL = protocolno.MODULE_SVR_RESERVED + 37007
-- 攻击对手
-- req: p = {team_id=, rival_id=}
-- response: p = {win, attack_report, money, left_attack_count, left_buy_atk_count, }
protocolno.TRADE_ATTACK_RIVAL = protocolno.MODULE_SVR_RESERVED + 37008
-- 去某个城市
-- req: p = {city_id=}
-- response: p = {cur_city=,from=,to=,status=, left_distance=}  -- 更新船的信息
protocolno.TRADE_GO_CITY = protocolno.MODULE_SVR_RESERVED + 37009
-- 返航
-- req: p = {}
-- response: p = {cur_city=,from=,to=,status=, left_distance=}  -- 更新船的信息
protocolno.TRADE_GO_BACK = protocolno.MODULE_SVR_RESERVED + 37010
-- 却换模式
-- req: p = {mode=}  1正常模式, 2掠夺模式
-- response: p = {boat=}  -- 更新船的信息
protocolno.TRADE_CHANGE_MODE = protocolno.MODULE_SVR_RESERVED + 37011
-- 玩家基本信息
-- req: p = nil
-- response: p = {}  -- 查询玩家信息
protocolno.TRADE_PLAYER_DATA = protocolno.MODULE_SVR_RESERVED + 37012
-- 城市信息
-- req: p = {city_id=}
-- response: p = {}  -- 查询城市基本信息
protocolno.TRADE_CITY_DATA = protocolno.MODULE_SVR_RESERVED + 37013
-- 城市刷新商品了
-- req : p = nil
-- response: p = {}  -- 不推送数据,需要自己查询
protocolno.TRADE_CITY_REFRESH = protocolno.MODULE_SVR_RESERVED + 37014
-- 船到港了
-- req : p = nil
-- response: p = {cur_city=,from=,to=,status=, left_distance=}
protocolno.TRADE_BOAT_STATUS = protocolno.MODULE_SVR_RESERVED + 37015
-- 被掠夺
-- req : p = nil
-- response: p = {boat={goods=, attacked_count= }}
protocolno.TRADE_BOAT_ATTACKED = protocolno.MODULE_SVR_RESERVED + 37016
-- 购买掠夺次数
-- req : p = nil
-- response: p = {buy_attack_count=, left_buy_atk_count=}
protocolno.TRADE_BUY_ATTACK_COUNT = protocolno.MODULE_SVR_RESERVED + 37017

return protocolno
