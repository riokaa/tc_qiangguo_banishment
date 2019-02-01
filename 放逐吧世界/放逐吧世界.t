var mainThread
var testarray = array(array(1,2), array(3,4))

function 执行()
    mod_控制逻辑()
end

function startBtn_点击()
    windowsetcaption(windowgetactivehwnd(), "放逐吧世界 " & version)
    if(buttongettext("startBtn") == "开始执行")
        buttonsettext("startBtn", "停止执行")
		mainThread = threadbegin("执行","")
    elseif(buttongettext("startBtn") == "停止执行")
        if(threadclose(mainThread))
			buttonsettext("startBtn", "开始执行")
        end
    end
end
