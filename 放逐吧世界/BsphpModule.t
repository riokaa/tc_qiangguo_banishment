
function bsmod_init()
    if(bs_取登陆状态信息() == 1)
        bs_取用户信息("用户名称")
    else
        
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