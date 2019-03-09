function webmovemouse()  //防封性质的动动鼠标
    //var x = rnd(1, 500)
    //var y = rnd(1, 500)
    //webmoveto("web", x, y)
    //sleep(200)
end

function webmovemousepro()
    var x1 = rnd(1,1000)
    var y1 = rnd(1,1000)
    var x2 = rnd(1,1000)
    var y2 = rnd(1,1000)
    var freq = 30
    var detx = (x2 - x1) / freq
    var dety = (y2 - y1) / freq
    for(var i = 0; i < freq; i++)
        webmoveto("web", x1, y1)
        x1 = x1 + detx
        y1 = y1 + dety
        sleep(20)
    end
    sleep(200)
end

function websmoothscroll(yPos)  //相对圆滑滚动
    var unit = 3
    if(yPos < 0)
        unit = -unit
    end
    yPos = mabs(yPos)
    for(var i = 0; i < cint(yPos/mabs(unit)); i++)
        websetscollpos("web", 0, unit, 1)
        sleep(3)
    end
end

function webrandomscroll(yPos)
    var unit = rnd(3, 10)
    if(yPos < 0)
        unit = -unit
    end
    yPos = mabs(yPos)
    for(var i = 0; i < cint(yPos/mabs(unit)); i++)
        websetscollpos("web", 0, unit, 1)
        sleep(3)
    end
end