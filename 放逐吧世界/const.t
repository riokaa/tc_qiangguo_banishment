//常量表
var author = "板san."
var DEBUG = false
var score = array()
var score_max_limit = array(1, 6, 6, 8, 10)
var url_main = "https://www.xuexi.cn/"
var url_mypoints = "https://pc.xuexi.cn/points/my-points.html"
var version = "v1.1"
var version_date = "2019.2.13"


//各省视频源
var url_learntv = "https://www.xuexi.cn/4426aa87b0b64ac671c96379a3a8bd26/db086044562a57b441c24f2af1c8e101.html"
var url_local_vdo = array()  //返回json格式文章数据


function const_init()
    
    //常量赋值初始化
	//url_local_vdo[0] = array("name"="山西", "url"="https://zj.xuexi.cn/local/zj/channel/7468c909-5672-4e76-b998-78b8d2c130f6.json")
	url_local_vdo[0] = array("name"="山西", "url"="https://sx.xuexi.cn/local/list.html?6b4b63f24adaa434bb66a1ac37e849e0=be3f0ff12434633c64f9ae75357b2adf272eb88426f6fd8e662ba68d11acecf6743228141bff2d9baa7e27a536a935bf&page=1")
	url_local_vdo[1] = array("name"="天津", "url"="https://tj.xuexi.cn/local/list.html?6b4b63f24adaa434bb66a1ac37e849e0=1716773628d5787e6652ac44576ccd8b887d24e273ff5790b9512f9ec0dd412001601b6b03409ef4b87131fa60e13802&page=1")
	url_local_vdo[2] = array("name"="浙江", "url"="https://zj.xuexi.cn/local/list.html?6b4b63f24adaa434bb66a1ac37e849e0=1ee1d4b83e51a09bc14ea52aed4de9612bbd19ba340253f5c87cb69af1821f124f4208345a74650885428ffeffaac9ba&page=1")

end