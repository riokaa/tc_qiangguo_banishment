var DEBUG = true
function logd(content)
    if(DEBUG)
        traceprint(timenow() & "[DEBUG]:" & content)
        editadd(timenow() & "[DEBUG]:" & content)
    end
end
function logi(content)
    traceprint(timenow() & "[INFO]:" & content)
        editadd(timenow() & "[INFO]:" & content)
end
function logw(content)
    traceprint(timenow() & "[WARN]:" & content)
        editadd(timenow() & "[WARN]:" & content)
end
function loge(content)
    traceprint(timenow() & "[ERROR]:" & content)
        editadd(timenow() & "[ERROR]:" & content)
end
function logf(content)
    traceprint(timenow() & "[FATAL]:" & content)
        editadd(timenow() & "[FATAL]:" & content)
end