
local a = "{pos=3, name='zhang'}"
local b = loadstring("return "..a)();
print(b.pos, b.name)