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
    mainHwnd = windowfind("Banishment")  //获取窗口句柄
    windowsetcaption(mainHwnd, "Banishment 放逐这个世界  " & version)  //窗口标题修改
    //windowsendmessage(mainHwnd, 793, 2100912, 524288)  //静音
    settray("Banishment", false)  //托盘设置
    gridfill("excel")  //表格填满初始化
    editadd("本软件『完全可以免费使用』。")
    editadd("")
    editadd("如无法正常使用，请更新IE浏览器至最新版本。")
    editadd("")
    editadd("多开方式：使用Sandbox（沙盘）软件进行多开。")
    editadd("网页缩放：Ctrl键 + 滚轮（非必要）。")
    editadd("使用方式：扫码登陆后执行。")
    editadd("")
    editadd("***  软件版本：" & version & "  ***")
    editadd("")
    
    bs_constInit()
    threadbegin("bsmod_init", "")
    threadbegin("mod_开始时滚动网页到二维码","")
    threadbegin("mod_检查更新","")
    threadbegin("bsmod_心跳包控制", "")
    //test()
end


function setting_btn_左键单击()
    mouselock()
    settingsHwnd = controlopenwindow("settings")
    mouseunlock()
end

function user_login_点击()
    controlopenwindow("user_login")
end

function user_reg_点击()
    controlopenwindow("user_register")
end

function user_exit_点击()
    controlopenwindow("user_exit")
end

function test()
    //bs_发送api请求("BSphpSeSsL.in", array())
    //controlopenwindow("register")
    //controlopenwindow("login")
end
