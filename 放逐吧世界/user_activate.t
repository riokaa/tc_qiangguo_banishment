function act_激活_点击()
    var _ka = editgettext("act_激活码框", "user_activate")
    _ka = strreplace(_ka, " ", "")
    var _response = bs_软件充值vip续期(bs_user, bs_pwd, 1, _ka, "")
    staticsettext("act_warn", _response, "user_activate")
    if(strfind(_response, "激活成功") >= 0)
        bsmod_刷新用户信息()
    end
end
