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
    //加载主页页面
    logi("————执行阅读文章————")
    webgo("web", url_main)
    logi("加载\"主页\"页面中(需要较长时间)....")
    while(!webloadcomplete("web"))
        sleep(500)
    end
    sleep(1000)
    logi("\"主页\"页面加载完毕.")
    
    //读取页面新闻标题们
    var result = webhtmlget("web", "innerHtml", "class:screen")
    var result_id = array()
    var result_title = array()
    var regInFrontOfTitle = "<div\\stitle=\"\"\\sclass=\"word-item\"\\sid=\"[0-9a-zA-Z]+\".*?\">"
    var regTitle = "([\\x{4e00}-\\x{9fa5}]|[0-9]|[\"|\\x{300a}|\\x{300b}|\\x{2014}|\\x{ff0c}|\\x{201c}|\\x{201d}|\\x{3001}]){9,}([\\x{4e00}-\\x{9fa5}]|[\"|\\x{300a}|\\x{300b}|\\x{2014}|\\x{ff0c}|\\x{201c}|\\x{201d}|\\x{3001}])"
    var regBehindTitle = "</div>"
    result = regexmatchtext(result, regInFrontOfTitle & regTitle & regBehindTitle, false, true, true, true)  //获取所有文章标题
    for(var i = 0; i < arraysize(result); i++)
        result_title[i] = regexmatchtext(result[i], regTitle, false, true, true, true)  //提取标题
        result_id[i] = regexmatchtext(result[i], "id=\"[0-9a-zA-Z]+\"", false, true, true, true)
        result_id[i] = regexmatchtext(result_id[i], "[0-9a-zA-Z]{10,}", false, true, true, true)  //提取标题id
    end
    logd("result_title: " & result_title)
    
    //随机选择文章并通过js点击的方法进入
    var randomNum = rnd(0, arraysize(result))
    var randomArticleId = result_id[randomNum][0]
    var randomArticleTitle = result_title[randomNum][0]
    logi("阅读随机文章\"" & randomArticleTitle & "\"中……")
    //js代码点击相应标题的文章
    var js_clickrandomarticle = "function getElementsByClassName(node,classname) {if (node.getElementsByClassName) {return node.getElementsByClassName(classname);} else {return (function getElementsByClass(searchClass,node) {if ( node == null )node=document;var classElements=[],els = node.getElementsByTagName(\"*\"),elsLen=els.length,pattern=new RegExp(\"(^|\\s)\"+searchClass+\"(\\s|$)\"), i, j;for (i = 0, j = 0; i < elsLen; i++) {if ( pattern.test(els[i].className) ) {classElements[j] = els[i]; j++;}}return classElements;})(classname, node);}}"
    js_clickrandomarticle = js_clickrandomarticle & "function getElementTitleEqualsTo(title){var elements = getElementsByClassName(document, \"word-item\");for(var i=0; i<elements.length;i++){if(elements[i].innerText == title){return elements[i];}}return null;}"
    js_clickrandomarticle = js_clickrandomarticle & "getElementTitleEqualsTo(\"" & randomArticleTitle & "\").click();"
    webrunjs("web", js_clickrandomarticle)
    //webrunjs("web", "document.getElementById(\"" & randomArticleId & "\").click();")
    logi("加载指定文章页面中....")
    while(!webloadcomplete("web"))
        sleep(500)
    end
    sleep(1000)
    
    //执行鬼畜阅读
    logi("指定文章页面加载完毕,开始执行阅读.")
    logi("Banishment this world!")
    var read_time = 240000
    var guichu_time = 500
    for(var i = 0; i < read_time/guichu_time; i++)
        websetscollpos("web", 0, (rnd(0,1)*2-1)*50+1, 1)
        sleep(guichu_time)
    end
    logi("文章阅读完毕!")
    sleep(3000)
end
function mod_执行观看视频()
    //第一频道_重要活动视频专辑
    //第一频道_学习专题报道
    //第一频道_新闻联播
    //以上频道三选一
    
    //加载电视台页面
    logi("————执行观看视频————")
    webgo("web", url_learntv)
    logi("加载\"学习电视台\"页面中……")
    while(!webloadcomplete("web"))
        sleep(500)
    end
    sleep(1000)
    logi("\"学习电视台\"页面加载完毕.")
    
    //随机选择视频
	webhtmlclick("web", "value:第一频道")
    var random_num = rnd(1,3)
    select(random_num)
        case 1
			webhtmlclick("web", "value:习近平活动视频集")
        case 2
			webhtmlclick("web", "value:专题报道")
        case 3
			webhtmlclick("web", "value:新闻联播")
    end
        
    //读取页面新闻标题们
    sleep(1000)
    var result = webhtmlget("web", "innerHtml", "class:screen")
    var result_id = array()
    var result_title = array()
    var regInFrontOfTitle = "<div\\stitle=\"\"\\sclass=\"word-item\"\\sid=\"[0-9a-zA-Z]+\".*?\">"
    var regTitle = "([\\x{4e00}-\\x{9fa5}]|[\"|\\x{300a}|\\x{300b}|\\x{2014}|\\x{ff0c}|\\x{201c}|\\x{201d}|\\x{3001}])([\\x{4e00}-\\x{9fa5}]|[0-9]|[\"|\\x{300a}|\\x{300b}|\\x{2014}|\\x{ff0c}|\\x{201c}|\\x{201d}|\\x{3001}]){8,}"
    var regBehindTitle = "</div>"
    result = regexmatchtext(result, regInFrontOfTitle & regTitle & regBehindTitle, false, true, true, true)  //获取所有文章标题
    for(var i = 0; i < arraysize(result); i++)
        result_title[i] = regexmatchtext(result[i], regTitle, false, true, true, true)  //提取标题
        result_id[i] = regexmatchtext(result[i], "id=\"[0-9a-zA-Z]+\"", false, true, true, true)
        result_id[i] = regexmatchtext(result_id[i], "[0-9a-zA-Z]{10,}", false, true, true, true)  //提取标题id
    end
    logd("result_title: " & result_title)
    
    //随机选择视频并通过js点击的方法进入
    var randomNum = rnd(0, arraysize(result))
    var randomArticleId = result_id[randomNum][0]
    var randomArticleTitle = result_title[randomNum][0]
    logi("观看随机视频\"" & randomArticleTitle & "\"中……")
    //js代码点击相应标题的视频
    var js_clickrandomarticle = "function getElementsByClassName(node,classname) {if (node.getElementsByClassName) {return node.getElementsByClassName(classname);} else {return (function getElementsByClass(searchClass,node) {if ( node == null )node=document;var classElements=[],els = node.getElementsByTagName(\"*\"),elsLen=els.length,pattern=new RegExp(\"(^|\\s)\"+searchClass+\"(\\s|$)\"), i, j;for (i = 0, j = 0; i < elsLen; i++) {if ( pattern.test(els[i].className) ) {classElements[j] = els[i]; j++;}}return classElements;})(classname, node);}}"
    js_clickrandomarticle = js_clickrandomarticle & "function getElementTitleEqualsTo(title){var elements = getElementsByClassName(document, \"word-item\");for(var i=0; i<elements.length;i++){if(elements[i].innerText == title){return elements[i];}}return null;}"
    js_clickrandomarticle = js_clickrandomarticle & "getElementTitleEqualsTo(\"" & randomArticleTitle & "\").click();"
    webrunjs("web", js_clickrandomarticle)
    for(var i = 5; i > 0; i--)
        logi("观看剩余" & i & "分钟.")
        sleep(60000)
    end
    
    sleep(3000)
end