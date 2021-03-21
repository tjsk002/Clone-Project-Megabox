<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보입력</title>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/member.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="css/megaMember.css" rel="stylesheet" type="text/css">
</head>

<body>
	<div class="member">
        <header id="header">
            <div class="container">
                <div class="megabox_img">
                <a href="mainpage.jsp">
                        <strong><img src="image/logo.png" alt="megabox"></strong>
                    </a>
                </div>
            </div>
        </header>
        <div class="step_member">
            <ol>
                <li>
                    <p class="step">
                        <em>STEP1.</em>
                        <span>본인인증</span>
                    </p>
                </li>
                <li>
                    <p class="step">
                        <em>STEP2.</em>
                        <span>약관동의</span>
                    </p>
                </li>
                <li>
                    <p class="step_on">
                        <em>STEP3.</em>
                        <span>정보입력</span>
                    </p>
                </li>
                <li>
                    <p class="step">
                        <em>STEP4.</em>
                        <span>가입완료</span>
                    </p>
                </li>
            </ol>
        </div>
        <p class="info">
            <strong>안녕하세요.</strong>
            <span>회원정보를 입력해주세요.</span>
        </p>
        <form method="POST" action="regist_ok.jsp" onsubmit="return member()">
            <table id="member_table1">
                <caption>
                    	생년월일, 휴대폰번호, 아이디, 비밀번호, 비밀번호 확인, 이메일 주소, 무인발권기 기능설정
                </caption>
                <colgroup>
                    <col style="width: 130px;">
                    <col>
                </colgroup>
                <tbody class="member_table2">
                    <tr>
                        <th scope="row">
                            	이름
                        </th>
                        <td><input type="text" class="text" name="username" id="username"></td>
                    </tr>
                    <tr>
                        <th scope="row">
                           	 생년월일
                        </th>
                        <td><input type="text" class="text" name="ssn1" id="ssn1" maxlength="6" placeholder="6자리만 입력해주세요."></td>
                    </tr>
                    <tr>
                        <th scope="row">
                           	 휴대폰 번호
                        </th>
                        <td><input type="text" class="text" name="hp" id="hp"></td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <label>아이디</label>
                        </th>
                        <td>
                            <input type="text" class="text" name="userid" id="userid" maxlength="12" placeholder="영문, 숫자 조합(8~12자)">
                            <button type="button" class="btnGray">중복확인</button>
                            <div class="alert" class="id">
                               	 아이디는 영문, 숫자 조합 8자리 이상 12자리 이하 입니다.
                            </div>
                        </td>
                        
                    </tr>
                    <tr>
                        <th scope="row">
                            <label>비밀번호</label>
                        </th>
                        <td>
                            <input type="password" class="text" name="userpw" id="userpw" maxlength="16" placeholder="영문,숫자,특수기호 중 2가지 이상 조합">
                            <div class="alert">
                                	비밀번호는 영문,숫자,특수기호 중 2가지 이상 조합하여 10자리 이상 16자리 이하입니다.
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <label>비밀번호 확인</label>
                        </th>
                        <td>
                            <input type="password" class="text" name="userpw_re" id="userpw_re" maxlength="16" placeholder="영문,숫자,특수기호 중 2가지 이상 조합">
                            <div class="alert">
                              	  비밀번호는 영문,숫자,특수기호 중 2가지 이상 조합하여 10자리 이상 16자리 이하입니다.
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">
                         	   이메일 주소
                        </th>
                        <td>
                            <input type="text" class="text" name="email" id="email" maxlength="50" placeholder="이메일주소를 입력해 주세요">
                            <div class="alert">
                                올바른 이메일 형식으로 입력해주세요.
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        
        <div class="marketing">
            <p class="tit" style="margin: 0;">마케팅 활용을 위한 개인정보 수집 이용 안내(선택)</p>
            <div class="cont">
                <dl>
                    <dt>수집목적</dt>
                    <dd>
                      	  고객맞춤형 상품 및 서비스 추천, 당사 신규 상품/서비스 안내 및 권유, 사은/할인 
                        	행사 등 각종 이벤트 정보 등의 안내 및 권유
                    </dd>
                    <dt>수집항목</dt>
                    <dd>이메일, 휴대폰번호, 주소, 생년월일, 선호영화관, 문자/이메일/앱푸쉬 
                      	  정보수신동의여부, 서비스 이용기록, 포인트 적립 및 사용 정보, 접속로그 
                    </dd>
                    <dt>보유기간</dt>                    
                    <dd>
                        회원 탈퇴시 혹은 이용 목적 달성시 까지
                    </dd>
                </dl>
                <div class="radio">
                    <input type="radio" name="agree" value="동의" id="agree"><label for="agree">동의</label>
                        <input type="radio" name="agree" value="미동의" id="notagree" checked style="margin-left: 20px!important;"><label for="notagree">미동의</label>
                </div>
                <p style="margin-top: 30px!important;">혜택 수신설정</p>
                <div class="benefit">
                    <input type="checkbox" id="push"><label for="push">알림</label>
                    <input type="checkbox" id="sms" style="margin-left: 20px!important;"><label for="sms">SMS</label>
                    <input type="checkbox" id="email" style="margin-left: 20px!important;"><label for="email">이메일</label>
                </div>
                <p style="margin-top: 20px!important;">    
                  	  ※  이벤트, 신규 서비스, 할인 혜택 등의 소식을 전해 드립니다.
                    <br>
                    (소멸포인트 및 공지성 안내 또는 거래정보와 관련된 내용은 수신 
                    	동의 여부와 상관없이 발송됩니다.)
                </p>
            </div>
        </div>
        <div class="btn_member">
            <input type="submit" class="btn_member_purple" value="회원가입">
        </div>
        </form>
    </div>
</body>
</html>