

function lg_login_点击()
    var _user = editgettext("lg_user", "user_login")
    var _pwd = editgettext("lg_pwd", "user_login")
    var _response = bs_登陆(_user, _pwd)
    if(_response == "9908?")
        controlclosewindow("user_login", 0)
        bsmod_刷新用户信息()
    else
        staticsettext("lg_warn", _response, "user_login")
    end
end


function lg_forget_点击()
    
end
