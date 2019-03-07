function settings_初始化()
    if(auto_shutdown)
        checksetstate("设置_autoshutdown", true, "settings")
    end
end

function 设置_退出_点击()
    windowclose(settingsHwnd)
    return true
end

function 设置_确定_点击()
    if(checkgetstate("设置_autoshutdown", "settings"))  //勾选自动关机
        if(!auto_shutdown)
            logi("设置：自动关机功能开启。")
        end
        auto_shutdown = true
    else  //不自动关机
        if(auto_shutdown)
            logi("设置：自动关机功能关闭。")
        end
        auto_shutdown = false
    end
end

function 设置_深入支持Btn_点击()
    buttonsettext("设置_深入支持Btn", "获取中……", "settings")
    logd("获取续命地址....")
    var requestMode = "get"
    var requestUrl = "http://api.rayiooo.top/banishment/getContinueLifeUrl.php"
    var response = httpsubmit(requestMode, requestUrl, "", "utf-8")
    logd("续命地址response: " & response)
    if(response == null || !isjson(response))
        buttonsettext("设置_深入支持Btn", "获取失败", "settings")
        logw("Remote: 无法获取服务器续命地址.")
        messagebox("很感谢！不过暂时没有深入支持功能。")
        return false
    end
    response = jsontoarray(response)
    if(response["message"] != "ok")
        buttonsettext("设置_深入支持Btn", "暂不支持深入", "settings")
        logw("Remote: 服务器当前不可续命.")
        messagebox("很感谢！不过暂时没有深入支持功能。")
        return false
    end
    logi("Remote: 服务器续命地址获取成功.")
    var continue_url = response["data"]["value"]
    logi("深入支持链接: " & continue_url)
    buttonsettext("设置_深入支持Btn", "深入支持", "settings")
    messagebox("感谢支持！请到控制台复制打开支持链接。")
    return true
end