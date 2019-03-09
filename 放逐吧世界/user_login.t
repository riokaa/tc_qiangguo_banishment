
function lg_auto_login()
    var _user = filereadini("USER", "User", path_config)
    var _pwd = filereadini("USER", "Pwd", path_config)
    if(_user == "" || _pwd == "")
        threadbegin("bsmod_登陆失败后处理", "")
        return false
    end
    _pwd = aesdecrypt(_pwd, aes_key)
    var _response = bs_登陆(_user, _pwd)
    var _array = array()
    if(strsplit(_response, "|", _array) >= 5)
        //登陆成功
        if(_array[0] == "01")
            bs_status = cint(_array[1])
            //另写请求减少请求次数
            bs_user = _user
            bs_vipDate = _array[4]
            if(_array[1] == "1011")
                bs_vip = true
            end
            threadbegin("bsmod_登陆成功后处理", "")
        else
            logw("登陆失败！错误码：" & _array[1])
            threadbegin("bsmod_登陆失败后处理", "")
        end
    elseif(_response == "9908")
        //已到期
        bs_status = cint(_array[1])
        bs_登陆(_user, _pwd)
        for(var i = 0; i < 10; i++)
            if(bsmod_刷新用户信息())
                break
            else
                bs_登陆(_user, _pwd)
            end
            sleep(1000)
        end
        tabactive("tab", 1)
    else
        //登陆失败
        logw("个人中心登陆失败.")
        threadbegin("bsmod_登陆失败后处理", "")
        return false
    end
    bs_pwd = _pwd
end

function lg_login_点击()
    var _user = editgettext("lg_user", "user_login")
    var _pwd = editgettext("lg_pwd", "user_login")
    var _response = bs_登陆(_user, _pwd)
    var _array = array()
    if(strsplit(_response, "|", _array) >= 5)
        //登陆成功
        if(_array[0] == "01")
            bs_status = cint(_array[1])
            //另写请求减少请求次数
            bs_user = _user
            bs_vipDate = _array[4]
            controlclosewindow("user_login", 0)
            if(_array[1] == "1011")
                bs_vip = true
            end
            threadbegin("bsmod_登陆成功后处理", "")
        else
            staticsettext("lg_warn", "登陆失败！错误码：" & _array[1], "user_login")
        end
    elseif(_response == "9908")
        //已到期
        bs_status = cint(_array[1])
        controlclosewindow("user_login", 0)
        bs_登陆(_user, _pwd)
        for(var i = 0; i < 10; i++)
            if(bsmod_刷新用户信息())
                break
            else
                bs_登陆(_user, _pwd)
            end
            sleep(1000)
        end
        tabactive("tab", 1)
    else
        //登陆失败
        staticsettext("lg_warn", _response, "user_login")
        return false
    end
    bs_pwd = _pwd
    //自动登陆信息存储至ini
    filewriteini("USER", "User", bs_user, path_config)
    filewriteini("USER", "Pwd", aesencrypt(bs_pwd, aes_key), path_config)
end

function lg_forget_点击()
    messagebox("联系相关邮箱~", "忘记密码")
end

function lg_hot_enter_热键()
    lg_login_点击()
end
