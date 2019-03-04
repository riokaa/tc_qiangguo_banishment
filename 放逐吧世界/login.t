

function lg_login_点击()
    var _user = editgettext("lg_user", "login")
    var _pwd = editgettext("lg_pwd", "login")
    var _response = bs_登陆(_user, _pwd)
    staticsettext("lg_warn", _response, "login")
end
