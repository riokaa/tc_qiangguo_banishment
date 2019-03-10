function user_changepwd_修改_点击()
    var _user = bs_user
    var _pwd = editgettext("changepwd_pwd", "user_changepwd")
    var _pwda = editgettext("changepwd_pwda", "user_changepwd")
    var _pwdb = editgettext("changepwd_pwdb", "user_changepwd")
    var _response = bs_修改密码(_user, _pwd, _pwda, _pwdb)
    staticsettext("changepwd_warn", _response, "user_changepwd")
    if(strfind(_response, "成功") != -1)
        bs_pwd = _pwda
		filewriteini("USER", "Pwd", aesencrypt(bs_pwd, aes_key), path_config)
    end
end
