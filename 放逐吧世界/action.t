
function websmoothscroll(yPos)  //相对圆滑滚动
    var unit = 3
    if(yPos >= 0)
        unit = 3
    else
        unit = -3
    end
    yPos = mabs(yPos)
    for(var i = 0; i < cint(yPos/3); i++)
        websetscollpos("web", 0, unit, 1)
        sleep(3)
    end
end