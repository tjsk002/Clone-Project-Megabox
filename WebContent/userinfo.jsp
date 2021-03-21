<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<!-- 미구현 부분 주석처리 했습니다. (이미지 등록, 회원탈퇴, 비밀번호변경, 주소) -->

<!-- mega_member 쿼리문  -->
<sql:setDataSource var="memberDb" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://127.0.0.1:3306/project" user="root" password="1234" />
<sql:query dataSource="${memberDb}" var="memberDb_rs">  
	SELECT mem_name, mem_birth, mem_hp, mem_email, mem_address FROM mega_member WHERE mem_id=?;  
	<sql:param value="${sessionScope.loginid}"/>
</sql:query>
<head>
<meta charset="UTF-8">
<title>라이프씨어터, 메가박스</title>
<link rel="stylesheet" href="css/userinfo_style.css">
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/userinfo.js"></script>
</head>
<body>
    <!-- //header -->
    <header id="header">
        <div class="container">
            <div class="row">
                <div class="header">
                    <h5> 
                       <c:choose >
						<c:when test="${not empty sessionScope.loginid}">
							
							<li><a href="logout_ok.jsp" id="logout">로그아웃</a></li>
							<li><a href="quick-reserve.jsp">빠른예매</a></li>
						</c:when>
						<c:otherwise>
						<li><a href="#" id="loginbringPopup">로그인</a></li>
						<li><a href="megaSign.jsp">회원가입</a></li>
						</c:otherwise>
						</c:choose>
                    </h5>
                    <br>
                    <nav class="nav">
                        <ul class="nav_left">
                            <li><a href="#"><img src="image/ico-sitemap_b.png" alt="메뉴"></a></li>
                                <li><a href="#"><img src="image/ico-search_b.png" alt="검색"></a></li>
                                <li><a href="boxoffice.jsp"><img src="image/gnb-txt-movie.png"></a></li>
                                <li><a href="booking.jsp"><img src="image/gnb-txt-reserve.png"></a></li>
                            </ul> 
                            <ul class="nav_middle">                       
                                <li><a href="mainpage.jsp"><img src="image/logo.png" alt="메인로고" transparent 0% 0% no-repeat padding-box;></a></li>
                            </ul>
                            <ul class="nav_right">
                                <li><a href="#"><img src="image/ico-mymega_b.png" alt="마이메가박스"></a></li>
                        </ul>
                    </nav>    
                </div>
            </div>
        </div>
    </header>

    <!-- //header -->
    
    <section id="body">
        <div class="container-userinfo">
            <div class="page-util">
            	<div class="inner-wrap">
	                <div class="location">
	                    <span><img src="image/bg-location-home.png" alt="home"> </span>
	                    <span><img src="image/bg-location-arr.png" alt="arr"></span>
	                    <a href="mypagemain.jsp" title="나의 메가박스 페이지로 이동">나의 메가박스</a>
	                    <span><img src="image/bg-location-arr.png" alt="arr"></span>
	                    <a href="userconfirm.jsp" title="비밀번호 확인 페이지로 이동">회원정보</a>
	                    <span><img src="image/bg-location-arr.png" alt="arr"></span>
	                    <a href="userconfirm.jsp" title="개인정보 수정 페이지로 이동">개인정보 수정</a>
	                </div>
	        	</div>
            </div>
			<div class="row">
	            <div class="nav">
	                <nav id="lnb">
	                    <ul>
	                        <li class="nav-title"><a href="mypagemain.jsp" title="나의 메가박스 페이지로 이동">나의 메가박스</a></li>
	                        <li class="nav-sub"><a href="bookinglist.jsp" title="예매내역 페이지로 이동">예매내역</a></li>
	                        <li class="nav-sub"><a href="userconfirm.jsp" title="회원정보 페이지로 이동">회원정보</a></li>
	                        <li class="nav-depth"><a href="userconfirm.jsp" title="개인정보수정 페이지로 이동">개인정보 수정</a></li>
	                    </ul>
	                </nav>
	            </div>
	
	            <div class="modify">
	                <div class="modify-notice">
	                    <h2 class="title-main">개인정보 수정</h2>
	                    <ul>
	                        <li>회원님의 정보를 정확히 입력해주세요.</li>
	                    </ul>
	                </div>
	
	                <div class="info-main">
	                    <table class="board-form">
	                        <colgroup>
	                            <col style="width:180px;">
	                            <col>
	                        </colgroup>
	                        <tbody>
	                            <tr>
	                                <th scope="row">프로필 사진</th>
	                                <td>
	                                    <div class="profile-photo">
	                                        <form name="fileForm">
	                                            <input type="file" id="profileTarget" name="file" style="display: none;">
	                                        </form>
	                                        <div class="profile-img">
	                                            <img src="image/bg-profile.png" alt="프로필 사진 샘플">
	                                        </div>
	                                       <!--  <button type="button" class="button small gray-line" id="addProfileImgBtn">이미지 등록</button> -->
	                                     <!--    <button type="button" class="button small member-out" id="memberOutBtn">회원탈퇴</button> -->
	                                    </div>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th scope="row">아이디</th>
	                                <td>${sessionScope.loginid}</td>
	                            </tr>
	                        </tbody>
	                    </table>
	                </div>
	
	                <div class="info_sub">
	                    <h3 class="title-sub">기본정보</h3>
	                        <p class="right"><em class="font-orange">* </em>필수</p>
	                    </h3>
	                    <table class="board-form">
	                        <colgroup>
	                            <col style="width:180px;">
	                            <col>
	                        </colgroup>
	                        <tbody>
	                            <tr>
	                                <th scope="row">
	                                    이름 <em class="font-orange">*</em>
	                                </th>
	                                <td>
	                                	<c:forEach var="mega_member" items="${memberDb_rs.rows }">
	                                    <span class="mbNmClass"><c:out value="${mega_member.mem_name}"/></span>
	                                    </c:forEach>
	                                    <button type="button" class="button small gray-line change-name" id="usernameChgBtn" title="이름 변경">이름 변경</button>
	                                    ※ 개명으로 이름이 변경된 경우, 회원정보의 이름을 변경하실 수 있습니다.
	                                </td>
	                            </tr>
	                            <tr>
	                                <th scope="row">
	                                    생년월일 <em class="font-orange">*</em>
	                                </th>
	                                <td>
	                                    <c:forEach var="mega_member" items="${memberDb_rs.rows }">
	                                    	<c:out value="${mega_member.mem_birth}"/>
	                                    </c:forEach>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th scope="row">
	                                    <label for="num">휴대폰</label> <em class="font-orange">*</em>
	                                </th>
	                                <td>
	                                    <div class="clearfix">
	                                    	<c:forEach var="mega_member" items="${memberDb_rs.rows }">
	                                        <p class="reset float-l w170px lh32 changeVal" data-name="phoneNo">
	                                            <c:out value="${mega_member.mem_hp}"/>
	                                        </p>
	                                        </c:forEach>
	                                        <div class="float-l">
	                                            <button type="button" class="button small gray-line change-phone-num" id="phoneChgBtn" title="휴대폰번호 변경">휴대폰번호 변경</button>
	                                        </div>
	                                    </div>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th scope="row">
	                                    <label for="email">이메일</label> <em class="font-orange">*</em>
	                                </th>
	                                <td>
	                                    <input type="text" id="email" name="mbEmail" class="input-text w500px" value="<c:forEach var="mega_member" items="${memberDb_rs.rows }"><c:out value="${mega_member.mem_email}"/></c:forEach>">
	                                </td>
	                            </tr>
	                            <!-- 미구현 부분 주석 처리 -->
	                           <!--  <tr>
	                                <th scope="row">비밀번호 <em class="font-orange">*</em></th>
	                                <td>
	                                    <button type="button" class="button small gray-line change-userpw" id="pwChgBtn" title="비밀번호 변경"><a href="#" title="비밀번호 변경페이지로 이동">비밀번호 변경</a></button>
									  	미구현
	                                    마지막 비밀번호 변경: 2289일전에 함 (2013-12-26 16:57:12)
	                                </td> -->
	                            </tr>
	                            <tr>
	                               <%--  <th scope="row">주소</th>
	                                <td>
	                                    <span>  </span>
	                                    <button type="button" class="button small gray-line change-address" id="addressChgBtn" title="우편번호 검색">우편번호 검색</button>
	                                    <c:forEach var="mega_member" items="${memberDb_rs.rows }">
	                                    <p class="reset mt10"><c:out value="${mega_member.mem_address}"/></p>
	                                    </c:forEach>
	                                </td> --%>
	                            </tr>
	                        </tbody>
	                    </table>
	                </div>
	                <div class="btn-group">
	                    <a href="mypagemain.jsp" class="button large" id="cancelBtn" title="취소">취소</a>
	                    <a href="#" class="button large purple" id="ckBtn" data-url="/mypage/userinfo" title="등록">등록</a>
	                </div>
	            </div>
	            
	            <div class="modify_popup">
	                <header class="layer-header">
	                    <h3 class="tit">알림</h3>
	                    <img src="image/btn-layer-close.png" alt="닫기">
	                </header>
	                <div class="layer-con">
	                    <p class="txt-common">회원정보가 수정되었습니다.</p>
	                    <div class="btn-group">
	                        <button type="button" class="button purple confirm">확인</button>
	                    </div>
	                </div>
	            </div>
            </div>
        </div>
    </section>

    
    <!-- //footer --> 
                                        
    <footer id="footer">
    <div class="row">      
        <div id="footer_sns">
            <div class="container">
                <div class="footer_sns">
                    <ul>
                        <li class="icon"><img src="image/ico-twitter.png"></li>
                            <li class="icon"><img src="image/ico-facebook.png"></li>
                            <li class="icon"><img src="image/ico-instagram.png"></li>
                            <li class="icon"><img src="image/ico-appstore.png"></li>
                            <li class="icon"><img src="image/ico-googleplay.png"></li>                       
                    </ul> 
                </div>
            </div>
        </div>    

        <div id="footer_infor">
            <div class="container">
                <div class="row">
                    <div class="com_infor">
                        <ul>
                            <li><a href="#">회사소개</a></li>
                            <li><a href="#">인재채용</a></li>
                            <li><a href="#">제휴/광고/부대사업 문의</a></li>
                            <li><a href="#">이용약관</a></li>
                            <li><a href="#">개인정보처리방침</a></li>
                            <li><a href="#">고객센터</a></li>
                            <li><a href="#">윤리경영</a></li>
                        </ul>
                    </div>
                    <div class="add_infor">
                        <ul class="address">
                        <h2><img src="image/logo_gray.png" alt="megabox"></h2>
                        </ul>
                        <ul class="address">
                        <address>
                            <p>서울특별시 성동구 왕십리로 50, 6층(성수동 1가, 메가박스스퀘어) ARS 1544-0070<br>
                            <span>대표자명 김진선</span> 개인정보보호 조상연<br><span>사업자등록번호 211-86-59478</span> 통신판매업신고번호 제 833호</p><br>
                            <p>Copyright 2014 by MegaboxJoongAng Inc. All right reserved</p>
                        </address>
                        </ul>
                    </div>
                </div>
            </div> 
        </div>
    </div>
    </footer>

    <!-- //footer -->
</body>
</html>