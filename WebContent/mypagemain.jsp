<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>s
<!-- mega_member 쿼리문  -->
<sql:setDataSource var="memberDb" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://127.0.0.1:3306/project" user="root"
	password="1234" />
<sql:query dataSource="${memberDb}" var="memberDb_rs">  
	SELECT mem_name FROM mega_member WHERE mem_id=?;  
	<sql:param value="${sessionScope.loginid}"/>
</sql:query>

<head>

<meta charset="UTF-8">
<title>나의메가박스 | 라이프씨어터, 메가박스</title>
<link rel="stylesheet" href="css/mypagemain_style.css">
</head>
<body>
	<div class="container-main">
        <!-- //header -->
        <header id="header">
            <div class="container">
                <div class="row">
                    <div class="header">
                        <h5> 
	                          <c:choose >
							<c:when test="${not empty sessionScope.loginid}">
								
								<li><a href="logout_ok.jsp" id="logout">로그아웃</a></li>
								<li><a href="booking.jsp">빠른예매</a></li>
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
            <div class="container-mypage">
                <div class="page-util">
                	<div class="inner-wrap"> 
	                    <div class="location">
	                        <span><img src="image/bg-location-home.png" alt="home"> </span>
	                        <span><img src="image/bg-location-arr.png" alt="arr"></span>
	                        <a href="mypagemain.jsp" title="나의 메가박스 페이지로 이동">나의 메가박스</a>
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
	
	                <div class="info">
	                    <div class="userInfo">
	                        <div class="img">
	                            <form name="fileForm" style="display: none;">
	                                <input type="file" name="file">
	                                <input type="hidden" name="fileMbNo" value="84913">
	                            </form>    
	                            <i class="iconset ico-add-photo"></i>
	                            <button type="button" class="img">
	                                <img src="image/bg-photo.png" alt="이미지" onerror="noImg(this, 'human')">
	                            </button>
	                        </div>
	                        <c:forEach var="mega_member" items="${memberDb_rs.rows }">
	                        <p class="welcome"><c:out value="${mega_member.mem_name}"/>님<br>환영합니다.</p>
	                        </c:forEach>
	                        <div class="link">
	                            <a href="userconfirm.jsp" title="개인정보수정">개인정보수정</a>
	                        </div>    
	                    </div>
	                    <div class="reserInfo">
	                        <h2 class="title">나의 예매내역</h2>
	                        <a href="bookinglist.jsp" class="more" title="나의 예매내역 더보기">더보기</a>
	                        <hr>
	                        <div class="history">
	                        <sql:query dataSource="${memberDb}" var="seat">  
								SELECT ticket_movieTime, ticket_seat FROM mega_ticket WHERE ticket_id=?;  
								<sql:param value="${sessionScope.loginid}"/>
							</sql:query>
							<c:forEach var="seatNum" items="${seat.rows}">
								<c:set var="ticket_seat" value="${seatNum.ticket_seat}" />
	                        	<c:set var="ticket_movieTime" value="${seatNum.ticket_movieTime}" />
	                        		<sql:query dataSource="${memberDb}" var="movieInfo">  
										SELECT time_title, time_start, time_sinema, time_theater, time_date FROM movie_time WHERE time_idx=?;  
										<sql:param value="${ticket_movieTime}"/>
									</sql:query>
									<c:forEach var="movie" items="${movieInfo.rows}">
										<c:set var="time_title" value="${movie.time_title}" />
										<c:set var="time_start" value="${movie.time_start}" />
										<c:set var="time_sinema" value="${movie.time_sinema}" />
										<c:set var="time_theater" value="${movie.time_theater}" />
										<c:set var="time_date" value="${movie.time_date}" />
									</c:forEach>
	                        
	                        	<div>영화제목 : ${time_title }, 시작시간 : ${time_start }, 좌석 : ${ticket_seat }, 지역 : ${time_sinema }, 상영관 : ${time_theater }, 날짜 : ${time_date }</div>
	                        	
	                        
	                        
	                        
	                        </c:forEach>
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
    </div>
</body>
</html>