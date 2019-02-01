function mod_控制逻辑()
    while(true)
		mod_获取积分情况()
        if(score[1] < score_max_limit[1])  //阅读文章
            mod_执行阅读文章()
        elseif(score[2] < score_max_limit[2])  //观看视频
            mod_执行观看视频()
        elseif(score[3] < score_max_limit[3])  //文章学习时长
            mod_执行阅读文章()
        elseif(score[4] < score_max_limit[4])  //视频学习时长
            mod_执行观看视频()
        else
            break
        end
        sleep(1000)
    end
    logi("恭喜你!今日网页端任务已全部完成.")
end

function mod_获取积分情况()
    logi("————获取积分情况————")
    webgo("web", url_mypoints)
    logi("加载\"我的积分\"页面中……")
    while(!webloadcomplete("web"))
        sleep(500)
    end
    sleep(1000)
    logi("我的积分页面加载完毕.")
    var result = webhtmlget("web", "innerHtml", "class:my-points-content")
    result = regexmatchtext(result, "([0-9]+分/[0-9]+分)", false, true, true, true)
    //traceprint(result)
    logi("每日登陆积分: " & result[0])
    logi("阅读文章积分: " & result[1])
    logi("观看视频积分: " & result[2])
    logi("文章学习时长积分: " & result[3])
    logi("视频学习时长积分: " & result[4])
    for(var i = 0; i < 5; i++)
		score[i] = int(strleft(result[i], strfind(result[i], "/") - 1))
    end
    logi("积分情况获取完毕.")
end

function mod_执行阅读文章()
    logi("————执行阅读文章————")
    webgo("web", url_main)
    logi("加载\"主页\"页面中....")
    while(!webloadcomplete("web"))
        sleep(500)
    end
    sleep(1000)
    logi("\"主页\"页面加载完毕.")
    
    var result = webhtmlget("web", "innerHtml", "class:screen")
    var regInFrontOfTitle = "<div\\stitle=\"\"\\sclass=\"word-item\"\\sid=\"[0-9a-zA-Z]+\".*?\">"
    var regTitle = "([\\x{4e00}-\\x{9fa5}]|[0-9]|[\"|\\x{300a}|\\x{300b}|\\x{2014}|\\x{ff0c}|\\x{201c}|\\x{201d}|\\x{3001}]){9,}([\\x{4e00}-\\x{9fa5}]|[\"|\\x{300a}|\\x{300b}|\\x{2014}|\\x{ff0c}|\\x{201c}|\\x{201d}|\\x{3001}])"
    var regBehindTitle = "</div>"
    result = regexmatchtext(result, regInFrontOfTitle & regTitle & regBehindTitle, false, true, true, true)  //获取所有文章标题
    for(var i = 0; i < arraysize(result); i++)
        result[i] = regexmatchtext(result[i], "id=\"[0-9a-zA-Z]+\"", false, true, true, true)
        result[i] = regexmatchtext(result[i], "[0-9a-zA-Z]{10,}", false, true, true, true)  //提取标题id
    end
    
    var randomArticleId = result[rnd(0, arraysize(result))][0]
    logi("阅读随机文章\"" & randomArticleId & "\"中……")
    //webhtmlclick("web", "id:" & randomArticleId)
    webrunjs("web", "document.getElementById(\"" & randomArticleId & "\").click();")
    logi("加载指定文章页面中....")
    while(!webloadcomplete("web"))
        sleep(500)
    end
    sleep(1000)
    logi("指定文章页面加载完毕,开始执行阅读.")
    logi("Banishment this world!")
    for(var i = 0; i < 1200; i++)
        websetscollpos("web", 0, (rnd(0,1)*2-1)*20+1, 1)
        sleep(50)
    end
    sleep(3000)
end
function mod_执行观看视频()
    logi("————执行观看视频————")
    webgo("web", url_learntv)
    logi("加载\"学习电视台\"页面中……")
    while(!webloadcomplete("web"))
        sleep(500)
    end
    sleep(1000)
    logi("\"学习电视台\"页面加载完毕.")
    webhtmlclick("web", "class:radio-div")
    sleep(60000)
end