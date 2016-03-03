--[["
  desc: table辅助类
  author: oyxz
  since: 2014-01-02
 "]]

local tableutil = {}

-- 得到map的长度
function tableutil.gettablelen(mytable)
	if mytable == nil then
		return nil
	end
	local result = 0
	for key, value in pairs(mytable) do
		result = result + 1
	end
	return result
end

-- 表复制
function tableutil.simple_copy(data)
	local tab = {}
	for k, v in pairs(data or {}) do
		tab[k] = v
	end
	return tab
end
tableutil.clone = tableutil.simple_copy

-- 表复制
function tableutil.deep_copy(data)
	local tab = {}
	for k, v in pairs(data or {}) do
		if type(v) ~= "table" then
			tab[k] = v
		else
			tab[k] = tableutil.deep_copy(v)
		end
	end
	return tab
end

-- 表复制某些数据
function tableutil.clone_data(data, keys)
	local tab = {}
	for _, k in pairs(keys or {}) do
		if data[k] then
			tab[k] = data[k]
		end
	end
	return tab
end

-- 表填充一些数据
function tableutil.fill_data(target, data)
	if target == nil then
		return
	end
	for k, v in pairs(data) do
		target[k] = v
	end
end

-- 一个元素是不是属于一个table
function tableutil.belong_to(mytable, value)
	for _, v in pairs(mytable) do
		if v == value then
			return true
		end
	end
	return false
end

-- 截取
function tableutil.sub(t, i, j)
	return { unpack(t, i, j) }
end


-- 合表
function tableutil.merger(tab_A, tab_B)
	local tab_C = {}
	for k, v in pairs(tab_A) do
		if type(v) == "table" then
			tab_C[k] = tableutil.deep_copy(v)
		else
			tab_C[k] = v
		end
	end

	for k,v in pairs(tab_B) do
		if type(v) == "table" then
			tab_C[k] = tableutil.deep_copy(v)
		else
			tab_C[k] = v
		end
	end

	return tab_C
end

-- 合并数组不保存键
function tableutil.merger_array(tab_A, tab_B)
	local tab_C = {}
	for k, v in pairs(tab_A  or {}) do
		table.insert(tab_C,v)
	end
	for k, v in pairs(tab_B or {}) do
		table.insert(tab_C,v)
	end
	return tab_C
end

-- 只加了最外层
function tableutil.simple_add_number(...)
	return tableutil.simple_add(...)
end

function tableutil.simple_multi(tb, d)
	if not tb or type(tb) ~= type({}) then
		return
	end
	assert(d and type(d)==type(1))

	local ret = {}
	for k, v in pairs(tb) do
		if type(v) == type(1) then
			ret[k] = v * d
		elseif type(v) == type({}) then
			ret[k] = tableutil.simple_multi(v, d)
		else
			ret[k] = v
		end
	end
	return ret
end

-- 加了多层
function tableutil.simple_add(...)
	local ret = {}
	for _, tb in pairs({...}) do
		for k, v in pairs(tb) do
			if type(v) == type(1) then
				ret[k] = (ret[k] or 0) + v
			elseif type(v) == type({}) then
				ret[k] = ret[k] or {}
				ret[k] = tableutil.simple_add(ret[k], v)
			else
				ret[k] = v
			end
		end
	end
	return ret
end

function tableutil.conver_map_to_table(maps)
	local stable = {}
	for _,v in ipairs(maps or {}) do
		table.insert(stable,v)
	end 
	return stable
end

--key tostring,解决稀疏数组问题
function tableutil.map_key_tostring(maps)
	local stable ={}
	for  k,v in pairs(maps or {}) do
		k = tostring(k) or k
		if type(v) == "table" then
			stable[k] = tableutil.map_key_tostring(v)
		else
			stable[k] = v
		end
	end 

	return stable
end


function tableutil.map_key_tonumber(maps)
	local stable = {}
	for  k,v in pairs(maps or {}) do
		k = tonumber(k) or k
		if type(v) == "table" then
			stable[k] = tableutil.map_key_tonumber(v)
		else
			stable[k] = v
		end
	end 
	return stable
end

-- 叠加相同键的值
function tableutil.overlay(attributes)
	return tableutil.simple_add(table.unpack(attributes))
end

-- 表乘法
function tableutil.multiply(attribute,rate)
	local result = {}
	for key, value in pairs(attribute) do
		if type(value) == "number" then
			result[key] = value *rate
		end
	end
	return result
end

-- print table
function tableutil.print_table(root)
	
	if root == nil then
		print("[PRINT_TABLE] root is nil")
		return
	end
	if type(root) ~= type({}) then
		print("[PRINT_TABLE] root not table type")
		return
	end
	if not next(root) then
		return
	end

	local cache = {  [root] = "." }
	local function _dump(t, space, name)
		local temp = {}
		for k,v in pairs(t) do
			local key = tostring(k)
			if cache[v] then
				table.insert(temp,"  +" .. key .. " {" .. cache[v].."}")
			elseif type(v) == "table" then
				local new_key = name .. "." .. key
				cache[v] = new_key
				table.insert(temp,"+" .. key .. _dump(v,space .. (next(t,k) and "|" or " " ).. string.rep(" ",#key),new_key))
			else
				table.insert(temp,"+" .. key .. " [" .. tostring(v).."]")
			end
		end
		return table.concat(temp,"\n"..space)
	end
	print(_dump(root, " 	     ", ""))
end

return tableutil
