
function getTimeStampMillis()
    return timediff("s", "1970/1/1 8:00:00", timenow()) * 1000
end