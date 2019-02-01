var editcontent = array("", "", "", "", "", "", "", "", "", "", "", "")
var editline = 12

function editadd(content)
    for(var i = 0; i < editline - 1; i++)
        editcontent[i] = editcontent[i+1]
    end
    editcontent[editline - 1] = content
    var control_text = ""
    for(var i = 0; i < editline - 1; i++)
        control_text = control_text & editcontent[i] & "\r\n"
    end
    control_text = control_text & editcontent[editline - 1]
    editsettext("控制台", control_text)
end