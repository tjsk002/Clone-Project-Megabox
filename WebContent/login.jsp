<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라이프시어터, 메가박스</title>
<link rel="stylesheet" href="css/login_style.css">
<script src="js/jquery-3.4.1.min.js"></script>
<script>
        $(function(){
            $("#ibxLoginPwd").on("keyup", function(){
                if($("#ibxLoginPwd").val().length >= 1 && ($("#ibxLoginId").val().length >= 1)){
                    $(".button").css("background-color", "#503396").css("color", "#fff");
                }
            });
        });
</script>
</head>
<body>
	<div class="container-login">
        <div class="login_popup">
            <header class="layer-header">
                <h3 class="tit">로그인</h3>
                <img src="image/btn-layer-close.png" alt="닫기">
            </header>
            <div class="layer-con">
    
                <div class="login-con">
                    <input name="userid" id="ibxLoginId" maxlength="20" type="text" placeholder="아이디" title="아이디를 입력하세요" class="input-text strTrim">
                    <input name="userpw" id="ibxLoginPwd" maxlength="20" type="password" placeholder="비밀번호" title="비밀번호를 입력하세요" class="input-text mt15">
                    <div class="chk-util">
                        <input id="chkIdSave" type="checkbox"> <label for="chkIdSave">아이디 저장</label>
                    </div>

                     
                    <button type="button" class="button purple confirm">로그인</button>
                    <div class="link">
                        <a href="idfind.jsp" title="ID/PW 찾기 선택">ID/PW 찾기</a>
                        <span> | </span>
                        <a href="megaSign.jsp" title="회원가입 선택">회원가입</a>
                    </div>
                </div>

                <div class="login-add">
                    <a href="https://ad.imp.joins.com/NetInsight/event/clk/4K5f_RgWicNm_8g9rYkT7jyJeokH7sM7kIb6n-Qg6sOIAbZhLVB5VzZ5V1N5U0NQbUc5d2tLWFpBAstB16GkRs0UgwO2czBUUmNlYmlSYlNtZHNUTlc3SEZDZwbZLW1lZ2Fib3hfcC9tYWluL21haW5AbWFpbl90b3BfMTEwMHg4MF8xMTAweDYwMAfOAARRFAjMtQmFpWFuYW1loKRfdWlk2W9ubXAtX2xGVWhCU2NWd3pXaWZZNmJIRVhCS1NaYjFXdTVuSkhMZFFrSEVhRUFNNHFXekFaQWJacGFqUlBlV3MyVFZSTVEzQjBORzlDTURnNWMzSjNBc3RCMTVxOC01ODNNUVBMUWRlYXZQdWZOekWkX2NpZLYzVng4eWJHclQyS2EzSTJUam5IVGpRo19ydMtB16GkRs0Ug6N0aWS2UVNvMDRrVzlRc1dPcXRINm5hLW1DdwqBoXLD" alt="광고" target="_blank">
                    <img id="pageBannerRnbImage" src="image/next-end.jpg"></a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>