
var bs_reqUrl = "http://verify.rayiooo.top/AppEn.php?appid=10000000&m=a1a7c60094c319355377aa90defb0d01"  //api请求url
var bs_reqUrl_coode = "http://verify.rayiooo.top/index.php?m=coode&sessl="
var bs_mutualKey = "ec46841638311d78e68b3078b5f1ed15"  //通信认证key
var bs_dataEnKey = "qVHXTCQFIxsvCch92u"
var bs_inSgin = "[KEY].*?板酱[KEY]banish!"
var bs_outSgin = "[KEY].*?大喵[KEY]ment!"
var bs_machineCode  //机器码
var bs_SeSSL
var bs_status = -1  //登录状态,1011登陆成功
var bs_user = ""

function bs_constInit()
    bs_machineCode = md5(getmac())
    bs_SeSSL = "ssl-" & bs_machineCode
    bs_reqUrl_coode = bs_reqUrl_coode & bs_SeSSL
end