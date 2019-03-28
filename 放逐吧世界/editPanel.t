var control_text = ""

function editadd(content)
    if(strlen(control_text) > 30000)
        control_text = ""
        logi("控制台自动清理完毕.")
    end
    control_text = content & "\r\n" & control_text
    editsettext("控制台", control_text)
end

function editInit()
    editadd("本软件『完全可以免费使用』。")
    editadd("")
    editadd("如无法正常使用，请更新IE浏览器至最新版本。")
    editadd("")
    editadd("多开方式：使用Sandbox（沙盘）软件进行多开。")
    editadd("网页缩放：Ctrl键 + 滚轮（非必要）。")
    editadd("使用方式：扫码登陆后执行。")
    editadd("")
    editadd("***  软件版本：" & version & "  ***")
    editadd("")
end