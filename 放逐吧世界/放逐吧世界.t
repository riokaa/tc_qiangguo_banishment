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
    constInit()
    bs_constInit()
    threadbegin("main_UIInit", "")
    threadbegin("editInit", "")
    threadbegin("cleanTrash", "")
    threadbegin("mod_开始时滚动网页到二维码","")
    threadbegin("mod_检查更新","")
    //test()
end

function main_UIInit()
    windowsetcaption(mainHwnd, "Banishment 放逐这个世界  " & version)  //窗口标题修改
    settray("Banishment", false)  //托盘设置
    gridfill("excel")  //表格填满初始化
    controlshow("user_exit", false)
    picturesetpicture("rikka_img", path_cur & "\\img\\Rikka.png")
end

function setting_btn_左键单击()
    mouselock()
    settingsHwnd = controlopenwindow("settings")
    mouseunlock()
end

function tab_选择改变()
    var _tab = tabgetcursel("tab")
    if(_tab == 2)
        if(webgeturl("web_公告") == "")
            webgo("web_公告", "http://verify.rayiooo.top/index.php?m=applib&c=appweb&a=new_list&open_new=")
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
        bs_获取SeSSL()
        bsmod_刷新用户信息()
    end
end

function test()
    //bs_发送api请求("BSphpSeSsL.in", array())
    //controlopenwindow("register")
    //controlopenwindow("login")
    
end
