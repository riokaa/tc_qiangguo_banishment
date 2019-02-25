function webmovemouse()  //防封性质的动动鼠标
    var x = rnd(1, 500)
    var y = rnd(1, 500)
    webmoveto("web", x, y)
    sleep(200)
end

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