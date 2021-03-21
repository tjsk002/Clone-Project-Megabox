<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="java.sql.*"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="movie_title" value="${param.movietitle }" />
<sql:setDataSource var="db" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://127.0.0.1:3306/project" user="root"
	password="1234" />
<sql:query dataSource="${db}" var="rs">  
	SELECT * FROM mega_movie WHERE movie_title =?;  
	<sql:param value="${movie_title}" />
</sql:query>

<!--  211~ 수정필요  -->

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Document</title>
<link rel="stylesheet" href="css/movie_detail.css">
<link rel="stylesheet" href="css/movie_preview.css">
<link rel="stylesheet" href="css/other_style.css">
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/movie_detail.js"></script>

</head>

<body>

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
							<li><a href="#"><img src="image/ico-sitemap_b.png"
									alt="메뉴"></a></li>
							<li><a href="#"><img src="image/ico-search_b.png"
									alt="검색"></a></li>
							<li><a href="boxoffice.jsp"><img
									src="image/gnb-txt-movie.png"></a></li>
							<li><a href="booking.jsp"><img
									src="image/gnb-txt-reserve.png"></a></li>
						</ul>
						<ul class="nav_middle">
							<li><a href="mainpage.jsp"><img src="image/logo.png"
									alt="메인로고"transparent 0% 0% no-repeatpadding-box;></a></li>
						</ul>
						<ul class="nav_right">
							<li><a href="mypagemain.jsp"><img
									src="image/ico-mymega_b.png" alt="마이메가박스"></a></li>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</header>
	
	
		<div class="movie-detail-page">
		<c:forEach var="movie" items="${rs.rows}" varStatus="status">
			<c:set var="movie_age" value="${movie.movie_age}" />
			<c:set var="movie_num" value="${movie.movie_num}" />
			<c:set var="movie_type" value="${movie.movie_type} " />
			<c:set var="movie_genre" value="${movie.movie_genre}" />
			<c:set var="movie_director" value="${movie.movie_director}" />
			<c:set var="movie_actors" value="${movie.movie_actors} " />
			<c:set var="movie_img" value="${movie.movie_img}" />
			<c:set var="movie_rank" value="${movie.movie_rank}" />
			<c:set var="movie_score" value="${movie.movie_score} " />
			<c:set var="movie_reser" value="${movie.movie_reser}" />
			<c:set var="movie_poster" value="${fn:split(movie_img,',')[0]}" />
			<c:set var="movie_summary" value="${movie.movie_summary }" />
			<c:set var="movie_release" value="${movie.movie_release }" />
			<c:set var="movie_video" value="${movie.movie_video }"/>
			<section class="movie">
				<div class="bg-img"></div>
				<div class="bg-pattern"></div>
				<div class="bg-mask"></div>

				<!-- movie-detail-cont -->
				<div class="movie-detail-cont">

					<!-- 개봉 예매가능-->
					<p class="title"><c:out value="${movie_title}"/></p>
					<div class="btn-util">
						<button type="button" title="보고싶어 안함" class="btn btn-like"
							rpst-movie-no="20003900">
							<i class="iconset ico-heart-line"></i> <span title="보고싶어 한 명수"
								id="intrstCnt"> 424 </span>
						</button>

					</div>

					<!-- info -->
					<div class="info">
						<div class="score">
							<p class="tit">실관람 평점</p>
							<div class="number gt" id="mainMegaScore">
								<!--  <div class="number gt" id="mainMegaScore">
					<p title="관람 전 점수" class="before"><em>9.6</em><span class="ir">점</span></p>
					<p title="관람 후 점수" class="after"><em>0</em><span class="ir">점</span></p> -->
								<p title="실관람 평점" class="before">
									<em>${movie_score }</em><span class="ir"></span>
								</p>
							</div>
						</div>

						<div class="rate">
							<p class="tit">예매율</p>
							<p class="cont">
								<em>${movie_rank }</em>위 (0&#37;)
							</p>
						</div>

						<div class="audience ">
							<div class="tit ">
								<span class="m-tooltip-wrap ">누적관객수
									<em class="m-tooltip ml05"> <i
										class="iconset ico-tooltip-gray">툴팁보기</i>
										<div class="m-detail-tooltip">
											<div class="bg-arr bottom"></div>
											<div class="cont-area"></div>
										</div>
								</em>
								</span>
							</div>
							<p class="cont">
								<em>${movie_num}</em> 명
							</p>
						</div>

					</div>
					<!--// info -->

					<div class="poster">
						<div class="wrap">

							<p class="movie-grade age-all">전체 관람가</p>

							<img
								src="${movie_poster }"
								onerror="noImg(this)" /> <a href="#"
								class="btn-poster-down" title="포스터 다운로드" data-no="1015925"
								data-sn="1">포스터 다운로드</a>
						</div>
					</div>

					<div class="reserve screen-type col-2">
						<div class="reserve">
							<a href="javascript:fn_bookingForm('20003900','basic');"
								class="btn reserve" title="영화 예매하기">예매</a>
						</div>
					</div>
				</div>
				<!--// movie-detail-cont -->
			</section>
		</c:forEach>
	</div>
	
	
	
	
	
	
	<div class="wrap-hidden">
		<div id="nav">
			<p>홈>영화>전체영화>박스오피스</p>
		</div>
		<div id="movie-detail">
			<p>${movie_title }</p>
			<div class="btn">
				
				<button type="button" value="heart" id="likebtn2">
					<img id="heart" src="image/heart_.png">
					<span title="보고싶어한 명수">0</span>
				</button>
				<button type="button" class="registBtn" value="예매">예매</button>
			</div>
		</div>
	</div>
	<div class="wrap-tab-list-on">
		<ul>
			<li><a href="movie_detail.jsp?movietitle=${movie_title }">주요정보</a></li>
			<li><a href="movie_review.jsp?movietitle=${movie_title }">한줄평</a></li>
			<li style="border-bottom: 2px solid #6643B3;"><a
				href="movie_preview.jsp?movietitle=${movie_title }"
				style="color: #6643B3;">예고편/스틸컷</a></li>
		</ul>
	</div>
	<div class="tab-wrap">
		<div class="tab-list">
			<div class="li">
				<a href="movie_detail.jsp?movietitle=${movie_title }">주요정보</a>
			</div>
			<div class="li">
				<a href="movie_review.jsp?movietitle=${movie_title }">한줄평</a>
			</div>
			<div class="li"
				style="border: 2px solid #6643B3; border-bottom: 1px solid white;">
				<a href="movie_preview.jsp?movietitle=${movie_title }">예고편/스틸컷</a>
			</div>
		</div>
	</div>

	<section class="content">

		<div class="movie-list-util mt40">
			<div class="">예고편() | 스틸컷()</div>

		</div>

		<div class="stillcut-slide" style="display: inline-block;">
			<div class="subject-wrap"
				style="border-bottom: 1px solid; padding: 10px;">
				<p style="font-size: 22px;">메인예고편</p>
			</div>
			<div class="top-container">
			<!-- 	<div class="left arrow">
					<p>이전영상</p>
				</div> -->
				<video id="videoTag" src="${movie_video }" controls></video>
				<!-- <div class="right arrow">
					<p>다음영상</p>
				</div> -->
			</div>
			<!-- <div class="thums-wrap">
				<img class="thumbs-img-button"> <img class="thumbs-img-button">
				<img class="thumbs-img-button"> <img class="thumbs-img-button">
			</div> -->
		</div>

		<div class="stair-slide">
			<h2 class="tit small">
				<c:set var="imgArray" value="${fn:split(movie_img,',') }"/>
			
				"<c:out value="${movie_title }"/>"에 대한 <c:out value="${fn:length(imgArray)}"/> 개의 스틸컷이 있어요!"
			</h2>
			
			<div class="stair-slide-list">
			</div>
			<c:forEach var="img" items="${imgArray}">
				<img class="thum big" src="${img }"/>
			</c:forEach>
		</div>
	
	</section>

	<footer id="footer">
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
							<h2>
								<img src="image/logo_gray.png" alt="megabox">
							</h2>
						</ul>
						<ul class="address">
							<address>
								<p>
									서울특별시 성동구 왕십리로 50, 6층(성수동 1가, 메가박스스퀘어) ARS 1544-0070<br> <span>대표자명
										김진선</span> 개인정보보호 조상연<br>
									<span>사업자등록번호 211-86-59478</span> 통신판매업신고번호 제 833호
								</p>
								<br>
								<p>Copyright 2014 by MegaboxJoongAng Inc. All right reserved</p>
							</address>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</footer>

</body>

</html>