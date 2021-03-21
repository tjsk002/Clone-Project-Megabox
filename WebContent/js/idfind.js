$(function(){
    $("#ibxSchIdMblpTelno").on("keyup", function(){
        if($("#ibxSchIdMbNm").val().length >= 1 && ($("#ibxSchIdBirthDe").val().length >= 8 && ($("#ibxSchIdMblpTelno").val().length >= 9))){
            $("#btnSchId").css("background-color", "#503396").css("color", "#fff");
        }
    });
    $("#btnSchId").click(function(){
        $(".idfine_popup").show();
    });
    $("img").click(function(){
        $(".idfine_popup").hide();
    })
    $(".confirm").click(function(){
        $(".idfine_popup").hide();
    })
})