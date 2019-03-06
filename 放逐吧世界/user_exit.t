
function user_exit_确定_点击()
    var _msg = bs_远程注销登录状态(bs_user, editgettext("user_exit_pwd", "user_exit"))
    messagebox(_msg, "注销了吗？")
    if(_msg == "注销成功!")
        controlclosewindow("user_exit", 0)
        bsmod_刷新用户信息()
    end
end


function user_exit_取消_点击()
    controlclosewindow("user_exit", 0)
end
