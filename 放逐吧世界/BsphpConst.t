
var bs_reqUrl = "http://verify.rayiooo.top/AppEn.php?appid=10000000&m=a1a7c60094c319355377aa90defb0d01"  //api请求url
var bs_mutualKey = "ec46841638311d78e68b3078b5f1ed15"  //通信认证key
var bs_inSgin = "[KEY]banish!"
var bs_outSgin = "[KEY]ment!"
var bs_machineCode  //机器码
var bs_SeSSL
var bs_loginStatus = 0  //登录状态,1011登陆成功

function bs_constInit()
    bs_machineCode = md5(getmac())
    bs_SeSSL = "ssl-" & bs_machineCode
end