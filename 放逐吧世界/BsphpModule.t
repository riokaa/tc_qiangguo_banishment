function bsmod_登陆成功后处理()
    controlshow("user_login", false, "放逐吧世界")
    controlshow("user_reg", false, "放逐吧世界")
    controlshow("user_exit", true, "放逐吧世界")
    controlenable("user_changePwd", true)
    staticsettext("label_user", bs_user)
    staticsettext("label_vipDate", bs_vipDate)
    if(bs_vip)
        staticsetcolor("label_vipStatus", "#00ff00")
        staticsettext("label_vipStatus", "邪王真眼健在√")
		controlenable("about_feedback", true)
    else
        staticsetcolor("label_vipStatus", "#ff0000")
        staticsettext("label_vipStatus", "已到期")
		controlenable("about_feedback", false)
    end
    logi("你好," & bs_user & ".")
end

function bsmod_登陆失败后处理()
    staticsettext("label_user", "未登录")
    staticsettext("label_vipStatus", "")
    staticsettext("label_vipDate", "")
    controlshow("user_login", true, "放逐吧世界")
    controlshow("user_reg", true, "放逐吧世界")
    controlshow("user_exit", false, "放逐吧世界")
    controlenable("user_changePwd", false)
	controlenable("about_feedback", false)
end

function bsmod_刷新用户信息()
    if(bs_取登陆状态信息() == 1)
        bs_user = bs_取用户信息("用户名称")
        bs_vipDate = bs_取用户信息("到期时间")
        if(bs_取用户信息("是否到期") ==1)
            bs_vip = true
        else
            bs_vip = false
        end
        threadbegin("bsmod_登陆成功后处理", "")
        return true
    else
        bs_status = -1
        bs_vip = false
        threadbegin("bsmod_登陆失败后处理", "")
        return false
    end
end

function bsmod_心跳包控制()
    while(true)
        bs_status = bs_心跳包()
        if(bs_status == 5031)
            logd("心跳正常.")
        elseif(bs_status == 5033)
            logw("账号已被冻结.")
        elseif(bs_status == 5030)
            logw("账号Pro功能已到期.")
        elseif(bs_status == 5026 || bs_status == 1049)
            logw("登陆超时.")
        end
        bsmod_刷新用户信息()
        sleep(15 * 60 * 1000)
    end
end