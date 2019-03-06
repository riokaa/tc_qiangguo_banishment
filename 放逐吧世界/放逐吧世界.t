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
    settray("Banishment", false)  //托盘设置
	editInit()
    constInit()
    bs_constInit()
    main_UIInit()
    threadbegin("cleanTrash", "")
    //threadbegin("bsmod_刷新用户信息", "")
    threadbegin("mod_开始时滚动网页到二维码","")
    threadbegin("mod_检查更新","")
    threadbegin("bsmod_心跳包控制", "")
    //test()
end

function main_UIInit()
    gridfill("excel")  //表格填满初始化
    controlshow("user_exit", false)
    picturesetpicture("rikka_img", path_cur & "\\img\\Rikka.png")
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
    if(bs_注销登陆() == 1)
        bsmod_刷新用户信息()
    end
    //controlopenwindow("user_exit")
end

function test()
    //bs_发送api请求("BSphpSeSsL.in", array())
    //controlopenwindow("register")
    //controlopenwindow("login")
    
end
