
function mod_执行观看视频(mode)
    
    logi("*** 执行观看视频 ***")
    
    //随机进入视频网页
    goVdoWeb()
    
    //执行鬼畜观看
    logi("指定视频页面加载完毕,开始执行观看.")
    logi("Banishment this world!")
    var watch_minute = 5
    if(mode == "time")  //挂时长模式
        logi("模式:挂时长.")
        watch_minute = 5
    elseif(mode == "amount")  //挂数量模式
        logi("模式:挂数量.")
        watch_minute = 1
    else
        loge("mod_执行观看视频:错误的mode格式")
    end
    for(var i = watch_minute; i > 0; i--)
        logi("观看剩余" & i & "分钟.")
        var read_time = 62000
        var guichu_time = 1000
        for(var j = 0; j < read_time/guichu_time; j++)
            websmoothscroll((rnd(0,1)*2-1)*50+5)
            sleep(guichu_time)
        end
    end
    
    logi("视频观看完毕!")
    sleep(3000)
end

function goVdoWeb()
    //进入视频网页
    var random_channel = rnd(-1, arraysize(url_local_vdo) - 1)  //-1中央,other地方
    if(random_channel == -1)  //中央视频
        
        //第一频道_重要活动视频专辑
        //第一频道_学习专题报道
        //第一频道_新闻联播
        //以上频道三选一
        
        webgo("web", url_learntv)
        logi("加载中央频道\"学习电视台\"....")
        while(!webloadcomplete("web"))
            sleep(500)
        end
        sleep(1000)
        logi("\"学习电视台\"加载完毕.")
        
        //随机选择视频
        webhtmlclick("web", "value:第一频道")
        sleep(500)
        var random_num = rnd(1,3)
        select(random_num)
            case 1
            logi("随机选择专题:强国活动视频集")
            webhtmlclick("web", "value:习近平活动视频集")
            case 2
            logi("随机选择专题:专题报道")
            webhtmlclick("web", "value:专题报道")
            case 3
            logi("随机选择专题:新闻联播")
            webhtmlclick("web", "value:新闻联播")
        end
        while(!webloadcomplete("web"))
            sleep(500)
        end
        
        //读取页面新闻标题们
        sleep(2000)
        var result = webhtmlget("web", "innerHtml", "class:screen")
        var regTitleBefore = "<div.*?\\sclass=\"word-item\".*?\">"
        //var 中文标点 = "[\"|\\x{2014}|\\x{2018}|\\x{2019}|\\x{201c}|\\x{201d}|\\x{3001}|\\x{300a}|\\x{300b}|\\x{3010}|\\x{3011}|\\x{ff01}|\\x{ff08}|\\x{ff09}|\\x{ff0c}|\\x{ff1a}|\\x{ff1b|\\x{ff1f}|\\s|\\.]"
        var regTitle = "([\\x{4e00}-\\x{9fa5}]|[\"|\\x{300a}|\\x{300b}|\\x{2014}|\\x{ff0c}|\\x{201c}|\\x{201d}|\\x{3001}])([\\x{4e00}-\\x{9fa5}]|[0-9]|[\"|\\x{300a}|\\x{300b}|\\x{2014}|\\x{ff0c}|\\x{201c}|\\x{201d}|\\x{3001}|\\s]){8,}"
        var regTitleEnd = "</div>"
        result = regexmatchtext(result, regTitleBefore & regTitle & regTitleEnd, false, true, true, true)  //获取所有视频标题
        logi("此页面共获取到" & arraysize(result) & "条视频.")
        
        //var result_id = array()
        var result_title = array()
        for(var i = 0; i < arraysize(result); i++)
            result_title[i] = regexmatchtext(result[i], regTitle, false, true, true, true)  //提取标题
            //result_id[i] = regexmatchtext(result[i], "id=\"[0-9a-zA-Z]+\"", false, true, true, true)
            //result_id[i] = regexmatchtext(result_id[i], "[0-9a-zA-Z]{10,}", false, true, true, true)  //提取标题id
        end
        logd("result_title: " & result_title)
        sleep(500)
        
        //随机选择视频并通过js点击的方法进入
        var randomNum = rnd(0, arraysize(result) - 1)
        //var randomArticleId = result_id[randomNum][0]
        var randomArticleTitle = result_title[randomNum][0]
        logi("观看随机视频\"" & randomArticleTitle & "\"中....")
        //js代码点击相应标题的视频
        var js_clickrandomarticle = "function getElementsByClassName(node,classname) {if (node.getElementsByClassName) {return node.getElementsByClassName(classname);} else {return (function getElementsByClass(searchClass,node) {if ( node == null )node=document;var classElements=[],els = node.getElementsByTagName(\"*\"),elsLen=els.length,pattern=new RegExp(\"(^|\\s)\"+searchClass+\"(\\s|$)\"), i, j;for (i = 0, j = 0; i < elsLen; i++) {if ( pattern.test(els[i].className) ) {classElements[j] = els[i]; j++;}}return classElements;})(classname, node);}}"
        js_clickrandomarticle = js_clickrandomarticle & "function getElementTitleEqualsTo(title){var elements = getElementsByClassName(document, \"word-item\");for(var i=0; i<elements.length;i++){if(elements[i].innerText == title){return elements[i];}}return null;}"
        js_clickrandomarticle = js_clickrandomarticle & "getElementTitleEqualsTo(\"" & randomArticleTitle & "\").click();"
        webrunjs("web", js_clickrandomarticle)
        
        
    else  //地方视频
        
        //加载站点
        logi("加载" & url_local_vdo[random_channel]["name"] & "地方视频站....")
        webgo("web", url_local_vdo[random_channel]["url"])
        while(!webloadcomplete("web"))  //等待加载
            sleep(500)
        end
        sleep(1000)
        logi(url_local_vdo[random_channel]["name"] & "视频站加载完毕.")
        
        //读取当前页面视频列表
        var result = webhtmlget("web", "innerHtml", "class:content")
        var regTitleBefore = "<span\\sclass=\"_3NwIqm\">"
        var regTitle = ".*?"
        var regTitleEnd = "</span>"
        result = regexmatchtext(result, regTitleBefore & regTitle & regTitleEnd, false, true, true, true)  //获取所有视频标题
        logi("此页面共获取到" & arraysize(result) & "条视频.")
        
        for(var i=0; i<arraysize(result); i++)  //抽取标题
            var temp = regexmatchtext(result[i], ">.*?<", false, true, true, true)
            if(arraysize(temp) == 1)
                result[i] = strsub(temp[0], 1, strlen(temp[0]) - 1)
                result[i] = strreplace(result[i], "&nbsp;", " ")  //去除nbsp
            end
        end
        logd("视频名列表: " & result)
        sleep(500)
        
        //随机选择视频
        var randomNum = rnd(0, arraysize(result) - 1)
        var randomArticleTitle = result[randomNum]
        logi("观看随机视频\"" & randomArticleTitle & "\"中....")
        //js代码点击相应标题的视频
        var _js = ""
        _js = _js & "function getElementByInnerText(tagname, searchText){"
        _js = _js & "	var aTags = document.getElementsByTagName(tagname);"
        _js = _js & "	for (var i = 0; i < aTags.length; i++) {"
        _js = _js & "		if (aTags[i].textContent == searchText) {"
        _js = _js & "			return aTags[i];"
        _js = _js & "		}"
        _js = _js & "	}"
        _js = _js & "	alert(\"没找到!\");"
        _js = _js & "}"
        //_js = _js & "alert(getElementByInnerText(\"a\", \"" & randomArticleTitle & "\").href);"
        _js = _js & "getElementByInnerText(\"a\", \"" & randomArticleTitle & "\").onclick();"
        //var js_clickrandomarticle = "function getElementsByClassName(node,classname) {if (node.getElementsByClassName) {return node.getElementsByClassName(classname);} else {return (function getElementsByClass(searchClass,node) {if ( node == null )node=document;var classElements=[],els = node.getElementsByTagName(\"*\"),elsLen=els.length,pattern=new RegExp(\"(^|\\s)\"+searchClass+\"(\\s|$)\"), i, j;for (i = 0, j = 0; i < elsLen; i++) {if ( pattern.test(els[i].className) ) {classElements[j] = els[i]; j++;}}return classElements;})(classname, node);}}"
        //js_clickrandomarticle = js_clickrandomarticle & "function getElementTitleEqualsTo(title){var elements = getElementsByClassName(document, \"_3NwIqm\");for(var i=0; i<elements.length;i++){if(elements[i].innerText == title){return elements[i];}}return null;}"
        //js_clickrandomarticle = js_clickrandomarticle & "getElementTitleEqualsTo(\"" & randomArticleTitle & "\").click();"
        //webrunjs("web", _js)
        //logd(webhtmlclick("web", "tag:a & class:_2VDs51"))
        logd(webhtmlclick("web", "tag:span & class:_3NwIqm"))
        
    end
    
    //等待网页加载
    while(!webloadcomplete("web"))
        sleep(500)
    end
end