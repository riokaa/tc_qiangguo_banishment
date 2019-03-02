
function bs_发送api请求(apiname, param)
    logd("执行api请求<" & apiname & ">")
    var _safecode = md5(getTimeStampMillis())
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
    var _sgin = md5(strreplace(bs_inSgin, "[KEY]", _parameter))
    _parameter = "parameter=" & _parameter & "&sgin=" & _sgin  //base64编码,后台需选择base64接收加密
    //logd("Api请求param密文:" & _parameter)
    
    //send post request
    var _response = httpsubmit("post", bs_reqUrl, _parameter, "utf-8")
    _response = base64decode(_response)
    logd("Api request response:" & _response)
    
    //verify data safe
    if(_response == null || !isjson(_response))
        loge("Api请求失败:" & getlasterror())
        return null
    end
    
    _response = jsontoarray(_response)
    if(arrayfindkey(_response, "response") == -1)
        loge("Api请求数据包错误:no response item.")
    end
    
    _parameter = _response
    var temp = _response["response"]
    _response = temp
	if(arrayfindkey(_response, "appsafecode") == -1 || arrayfindkey(_response, "sgin") == -1)
		loge("Api请求数据包错误:no appsafecode/sgin item.")
    end
    
    _sgin = _response["data"] & _response["date"] & _response["unix"] & _response["microtime"] & _response["appsafecode"]
    _sgin = md5(strreplace(bs_outSgin, "[KEY]", _sgin))
    if(_response["sgin"] != _sgin)
        loge("Api请求数据包验证失败:wrong sign! (" & _sgin & ")")
        return null
    end
    if(_response["appsafecode"] != _safecode)
        loge("Api请求数据包异常:wrong appsafecode!")
        return null
    end
    
    logd("Api请求成功!")
    return _response["data"]
end
