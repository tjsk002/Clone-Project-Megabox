<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라이프시어터, 메가박스</title>
<link rel="stylesheet" href="css/pwfind_style.css">
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/pwfind.js"></script>
</head>
<body>
	<div class="container">
        <div class="content">
            <div class="ci">
                <a href="mainpage.jsp" title="메인 페이지로 이동"></a>
            </div>
            <div class="col">
                <p class="tit-member">아이디/비밀번호 찾기</p>
                <div class="tab-list">
                    <ul>
                        <li class="tab-id"><a href="idfind.jsp" title="아이디 찾기">아이디 찾기</a></li>
                        <li class="tab-pw"><a href="pwfind.jsp" title="비밀번호 찾기">비밀번호 찾기</a></li>
                    </ul>
                </div>
                <div class="tit-mt40">
                    <p>간편찾기</p>
                </div>
                <div class="table">
                    <table class="board-form">
						<colgroup>
							<col style="width:130px;">
							<col>
						</colgroup>
						<tbody>
                            <tr>
								<th scope="row"><label for="ibxSchPwMbID">아이디</label></th>
								<td>
									<input id="ibxSchPwMbID" name="userid" maxlength="20" type="text" placeholder="아이디" class="input-text w230px">
									<div id="ibxSchPwMbID-error-text" class="alert"></div>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="ibxSchIdMbNm">이름</label></th>
								<td>
                                    <input id="ibxSchIdMbNm" name="username" maxlength="20" type="text" placeholder="이름" class="input-text w230px"><!--이름-->
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="ibxSchIdMblpTelno">휴대폰 번호</label></th>
								<td>
                                    <input id="ibxSchIdMblpTelno" name="userhp" maxlength="11" type="text" placeholder="'-' 없이 입력" class="input-text w230px"><!--'-' 없이 입력-->
                                    <button id="btnSchPwdMbCertNoSend" type="button" class="button gray w75px ml08 disabled" disabled="disabled">인증요청<!--인증요청--></button>
								</td>
							</tr>
						</tbody>
					</table>
                </div>
                <div class="btn-find">
                    <p class="btn"><button id="btnSchPw" type="button">비밀번호 찾기</button></p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>