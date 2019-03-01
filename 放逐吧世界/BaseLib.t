
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