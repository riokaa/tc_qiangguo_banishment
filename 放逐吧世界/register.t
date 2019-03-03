function register_初始化()
    threadbegin("reg_coode_pic_左键单击", "")
end


function reg_coode_pic_左键单击()
    httpdownload(bs_reqUrl_coode, "rc:coode.jpeg")
    logd("验证码请求:" & bs_reqUrl_coode)
    picturesetpicture("reg_coode_pic", "rc:coode.jpeg", "register")
end


function reg_reg_点击()
    var _email = editgettext("reg_email", "register")
    var _user = editgettext("reg_user", "register")
    var _pwd = editgettext("reg_pwd", "register")
    var _pwdb = editgettext("reg_pwdb", "register")
    var _coode = editgettext("reg_coode", "register")
    var _response = bs_注册(_user, _pwd, _pwdb, _email, _coode)
    staticsettext("reg_warn", _response, "register")
end
