

-- local items = {0.3,0.6,1}

-- -- 0.16
-- items = {0.32,0.58,0.76,0.88,0.96,1}
-- items2 = {0.26,0.48,0.64,0.78,0.90,1}
-- items3 = {0.20,0.40,0.58,0.74,0.88,1}

-- function count(items)
-- 	local len = #items
-- 	print("==> " .. len .. "个数平均概率：" .. 1/(len) )

-- 	local last_rom = 0
-- 	local total = 0
-- 	for index,value in pairs(items) do
-- 		if index == 1 then
-- 			print("==> 第" .. index .. "个实际概率：", value)
-- 			total = value
-- 			last_rom = value
-- 		elseif index == len then
-- 			print("==> 第" .. index .. "个实际概率：", value - total)
-- 		else
-- 			print("==> 第" .. index .. "个实际概率：", value - last_rom)
-- 			total = total + (value - last_rom)
-- 			last_rom = value
-- 		end
-- 	end
-- end

-- count(items)
-- print("==============")
-- count(items2)
-- print("==============")
-- count(items3)
-- print("==============")

local str = "hello world"
print(str)
-- print(string.pack(">s2", str))
-- print(string.pack(">s3", str))

