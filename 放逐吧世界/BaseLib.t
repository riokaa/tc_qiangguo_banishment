function cleanTrash()
    //清理垃圾文件
    foldercreate(path_cur & "config")
    var path_config = path_cur & "config\\Config.ini"
    var path_temp = filereadini("EXE", "TempPath", path_config)
    if(path_temp != "")
        var _res = folderdelete(path_temp)
        logd("删除临时文件:" & _res)
        if(_res == 1)
            logi("残留的临时文件已清理.")
        end
    end
    var _res = filewriteini("EXE", "TempPath", path_rc, path_config)
    logd("写配置结果:" & _res)
end

function destroyMyself()
    sleep(5000)
    windowclose(mainHwnd)
end

function getTimeStampMillis()
    return timediff("s", "1970/1/1 8:00:00", timenow()) * 1000
end

function httpBodyLinkParam(paramList)
    var str = ""
    for(var i = 0; i < arraysize(paramList); i++)
        str = str & paramList[i] & "&"
    end
    str = strtrim(str, "&")
    return str
end