//常量表
var aes_key = "4e72acd42edcb859ec49f60fd1106a50"
var author = "板san."
var DEBUG = false
var score = array(0, 0, 0, 0, 0)
var score_max_limit = array(1, 6, 6, 6, 6)
var settings_auto_close = false
var settings_auto_shutdown = false
var url_learntv = "https://www.xuexi.cn/4426aa87b0b64ac671c96379a3a8bd26/db086044562a57b441c24f2af1c8e101.html"
var url_main = "https://www.xuexi.cn/"
var url_mypoints = "https://pc.xuexi.cn/points/my-points.html"
var url_pay = "http://verify.rayiooo.top/index.php?m=applib&c=appweb&a=new_info&id=83"
var url_public = "http://verify.rayiooo.top/index.php?m=applib&c=appweb&open_new=&a=new_list&list=10001"
var vdo_list = array()  //json格式视频分发数据
var vdo_list_num = 0
var version = "v2.0.3"
var version_date = "2019.3.28"

var path_config
var path_cur
var path_rc

function constInit()
    path_cur = sysgetcurrentpath()
    path_rc = getrcpath("rc:")
    foldercreate(path_cur & "config")
    path_config = path_cur & "config\\Config.ini"
end