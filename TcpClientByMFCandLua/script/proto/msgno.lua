--[["
	desc: 消息信息编号定义
	author: oyxz
	since: 2014-01-04
 "]]

local msgno = {}
local content = {}

-- > 0 表示信息提示
msgno.SUCCESS = 1
content[msgno.SUCCESS] = "成功"
msgno.FAILED = 2
content[msgno.FAILED] = "失败"

-- 分配500~600号段给场景管理使用
msgno.COMMON_SCENE_RESERVED = 500

-- 5000以内为系统保留号段
-- add more 

-- 5000以上为功能模块号段
msgno.MODULE_MSG_RESERVED = 5000

-- 推荐每个功能模块预留100的id号段

-- quest 
msgno.QUEST_LIST_SUC = msgno.MODULE_MSG_RESERVED + 201 --查询任务列表成功

-- bag 成功的情况
msgno.BAG_GET_ITEM_LIST_SUC = msgno.MODULE_MSG_RESERVED + 301 --获取背包道具信息成功
content[msgno.BAG_GET_ITEM_LIST_SUC] = "获取背包道具信息成功"
msgno.BAG_USE_ITEM_SUC 	= msgno.MODULE_MSG_RESERVED + 302 --使用道具成功
content[msgno.BAG_USE_ITEM_SUC] = "使用道具成功"
msgno.BAG_SELL_ITEM_SUC 	= msgno.MODULE_MSG_RESERVED + 303 --出售道具成功
content[msgno.BAG_SELL_ITEM_SUC] = "出售道具成功"
msgno.BAG_EQUIP_ITEM_SUC 	= msgno.MODULE_MSG_RESERVED + 304 --装备道具成功
content[msgno.BAG_EQUIP_ITEM_SUC] = "装备道具成功"
msgno.BAG_UNEQUIP_ITEM_SUC 	= msgno.MODULE_MSG_RESERVED + 305 --脱下装备成功
content[msgno.BAG_UNEQUIP_ITEM_SUC] = "脱下装备成功"
msgno.BAG_CHANGE_ITEM_SUC 	= msgno.MODULE_MSG_RESERVED + 306 --背包中道具数量改变成功 
content[msgno.BAG_CHANGE_ITEM_SUC] = "背包中道具数量改变成功"

msgno.PLAYER_EQUIP_UPDATE_SUC = msgno.MODULE_MSG_RESERVED + 307 --装备更新成功 
content[msgno.PLAYER_EQUIP_UPDATE_SUC] = "装备更新成功"
msgno.PLAYER_EQUIP_AUTO_SUCC = msgno.MODULE_MSG_RESERVED + 308 --自动穿装备成功
content[msgno.PLAYER_EQUIP_AUTO_SUCC] = "自动穿装备成功"
msgno.ITEM_AUTO_FUSEITEM_SUCC = msgno.MODULE_MSG_RESERVED + 309 --自动合成道具成功
content[msgno.ITEM_AUTO_FUSEITEM_SUCC] = "自动合成道具成功"
msgno.BAG_COLLATING_ITEM_LIST_SUCC = msgno.MODULE_MSG_RESERVED + 310 --整理背包成功
content[msgno.BAG_COLLATING_ITEM_LIST_SUCC] = "整理背包成功"
msgno.BAG_QUICKSELL_ITEM_SUCC = msgno.MODULE_MSG_RESERVED + 311 --一键出售成功
content[msgno.BAG_QUICKSELL_ITEM_SUCC] = "一键出售成功"
msgno.ITEM_GIFT_OPEN_SUCC = msgno.MODULE_MSG_RESERVED + 312 --开启礼包成功
content[msgno.ITEM_GIFT_OPEN_SUCC] = "开启礼包成功"

msgno.GET_SIGIN_REWARD_BY_MAIL_SUCC = msgno.MODULE_MSG_RESERVED + 313 -- 签到背包空间不足的情况
content[msgno.GET_SIGIN_REWARD_BY_MAIL_SUCC] = "背包空间不足，通过邮件发放奖励"

-- shop
msgno.SHOP_BUY_SUCCESS = msgno.MODULE_MSG_RESERVED + 601 -- 购买成功
content[msgno.SHOP_BUY_SUCCESS] = "购买成功"
msgno.SHOP_GET_SUCCESS = msgno.MODULE_MSG_RESERVED + 602 -- 商店商品查询
content[msgno.SHOP_GET_SUCCESS] = "商店商品查询"

-- monster
msgno.MONSTER_ADD_PART = msgno.MODULE_MSG_RESERVED + 701
content[msgno.MONSTER_ADD_PART] = "补了部分兵"

--PLAYER
msgno.PLAYER_GET_INFOR_SUC = msgno.MODULE_MSG_RESERVED + 801 --获取角色信息成功
content[msgno.PLAYER_GET_INFOR_SUC] = "获取角色信息成功"
msgno.PLAYER_UPDATE_BASIC_SUC = msgno.MODULE_MSG_RESERVED + 802 -- 更新角色基础信息成功
content[msgno.PLAYER_UPDATE_BASIC_SUC] = "更新角色基础信息成功"
msgno.PLAYER_GET_VIP_AWARDS_SUC = msgno.MODULE_MSG_RESERVED + 803 --领取VIP礼包成功
content[msgno.PLAYER_GET_VIP_AWARDS_SUC] = "领取VIP礼包成功"
msgno.PLAYER_GET_EQUIP_DATA_SUC = msgno.MODULE_MSG_RESERVED + 804 --获取装备数据成功
content[msgno.PLAYER_GET_EQUIP_DATA_SUC] = "获取装备数据成功"
msgno.PLAYER_GET_KEY_SEAT_SUC = msgno.MODULE_MSG_RESERVED + 805 --获取技能键位成功
content[msgno.PLAYER_GET_KEY_SEAT_SUC] = "获取技能键位成功"
msgno.PLAYER_BUY_ENERGY_SUC = msgno.MODULE_MSG_RESERVED + 806 -- 购买体力成功
content[msgno.PLAYER_BUY_ENERGY_SUC] = "购买体力成功"
msgno.PLAYER_BUY_STRGCD_SUC = msgno.MODULE_MSG_RESERVED + 807 -- 购买强化冷却时间成功
content[msgno.PLAYER_BUY_STRGCD_SUC] = "购买强化冷却时间成功"



--mail
msgno.MAIL_SHOW_SUCCESS          = msgno.MODULE_MSG_RESERVED + 1001 -- 现实邮件成功
content[msgno.MAIL_SHOW_SUCCESS] = "现实邮件成功"
msgno.MAIL_READ_SUCCESS          = msgno.MODULE_MSG_RESERVED + 1003 -- 读取邮件成功
content[msgno.MAIL_READ_SUCCESS] = "读取邮件成功"

--guild
msgno.GUILD_CREATE_SUCCESS 					    = msgno.MODULE_MSG_RESERVED + 1101 -- 创建帮派成功
content[msgno.GUILD_CREATE_SUCCESS]			    = "创建帮派成功"
msgno.GUILD_CHAT_SUCCESS				        = msgno.MODULE_MSG_RESERVED + 1102 -- 帮派聊天发送成功
content[msgno.GUILD_CHAT_SUCCESS]		        = "帮派聊天发送成功"
msgno.GUILD_APPLY_SUCCESS 					    = msgno.MODULE_MSG_RESERVED + 1103 -- 申请帮派成功
content[msgno.GUILD_APPLY_SUCCESS]			    = "申请帮派成功"
msgno.GUILD_SHOW_NUM_SUCCESS 				    = msgno.MODULE_MSG_RESERVED + 1104 -- 显示帮派个数
content[msgno.GUILD_SHOW_NUM_SUCCESS]           = "显示帮派个数成功"
msgno.GUILD_SHOW_SUCCESS 					    = msgno.MODULE_MSG_RESERVED + 1105 --显示帮派列表
content[msgno.GUILD_SHOW_SUCCESS] 			    = "显示帮派列表成功"
msgno.GUILD_GET_GUILD_FROM_ID_SUCCESS           = msgno.MODULE_MSG_RESERVED + 1106 --通过ID获取帮派
content[msgno.GUILD_GET_GUILD_FROM_ID_SUCCESS]  = "通过名字获取帮派成功"
msgno.GUILD_GET_GUILD_INFO_SUCCESS              = msgno.MODULE_MSG_RESERVED + 1107 --获取帮派基本信息
content[msgno.GUILD_GET_GUILD_INFO_SUCCESS]     = "获取帮派基本信息成功"
msgno.GUILD_SHOW_MENBER_POWER_SUCCESS           = msgno.MODULE_MSG_RESERVED + 1108 --帮派成员列表（权力）
content[msgno.GUILD_SHOW_MENBER_POWER_SUCCESS]  = "帮派成员列表获取成功"
msgno.GUILD_SHOW_MENBER_LV_SUCCESS			    = msgno.MODULE_MSG_RESERVED + 1109 --帮派成员列表（等级）
content[msgno.GUILD_SHOW_MENBER_LV_SUCCESS]     = "帮派成员列表获取成功"
msgno.GUILD_SHOW_MENBER_CON_SUCCESS             = msgno.MODULE_MSG_RESERVED + 1110 --帮派成员列表（贡献）
content[msgno.GUILD_SHOW_MENBER_CON_SUCCESS]    = "帮派成员列表获取成功"
msgno.GUILD_UP_POWER_SUCCESS                    = msgno.MODULE_MSG_RESERVED + 1111 --提升成员权限
content[msgno.GUILD_UP_POWER_SUCCESS]           = "提升成员权限成功"
msgno.GUILD_APPLY_TO_GUILD_SUCCESS              = msgno.MODULE_MSG_RESERVED + 1112 --批准玩家进入帮派
content[msgno.GUILD_APPLY_TO_GUILD_SUCCESS]     = "批准玩家进入帮派成功"
msgno.GUILD_SHOW_APPLY_SUCCESS                  = msgno.MODULE_MSG_RESERVED + 1113 --显示申请列表
content[msgno.GUILD_SHOW_APPLY_SUCCESS]         = "显示申请列表成功"
msgno.GUILD_DELETE_MENBER_SUCCESS               = msgno.MODULE_MSG_RESERVED + 1114 --剔除成员成功
content[msgno.GUILD_DELETE_MENBER_SUCCESS]      = "剔除成员成功"
msgno.GUILD_EXIT_GUILD_SUCCESS                  = msgno.MODULE_MSG_RESERVED + 1115 --退出帮派成功
content[msgno.GUILD_EXIT_GUILD_SUCCESS]         = "退出帮派成功"
msgno.GUILD_CON_SUCCESS                         = msgno.MODULE_MSG_RESERVED + 1116 --贡献钱成功
content[msgno.GUILD_CON_SUCCESS]                = "贡献钱成功"
msgno.GUILD_WRITE_ANNOUNCEMENT_SUCCESS          = msgno.MODULE_MSG_RESERVED + 1117 --修改公告成功
content[msgno.GUILD_WRITE_ANNOUNCEMENT_SUCCESS] = "修改公告成功"
msgno.GUILD_EMPTY_APPLY_SUCCESS                 = msgno.MODULE_MSG_RESERVED + 1118 --情况申请列表成功
content[msgno.GUILD_EMPTY_APPLY_SUCCESS]        = "情况申请列表成功"
msgno.GUILD_SHOW_POWER_SUCCESS                  = msgno.MODULE_MSG_RESERVED + 1119 --显示权限成功
content[msgno.GUILD_SHOW_POWER_SUCCESS]         = "显示权限成功"
msgno.GUILD_CON_GOODS_SUCCESS 			        = msgno.MODULE_MSG_RESERVED + 1120 --贡献物品成功
content[msgno.GUILD_CON_GOODS_SUCCESS]          = "贡献物品成功"
msgno.GUILD_SHOW_SHOP_SUCCESS                   = msgno.MODULE_MSG_RESERVED + 1121 --显示帮派商店成
content[msgno.GUILD_SHOW_SHOP_SUCCESS]          = "显示帮派商店成功"
msgno.GUILD_BUY_SHOP_SUCCESS                    = msgno.MODULE_MSG_RESERVED + 1122 --买物品成功
content[msgno.GUILD_BUY_SHOP_SUCCESS]           = "买物品成功"

-- buff 
msgno.BUFF_CHANGE_SUC = msgno.MODULE_MSG_RESERVED + 1701 -- buff改变成功
content[msgno.BUFF_CHANGE_SUC] = "buff改变成功"
msgno.BUFF_REMOVE_SUC = msgno.MODULE_MSG_RESERVED + 1702 -- buff删除成功
content[msgno.BUFF_REMOVE_SUC] = "buff删除成功"



-- 好友
msgno.ADD_CONTACT_SUC = msgno.MODULE_MSG_RESERVED + 2001
msgno.DEL_CONTACT_SUC = msgno.MODULE_MSG_RESERVED + 2002
msgno.PUSH_BLACK_SUC = msgno.MODULE_MSG_RESERVED + 2003
msgno.PUSH_CONTACT_LIST_SUC = msgno.MODULE_MSG_RESERVED + 2004
msgno.SEND_PRIVATE_MESSAGE_SUC = msgno.MODULE_MSG_RESERVED + 2005

-- chat
msgno.SEND_HORN_MESSAGE_SUC = msgno.MODULE_MSG_RESERVED + 2101
msgno.SEND_SCENE_MESSAGE_SUC = msgno.MODULE_MSG_RESERVED + 2102



msgno.ACTIVE_REWARD_STATUS_CHANGE_SUCCESS = msgno.MODULE_MSG_RESERVED + 2301  --主动推送活动状态改变信息成功
content[msgno.ACTIVE_REWARD_STATUS_CHANGE_SUCCESS] = "主动推送活动状态改变信息成功"
msgno.ACTIVE_GET_REWARD_SUCCESS = msgno.MODULE_MSG_RESERVED + 2302            --领取活动奖励成功
content[msgno.ACTIVE_GET_REWARD_SUCCESS] = "领取奖励成功" 
msgno.ACTIVE_SEND_ALL_DATA_SUCCESS = msgno.MODULE_MSG_RESERVED+2303			--主动推送所有活动信息成功       
content[msgno.ACTIVE_SEND_ALL_DATA_SUCCESS] = "主动推送所有活动信息成功"
msgno.ACTIVE_GET_REMAIN_TIME_SUCCESS = msgno.MODULE_MSG_RESERVED + 2304		--获取剩余时间成功
content[msgno.ACTIVE_GET_REMAIN_TIME_SUCCESS] = "获取剩余时间成功"
msgno.ACTIVE_ALREADY_HAS = msgno.MODULE_MSG_RESERVED + 2305	 --已经激活
content[msgno.ACTIVE_ALREADY_HAS] = "已经激活"


-- -1000以上为功能模块号段
msgno.MODULE_ERROR_RESERVED = -5000


-- 推荐每个功能模块预留100的id号段

-- auth
msgno.AUTH_NOT_LOGIN = msgno.MODULE_ERROR_RESERVED - 1 --登录失败
content[msgno.AUTH_NOT_LOGIN] = "登录失败"
msgno.AUTH_LOGIN_ACCOUNT_FAILURE = msgno.MODULE_ERROR_RESERVED - 2 --重复登录
content[msgno.AUTH_LOGIN_ACCOUNT_FAILURE] = "重复登录"
msgno.AUTH_LOGIN_VERSIONS_ERROR = msgno.MODULE_ERROR_RESERVED - 3 --client版本和服务器版本不匹配
content[msgno.AUTH_LOGIN_VERSIONS_ERROR] = "密码或者账号过长(client版本和服务器版本不匹配"

-- quest 
msgno.QUEST_NOT_EXIST = msgno.MODULE_ERROR_RESERVED - 201
content[msgno.QUEST_NOT_EXIST] = "任务不存在"
msgno.QUEST_MAX_COUNT = msgno.MODULE_ERROR_RESERVED - 202
content[msgno.QUEST_MAX_COUNT] = "超过最大任务数"
msgno.QUEST_LV_LESS = msgno.MODULE_ERROR_RESERVED - 203
content[msgno.QUEST_LV_LESS] = "等级不够"
msgno.QUEST_NO_ACCEPT = msgno.MODULE_ERROR_RESERVED - 204
content[msgno.QUEST_NO_ACCEPT] = "没有领取过该任务"
msgno.QUEST_CANNOT_DEL = msgno.MODULE_ERROR_RESERVED - 205
content[msgno.QUEST_CANNOT_DEL] = "任务无法删除"
msgno.QUEST_CANNOT_DEL_C = msgno.MODULE_ERROR_RESERVED - 206
content[msgno.QUEST_CANNOT_DEL_C] = "任务以完成,无法删除"
msgno.QUEST_UN_COMPLETE = msgno.MODULE_ERROR_RESERVED - 207
content[msgno.QUEST_CANNOT_DEL_C] = "任务未完成"
msgno.QUEST_PRE_NOT_COMPLETE = msgno.MODULE_ERROR_RESERVED - 208
content[msgno.QUEST_PRE_NOT_COMPLETE] = "前置任务未完成"
msgno.QUEST_ALREADY_GET = msgno.MODULE_ERROR_RESERVED - 209
content[msgno.QUEST_ALREADY_GET] = "任务已经领取过了"

-- BAG
msgno.GET_BAG_INFOR_FAL = msgno.MODULE_ERROR_RESERVED - 301 -- 获取背包道具信息失败
content[msgno.GET_BAG_INFOR_FAL] = "获取背包道具信息失败"
msgno.BAG_ITEM_PARAMS_ERR = msgno.MODULE_ERROR_RESERVED - 302 -- 参数不合法
content[msgno.BAG_ITEM_PARAMS_ERR] = "参数不合法"
msgno.BAG_ITEM_NOT_ID = msgno.MODULE_ERROR_RESERVED - 303 -- 道具ID不存在
content[msgno.BAG_ITEM_NOT_ID] = "道具ID不存在"
msgno.BAG_ITEM_EXCEL_OBJ_ERR = msgno.MODULE_ERROR_RESERVED - 304 -- 道具在EXCEL配置表中找不到
content[msgno.BAG_ITEM_EXCEL_OBJ_ERR] = "道具在EXCEL配置表中找不到"

-- bag use
msgno.BAG_ITEM_NOT_COUNT = msgno.MODULE_ERROR_RESERVED - 305 --道具数量不足
content[msgno.BAG_ITEM_NOT_COUNT] = "道具数量不足"
msgno.BAG_USE_ITEM_PROFESSION_ERR = msgno.MODULE_ERROR_RESERVED - 306 --职业不符合
content[msgno.BAG_USE_ITEM_PROFESSION_ERR] = "职业不符合"
msgno.BAG_USE_ITEM_PLAYER_LEV_ERR = msgno.MODULE_ERROR_RESERVED - 307 --等级不够
content[msgno.BAG_USE_ITEM_PLAYER_LEV_ERR] = "等级不够"
msgno.BAG_OPEN_GIFT_OUT_SPACE_ERR =  msgno.MODULE_ERROR_RESERVED - 308 --打开礼包空间不足
content[msgno.BAG_OPEN_GIFT_OUT_SPACE_ERR] = "打开礼包空间不足"

-- bag sell
msgno.BAG_SELL_ITEM_ERR = msgno.MODULE_ERROR_RESERVED - 309 --道具不可出售
content[msgno.BAG_SELL_ITEM_ERR] = "道具不可出售"
msgno.BAG_OUT_OF_SPACE_ERR = msgno.MODULE_ERROR_RESERVED - 310 --  背包空间不足
content[msgno.BAG_OUT_OF_SPACE_ERR] = "背包空间不足"
msgno.BAG_EQUIP_ITEM_ERR = msgno.MODULE_ERROR_RESERVED - 311 --  该道具不是装备
content[msgno.BAG_EQUIP_ITEM_ERR] = "该道具不是装备"
msgno.BAG_ITEM_OBJ_ERR =  msgno.MODULE_ERROR_RESERVED - 312 --  道具对象不存在
content[msgno.BAG_ITEM_OBJ_ERR] = "道具对象不存在"
msgno.BAG_ITEM_COUNT_ERR =  msgno.MODULE_ERROR_RESERVED - 312 --  使用道具数量错误
content[msgno.BAG_ITEM_COUNT_ERR] = "使用道具数量错误"
msgno.BAG_ITEM_SAME_ERR =  msgno.MODULE_ERROR_RESERVED - 313 --  身上存在相同装备
content[msgno.BAG_ITEM_SAME_ERR] = "身上存在相同装备"

-- bag extend
msgno.BAG_CANNOT_EXTEND =  msgno.MODULE_ERROR_RESERVED - 314 
content[msgno.BAG_CANNOT_EXTEND] = "无法扩充"

-- bag space
msgno.BAG_FULL = msgno.MODULE_ERROR_RESERVED - 315
content[msgno.BAG_FULL] = "背包满"


-- 选择角色 创建角色
msgno.ACCOUNT_ROLS_GET_FAIL		= msgno.MODULE_ERROR_RESERVED - 501  -- 获取账号角色列表失败
content[msgno.ACCOUNT_ROLS_GET_FAIL] = "获取账号角色列表失败"
msgno.ACCOUNT_ROLS_CREATE_FAIL 	= msgno.MODULE_ERROR_RESERVED - 502  -- 创建账号角色失败
content[msgno.ACCOUNT_ROLS_CREATE_FAIL] = "创建账号角色失败"
msgno.ACCOUNT_ROLS_CREATE_NAME_LEN 	= msgno.MODULE_ERROR_RESERVED - 503  -- 角色名字长度不能超过20个字符
content[msgno.ACCOUNT_ROLS_CREATE_NAME_LEN] = "角色名字长度不能超过20个字符"
msgno.ACCOUNT_ROLS_CREATE_NAME_USED = msgno.MODULE_ERROR_RESERVED - 504  -- 角色名字被使用了
content[msgno.ACCOUNT_ROLS_CREATE_NAME_USED] = "角色名字被使用了"

--shop errno
msgno.SHOP_GOODS_ID_NOT_EXIT = msgno.MODULE_ERROR_RESERVED - 601
content[msgno.SHOP_GOODS_ID_NOT_EXIT] = "商品不存在"
msgno.SHOP_GOODS_NUMBER_ERROR = msgno.MODULE_ERROR_RESERVED - 602
content[msgno.SHOP_GOODS_NUMBER_ERROR] = "购买数量错误"
msgno.SHOP_GOODS_ALREADY_BUY = msgno.MODULE_ERROR_RESERVED - 603
content[msgno.SHOP_GOODS_ALREADY_BUY] = "商品已经购买了"
msgno.SHOP_GOODS_ERROR = msgno.MODULE_ERROR_RESERVED - 604
content[msgno.SHOP_GOODS_ERROR] = "商品数据异常"
msgno.SHOP_GOODS_REFRESH_NUM_ERROR = msgno.MODULE_ERROR_RESERVED - 605
content[msgno.SHOP_GOODS_REFRESH_NUM_ERROR] = "刷新次数错误"
msgno.SHOP_GOODS_REFRESH_NO_NUM = msgno.MODULE_ERROR_RESERVED - 606
content[msgno.SHOP_GOODS_REFRESH_NO_NUM] = "刷新次数用完了"
msgno.SHOP_GOODS_POSITION_ERROR = msgno.MODULE_ERROR_RESERVED - 607
content[msgno.SHOP_GOODS_POSITION_ERROR] = "该位置商品异常"
msgno.SHOP_GOODS_ITEM_PRICE_ERROR = msgno.MODULE_ERROR_RESERVED - 608
content[msgno.SHOP_GOODS_ITEM_PRICE_ERROR] = "商品信息异常"

--PLAYER
msgno.PLAYER_GET_INFOR_FAL = msgno.MODULE_ERROR_RESERVED - 801 --获取角色信息(属性+装备)失败
content[msgno.PLAYER_GET_INFOR_FAL] = "获取角色信息失败"
msgno.PLAYER_UPDATE_BASIC_FAL = msgno.MODULE_ERROR_RESERVED - 802 --更新角色基础信息失败
content[msgno.PLAYER_UPDATE_BASIC_FAL] = "更新角色基础信息失败"
msgno.PLAYER_GET_VIP_AWARDS_FAL = msgno.MODULE_ERROR_RESERVED - 803 --领取VIP礼包失败
content[msgno.PLAYER_GET_VIP_AWARDS_FAL] = "领取VIP礼包失败"

--update basic errno
msgno.PLAYER_EXP_ERR = msgno.MODULE_ERROR_RESERVED - 810 -- 经验不足
content[msgno.PLAYER_EXP_ERR] = "经验不足"
msgno.PLAYER_MONEY_ERR = msgno.MODULE_ERROR_RESERVED - 811 -- 金币不足
content[msgno.PLAYER_MONEY_ERR] = "金币不足"
msgno.PLAYER_GOLD_ERR = msgno.MODULE_ERROR_RESERVED - 812 -- 元宝不足
content[msgno.PLAYER_GOLD_ERR] = "元宝不足"
msgno.PLAYER_STONE_ERR = msgno.MODULE_ERROR_RESERVED - 813 -- 石材不足
content[msgno.PLAYER_STONE_ERR] = "石材不足"
msgno.PLAYER_WOOD_ERR = msgno.MODULE_ERROR_RESERVED - 814 -- 木材不足
content[msgno.PLAYER_WOOD_ERR] = "木材不足"
msgno.PLAYER_STEEL_ERR = msgno.MODULE_ERROR_RESERVED - 809 -- 木材不足
content[msgno.PLAYER_STEEL_ERR] = "钢材不足"


msgno.PLAYER_NOT_VIP = msgno.MODULE_ERROR_RESERVED - 808 -- 不是VIP
content[msgno.PLAYER_NOT_VIP] = "不是VIP"
msgno.PLAYER_GUIL_ERR = msgno.MODULE_ERROR_RESERVED - 815 -- 修改帮派失败
content[msgno.PLAYER_GUIL_ERR] = "修改帮派失败"
msgno.PLAYER_SP_ERR = msgno.MODULE_ERROR_RESERVED - 816 -- 修改真气失败
content[msgno.PLAYER_SP_ERR] = "修改真气失败"
msgno.PLAYER_HONOR_ERR =  msgno.MODULE_ERROR_RESERVED - 817 -- 修改头荣誉失败
content[msgno.PLAYER_HONOR_ERR] = "修改头荣誉失败"
msgno.PLAYER_NOT_GET_AGAIN  = msgno.MODULE_ERROR_RESERVED - 818 -- 会员礼包已经领取过
content[msgno.PLAYER_NOT_GET_AGAIN] = "会员礼包已经领取过"
msgno.PLAYER_RECHARGE_GOLD_ERR = msgno.MODULE_ERROR_RESERVED - 819 -- 充值元宝参数错误
content[msgno.PLAYER_RECHARGE_GOLD_ERR] = "充值元宝参数错误"
msgno.PLAYER_ENERGY_ERR = msgno.MODULE_ERROR_RESERVED - 820 -- 修改体力错误
content[msgno.PLAYER_ENERGY_ERR] = "修改体力错误"
msgno.PLAYER_BUY_ENERGY_ERR = msgno.MODULE_ERROR_RESERVED - 821 -- 修改角色购买体力次数错误
content[msgno.PLAYER_BUY_ENERGY_ERR] = "修改角色购买体力次数错误"
msgno.PLAYER_OBJ_ERR = msgno.MODULE_ERROR_RESERVED - 822 -- 角色对象不在线
content[msgno.PLAYER_OBJ_ERR] = "角色对象不在线"
msgno.PLAYER_MAX_ENERGY_ERR = msgno.MODULE_ERROR_RESERVED - 823 -- 角色体力上限错误
content[msgno.PLAYER_MAX_ENERGY_ERR] = "角色体力上限错误"
-- 购买体力
msgno.PLAYER_ENERGY_OVER_ERR = msgno.MODULE_ERROR_RESERVED - 824 -- 超过最大购买体力次数
content[msgno.PLAYER_ENERGY_OVER_ERR] = "超过最大购买体力次数"
msgno.PLAYER_ENERGY_OVER_MAX = msgno.MODULE_ERROR_RESERVED - 825-- 体力已满
content[msgno.PLAYER_ENERGY_OVER_MAX] = "体力已满"
--
msgno.PLAYER_NOT_EXIST = msgno.MODULE_ERROR_RESERVED - 826
content[msgno.PLAYER_NOT_EXIST] = "角色不存在"

--mail
msgno.MAIL_NO_MAIL             = msgno.MODULE_ERROR_RESERVED - 1001
content[msgno.MAIL_NO_MAIL]    = "没有这邮件"
msgno.MAIL_CANNOT_DEL          = msgno.MODULE_ERROR_RESERVED - 1002
content[msgno.MAIL_CANNOT_DEL] = "无法删除邮件"
msgno.MAIL_CANNOT_GET_ATTACH          = msgno.MODULE_ERROR_RESERVED - 1003
content[msgno.MAIL_CANNOT_GET_ATTACH] = "无法领取附件"
msgno.MAIL_PARAM_ERR          = msgno.MODULE_ERROR_RESERVED - 1004
content[msgno.MAIL_PARAM_ERR] = "邮件参数错误"
msgno.MAIL_TARGET_NO          = msgno.MODULE_ERROR_RESERVED - 1005
content[msgno.MAIL_TARGET_NO] = "玩家不存在"

--chat 
msgno.CHAT_NOT_PEOPLE 		   = msgno.MODULE_ERROR_RESERVED - 1101
content[msgno.CHAT_NOT_PEOPLE] = "玩家不在线"
msgno.CHAT_IN_CD 		       = msgno.MODULE_ERROR_RESERVED - 1102
content[msgno.CHAT_IN_CD]      = "说话太快"


--guild
msgno.GUILD_ID_NOT_EXIST 							= msgno.MODULE_ERROR_RESERVED - 1201
content[msgno.GUILD_ID_NOT_EXIST] 					= "公会id不存在"
msgno.GUILD_HAVE_NOT_GUILD 							= msgno.MODULE_ERROR_RESERVED - 1202
content[msgno.GUILD_HAVE_NOT_GUILD] 				= "玩家没有加入或创建公会"
msgno.GUILD_IS_NOT_GUILD_MEMBER 					= msgno.MODULE_ERROR_RESERVED - 1203
content[msgno.GUILD_IS_NOT_GUILD_MEMBER] 			= "玩家不是公会成员"
msgno.GUILD_HAVE_GUILD 								= msgno.MODULE_ERROR_RESERVED - 1204
content[msgno.GUILD_HAVE_GUILD] 					= "玩家已有公会"
msgno.GUILD_NOT_ENOUGH_POWER 						= msgno.MODULE_ERROR_RESERVED - 1205
content[msgno.GUILD_NOT_ENOUGH_POWER] 				= "玩家没有足够权限执行此操作"
msgno.GUILD_EXCEL_OBJ_ERR 							= msgno.MODULE_ERROR_RESERVED - 1206
content[msgno.GUILD_EXCEL_OBJ_ERR] 					= "配置表对象不存在"
msgno.GUILD_HAVE_NOT_APPLY 							= msgno.MODULE_ERROR_RESERVED - 1207
content[msgno.GUILD_HAVE_NOT_APPLY] 				= "玩家未申请加入公会"
msgno.GUILD_HAVE_APPLY 								= msgno.MODULE_ERROR_RESERVED - 1208
content[msgno.GUILD_HAVE_APPLY] 					= "玩家已经申请加入公会"
msgno.GUILD_HAVE_FULL_MEMBER 						= msgno.MODULE_ERROR_RESERVED - 1209
content[msgno.GUILD_HAVE_FULL_MEMBER] 				= "公会成员已满"
msgno.GUILD_CAN_NOT_MODIFY_SELF 					= msgno.MODULE_ERROR_RESERVED - 1210
content[msgno.GUILD_CAN_NOT_MODIFY_SELF] 			= "会长无法修改自己的权限"
msgno.GUILD_VICE_PRESIDENT_IS_MAX 					= msgno.MODULE_ERROR_RESERVED - 1211
content[msgno.GUILD_VICE_PRESIDENT_IS_MAX] 			= "副会长职位已达上限"
msgno.GUILD_LV_NOT_ENOUHG_ERROR               		= msgno.MODULE_ERROR_RESERVED - 1212 
content[msgno.GUILD_LV_NOT_ENOUHG_ERROR]      		= "等级不够"
msgno.GUILD_LV_CAN_NOT_DELETE_SELF               	= msgno.MODULE_ERROR_RESERVED - 1213 
content[msgno.GUILD_LV_CAN_NOT_DELETE_SELF]      	= "无法将自己剔除公会"
msgno.GUILD_GUILD_NAME_ERROR				 		= msgno.MODULE_ERROR_RESERVED - 1214 
content[msgno.GUILD_GUILD_NAME_ERROR]         		= "公会名字重复"
msgno.GUILD_CAN_NOT_APPLP_WITH_REFUSE		  		= msgno.MODULE_ERROR_RESERVED - 1215
content[msgno.GUILD_CAN_NOT_APPLP_WITH_REFUSE]		= "当前处于被拒绝状态，无法申请"
msgno.GUILD_INVITE_NOT_EXIST		  				= msgno.MODULE_ERROR_RESERVED - 1216
content[msgno.GUILD_INVITE_NOT_EXIST]				= "邀请不存在"
msgno.GUILD_INVITER_IS_NOT_MEMBER		  			= msgno.MODULE_ERROR_RESERVED - 1217
content[msgno.GUILD_INVITER_IS_NOT_MEMBER]			= "邀请者不是该公会成员，此邀请无效"
msgno.GUILD_TARGET_NOT_EXIST         				= msgno.MODULE_ERROR_RESERVED - 1218
content[msgno.GUILD_TARGET_NOT_EXIST]   			= "玩家不存在"
msgno.GUILD_PRESIDENT_CAN_NOT_EXIT         			= msgno.MODULE_ERROR_RESERVED - 1218
content[msgno.GUILD_PRESIDENT_CAN_NOT_EXIT]   		= "会长无法退出公会，请解散公会或委任其它成员为会长"
msgno.GUILD_UP_POWER_ERROR         					= msgno.MODULE_ERROR_RESERVED - 1219
content[msgno.GUILD_UP_POWER_ERROR]   				= "修改的权限不合法"
msgno.GUILD_ALREADY_INVITE         					= msgno.MODULE_ERROR_RESERVED - 1220
content[msgno.GUILD_ALREADY_INVITE]   				= "已邀请该玩家，无法再次邀请"
msgno.GUILD_DELETE_NO_COUNT         				= msgno.MODULE_ERROR_RESERVED - 1221
content[msgno.GUILD_DELETE_NO_COUNT]   				= "今天已达公会剔除人数上限，无法剔除玩家"
msgno.GUILD_CAN_NOT_APPLY_WITH_EXIT		  			= msgno.MODULE_ERROR_RESERVED - 1222
content[msgno.GUILD_CAN_NOT_APPLY_WITH_EXIT]		= "当前处于主动退出公会状态，无法邀请或申请"
msgno.GUILD_NOT_GIVE_BANQUET_TIME		  			= msgno.MODULE_ERROR_RESERVED - 1223
content[msgno.GUILD_NOT_GIVE_BANQUET_TIME]			= "未到设宴时间段，无法设宴"
msgno.GUILD_ALREADY_GIVE_BANQUET		  			= msgno.MODULE_ERROR_RESERVED - 1224
content[msgno.GUILD_ALREADY_GIVE_BANQUET]			= "公会已经设宴，无法再次设宴"
msgno.GUILD_ALREADY_GET_BANQUET_ENERGY		  		= msgno.MODULE_ERROR_RESERVED - 1225
content[msgno.GUILD_ALREADY_GET_BANQUET_ENERGY]		= "今天已领取过体力，无法再次领取"
msgno.GUILD_OVER_GET_BANQUET_ENERGY		  		    = msgno.MODULE_ERROR_RESERVED - 1226
content[msgno.GUILD_OVER_GET_BANQUET_ENERGY]		= "已超过宴会领取时间，无法领取宴会体力"
msgno.GUILD_HAVE_NOT_BANQUET_ENERGY		  		    = msgno.MODULE_ERROR_RESERVED - 1227
content[msgno.GUILD_HAVE_NOT_BANQUET_ENERGY]		= "公会未设宴"
msgno.GUILD_CREATE_LV_NOT_ENOUGH		  		    = msgno.MODULE_ERROR_RESERVED - 1228
content[msgno.GUILD_CREATE_LV_NOT_ENOUGH]		    = "级别不够，无法创建公会"
msgno.GUILD_APPLY_MAX 								= msgno.MODULE_ERROR_RESERVED - 1229
content[msgno.GUILD_APPLY_MAX] 						= "玩家申请公会个数已达上限"

--chat 
msgno.CHAT_NOT_PEOPLE 		   = msgno.MODULE_ERROR_RESERVED - 1101 --玩家不在线
content[msgno.CHAT_NOT_PEOPLE] = "玩家不在线"


-- 好友
msgno.NOT_CONTACT = msgno.MODULE_ERROR_RESERVED - 1801 -- 不是联系人
content[msgno.NOT_CONTACT] = "不是联系人 "
msgno.ALREADY_CONTACT = msgno.MODULE_ERROR_RESERVED - 1802 -- 已经存在于联系人列表中
content[msgno.ALREADY_CONTACT] = "已经存在于联系人列表中 "
msgno.DATA_ERROR = msgno.MODULE_ERROR_RESERVED - 1803 -- 数据异常
content[msgno.DATA_ERROR] = "数据异常 "
msgno.ALREADY_IN_BLACK_LIST = msgno.MODULE_ERROR_RESERVED - 1804 -- 好友已经在黑名单
content[msgno.ALREADY_IN_BLACK_LIST] = "已经在黑名单中"
msgno.TARGET_NOT_ONLINE = msgno.MODULE_ERROR_RESERVED - 1805	-- 对方玩家不在线
content[msgno.TARGET_NOT_ONLINE] = "对方玩家不在线 "
msgno.SEND_BLANK_MESSAGE = msgno.MODULE_ERROR_RESERVED - 1806	-- 空白消息
content[msgno.SEND_BLANK_MESSAGE] = "空白消息 "
msgno.SEND_MESSAGE_FREQUENTLY = msgno.MODULE_ERROR_RESERVED - 1807	-- 发送消息太频繁
content[msgno.SEND_MESSAGE_FREQUENTLY] = "发送消息太频繁 "
msgno.NOT_ENOUGH_HORN = msgno.MODULE_ERROR_RESERVED - 1808
content[msgno.NOT_ENOUGH_HORN] = "喇叭道具不足 "
msgno.SEND_SCENE_MESSAGE_FAL = msgno.MODULE_ERROR_RESERVED - 1809
msgno.MAX_FRIEND_NUM = msgno.MODULE_ERROR_RESERVED - 1810    --超出上限 100
content[msgno.MAX_FRIEND_NUM] = "好友数量超出上限 "
msgno.ALREADY_ASKING = msgno.MODULE_ERROR_RESERVED - 1811    --已经申请过好友
content[msgno.ALREADY_ASKING] = "你已经申请过该好友 "
msgno.ALREADY_VISIT = msgno.MODULE_ERROR_RESERVED - 1812    --今日已经访问过好友
content[msgno.ALREADY_VISIT] = "今日已经访问过好友 "
msgno.MAX_VISTOR_NUM = msgno.MODULE_ERROR_RESERVED - 1813    --今日访问次数限制
content[msgno.MAX_VISTOR_NUM] = "今日访问次数限制 "
msgno.BATCH_ASKING_NOT_ONLINE = msgno.MODULE_ERROR_RESERVED - 1814    --部分玩家离线
content[msgno.BATCH_ASKING_NOT_ONLINE] = "部分玩家离线 "
msgno.ASKING_BE_REFUSE = msgno.MODULE_ERROR_RESERVED - 1815    --好友申请被拒绝
content[msgno.ASKING_BE_REFUSE] = "好友申请被拒绝 "
msgno.ADD_FRIEND_SUCCESS = msgno.MODULE_ERROR_RESERVED - 1816    --添加好友成功
content[msgno.ADD_FRIEND_SUCCESS] = "添加好友成功 "
msgno.FRIEND_CANNOT_GET = msgno.MODULE_ERROR_RESERVED - 1817   --不符合领取条件
content[msgno.FRIEND_CANNOT_GET] = "不符合领取条件 "
msgno.GET_ENERGY_MAX = msgno.MODULE_ERROR_RESERVED - 1818    --领取体力上限
content[msgno.GET_ENERGY_MAX] = "领取体力上限 "
msgno.MAX_FRIEND_BLACK_NUM = msgno.MODULE_ERROR_RESERVED - 1819    --黑名单上限
content[msgno.MAX_FRIEND_BLACK_NUM] = "黑名单上限 "
msgno.MAX_FRIEND_BE_APPLY_NUM = msgno.MODULE_ERROR_RESERVED - 1820    --被申请列表上限
content[msgno.MAX_FRIEND_BE_APPLY_NUM] = "被申请列表上限 "
msgno.CAN_NOT_FIND_PLAYER = msgno.MODULE_ERROR_RESERVED - 1821    --找不到玩家
content[msgno.CAN_NOT_FIND_PLAYER] = "找不到该玩家"
msgno.CAN_NOT_ADD_SELF = msgno.MODULE_ERROR_RESERVED - 1822    --不能加自己为好友
content[msgno.CAN_NOT_ADD_SELF] = "不能加自己为好友"
msgno.FRIEND_BE_ASKING = msgno.MODULE_ERROR_RESERVED - 1823    --对方已向你发送好友申请
content[msgno.FRIEND_BE_ASKING] = "对方已向你发送好友申请"
msgno.IN_TARGET_BLACK_LIST = msgno.MODULE_ERROR_RESERVED - 1824    --自己在对方的黑名单内
content[msgno.IN_TARGET_BLACK_LIST] = "自己在对方的黑名单内"
msgno.CAN_NOT_JOIN_BLACK_SELF = msgno.MODULE_ERROR_RESERVED - 1825    --不能拉黑自己
content[msgno.CAN_NOT_JOIN_BLACK_SELF] = "不能拉黑自己"

--活动
msgno.ACTIVE_GET_REWARD_FAILED = msgno.MODULE_ERROR_RESERVED - 2001				--领取活动奖励失败
content[msgno.ACTIVE_GET_REWARD_FAILED] = "领取奖励失败"

msgno.ACTIVE_TIME_OVER = msgno.MODULE_ERROR_RESERVED - 2003					-- 活动未开启或已结束
content[msgno.ACTIVE_TIME_OVER] = "活动未开启或已结束"

msgno.ACTIVE_REWARD_NOT_EXIST = msgno.MODULE_ERROR_RESERVED - 2004			-- 活动未开启或已结束
content[msgno.ACTIVE_REWARD_NOT_EXIST] = "活动奖励数据不存在"

msgno.ACTIVE_REWARD_ALREADY_GET = msgno.MODULE_ERROR_RESERVED - 2005			-- 活动未开启或已结束
content[msgno.ACTIVE_REWARD_ALREADY_GET] = "活动奖励已经领取"
msgno.ACTIVE_REWARD_NOT_GET_TIME = msgno.MODULE_ERROR_RESERVED - 2006			-- 活动未开启或已结束
content[msgno.ACTIVE_REWARD_NOT_GET_TIME] = "活动奖励未到领取时间"





-- 充值
msgno.RECHARGE_ID_NOT_EXIST = msgno.MODULE_ERROR_RESERVED - 2501
content[msgno.RECHARGE_ID_NOT_EXIST] = "充值id不存在"

-- 签到
msgno.SIGN_TODAY_SIGNED = msgno.MODULE_ERROR_RESERVED - 2601
content[msgno.SIGN_TODAY_SIGNED] = "今日已经签到过了"
msgno.SIGN_NOT_EXIST_ADD_SIGN = msgno.MODULE_ERROR_RESERVED - 2602
content[msgno.SIGN_NOT_EXIST_ADD_SIGN] = "没有可以补签的天数"
msgno.SIGN_ADD_SIGN_GOLD_ERROR = msgno.MODULE_ERROR_RESERVED - 2603
content[msgno.SIGN_ADD_SIGN_GOLD_ERROR] = "补签所需的元宝不足"
msgno.SIGN_REWARD_ERROR = msgno.MODULE_ERROR_RESERVED - 2604
content[msgno.SIGN_REWARD_ERROR] = "领取签到礼包的条件未达成"
msgno.SIGN_REWARD_ALREADY_GET_ERROR = msgno.MODULE_ERROR_RESERVED - 2605
content[msgno.SIGN_REWARD_ALREADY_GET_ERROR] = "签到礼包已经领取过了"


--帮派
msgno.GUILD_MONSTER_ID_ERROR = msgno.MODULE_ERROR_RESERVED - 3201
content[msgno.GUILD_MONSTER_ID_ERROR] = "喂养守护兽ID有错"
msgno.GUILD_LV_LIMIT = msgno.MODULE_ERROR_RESERVED - 3202
content[msgno.GUILD_LV_LIMIT] = "等级上限"
msgno.GUILD_ITEM_ERROR = msgno.MODULE_ERROR_RESERVED - 3203
content[msgno.GUILD_ITEM_ERROR] = "喂养的道具不对"
msgno.GUILD_FEED_LIMIT = msgno.MODULE_ERROR_RESERVED - 3204
content[msgno.GUILD_FEED_LIMIT] = "喂养每日上限"
 

-- 酒馆
msgno.PUB_NO_REWARD_TYPE = msgno.MODULE_ERROR_RESERVED - 3301
content[msgno.PUB_NO_REWARD_TYPE] = "奖池类型不存在"
msgno.PUB_NO_REWARD_COUNT_ERR = msgno.MODULE_ERROR_RESERVED - 3302
content[msgno.PUB_NO_REWARD_TYPE] = "设宴次数错误"
msgno.PUB_REWARD_TYPE_NO_OPEN = msgno.MODULE_ERROR_RESERVED - 3303
content[msgno.PUB_REWARD_TYPE_NO_OPEN] = "奖池类型未开启"
msgno.PUB_MEDAL_LESS = msgno.MODULE_ERROR_RESERVED - 3304
content[msgno.PUB_MEDAL_LESS] = "勋章不足"
--统帅
msgno.MONSTER_NOT_EXIST = msgno.MODULE_ERROR_RESERVED - 3401
content[msgno.MONSTER_NOT_EXIST] = "统帅不存在"
msgno.MONSTER_ALREADY_GET = msgno.MODULE_ERROR_RESERVED - 3402
content[msgno.MONSTER_ALREADY_GET] = "已经拥有该统帅"
msgno.MONSTER_MAX_COUNT = msgno.MODULE_ERROR_RESERVED - 3403
content[msgno.MONSTER_MAX_COUNT] = "超过当前带兵上限"
msgno.MONSTER_MAX_STEP = msgno.MODULE_ERROR_RESERVED - 3404
content[msgno.MONSTER_MAX_STEP] = "统帅阶数上限"
msgno.MONSTER_RESUORCE_ERROR = msgno.MODULE_ERROR_RESERVED - 3405
content[msgno.MONSTER_RESUORCE_ERROR] = "资源不足"

--建筑升级
msgno.BUILDING_NOT_EXIST = msgno.MODULE_ERROR_RESERVED - 3501
content[msgno.BUILDING_NOT_EXIST] = "建筑不存在"
msgno.BUILDING_MAX_LV = msgno.MODULE_ERROR_RESERVED - 3502
content[msgno.BUILDING_MAX_LV] = "建筑达到最高级"
msgno.BUILDING_NOT_CONDITION = msgno.MODULE_ERROR_RESERVED - 3503
content[msgno.BUILDING_NOT_CONDITION] = "依赖的建筑等级未达到条件"
msgno.BUILDING_NOT_PLAYER_UP = msgno.MODULE_ERROR_RESERVED - 3504
content[msgno.BUILDING_NOT_PLAYER_UP] = "无法手动升级"



--饰品穿戴
msgno.DECORATE_NO_OPEN = msgno.MODULE_ERROR_RESERVED - 3601
content[msgno.DECORATE_NO_OPEN] = "饰品孔位未开启"
msgno.DECORATE_SAME_TYPE = msgno.MODULE_ERROR_RESERVED - 3602
content[msgno.DECORATE_SAME_TYPE] = "穿戴饰品孔类型相同"
msgno.DECORATE_ALREADY_HAS = msgno.MODULE_ERROR_RESERVED - 3603
content[msgno.DECORATE_ALREADY_HAS] = "已穿戴饰品"

-- 通用奖励
msgno.COMMON_REWARD_NOT_FOUND = msgno.MODULE_ERROR_RESERVED - 3701
content[msgno.COMMON_REWARD_NOT_FOUND] = "找不到奖励"

-- 布阵
msgno.MONSTER_POSITION_NOT_TEAM = msgno.MODULE_ERROR_RESERVED - 3801
content[msgno.MONSTER_POSITION_NOT_TEAM] = "部队未开启"
msgno.MONSTER_POSITION_LESS = msgno.MODULE_ERROR_RESERVED - 3802
content[msgno.MONSTER_POSITION_LESS] = "位置超出数量"
msgno.MONSTER_POSITION_POSITION_ERROR = msgno.MODULE_ERROR_RESERVED - 3803
content[msgno.MONSTER_POSITION_POSITION_ERROR] = "位置不合法"
msgno.MONSTER_POSITION_POSITION_NO_OPEN = msgno.MODULE_ERROR_RESERVED - 3804
content[msgno.MONSTER_POSITION_POSITION_NO_OPEN] = "位置未开启"

--副本 enough
msgno.RESET_COUNT_NOT_ENOUGH = msgno.MODULE_ERROR_RESERVED - 3901
content[msgno.RESET_COUNT_NOT_ENOUGH] = "副本重置次数不足"
msgno.ENERGY_NOT_ENOUGH = msgno.MODULE_ERROR_RESERVED - 3902
content[msgno.ENERGY_NOT_ENOUGH] = "行动力不足"
msgno.COPY_CONFITION_NOT_ENOUGH = msgno.MODULE_ERROR_RESERVED - 3903
content[msgno.COPY_CONFITION_NOT_ENOUGH] = "条件不足不能挑战该副本"
msgno.CHALLENGE_NOT_ENOUGH = msgno.MODULE_ERROR_RESERVED - 3904
content[msgno.CHALLENGE_NOT_ENOUGH] = "挑战次数不足"
msgno.CANOT_BUY_CHALLENGE = msgno.MODULE_ERROR_RESERVED - 3905
content[msgno.CANOT_BUY_CHALLENGE] = "该副本不允许重置挑战次数"
msgno.COPY_VISIT_NOT_ENOUGH = msgno.MODULE_ERROR_RESERVED - 3906
content[msgno.COPY_VISIT_NOT_ENOUGH] = "拜访度不足,不能领取统帅"
msgno.TREASURE_NOT_OPEN = msgno.MODULE_ERROR_RESERVED - 3907
content[msgno.TREASURE_NOT_OPEN] = "宝箱未开启,不能领取宝箱"
msgno.MOPUP_STAR_3_ERR = msgno.MODULE_ERROR_RESERVED - 3908
content[msgno.MOPUP_STAR_3_ERR] = "必须是三星评价才能进行"
msgno.RESET_NOT_VIP = msgno.MODULE_ERROR_RESERVED - 3909
content[msgno.RESET_NOT_VIP] = "不满足重置的条件,不是VIP"
msgno.RESET_HAS_CHALLEGE_COUNT = msgno.MODULE_ERROR_RESERVED - 3910
content[msgno.RESET_HAS_CHALLEGE_COUNT] = "还有挑战次数不用重置"
msgno.MOPUP_NOT_PASS = msgno.MODULE_ERROR_RESERVED - 3911
content[msgno.MOPUP_NOT_PASS] = "该副本未通关过,不能扫荡"
msgno.TREASURE_HAD_OPEN = msgno.MODULE_ERROR_RESERVED - 3912
content[msgno.TREASURE_HAD_OPEN] = "宝箱已领取"
msgno.COPY_ALREADY_PASS = msgno.MODULE_ERROR_RESERVED - 3913
content[msgno.COPY_ALREADY_PASS] = "副本已通关，不能进行挑战"
msgno.COPY_NOT_OPEN = msgno.MODULE_ERROR_RESERVED - 3914
content[msgno.COPY_NOT_OPEN] = "副本未开启"
 
--封地
msgno.FIEF_HAS_NOT = msgno.MODULE_ERROR_RESERVED - 4000
content[msgno.FIEF_HAS_NOT] = "该封地未开启"
msgno.FIEF_POS_HAS_NOT = msgno.MODULE_ERROR_RESERVED - 4001
content[msgno.FIEF_POS_HAS_NOT] = "该孔位未开启"
msgno.FIEF_POS_HAS_NOT_BUILDING = msgno.MODULE_ERROR_RESERVED - 4002
content[msgno.FIEF_POS_HAS_NOT_BUILDING] = "该孔位没有建造建筑"
msgno.FIEF_POS_DEFAULT = msgno.MODULE_ERROR_RESERVED - 4003
content[msgno.FIEF_POS_DEFAULT] = "默认建筑不能拆除"
msgno.FIEF_NO_RESOURCES = msgno.MODULE_ERROR_RESERVED - 4004
content[msgno.FIEF_NO_RESOURCES] = "无资源不能领取"
msgno.FIEF_CD_TIME= msgno.MODULE_ERROR_RESERVED - 4005
content[msgno.FIEF_CD_TIME] = "领取时间cd"
msgno.FIEF_POS_HAS__BUILDING = msgno.MODULE_ERROR_RESERVED - 4006
content[msgno.FIEF_POS_HAS__BUILDING] = "该孔位已建造建筑"


-- 学院
msgno.MONSTER_STEP_CANNOT = msgno.MODULE_ERROR_RESERVED - 4101
content[msgno.MONSTER_STEP_CANNOT] = "无法进阶"
msgno.MONSTER_STRENGTHEN_CANNOT = msgno.MODULE_ERROR_RESERVED - 4102
content[msgno.MONSTER_STRENGTHEN_CANNOT] = "无法强化"
msgno.MONSTER_STEP_MAX = msgno.MODULE_ERROR_RESERVED - 4103
content[msgno.MONSTER_STEP_MAX] = "以进阶到最高级"
msgno.MONSTER_STRENGTHEN_MAX = msgno.MODULE_ERROR_RESERVED - 4104
content[msgno.MONSTER_STRENGTHEN_MAX] = "以强化到最高级"
msgno.MONSTER_STEP_STRENGTHEN = msgno.MODULE_ERROR_RESERVED - 4105
content[msgno.MONSTER_STEP_STRENGTHEN] = "需要强化满才能进阶"
msgno.MONSTER_STEP_XUEYUAN_LV = msgno.MODULE_ERROR_RESERVED - 4106
content[msgno.MONSTER_STEP_XUEYUAN_LV] = "学院等级不够"
-- 学院背包
msgno.COLLEGE_MATERIAL_LESS = msgno.MODULE_ERROR_RESERVED - 4107
content[msgno.COLLEGE_MATERIAL_LESS] = "材料不够"
msgno.COLLEGE_MATERIAL_NO = msgno.MODULE_ERROR_RESERVED - 4108
content[msgno.COLLEGE_MATERIAL_NO] = "找不到合成目标"
msgno.COLLEGE_MATERIAL_NUM_ERR = msgno.MODULE_ERROR_RESERVED - 4109
content[msgno.COLLEGE_MATERIAL_NUM_ERR] = "数量错误"
msgno.COLLEGE_MATERIAL_CANNOT_MERGE = msgno.MODULE_ERROR_RESERVED - 4110
content[msgno.COLLEGE_MATERIAL_CANNOT_MERGE] = "无法合成"
msgno.COLLEGE_MATERIAL_CANNOT_SPLIT = msgno.MODULE_ERROR_RESERVED - 4111
content[msgno.COLLEGE_MATERIAL_CANNOT_SPLIT] = "无法分解"

-- 市场
msgno.IN_CD_TIME = msgno.MODULE_ERROR_RESERVED - 4201
content[msgno.IN_CD_TIME] = "冷却中"
msgno.MONEY_BUY_COUNT_LESS = msgno.MODULE_ERROR_RESERVED - 4202
content[msgno.MONEY_BUY_COUNT_LESS] = "购买次数不足"
msgno.MONEY_NOT_OPEN = msgno.MODULE_ERROR_RESERVED - 4203
content[msgno.MONEY_NOT_OPEN] = "市场未开启"
msgno.MONEY_PRICE_ERR = msgno.MODULE_ERROR_RESERVED - 4204
content[msgno.MONEY_PRICE_ERR] = "价格错误"
-- 庄园
msgno.MANOR_BUY_COUNT_LESS = msgno.MODULE_ERROR_RESERVED - 4205
content[msgno.MANOR_BUY_COUNT_LESS] = "购买次数不足"
msgno.MANOR_NOT_OPEN = msgno.MODULE_ERROR_RESERVED - 4206
content[msgno.MANOR_NOT_OPEN] = "庄园未开启"
msgno.MANOR_PRICE_ERR = msgno.MODULE_ERROR_RESERVED - 4207
content[msgno.MANOR_PRICE_ERR] = "价格错误"

-- 科技点
msgno.SCIENCE_ALREADY_EXPLORE = msgno.MODULE_ERROR_RESERVED - 4301
content[msgno.SCIENCE_ALREADY_EXPLORE] = "普通科技点已被探索"
msgno.SCIENCE_STAR_NOT_ENOUGH = msgno.MODULE_ERROR_RESERVED - 4302
content[msgno.SCIENCE_STAR_NOT_ENOUGH] = "副本星级不够"
msgno.SCIENCE_NOT_EXIST = msgno.MODULE_ERROR_RESERVED - 4303
content[msgno.SCIENCE_NOT_EXIST] = "科技点不存在"
msgno.SCIENCE_ATTR_NOT_EXIST = msgno.MODULE_ERROR_RESERVED - 4304
content[msgno.SCIENCE_ATTR_NOT_EXIST] = "科技点属性ID不存在"
msgno.SCIENCE_FREE_TIMES_NOT_ENOUGH = msgno.MODULE_ERROR_RESERVED - 4305
content[msgno.SCIENCE_FREE_TIMES_NOT_ENOUGH] = "免费研发次数不足"
msgno.SCIENCE_CAN_NOT_RESEARCH = msgno.MODULE_ERROR_RESERVED - 4306
content[msgno.SCIENCE_CAN_NOT_RESEARCH] = "该科技点无法研发"

--竞技场
msgno.PVP_NO_DATA = msgno.MODULE_ERROR_RESERVED - 4501
content[msgno.PVP_NO_DATA] = "没有数据"
msgno.PVP_COUNT_LESS = msgno.MODULE_ERROR_RESERVED - 4502
content[msgno.PVP_COUNT_LESS] = "挑战次数不足"
msgno.PVP_RIVAL_CHANGE = msgno.MODULE_ERROR_RESERVED - 4503
content[msgno.PVP_RIVAL_CHANGE] = "对手信息变化"
msgno.PVP_RIVAL_ERR = msgno.MODULE_ERROR_RESERVED - 4504
content[msgno.PVP_RIVAL_ERR] = "请挑战正确的对手"
msgno.PVP_REFRESH_RIVAL_CD = msgno.MODULE_ERROR_RESERVED - 4505
content[msgno.PVP_REFRESH_RIVAL_CD] = "CD中"
msgno.PVP_NO_RIVAL = msgno.MODULE_ERROR_RESERVED - 4506
content[msgno.PVP_NO_RIVAL] = "目标不存在"
msgno.PVP_BUY_COUNT_LESS = msgno.MODULE_ERROR_RESERVED - 4507
content[msgno.PVP_BUY_COUNT_LESS] = "挑战购买次数不足"
msgno.PVP_RECORD_NOT = msgno.MODULE_ERROR_RESERVED - 4508
content[msgno.PVP_RECORD_NOT] = "记录无法查看"
-- 竞技场 商店
msgno.PVP_SHOP_NO_GOODS = msgno.MODULE_ERROR_RESERVED - 4520
content[msgno.PVP_SHOP_NO_GOODS] = "商品不存在"
msgno.PVP_SHOP_COUNT_LIMIT = msgno.MODULE_ERROR_RESERVED - 4521
content[msgno.PVP_SHOP_COUNT_LIMIT] = "商品超出购买限制"
msgno.PVP_SHOP_PRESTIGE_LESS = msgno.MODULE_ERROR_RESERVED - 4522
content[msgno.PVP_SHOP_PRESTIGE_LESS] = "声望不足"


--银矿战
msgno.SILVERMINE_POINT_ERROR = msgno.MODULE_ERROR_RESERVED - 4601
content[msgno.SILVERMINE_POINT_ERROR] = "银矿战矿点错误"
msgno.SILVERMINE_HEIGHT_POINT_NOT = msgno.MODULE_ERROR_RESERVED - 4602
content[msgno.SILVERMINE_HEIGHT_POINT_NOT] = "矿点未开放"
msgno.SILVERMINE__POINT_PROTECTED= msgno.MODULE_ERROR_RESERVED - 4603
content[msgno.SILVERMINE__POINT_PROTECTED] = "矿点处于保护时间状态"
msgno.SILVERMINE__NOT_TIME= msgno.MODULE_ERROR_RESERVED - 4604
content[msgno.SILVERMINE__NOT_TIME] = "不在活动时间"
msgno.SILVERMINE__NOT_STATUS= msgno.MODULE_ERROR_RESERVED - 4605
content[msgno.SILVERMINE__NOT_STATUS] = "无资格参与该矿点占领"
msgno.SILVERMINE__NOT_PUBLIC= msgno.MODULE_ERROR_RESERVED - 4606
content[msgno.SILVERMINE__NOT_PUBLIC] = "非公共矿点不能放弃采集"
msgno.SILVERMINE__IS_SELF= msgno.MODULE_ERROR_RESERVED - 4607
content[msgno.SILVERMINE__IS_SELF] = "自己占领过的矿点不能再占领"
msgno.SILVERMINE_NOT_NUM= msgno.MODULE_ERROR_RESERVED - 4608
content[msgno.SILVERMINE_NOT_NUM] = "秘银数量不足"
msgno.SILVERMINE_RICE_NOT_NUM= msgno.MODULE_ERROR_RESERVED - 4609
content[msgno.SILVERMINE_RICE_NOT_NUM] = "库存粮草数量不足"
msgno.SILVERMINE_POINT_CHECK_ERROR= msgno.MODULE_ERROR_RESERVED - 4610
content[msgno.SILVERMINE_POINT_CHECK_ERROR] = "位置和矿点信息检验错误"
msgno.SILVERMINE_NO_ATTACK_LAYOUT= msgno.MODULE_ERROR_RESERVED - 4611
content[msgno.SILVERMINE_NO_ATTACK_LAYOUT] = "未设置出战阵容"
msgno.SILVERMINE_RECHARE_NONE= msgno.MODULE_ERROR_RESERVED - 4612
content[msgno.SILVERMINE_RECHARE_NONE] = "补兵列表为空"
msgno.SILVERMINE_NOTE_ACTIVITY= msgno.MODULE_ERROR_RESERVED - 4613
content[msgno.SILVERMINE_NOTE_ACTIVITY] = "银矿战不在活动状态"

 
-- 龙与地下城
msgno.DUNGEON_CHAPTER_HAS_LOCKED = msgno.MODULE_ERROR_RESERVED - 4801
content[msgno.DUNGEON_CHAPTER_HAS_LOCKED] = "章节已被锁定，无法挑战或扫荡该章节"
msgno.DUNGEON_CHALLENGE_COUNT_NOT_ENOUGH = msgno.MODULE_ERROR_RESERVED - 4802
content[msgno.DUNGEON_CHALLENGE_COUNT_NOT_ENOUGH] = "重新挑战次数不足"
msgno.DUNGEON_GOLD_CHALLENGE_COUNT_NOT_ENOUGH = msgno.MODULE_ERROR_RESERVED - 4803
content[msgno.DUNGEON_GOLD_CHALLENGE_COUNT_NOT_ENOUGH] = "钻石挑战次数不足"
msgno.DUNGEON_RECHARGE_COUNT_NOT_ENOUGH = msgno.MODULE_ERROR_RESERVED - 4804
content[msgno.DUNGEON_RECHARGE_COUNT_NOT_ENOUGH] = "一键补兵次数不足"
msgno.DUNGEON_CHALLENGE_TIMES_NOT_ENOUGH = msgno.MODULE_ERROR_RESERVED - 4805
content[msgno.DUNGEON_CHALLENGE_TIMES_NOT_ENOUGH] = "免费重新挑战次数不足"

-- 符文
msgno.RUNE_HOLE_ERROR = msgno.MODULE_ERROR_RESERVED - 4900
content[msgno.RUNE_HOLE_ERROR] = "孔位不合法"
msgno.RUNE_HOLE_NO_OPEN = msgno.MODULE_ERROR_RESERVED - 4901
content[msgno.RUNE_HOLE_NO_OPEN] = "孔位未开"
msgno.RUNE_NUM_LESS = msgno.MODULE_ERROR_RESERVED - 4902
content[msgno.RUNE_NUM_LESS] = "符文不足"
msgno.RUNE_SAME_TYPE = msgno.MODULE_ERROR_RESERVED - 4903
content[msgno.RUNE_SAME_TYPE] = "装备了相同类型的符文"
msgno.RUNE_MERGE_ID_ERR = msgno.MODULE_ERROR_RESERVED - 4904
content[msgno.RUNE_MERGE_ID_ERR] = "非法合成ID"
msgno.RUNE_NUM_ERR = msgno.MODULE_ERROR_RESERVED - 4905
content[msgno.RUNE_NUM_ERR] = "数量错误"
msgno.RUNE_SELL_INDEX_ERROR = msgno.MODULE_ERROR_RESERVED - 4906
content[msgno.RUNE_SELL_INDEX_ERROR] = "卖出位置错误"
msgno.RUNE_SELL_NUM_LESS = msgno.MODULE_ERROR_RESERVED - 4907
content[msgno.RUNE_SELL_NUM_LESS] = "数量不够"


-- 怪物攻城
msgno.ATK_SP_PRICE_ERR = msgno.MODULE_ERROR_RESERVED - 5000
content[msgno.ATK_SP_PRICE_ERR] = "价格错误"
msgno.ATK_BUY_COUNT_LESS = msgno.MODULE_ERROR_RESERVED - 5001
content[msgno.ATK_BUY_COUNT_LESS] = "购买次数不足"
msgno.ATK_BUY_PRICE_LESS = msgno.MODULE_ERROR_RESERVED - 5002
content[msgno.ATK_BUY_PRICE_LESS] = "余额不足"
msgno.ATK_NO_MONSTER_TEAM = msgno.MODULE_ERROR_RESERVED - 5003
content[msgno.ATK_NO_MONSTER_TEAM] = "怪物不存在"
msgno.ATK_SP_LESS = msgno.MODULE_ERROR_RESERVED - 5004
content[msgno.ATK_SP_LESS] = "精力不够"
msgno.ATK_DIE_OR_RUN = msgno.MODULE_ERROR_RESERVED - 5005
content[msgno.ATK_DIE_OR_RUN] = "怪物逃走或被击杀"
msgno.ATK_SHARE_FAILED = msgno.MODULE_ERROR_RESERVED - 5006
content[msgno.ATK_SHARE_FAILED] = "分享失败"
msgno.ATK_ON_BEGIN = msgno.MODULE_ERROR_RESERVED - 5007
content[msgno.ATK_ON_BEGIN] = "活动还未开始"
msgno.ATK_ALREADY_SHARED = msgno.MODULE_ERROR_RESERVED - 5008
content[msgno.ATK_ALREADY_SHARED] = "已经共享了"
msgno.ATK_FEATS_GET = msgno.MODULE_ERROR_RESERVED - 5009
content[msgno.ATK_FEATS_GET] = "已经领取过了"
msgno.ATK_FEATS_NO_ID = msgno.MODULE_ERROR_RESERVED - 5010
content[msgno.ATK_FEATS_NO_ID] = "没有该奖励"
msgno.ATK_FEATS_LESS = msgno.MODULE_ERROR_RESERVED - 5011
content[msgno.ATK_FEATS_LESS] = "功勋不足"
msgno.ATK_CANNOT_GET = msgno.MODULE_ERROR_RESERVED - 5012
content[msgno.ATK_CANNOT_GET] = "不能领取"
msgno.ATK_PLAYER_ERR = msgno.MODULE_ERROR_RESERVED - 5013
content[msgno.ATK_PLAYER_ERR] = "怪物攻城玩家数据错误"


-- 装备系统
msgno.EQUIP_SILVER_NOT_ENOUGH = msgno.MODULE_ERROR_RESERVED - 5101 
content[msgno.EQUIP_SILVER_NOT_ENOUGH] = "秘银不足，无法兑换装备" 
msgno.EQUIP_EXCHANGE_COUNT_NOT_ENOUGH = msgno.MODULE_ERROR_RESERVED - 5102 
content[msgno.EQUIP_EXCHANGE_COUNT_NOT_ENOUGH] = "兑换次数已达限购上限,无法兑换" 
msgno.EQUIP_CAN_NOT_EXCHANGE = msgno.MODULE_ERROR_RESERVED - 5103 
content[msgno.EQUIP_CAN_NOT_EXCHANGE] = "无法兑换当前级别装备"
msgno.EQUIP_EQUIP_LEVEL_NOT_ENOUGH = msgno.MODULE_ERROR_RESERVED - 5104 
content[msgno.EQUIP_EQUIP_LEVEL_NOT_ENOUGH] = "未达到穿戴等级要求"
msgno.OBJ_NOT_EQUIP_ERR = msgno.MODULE_ERROR_RESERVED - 5105
content[msgno.OBJ_NOT_EQUIP_ERR] = "强化对象不是装备"
msgno.BAG_ITEM_EXCEL_OBJ_ERR = msgno.MODULE_ERROR_RESERVED - 5106
content[msgno.BAG_ITEM_EXCEL_OBJ_ERR] = "配置表对象不存在"
msgno.EQUIP_STRENGTHEN_EQUIP_OBJ_ERR = msgno.MODULE_ERROR_RESERVED - 5106
content[msgno.EQUIP_STRENGTHEN_EQUIP_OBJ_ERR] = "装备不存在"
msgno.EQUIP_STRENGTHEN_MAX_ERR = msgno.MODULE_ERROR_RESERVED - 5106
content[msgno.EQUIP_STRENGTHEN_MAX_ERR] = "已达强化上限，无法强化"
msgno.EQUIP_STRENGTHEN_LV_NOT_ENOUGH = msgno.MODULE_ERROR_RESERVED - 5107
content[msgno.EQUIP_STRENGTHEN_LV_NOT_ENOUGH] = "装备强化级别为0，无法熔炼"
msgno.EQUIP_AUTO_STRENGTHEN_SILVER_NOT_ENOUGH = msgno.MODULE_ERROR_RESERVED - 5108
content[msgno.EQUIP_AUTO_STRENGTHEN_SILVER_NOT_ENOUGH] = "秘银不足，无法自动强化"
msgno.EQUIP_STRENGTHEN_BUILDING_LV_NOT_ENOUGH = msgno.MODULE_ERROR_RESERVED - 5109
content[msgno.EQUIP_STRENGTHEN_BUILDING_LV_NOT_ENOUGH] = "装备强化依赖建筑等级不足"


-- 贸易
msgno.TRADE_BOAT_NOTUP = msgno.MODULE_ERROR_RESERVED - 5201
content[msgno.TRADE_BOAT_NOTUP] = "船无法升级"
msgno.TRADE_STATUS_ERR = msgno.MODULE_ERROR_RESERVED - 5202
content[msgno.TRADE_STATUS_ERR] = "船的状态不对"
msgno.TRADE_SAME_CITY = msgno.MODULE_ERROR_RESERVED - 5203
content[msgno.TRADE_SAME_CITY] = "目标城市和出发城市相同"
msgno.TRADE_UNLOCK_CITY = msgno.MODULE_ERROR_RESERVED - 5204
content[msgno.TRADE_UNLOCK_CITY] = "城市未解锁"
msgno.TRADE_NOTTO_CITY = msgno.MODULE_ERROR_RESERVED - 5205
content[msgno.TRADE_NOTTO_CITY] = "城市不可到达"
msgno.TRADE_NO_CITY = msgno.MODULE_ERROR_RESERVED - 5206
content[msgno.TRADE_NO_CITY] = "城市不存在"
msgno.TRADE_LV_LESS = msgno.MODULE_ERROR_RESERVED - 5207
content[msgno.TRADE_LV_LESS] = "等级不够"
msgno.TRADE_OUT_COUNT = msgno.MODULE_ERROR_RESERVED - 5208
content[msgno.TRADE_OUT_COUNT] = "商品数量不足"
msgno.TRADE_OUT_SPACE = msgno.MODULE_ERROR_RESERVED - 5209
content[msgno.TRADE_OUT_SPACE] = "船空间不足"
msgno.TRADE_SALE_NUM_ERR = msgno.MODULE_ERROR_RESERVED - 5210
content[msgno.TRADE_SALE_NUM_ERR] = "卖出数量有误"
msgno.TRADE_CITY_NOT_SALE = msgno.MODULE_ERROR_RESERVED - 5211
content[msgno.TRADE_CITY_NOT_SALE] = "不可以在此城市出售"
msgno.TRADE_BOAT_NOT_IN_CITY = msgno.MODULE_ERROR_RESERVED - 5212
content[msgno.TRADE_BOAT_NOT_IN_CITY] = "船不在当前城市"
msgno.TRADE_NOT_GET_FRIEND = msgno.MODULE_ERROR_RESERVED - 5213
content[msgno.TRADE_NOT_GET_FRIEND] = "无法获取好友的商品信息"
msgno.TRADE_DATA_ERR = msgno.MODULE_ERROR_RESERVED - 5214
content[msgno.TRADE_DATA_ERR] = "数据错误"
msgno.TRADE_CANNOT_ATTACK_CITY = msgno.MODULE_ERROR_RESERVED - 5215
content[msgno.TRADE_CANNOT_ATTACK_CITY] = "无法攻击城市"
msgno.TRADE_PROTECT_CITY = msgno.MODULE_ERROR_RESERVED - 5216
content[msgno.TRADE_PROTECT_CITY] = "无法攻击城市"
msgno.TRADE_CANNOT_ATK_PLAYER = msgno.MODULE_ERROR_RESERVED - 5217
content[msgno.TRADE_CANNOT_ATK_PLAYER] = "无法攻击对手"
msgno.TRADE_ATK_COUNT_LESS = msgno.MODULE_ERROR_RESERVED - 5218
content[msgno.TRADE_ATK_COUNT_LESS] = "攻击次数不足"
msgno.TRADE_BUY_COUNT_LESS = msgno.MODULE_ERROR_RESERVED - 5219
content[msgno.TRADE_BUY_COUNT_LESS] = "购买次数不足"
msgno.TRADE_MODE_ERR = msgno.MODULE_ERROR_RESERVED - 5220
content[msgno.TRADE_MODE_ERR] = "模式不对"

-- reward
msgno.REWARD_GET_ERR = msgno.MODULE_ERROR_RESERVED - 5301
content[msgno.REWARD_GET_ERR] = "获取奖励失败"

-- 条件开启
msgno.OPEN_CONDITION_LV_LESS = msgno.MODULE_ERROR_RESERVED - 5401
content[msgno.OPEN_CONDITION_LV_LESS] = "等级不够"
msgno.OPEN_CONDITION_BUILDING_LV_LESS = msgno.MODULE_ERROR_RESERVED - 5402
content[msgno.OPEN_CONDITION_BUILDING_LV_LESS] = "建筑等级不够"
msgno.OPEN_CONDITION_SCENE_NOTPASS = msgno.MODULE_ERROR_RESERVED - 5403
content[msgno.OPEN_CONDITION_SCENE_NOTPASS] = "未通关副本"
msgno.OPEN_CONDITION_VIP_LESS = msgno.MODULE_ERROR_RESERVED - 5404
content[msgno.OPEN_CONDITION_VIP_LESS] = "vip等级不够"

-- 获取说明
function msgno.get_content(no)
	return content[no]
end

return msgno
