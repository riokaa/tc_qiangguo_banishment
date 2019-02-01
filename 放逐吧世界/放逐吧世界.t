var mainThread
var testarray = array(array(1,2), array(3,4))

function 执行()
    mod_控制逻辑()
end

function startBtn_点击()
    windowsetcaption(windowgetactivehwnd(), "放逐吧世界 " & version)
    mainThread = threadbegin("执行","")
end
