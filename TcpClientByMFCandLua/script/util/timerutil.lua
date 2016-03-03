-- 定时器

require("iuplua")

local timerutil = {}
local meta = timerutil

function meta:new(callback, delay)
    if not callback then
        print("timer callback is nil")
        return nil
    end

    local delay = delay or 500
    local mytimer = iup.timer{time=delay}
    local meta = mytimer
    meta.callback = callback

    function meta:action_cb()
        self.callback()
        return iup.DEFAULT
    end

    function meta:is_run()
        return self.run == "YES"
    end

    function meta:start()
        self.run = "YES"
    end

    function meta:pause()
        self.run = "NO"
    end

    function meta:stop()
        meta = nil
    end
    return mytimer
end

return timerutil