<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라이프시어터, 메가박스</title>
<link rel="stylesheet" href="css/pwreset_style.css">
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/pwreset.js"></script>
</head>
<body>
	<div class="container">
        <div class="content">
            <div class="ci">
                <a href="mainpage.jsp" title="메인 페이지로 이동"></a>
            </div>
            <div class="col">
                <p class="tit-member">비밀번호 재설정</p>
                
                <div class="font-gblue">
                    <ul>
                        <li>보안인증이 완료되었습니다. 새로 사용하실 비밀번호를 입력해주세요.</li>
                    </ul>    
                </div>
                <div class="table">
                    <table class="board-form">
						<colgroup>
							<col style="width:130px;">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><label for="ibxSchIdMbNm">아이디</label></th>
								<td>
									<input id="ibxSchIdMbId" name="userid" maxlength="20" type="text" placeholder="아이디" class="input-text w230px">
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="ibxPwdReSetLoginPwd">새 비밀번호<!--새 비밀번호--></label></th>
								<td>
									<input id="ibxPwdReSetLoginPwd" name="userpw" maxlength="16" type="password" placeholder="영문,숫자,특수기호 중 2가지 이상 조합" class="input-text w300px"><!--영문,숫자,특수기호 중 2가지 이상 조합-->
								</td>
                            </tr>
                            <tr>
								<th scope="row"><label for="ibxPwdReSetLoginPwdConfirm">새 비밀번호 확인<!--새 비밀번호 확인--></label></th>
								<td>
									<input id="ibxPwdReSetLoginPwdConfirm" name="userpw-re"maxlength="16" type="password" placeholder="영문,숫자,특수기호 중 2가지 이상 조합" class="input-text w300px"><!--영문,숫자,특수기호 중 2가지 이상 조합-->
									<div id="pwdReSet-error-text" class="alert"></div>
								</td>
							</tr>
						</tbody>
					</table>
                </div>
                <div class="notice">
                    <ul>
                        <li>비밀번호는 영문, 숫자, 특수문자 중 2가지 이상 조합 10자리 이상으로 설정해주세요.</li>
                        <li>생년월일, 휴대폰번호 등 개인정보와 관련된 숫자, 연속된 숫자와 같이 쉬운 비밀번호는 사용을 자제해주세요.</li>
                        <li>비밀번호는 3개월마다 변경해주세요.</li>
                        <li>비밀번호 변경시 로그인된 모든 디바이스에서 로그아웃됩니다. 변경한 비밀번호로 다시 로그인 후 이용해주세요.</li>
                    </ul>
                </div>

                <div class="btn-find">
                    <p class="btn"><button id="btnSchId" type="button">확인</button></p>
                </div>
            </div>
        </div>

        
    </div>
</body>
</html>