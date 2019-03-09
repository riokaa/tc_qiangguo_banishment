var mainHwnd
var mainThread
var proThread_mouseMove
var proThread_scroll

function 执行()
    mod_控制逻辑()
end

function startBtn_点击()
    if(buttongettext("startBtn") == "开始执行")
        buttonsettext("startBtn", "停止执行")
        mainThread = threadbegin("执行","")
    elseif(buttongettext("startBtn") == "停止执行")
        if(threadclose(mainThread))
            threadsuspend(proThread_mouseMove)
            buttonsettext("startBtn", "开始执行")
        end
    end
end

function 放逐吧世界_初始化()
    mainHwnd = windowfind("Banishment")  //获取窗口句柄
    //init options
    constInit()
    bs_constInit()
    threadbegin("main_UIInit", "")
    threadbegin("editInit", "")
    //thread options
    proThread_mouseMove = threadbegin("promod_鼠标光标人性化移动", "")
    proThread_scroll = threadbegin("promod_滚轮人性化滚动", "")
    //module options
    threadbegin("cleanTrash", "")
    threadbegin("mod_开始时滚动网页到二维码","")
    threadbegin("mod_检查更新","")
    threadbegin("lg_auto_login", "")
    //后处理
    sleep(500)
    threadsuspend(proThread_mouseMove)
    threadsuspend(proThread_scroll)
    //test()
end

function main_UIInit()
    windowsetcaption(mainHwnd, "Banishment 放逐这个世界  " & version)  //窗口标题修改
    settray("Banishment", false)  //托盘设置
    gridfill("excel")  //表格填满初始化
    picturesetpicture("rikka_img", path_cur & "\\img\\Rikka.png")
end

function tab_选择改变()
    var _tab = tabgetcursel("tab")
    if(_tab == 2)
        if(webgeturl("web_公告") == "")
            webgo("web_公告", url_public)
            websetnewwindow("web_公告", true)
        end
    end
end

function user_login_点击()
    controlopenwindow("user_login")
end

function user_reg_点击()
    controlopenwindow("user_register")
end

function user_exit_点击()
    if(bs_注销登陆() == 1)
        bs_user = ""
        bs_pwd = ""
        filewriteini("USER", "User", bs_user, path_config)
        filewriteini("USER", "Pwd", bs_pwd, path_config)
        bs_获取SeSSL()
        bsmod_刷新用户信息()
    end
end

function user_act_点击()
    controlopenwindow("user_activate")
end

function user_getPro_点击()
    controlopenwindow("user_pay")
end

function set_apply_点击()
    //自动关机
    if(checkgetstate("set_autoshutdown"))
        if(!settings_auto_shutdown)
            settings_auto_shutdown = true
            logi("设置：自动关机功能开启。")
        end
    else
        if(settings_auto_shutdown)
            settings_auto_shutdown = false
            logi("设置：自动关机功能关闭。")
        end
    end
    
    //反馈
    threadbegin("set_apply_success_thread", "")
end
function set_apply_success_thread()
    buttonsettext("set_apply", "成功!")
    sleep(1000)
    buttonsettext("set_apply", "应用")
end

function test()
    
end
