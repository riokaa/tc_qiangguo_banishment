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
    //后处理
    sleep(500)
    threadsuspend(proThread_mouseMove)
    threadsuspend(proThread_scroll)
    //module options
    threadbegin("cleanTrash", "")
    threadbegin("mod_开始时滚动网页到二维码","")
    threadbegin("mod_检查更新","")
    threadbegin("lg_auto_login", "")
    //test()
end

function main_UIInit()
    windowsetcaption(mainHwnd, "Banishment 放逐这个世界  " & version)  //窗口标题修改
    settray("Banishment", false)  //托盘设置
    gridfill("excel")  //表格填满初始化
    picturesetpicture("rikka_img", path_cur & "\\img\\rikka.png")
    picturesetpicture("user_img_rikka", path_cur & "\\img\\jyaoushingan_100x.png")
    picturesetpicture("user_img_cloud", path_cur & "\\img\\clouds\\cloud_" & rnd(1, 6) & ".png")
    //settings
    if(filereadini("SETTINGS", "AutoClose", path_config) == "1")
        settings_auto_close = true
        checksetstate("set_autoclose", true)
    end
    if(filereadini("SETTINGS", "AutoShutdown", path_config) == "1")
        settings_auto_shutdown = true
        checksetstate("set_autoshutdown", true)
    end
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
function user_changePwd_点击()
    controlopenwindow("user_changepwd")
end
function user_act_点击()
    controlopenwindow("user_activate")
end
function user_getPro_点击()
    controlopenwindow("user_pay")
end
function user_pro_detail_点击()
    url_browser = "http://verify.rayiooo.top/index.php?m=applib&c=appweb&a=new_info&id=85"
    var _hwnd = controlopenwindow("user_browser")
    windowsetcaption(_hwnd, "Pro功能")
end

function set_apply_点击()
    //自动关程序
    if(checkgetstate("set_autoclose"))
        if(!settings_auto_close)
            settings_auto_close = true
            filewriteini("SETTINGS", "AutoClose", "1", path_config)
            logi("设置: 积分刷满后自动关闭程序开启.")
        end
    else
        if(settings_auto_close)
            settings_auto_close = false
            filewriteini("SETTINGS", "AutoClose", "0", path_config)
            logi("设置: 积分刷满后自动关闭程序关闭.")
        end
    end
    //自动关机
    if(checkgetstate("set_autoshutdown"))
        if(!settings_auto_shutdown)
            settings_auto_shutdown = true
            filewriteini("SETTINGS", "AutoShutdown", "1", path_config)
            logi("设置: 积分刷满后自动关机开启.")
        end
    else
        if(settings_auto_shutdown)
            settings_auto_shutdown = false
            filewriteini("SETTINGS", "AutoShutdown", "0", path_config)
            logi("设置: 积分刷满后自动关机关闭.")
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

function about_feedback_点击()
    url_browser = "http://verify.rayiooo.top/index.php?m=applib&c=appweb&a=feedback&daihao=10000000&uid=" & bs_user & "&table=快捷反馈&leix=feedback"
    var _hwnd = controlopenwindow("user_browser")
    windowsetcaption(_hwnd, "快捷反馈  联系方式请填邮箱~")
end

function test()
    
end



