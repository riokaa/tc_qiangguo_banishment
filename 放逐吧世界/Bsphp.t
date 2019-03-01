
function bs_发送api请求(apiname, param)
    //build post body
    var _parameter = array()
    var _api = "api=" & apiname
    var _BSphpSeSsL = "BSphpSeSsL=" & bs_SeSSL
    var _date = "date=" & getnettime()
    var _md5 = "md5="
    var _mutualkey = "mutualkey=" & bs_mutualKey
    var _appsafecode = "appsafecode=" & md5(getTimeStampMillis())
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
    logd("api请求param明文:" & _parameter)
    _parameter = strreplace(bs_inSgin, "[KEY]", _parameter)
    _parameter = base64encode(_parameter)
    _parameter = "parameter=" & _parameter & "&sgin=" & md5(_parameter)
    logd("api请求param密文:" & _parameter)
    //send post request
    var _response = httpsubmit("post", bs_reqUrl, _parameter)
    if(_response == null)
        loge("api请求失败:" & getlasterror())
        return null
    end
    logd("api请求成功response:" & _response)
    
end