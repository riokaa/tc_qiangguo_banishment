
function lg_login_点击()
    var _user = editgettext("lg_user", "user_login")
    var _pwd = editgettext("lg_pwd", "user_login")
    var _response = bs_登陆(_user, _pwd)
    var _array = array()
    if(strsplit(_response, "|", _array) >= 5)
        //登陆成功
        if(_array[0] == "01")
            bs_status = cint(_array[1])
			controlclosewindow("user_login", 0)
			bsmod_刷新用户信息()
		else
			staticsettext("lg_warn", "登陆失败！错误码：" & _array[1], "user_login")
        end
    elseif(_response == "9908")
        //已到期
        staticsettext("lg_warn", "邪王真眼Pro过期！续期即可登陆。", "user_login")
        bsmod_刷新用户信息()
    else
        //登陆失败
        staticsettext("lg_warn", _response, "user_login")
    end
end


function lg_forget_点击()
    
end
