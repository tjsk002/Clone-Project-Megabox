<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>본인인증</title>
</head>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="css/megaSign.css" rel="stylesheet" type="text/css">
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
	            <p class="step_on">
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
	            <p class="step">
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
	    <strong>회원가입을 위한 본인인증 단계입니다.</strong></br>
	    <span>원하시는 인증방법을 선택해주세요.</span>
	</p>
	<div class="join">
	    <a href="megaTerms.jsp">
	        <p><img src="image/phone.PNG"></p>
	        <span>휴대폰 인증</span>
	    </a>
	    
	</div>
	<ul class="dot">
	    <li>14세 미만 어린이는 보호자 인증을 추가로 완료한 후 가입이 가능합니다.</li>
	    <li>본인인증 시 제공되는 정보는 해당 인증기관에서 직접 수집하며, 인증 이외의 용도로 이용 또는 저장되지 않습니다.</li>
	</ul>
	</div>
</body>
</html>