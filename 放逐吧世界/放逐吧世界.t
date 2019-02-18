var mainHwnd
var mainThread
var settingsHwnd

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
    mainHwnd = windowfind("Banishment")
    windowsetcaption(mainHwnd, "Banishment 放逐这个世界  " & version)  //窗口标题修改
    //windowsendmessage(mainHwnd, 793, 2100912, 524288)  //静音
    gridfill("excel")
    editadd("┌───────────────────────────────┐")
    editadd("│***  软件版本：" & version & "  ***		  │")
    editadd("│					  │")
    editadd("│使用方式：扫码登陆后执行。		  │")
    editadd("│网页缩放：Ctrl键 + 滚轮（非必要）。	  │")
    editadd("│					  │")
    editadd("│本软件『完全免费』。			  │")
    editadd("└───────────────────────────────┘")
    
    threadbegin("mod_开始时滚动网页到二维码","")
    threadbegin("mod_检查更新","")
end


function setting_btn_左键单击()
    mouselock()
    settingsHwnd = controlopenwindow("settings")
    mouseunlock()
end
