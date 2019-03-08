
function user_login_初始化()
    hotkeyregister("lg_hottab", "user_login")
    windowsetfocus(controlgethandle("lg_user", "user_login"))
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
            controlshow("user_login", false, "放逐吧世界")
            controlshow("user_reg", false, "放逐吧世界")
            controlshow("user_exit", true, "放逐吧世界")
            bs_user = editgettext("lg_user", "user_login")
            controlclosewindow("user_login", 0)
            staticsettext("label_user", bs_user)
            staticsettext("label_vipDate", _array[4])
            if(_array[1] == "1011")
                bs_vip = true
                staticsetcolor("label_vipStatus", "#00ff00")
                staticsettext("label_vipStatus", "邪王真眼健在√")
            end
        else
            staticsettext("lg_warn", "登陆失败！错误码：" & _array[1], "user_login")
        end
    elseif(_response == "9908")
        //已到期
        //staticsettext("lg_warn", "邪王真眼Pro过期！续期即可登陆。", "user_login")
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
    else
        //登陆失败
        staticsettext("lg_warn", _response, "user_login")
    end
end


function lg_forget_点击()
    //TODO
end


function lg_tab_热键()
    if(windowgetfocushwnd() == controlgethandle("lg_user", "user_login"))
        windowsetfocus(controlgethandle("lg_pwd", "user_login"))
    end
end
