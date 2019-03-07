
function bs_发送api请求(apiname, param)
    logd("执行api请求<" & apiname & ">")
    var _safecode = strlowercase(bbymd5(getTimeStampMillis()))
    //build post body
    var _parameter = array()
    var _api = "api=" & apiname
    var _BSphpSeSsL = "BSphpSeSsL=" & bs_SeSSL
    var _date = "date=" & getnettime()
    var _md5 = "md5="
    var _mutualkey = "mutualkey=" & bs_mutualKey
    var _appsafecode = "appsafecode=" & _safecode
    arraypush(_parameter, _api)
    arraypush(_parameter, _BSphpSeSsL)
    arraypush(_parameter, _date)
    arraypush(_parameter, _md5)
    arraypush(_parameter, _mutualkey)
    arraypush(_parameter, _appsafecode)
    for(var i = 0; i < arraysize(param); i++)
        arraypush(_parameter, param[i])
    end
    _parameter = httpBodyLinkParam(_parameter)
    //logd("Api请求param明文:" & _parameter)
    _parameter = base64encode(_parameter)
    var _sgin = bbymd5(strreplace(bs_inSgin, "[KEY]", _parameter))
    _sgin = strlowercase(_sgin)
    _parameter = "parameter=" & _parameter & "&sgin=" & _sgin  //base64编码,后台需选择base64接收加密
    //logd("Api请求param密文:" & _parameter)
    
    //send post request
    var _response = httpsubmit("post", bs_reqUrl, _parameter, "utf-8")
    _response = base64decode(_response)
    logd("Api request response:" & _response)
    
    //verify data safe
    if(_response == null || !isjson(_response))
        loge("Api请求失败:" & getlasterror())
        return ""
    end
    
    _response = jsontoarray(_response)
    if(arrayfindkey(_response, "response") == -1)
        loge("Api请求数据包错误:no response item.")
        return ""
    end
    
    _parameter = _response
    var temp = _response["response"]
    _response = temp
    if(arrayfindkey(_response, "appsafecode") == -1 || arrayfindkey(_response, "sgin") == -1)
        loge("Api请求数据包错误:no appsafecode/sgin item.")
        return ""
    end
    
    _sgin = _response["data"] & _response["date"] & _response["unix"] & _response["microtime"] & _response["appsafecode"]
    _sgin = bbymd5(urldecode(strreplace(bs_outSgin, "[KEY]", _sgin)))
    _sgin = strlowercase(_sgin)
    if(_response["sgin"] != _sgin)
        logd(_sgin)
        loge("Api请求数据包验证失败:wrong sign! (" & _sgin & ")")
        return ""
    end
    if(_response["appsafecode"] != _safecode)
        loge("Api请求数据包被劫持! ")
        return ""
    end
    
    //logd("Api请求成功!")
    return _response["data"]
end

function bs_登陆(user, pwd)
    var _req = array()
    _req[0] = "user=" & user
    _req[1] = "pwd=" & pwd
    _req[2] = "maxoror=" & bs_machineCode
    return bs_发送api请求("login.lg", _req)
end

function bs_获取SeSSL()
    bs_SeSSL = "ssl-" & md5(getmac() & getTimeStampMillis())
end

function bs_取登陆状态信息()
    var _req = array()
    return bs_发送api请求("lginfo.lg", _req)
end

function bs_取用户信息(info)
    var _req = array()
    _req[0] = "info="
    if(info == "用户名称")
        _req[0] = "info=UserName"
    elseif(info == "到期时间")
        _req[0] = "info=UserVipDate"
    elseif(info == "是否到期")
        _req[0] = "info=UserVipWhether"
    end
    return bs_发送api请求("getuserinfo.lg", _req)
end

function bs_心跳包()
    var _req = array()
    return bs_发送api请求("timeout.lg", _req)
end

function bs_注册(user, pwd, pwdb, email, coode)
    var _req = array()
    _req[0] = "user=" & user
    _req[1] = "pwd=" & pwd
    _req[2] = "pwdb=" & pwdb
    _req[3] = "mail=" & email
    _req[4] = "coode=" & coode
    return bs_发送api请求("registration.lg", _req)
end

function bs_注销登陆()
    var _req = array()
    return bs_发送api请求("cancellation.lg", _req)
end