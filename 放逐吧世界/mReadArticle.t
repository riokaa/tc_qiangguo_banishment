
function mod_执行阅读文章(mode)
    //加载主页页面
    logi("*** 执行阅读文章 ***")
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
    logi("当前页面共获取到" & arraysize(result) & "条文章.")
    if(arraysize((result) == 0)
        logf("请将本机IE浏览器升级到最新版本!")
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
    if(mode == "time")  //挂时长模式
        logi("模式:挂时长.")
        read_time = 248000
    elseif(mode == "amount")  //挂数量模式
        logi("模式:挂数量.")
        read_time = 60000
    else
        loge("mod_执行阅读文章:错误的mode格式")
    end
    var guichu_time = 1000
    for(var i = 0; i < read_time/guichu_time; i++)
        websmoothscroll((rnd(0,1)*2-1)*50+5)
        sleep(guichu_time)
    end
    
    logi("文章阅读完毕!")
    sleep(3000)
end
