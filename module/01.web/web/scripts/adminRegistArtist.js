/**
 * 初始化
 */
$(document).ready(function() {
    if(message != EMPTY){
        showInformation(message);
    }
});

/**
 * 评论专员注册
 */
function registArtist(){
    var name = $("#name").val();
    var password = document.getElementById("password").value;
    //md5签名
    var md5Pwd = MD5(password + md5Key);
    document.getElementById("password").value = md5Pwd;
    var confirmPassword = document.getElementById("confirm_password").value;
    //md5签名
    var md5ConfirmPassword = MD5(confirmPassword + md5Key);
    document.getElementById("confirm_password").value = md5ConfirmPassword;
    document.forms["adminRegistArtistForm"].submit();
}