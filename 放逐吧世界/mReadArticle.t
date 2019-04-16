
function mod_执行阅读文章(mode)
    //加载主页页面
    logi("*** 执行阅读文章 ***")
    webmovemouse()  //动动鼠标
    webgo("web", url_main)
    logi("加载\"主页\"页面中(需要较长时间)....")
    sleep(800)
    while(!webloadcomplete("web"))
        sleep(500)
    end
    sleep(800)
    logi("\"主页\"页面加载完毕.")
    
    //读取页面新闻标题们
    var result = webhtmlget("web", "innerHtml", "id:root")
    while(strfind(result, "<div class=\"text-wrap\"") == -1)
        sleep(1000)
        result = webhtmlget("web", "innerHtml", "id:root")
    end
    var result_id = array()
    var result_title = array()
    var regInFrontOfTitle = "<div\\sclass=\"text-wrap\".*?><span\\sclass=\"text\".*?>"
    var regTitle = "([\\x{4e00}-\\x{9fa5}]|[0-9]|[\"|\\x{300a}|\\x{300b}|\\x{2014}|\\x{ff0c}|\\x{201c}|\\x{201d}|\\x{3001}]){9,}([\\x{4e00}-\\x{9fa5}]|[\"|\\x{300a}|\\x{300b}|\\x{2014}|\\x{ff0c}|\\x{201c}|\\x{201d}|\\x{3001}])"
    var regBehindTitle = "</span></div>"
    result = regexmatchtext(result, regInFrontOfTitle & regTitle & regBehindTitle, false, true, true, true)  //获取所有文章标题
    logi("当前页面共获取到" & arraysize(result) & "条文章.")
    if(arraysize(result) == 0)
        logf("如果每次都弹出此提示，请将本机IE浏览器升级到最新版本！")
    end
    for(var i = 0; i < arraysize(result); i++)
        result_title[i] = regexmatchtext(result[i], regTitle, false, true, true, true)  //提取标题
        result_id[i] = regexmatchtext(result[i], "id=\"[0-9a-zA-Z]+\"", false, true, true, true)
        result_id[i] = regexmatchtext(result_id[i], "[0-9a-zA-Z]{10,}", false, true, true, true)  //提取标题id
    end
    logd("result_title: " & result_title)
    sleep(500)
    
    //随机选择文章并通过js点击的方法进入
    var randomNum = rnd(0, arraysize(result)-1)
    var randomArticleId = result_id[randomNum][0]
    var randomArticleTitle = result_title[randomNum][0]
    logi("阅读随机文章\"" & randomArticleTitle & "\"中....")
    //js代码点击相应标题的文章
    var js_clickrandomarticle = "function getElementsByClassName(node,classname) {if (node.getElementsByClassName) {return node.getElementsByClassName(classname);} else {return (function getElementsByClass(searchClass,node) {if ( node == null )node=document;var classElements=[],els = node.getElementsByTagName(\"*\"),elsLen=els.length,pattern=new RegExp(\"(^|\\s)\"+searchClass+\"(\\s|$)\"), i, j;for (i = 0, j = 0; i < elsLen; i++) {if ( pattern.test(els[i].className) ) {classElements[j] = els[i]; j++;}}return classElements;})(classname, node);}}"
    js_clickrandomarticle = js_clickrandomarticle & "function getElementTitleEqualsTo(title){var elements = getElementsByClassName(document, \"text-wrap\");for(var i=0; i<elements.length;i++){if(elements[i].innerText == title){return elements[i];}}return null;}"
    js_clickrandomarticle = js_clickrandomarticle & "getElementTitleEqualsTo(\"" & randomArticleTitle & "\").click();"
    webmovemouse()  //动动鼠标
    webrunjs("web", js_clickrandomarticle)
    //webrunjs("web", "document.getElementById(\"" & randomArticleId & "\").click();")
    sleep(800)
    logd("加载指定文章中....")
    while(!webloadcomplete("web"))
        sleep(500)
    end
    sleep(800)
    
    //执行鬼畜阅读
    var read_time = 120000
    if(mode == "time")  //挂时长模式
        logd("模式:挂时长.")
        if(bs_vip)
            read_time = read_time * rnd(60, 150) / 100
        end
    elseif(mode == "amount")  //挂数量模式
        logd("模式:挂数量.")
        read_time = 60000
        if(bs_vip)
            read_time = read_time + rnd(-20, 10) * 1000
        end
    else
        loge("mod_执行阅读文章:错误的mode格式")
    end
    logi("开始执行阅读 - " & (read_time/60000.0) & " - 分钟.")
    logi("Banishment this world!")
    threadresume(proThread_scroll)
    sleep(read_time)
    threadsuspend(proThread_scroll)
    
    logi("文章阅读完毕!")
    sleep(2000)
end
