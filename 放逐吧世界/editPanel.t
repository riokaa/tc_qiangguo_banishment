var control_text = ""

//var editcontent = array("", "", "", "", "", "", "", "", "", "", "", "")
//var editline = 12
//从下往上的无滚动条的控制台
//function editadd(content)
//    for(var i = 0; i < editline - 1; i++)
//        editcontent[i] = editcontent[i+1]
//    end
//    editcontent[editline - 1] = content
//    var control_text = ""
//    for(var i = 0; i < editline - 1; i++)
//        control_text = control_text & editcontent[i] & "\r\n"
//    end
//    control_text = control_text & editcontent[editline - 1]
//    editsettext("控制台", control_text)
//end

function editadd(content)
    if(strlen(control_text) > 10000)
        control_text = ""
        logi("控制台自动清理完毕.")
    end
    control_text = content & "\r\n" & control_text
    editsettext("控制台", control_text)
end