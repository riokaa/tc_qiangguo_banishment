var mainThread
var testarray = array(array(1,2), array(3,4))

function 执行()
    mod_控制逻辑()
end

function startBtn_点击()
    if(buttongettext("startBtn") == "开始执行")
        buttonsettext("startBtn", "停止执行")
        mainThread = threadbegin("执行","")
    elseif(buttongettext("startBtn") == "停止执行")
        if(threadclose(mainThread))
            buttonsettext("startBtn", "开始执行")
        end
    end
end

function 放逐吧世界_初始化()
    windowsetcaption(windowfind("放逐吧世界"), "放逐吧世界 " & version)
    gridfill("excel")
    editadd("————————————————————————")
    editadd("软件版本: " & version)
    editadd("使用方式: 扫码登陆 → 开始执行(可后台运行)")
    editadd("")
    editadd("网页缩放: 网页框 Ctrl+滚轮 = 放大/缩小")
    editadd("————————————————————————")
    
	threadbegin("mod_开始时滚动网页到二维码","")
end

function rikka_img_左键单击()
    
end
