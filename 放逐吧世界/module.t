function mod_控制逻辑()
    //变量初始化
    vdo_list = array()  //json格式视频分发数据
    vdo_list_num = 0
    
    logi("提示: 如果无法正常运行，尝试更新本机IE浏览器到最新版本。")
    threadbegin("mod_获取视频列表分发", "")
    while(true)
        if(bs_vip)
            //vip功能
            threadresume(proThread_mouseMove)
        else
            threadsuspend(proThread_mouseMove)
        end
        mod_获取积分情况()
        if(score[3] < score_max_limit[3])  //文章学习时长(优先时长)
            mod_执行阅读文章("time")
        elseif(score[4] < score_max_limit[4])  //视频学习时长
            mod_执行观看视频("time")
        elseif(score[1] < score_max_limit[1])  //阅读文章
            mod_执行阅读文章("amount")
        elseif(score[2] < score_max_limit[2])  //观看视频
            mod_执行观看视频("amount")
        else
            break
        end
        sleep(1000)
    end
    logi("恭喜你!今日网页端任务已全部完成.")
    buttonsettext("startBtn", "开始执行")
    if(settings_auto_shutdown)
        logi("10秒后将执行自动关机操作.")
        sleep(10000)
        sysshutdown(0)
    end
end

function mod_开始时滚动网页到二维码()   //并静音洗脑曲
    var js = "document.getElementsByTagName(\'audio\')[0].volume = 0;"
    while(!webloadcomplete("web"))
        webrunjs("web", js)  //静音
        sleep(500)
    end
    webrunjs("web", js)  //静音
    sleep(500)
    websetscollpos("web",300, 950)
end

function mod_表格写(result)
    gridsetcontent("excel", 1, 0, "每日签到")
    gridsetcontent("excel", 2, 0, "文章阅读数")
    gridsetcontent("excel", 3, 0, "视频观看数")
    gridsetcontent("excel", 4, 0, "文章阅读时长")
    gridsetcontent("excel", 5, 0, "视频观看时长")
    gridsetcontent("excel", 1, 1, result[0])
    gridsetcontent("excel", 2, 1, result[1])
    gridsetcontent("excel", 3, 1, result[2])
    gridsetcontent("excel", 4, 1, result[3])
    gridsetcontent("excel", 5, 1, result[4])
    var fenmu = 0, fenzi = 0
    for(var i = 0; i < arraysize(score_max_limit); i++)
        fenmu = fenmu + score_max_limit[i]
        fenzi = fenzi + score[i]
    end
    var percent = int(fenzi*100/fenmu)
    progresssetprogress("bar", percent)
    //settraytip("进度：" & fenzi & "/" & fenmu)
    logd(fenzi & "/" & fenmu & "=" & percent & "%")
end

function mod_获取积分情况()
    logi("*** 获取积分情况 ***")
    webmovemouse()  //动动鼠标
    webgo("web", url_mypoints)
    logi("加载\"我的积分\"页面中....")
    sleep(800)
    while(!webloadcomplete("web"))
        sleep(500)
    end
    sleep(800)
    logi("我的积分页面加载完毕.")
    var result = array()
    while(arraysize(result) == 0)
        result = webhtmlget("web", "innerHtml", "class:my-points-content")
        result = regexmatchtext(result, "([0-9]+分/[0-9]+分)", false, true, true, true)
        sleep(800)
    end
    logd("每日登陆积分: " & result[0])
    logd("阅读文章积分: " & result[1])
    logd("观看视频积分: " & result[2])
    logd("文章学习时长积分: " & result[3])
    logd("视频学习时长积分: " & result[4])
    for(var i = 0; i < 5; i++)
        score[i] = int(strleft(result[i], strfind(result[i], "/") - 1))
    end
    logi("积分情况获取完毕.")
    threadbegin("mod_表格写", result)
    sleep(1000)
end

function mod_检查更新()
    var requestMode = "get"
    var requestUrl = "http://api.rayiooo.top/banishment/version.php?version=" & version
    var response = httpsubmit(requestMode, requestUrl, "", "utf-8")
    logd("检查更新response: " & response)
    if(response == null || !isjson(response))
        return false
    end
    response = jsontoarray(response)
    if(response["message"] != "ok")
        return false
    end
    if(response["data"]["version"] == version)
        logd("没有新版本发布.")
    else
        messagebox("发现新版本啦！请到公告栏中查看。", "检查更新")
        logi("发现新版本: " & response["data"]["version"])
    end
    return true
end

function mod_获取视频列表分发()
    logd("获取视频列表中....")
    var requestMode = "get"
    var requestUrl = "http://api.rayiooo.top/banishment/getVideoList.php"
    var response = httpsubmit(requestMode, requestUrl, "", "utf-8")
    logd("获取视频列表response: " & response)
    if(response == null || !isjson(response))
        logi("Remote: 无法获取视频列表.")
        return false
    end
    response = jsontoarray(response)
    if(response["message"] != "ok")
        logi("视频列表获取失败.")
        return false
    end
    logi("视频列表获取成功.")
    vdo_list = response["data"]
    return true
end

function promod_鼠标光标人性化移动()
    while(true)
        sleep(rnd(5, 30) * 1000)
        webmovemousepro()
    end
end

function promod_滚轮人性化滚动()
    while(true)
        logd("Hi Pro.")
        if(!bs_vip)
            //非pro
            sleep(1000)
            websmoothscroll((rnd(0,1)*2-1) * 50 + 5)
        else
            //pro
            sleep(rnd(1, 20) * 1000)
            webrandomscroll((rnd(0,1)*2-1) * (rnd(20, 500)) + 20)
        end
    end
end