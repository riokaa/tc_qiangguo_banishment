﻿function user_register_初始化()
    threadbegin("reg_coode_pic_左键单击", "")
end

function reg_coode_pic_左键单击()
    foldercreate(path_cur & "temp")
    httpdownload(bs_reqUrl_coode, path_cur & "temp\\coode.jpeg")
    logd("验证码请求:" & bs_reqUrl_coode)
    picturesetpicture("reg_coode_pic", path_cur & "temp\\coode.jpeg", "user_register")
end

function reg_reg_点击()
    staticsettext("reg_warn", "", "user_register")
    var _email = editgettext("reg_email", "user_register")
    var _user = editgettext("reg_user", "user_register")
    var _pwd = editgettext("reg_pwd", "user_register")
    var _pwdb = editgettext("reg_pwdb", "user_register")
    var _coode = editgettext("reg_coode", "user_register")
    var _response = bs_注册(_user, _pwd, _pwdb, _email, _coode)
    staticsettext("reg_warn", _response, "user_register")
end
