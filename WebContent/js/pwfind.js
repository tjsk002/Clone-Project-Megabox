$(function(){
    $("#ibxSchIdMblpTelno").on("keyup", function(){
        if($("#ibxSchPwMbID").val().length >= 1 && ($("#ibxSchIdMbNm").val().length >= 2 && ($("#ibxSchIdMblpTelno").val().length >= 9))){
            $("#btnSchPwdMbCertNoSend").css("background-color", "#666").css("color", "#fff");
            $("#btnSchPw").css("background-color", "#503396").css("color", "#fff");
        }
    });
});