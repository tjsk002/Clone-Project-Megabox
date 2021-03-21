<%@page import="javax.websocket.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="megaboxClass.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	/* 
	String reset = null;
	request.setAttribute("movieTime", reset);
	 */
	/* TimeMovieDAO timeMovieDAO = new TimeMovieDAO();
	ArrayList<TimeMovieDTO> movieTime = new ArrayList<>();
	movieTime = null;
	movieTime = timeMovieDAO.selectTimeMovie();
	request.setAttribute("movieTime", movieTime);
	
	 */
	MovieDAO movieDAO = new MovieDAO();
	ArrayList<MovieDTO> movieList = new ArrayList<>();
	movieList = movieDAO.selectMovid1();
	request.setAttribute("movieList", movieList);
%>

<sql:setDataSource var="db" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://127.0.0.1:3306/project" user="root"
	password="1234" />
	
<sql:query dataSource="${db}" var="memberDb_rs">  
	SELECT mem_name FROM mega_member WHERE mem_id=?;  
	<sql:param value="${sessionScope.loginid}"/>
</sql:query>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>빠른 예매</title>
<link rel="stylesheet" href="css/other_style.css">
<link rel="stylesheet" href="css/main_js.css">
<script src="js/mainpage.js"></script>
<link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/bookingCss.css?ver=8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="js/booking.js?ver=12"></script>
</head>
<body>


    <!-- //header -->
    <header id="header">
		<div class="container" style="position: relative; width: 1100px; margin: 0 auto;">
			<div class="row">
				<div class="header">
					<h5 style="margin-top: 10px;">
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
							<li><a href="#"><img src="image/ico-sitemap_b.png"
									alt="메뉴" class="menuBtn" ><img src="image/btn-header-layer-close.png" class="menuClose" style="display:none; position: absolute; float: left; top: 43px; left: 47px; z-index: 1;"></a></li>
							<li><a href="#"><img src="image/ico-search_b.png"
									alt="검색" class="searchBtn"><img src="image/btn-header-layer-close.png" class="searchClose" style="display:none; position: absolute; float: left; top: 43px; left: 150px; z-index: 1;"></a></li>
							<li><a href="boxoffice.jsp"><img
									src="image/gnb-txt-movie.png"></a></li>
							<li><a href="booking.jsp"><img src="image/gnb-txt-reserve.png"></a></li>
						</ul>
						<ul class="nav_middle">
							<li><a href="mainpage.jsp"><img src="image/logo.png"
									alt="메인로고" transparent 0% 0% no-repeatpadding-box;></a></li>
						</ul>
						<ul class="nav_right" >
							<li><a href="mypagemain.jsp"><img
									src="image/ico-mymega_b.png" alt="마이메가박스"></a></li>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</header>
    <!-- //header -->
    <div>
        <div class="page-util"><div id="inner-wrap"><div class="location"><span class="location">HOME</span><a href="booking.jsp" class="fast">예매</a><a href="booking.jsp" class="fast">빠른예매</a></div></div></div>
        <div id="main">
            <div class="tit"><h2>빠른예매</h2></div>
            <div id="pick">
                <div class="time-schedule">
                    <button class="btn-next btn-prev-date" title="이전 날짜 보기"><i class="iconset ico-cld-pre"></i></button>
                    <div class="date-list">
                        <div class="wrap-date">
                        <%-- <sql:query dataSource="${db}" var="rs">  
							SELECT DISTINCT time_date FROM movie_time;  
						</sql:query>	
                         --%>
                         	
                            <button class="disabled sat date-area">
                                <span class="ir">5월</span>
                                <em style="pointer-events: none;">6<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">화</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Tue</span>
                            </button>
                            <button class="on date-area">
                                <span class="ir">5월</span>
                                <em style="pointer-events: none;">7<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">오늘</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Wed</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">5월</span>
                                <em style="pointer-events: none;">8<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">목</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Thu</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">5월</span>
                                <em style="pointer-events: none;">1<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">금</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Fri</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">2<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">토</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Sat</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">3<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">일</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Sun</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">4<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">월</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Mon</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">5<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">화</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Tue</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">6<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">수</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Wed</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">7<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">목</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Thu</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">8<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">금</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Fri</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">9<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">토</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Sat</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">10<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">일</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Sun</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">11<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">월</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Mon</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">12<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">화</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Thu</span>
                            </button>
                            <button class="disabled sat date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">13<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">수</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Wed</span>
                            </button>
                        </div>
                    </div>
                    <button class="btn-next btn-next-date" title="다음 날짜 보기"><i class="iconset ico-cld-next"></i></button>
                    <div class="bg-line"><button class="btn-calendar-large"></button></div>
                </div>
                <div class="quick-reserve-area">
                    <div class="movie-choice">
                        <p class="tit">영화</p>
                        <div class="list-area">
                            <div class="all-list">
                                <button type="button" class="btn-tab on-movie" id="movieAll">전체</button>
                                <button type="button" class="btn-tab off-movie"></button>
                                <div class="list">
                                    <div class="scroll">
                                        <ul>
                                        	<c:forEach var="movieDTO" items="${movieList}">
                                        	<c:set var="title" value="${movieDTO.movieTitle}" />
                                            <li style="height:100%;">
                                                <button type="button" class="btn">
                                                    <span class="movie-grade">${movieDTO.movieAge}</span>
                                                    <%
													LikeDAO likeDAO = new LikeDAO();
													boolean ck = likeDAO.selectMovieLike((String)pageContext.getAttribute("title"), (String)session.getAttribute("loginid"));
													if(ck){
													%>
                                                    		<i class="ico-heart-small" style="background-image: url(image/heart_1.png); background-size: cover;">${movieDTO.movieLike}</i>
                                                    <%}else{ %>	
															<i class="ico-heart-small">${movieDTO.movieLike}</i>
													<%} %>
                                                    <span class="txt">${movieDTO.movieTitle }</span>
                                                </button>
                                            </li>
                                            </c:forEach>
                                            
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="view-area">
                            <div class="choice-all" id="choiceMoiveNone" style="display: block;">
                                <strong>모든영화</strong>
                                <span>목록에서 영화를 선택하세요.</span>
                            </div>
                            <div class="choice-list-movie" id="choiceMovieList" style="display: none;">
                                <div class="bg-movie" id="bg-m1" style="margin-left: 0;">
                                </div>
                                <div class="bg-movie" id="bg-m2"></div>
                                <div class="bg-movie" id="bg-m3"></div>
                            </div>
                        </div>
                    </div>
                    <div class="theater-choice">
                        <div class="tit-area">
                            <p class="tit">극장</p>
                        </div>
                        <div class="list-area">
                            <div class="all-list">
                                <button type="button" class="btn-tab on-theater" id="movieAll">전체</button>
                                <button type="button" class="btn-tab off-theater"></button>
                                <div class="list">
                                    <div class="scroll">
                                        <ul>
                                            <li>
                                                <button type="button" class="btn-theater">서울</button>
                                                <div class="theater-list" style="display: none;">
                                                    <ul class="list-left">
                                                        <li>
                                                            <button type="button" class="detail-list">강남</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">강남대로(씨티)</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">강동</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">군자</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">동대문</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">마곡</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">목동</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">상봉</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">상암월드컵경기장</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">성수</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">센트럴</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">송파파크하비오</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">신촌</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">은평</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">이수</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">창동</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">코엑스</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">홍대</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">화곡</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">ARTNINE</button>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </li>
                                            <li>
                                                <button type="button" class="btn-theater">경기</button>
                                                <div class="theater-list" style="display: none;">
                                                    <ul class="list-left">
                                                        <li>
                                                            <button type="button" class="detail-list">고양스타필드</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">김포한강신도시</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">남양주</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">동탄</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">미사강변</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">백석</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">별내</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">부천스타필드시티</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">분당</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">수원</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">수원남문</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">시흥배곧</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">안산중앙</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">양주</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">영통</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">용인테크노밸리</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">의정부민락</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">일산</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">일산벨라시타</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">킨텍스</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">파주금촌</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">파주운정</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">파주출판도시</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">평택</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">하남스타필드</button>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </li>
                                            <li>
                                                <button type="button" class="btn-theater">인천</button>
                                                <div class="theater-list" style="display: none;">
                                                    <ul class="list-left">
                                                        <li>
                                                            <button type="button" class="detail-list">검단</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">송도</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">영종</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">인천논현</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">청라</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">청라지겔</button>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </li>
                                            <li>
                                                <button type="button" class="btn-theater">대전/충청/세종</button>
                                                <div class="theater-list" style="display: none;">
                                                    <ul class="list-left">
                                                        <li>
                                                            <button type="button" class="detail-list">공주</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">대전</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">대전유성</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">대전중앙로</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">세종(조치원)</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">세종나성</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">오창</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">제천</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">진천</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">천안</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">청주사창(구)</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">충주</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">홍성내포</button>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </li>
                                            <li>
                                                <button type="button" class="btn-theater">부산/대구/경상</button>
                                                <div class="theater-list" style="display: none;">
                                                    <ul class="list-left">
                                                        <li>
                                                            <button type="button" class="detail-list">거창</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">경북도청</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">경산하양</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">경주</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">구미강동</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">김천</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">남포항</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">대구(칠성로)</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">대구신세계(동대구)</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">대구이시아</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">덕천</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">마산</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">문경</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">부산극장</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">부산대</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">북대구(칠곡)</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">사천</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">삼천포</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">양산</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">양산라피에스타</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">울산</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">정관</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">창원</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">해운대(장산)</button>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </li>
                                            <li>
                                                <button type="button" class="btn-theater">광주/전라</button>
                                                <div class="theater-list" style="display: none;">
                                                    <ul class="list-left">
                                                        <li>
                                                            <button type="button" class="detail-list">광주상무</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">광주하남</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">남원</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">목포하당(포르모)</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">송천</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">순천</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">여수웅천</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">전대(광주)</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">첨단</button>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </li>
                                            <li>
                                                <button type="button" class="btn-theater">강원</button>
                                                <div class="theater-list" style="display: none;">
                                                    <ul class="list-left">
                                                        <li>
                                                            <button type="button" class="detail-list">남춘천</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">속초</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">원주</button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="detail-list">원주센트럴</button>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </li>
                                            <li>
                                                <button type="button" class="btn-theater">제주</button>
                                                <div class="theater-list" style="display: none;">
                                                    <ul class="list-left">
                                                        <li>
                                                            <button type="button" class="detail-list">제주</button>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="view-area">
                            <div class="choice-all" id="choiceBrchNone" style="display: block;">
                                <strong>전체극장</strong>
                                <span>목록에서 극장을 선택하세요.</span>
                            </div>
                            <div class="choice-list" id="choiceBrchList" style="display: none;">
                                <div class="bg" id="bg1"></div>
                                <div class="bg" id="bg2"></div>
                                <div class="bg" id="bg3"></div>
                            </div>
                        </div>
                    </div>
                    <div class="time-choice">
                        <div class="tit-area">
                            <p class="tit-time" style="clear: both;">시간</p>
                            <div class="right legend">
                                <i class="iconset ico-sun" title="조조"></i> 조조
                                <i class="iconset ico-brunch" title="브런치"></i> 브런치
                                <i class="iconset ico-moon" title="심야"></i> 심야
                            </div>
                        </div>
                        <div class="hour-schedule">
                            <button class="btn-prev-time"></button>
                            <div class="wrap">
                                <div class="view" style="position: absolute; width: 1015px; left: 0px;">
                                    <button type="button" class="hour">00</button>
                                    <button type="button" class="hour">01</button>
                                    <button type="button" class="hour">02</button>
                                    <button type="button" class="hour">03</button>
                                    <button type="button" class="hour">04</button>
                                    <button type="button" class="hour">05</button>
                                    <button type="button" class="hour">06</button>
                                    <button type="button" class="hour">07</button>
                                    <button type="button" class="hour">08</button>
                                    <button type="button" class="hour">09</button>
                                    <button type="button" class="hour">10</button>
                                    <button type="button" class="hour">11</button>
                                    <button type="button" class="hour">12</button>
                                    <button type="button" class="hour">13</button>
                                    <button type="button" class="hour">14</button>
                                    <button type="button" class="hour">15</button>
                                    <button type="button" class="hour">16</button>
                                    <button type="button" class="hour">17</button>
                                    <button type="button" class="hour">18</button>
                                    <button type="button" class="hour">19</button>
                                    <button type="button" class="hour">20</button>
                                    <button type="button" class="hour">21</button>
                                    <button type="button" class="hour">22</button>
                                    <button type="button" class="hour">23</button>
                                    <button type="button" class="hour">24</button>
                                    <button type="button" class="hour">25</button>
                                    <button type="button" class="hour">26</button>
                                    <button type="button" class="hour">27</button>
                                    <button type="button" class="hour">28</button>
                                </div>
                            </div>
                            <button class="btn-next-time"></button>
                        </div>
                        <div class="movie-schedule-area">
                            <div class="no-result" id="playScheduleNonList" style="display: block;">
                                <i class="iconset ico-movie-time"></i>
                                <p>영화와 극장을 선택하시면<br>상영시간표를 비교하여 볼 수 있습니다.</p>
                            </div>
                            <div class="result" style="display: none;">
                                <div class="scroll">
                                    <div class="mCSB_container">
                                        <ul>
                                        	<!-- 여기다 리스 트 추가 -->
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!--footer -->
    <footer id="footer" style="background-color: #F8F8FA ; width: 100%;">

        <div id="footer_sns" >
            <div class="container" style="position: relative; min-width:1100px; width: 1100px; margin: 0 auto; ">
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
            <div class="container" style="position: relative; min-width:1100px; width: 1100px; margin: 0 auto; ">
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
                                    <span>대표자명 김진선</span> 개인정보보호 조상연<br><span>사업자등록번호 211-86-59478</span> 통신판매업신고번호 제
                                    833호</p><br>
                                <p>Copyright 2014 by MegaboxJoongAng Inc. All right reserved</p>
                            </address>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

    </footer>
    <!-- //footer -->

</body>
</html>