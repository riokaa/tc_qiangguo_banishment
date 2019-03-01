var control_text = ""

function editadd(content)
    if(strlen(control_text) > 10000)
        control_text = ""
        logi("控制台自动清理完毕.")
    end
    control_text = content & "\r\n" & control_text
    editsettext("控制台", control_text)
end