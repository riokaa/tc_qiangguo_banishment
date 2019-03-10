function cleanTrash()
    //清理垃圾文件
    var path_temp = filereadini("EXE", "TempPath", path_config)
    if(path_temp != "")
        var _res = folderdelete(path_temp)
        if(_res == 1)
            logi("残留的临时文件已清理.")
        end
    end
    filewriteini("EXE", "TempPath", path_rc, path_config)
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