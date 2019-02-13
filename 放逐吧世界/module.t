function mod_控制逻辑()
    while(true)
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
end

function mod_开始时滚动网页到二维码()   
    while(!webloadcomplete("web"))
        sleep(500)
    end
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
    var fenmu = 1, fenzi = 0
    for(var i = 0; i < arraysize(score_max_limit); i++)
        fenmu = fenmu + score_max_limit[i]
        fenzi = fenzi + score[i]
    end
    var percent = int(fenzi*100/fenmu)
    progresssetprogress("bar", percent)
    logd(fenzi & "/" & fenmu & "=" & percent & "%")
end
function mod_获取积分情况()
    logi("*** 获取积分情况 ***")
    webgo("web", url_mypoints)
    logi("加载\"我的积分\"页面中……")
    while(!webloadcomplete("web"))
        sleep(500)
    end
    sleep(1000)
    logi("我的积分页面加载完毕.")
    var result = webhtmlget("web", "innerHtml", "class:my-points-content")
    result = regexmatchtext(result, "([0-9]+分/[0-9]+分)", false, true, true, true)
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
    var requestUrl = "http://api.rayiooo.top/banishment/version.php"
    var response = httpsubmit(requestMode, requestUrl, "", "utf-8")
    logd("检查更新response: " & response)
    if(response == null || !isjson(response))
        return false
    end
    response = jsontoarray(response)
    if(response["status"] != 1)
        return false
    end
    if(response["info"]["version"] == version)
        logd("没有新版本发布.")
    else
        logi("*** 发现软件新版本 " & response["info"]["version"] & " ***")
        logi("")
        logi("更新内容：" & response["info"]["update_content"])
        logi("下载地址：" & response["info"]["download"])
    end
    return true
end