
function bsmod_init()
    if(bs_取登陆状态信息() == 1)
        bsmod_刷新用户信息()
        controlshow("user_login", false)
        controlshow("user_reg", false)
        controlshow("user_exit", true)
    else
        controlshow("user_login", true)
        controlshow("user_reg", true)
        controlshow("user_exit", false)
    end
end

function bsmod_刷新用户信息()
    bs_user = bs_取用户信息("用户名称")
    staticsettext("label_user", bs_user)
    staticsettext("label_vipDate", bs_取用户信息("到期时间"))
    if(bs_取用户信息("是否到期") ==1)
        staticsetcolor("label_vipStatus", "#00ff00")
        staticsettext("label_vipStatus", "√")
    else
        staticsetcolor("label_vipStatus", "#ff0000")
        staticsettext("label_vipStatus", "已到期")
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
        sleep(15 * 60 * 1000)
    end
end