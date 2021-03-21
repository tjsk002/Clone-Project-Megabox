$(function(){
    $("#ibxPwdReSetLoginPwdConfirm").on("keyup", function(){
        if($("#ibxSchIdMbId").val().length >= 1 && ($("#ibxPwdReSetLoginPwd").val().length >= 10 && ($("#ibxPwdReSetLoginPwdConfirm").val().length >= 10))){
            $("#btnSchId").css("background-color", "#503396").css("color", "#fff");
        }
    });
});