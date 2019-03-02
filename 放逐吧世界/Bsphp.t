
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
    logd("Api请求param明文:" & _parameter)
    _parameter = base64encode(_parameter)
    var _sgin = md5(strreplace(bs_inSgin, "[KEY]", _parameter))
    _parameter = "parameter=" & _parameter & "&sgin=" & _sgin  //base64编码,后台需选择base64接收加密
    logd("Api请求param密文:" & _parameter)
    
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
    
    arraydeletekey(_parameter["response"], "sgin")
    _sgin = md5(_parameter)
    if(_response["appsafecode"] != _appsafecode || _response["sgin"] != _sgin)
        loge("Api请求数据包异常:verify error! sgin=" & _sgin)
    end
    logd("Api请求成功response:" & _response)
    
end