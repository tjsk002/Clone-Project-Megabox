<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="movie_title" value="${param.movietitle }" />

<!-- movie info database -->
<sql:setDataSource var="db" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://127.0.0.1:3306/project" user="root" password="1234" />
<sql:query dataSource="${db}" var="rs">  
	SELECT * FROM mega_movie WHERE movie_title =?;  
	<sql:param value="${movie_title}" />
</sql:query>
<!-- review database 최신순으로  -->
<sql:setDataSource var="reviewDb" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://127.0.0.1:3306/project" user="root" password="1234"	/>
<sql:query dataSource="${reviewDb}" var="reviewRs">  
	SELECT * FROM  movie_review  WHERE review_title =? ORDER BY review_date DESC;  
	<sql:param value="${movie_title}" />
</sql:query>
<!-- review 중복 작성 방지  -->
<sql:query dataSource="${reviewDb}" var="wrote_review">  
	SELECT review_title FROM  movie_review  WHERE review_title =(?) AND review_id=(?);  
	<sql:param value="${movie_title}" />
	<sql:param value="${loginid}" />
</sql:query>
<c:out value="${wrote_review.rowCount }" />
<%-- <c:set var="check-wrote" value="${wrote_review.rowCount }"/> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>(${movie_title}) 주요정보 < 영화 | 라이프시터, 메가박스</title>
<link href="css/movie_detail.css" rel="stylesheet" type="text/css">
<link href="css/other_style.css" rel="stylesheet" type="text/css">
<link href="css/review.css" rel="stylesheet" type="text/css">
<script src="js/jquery-3.4.1.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="js/movie_detail.js"></script>
<style>
</style>
</head>
<body>
	<header id="header">
		<div class="container">
			<div class="row">
				<div class="header">
					<h5>
						<c:choose>
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
			<c:set var="movie_release" value="${movie.movie-release }" />
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
	<!--// movie-detail -->

	<div class="wrap-hidden">
		<div id="nav">
			<p>홈>영화>전체영화>박스오피스</p>
		</div>
		<div id="movie-detail">
			<p>${movie_title }</p>
			<div class="btn">
				<button type="button" id="likebtn2" class="likebtn2">
					<img id="heart" src="image/heart_.png"> <span
						title="보고싶어한 명수">0</span>
				</button>
				<button type="button" class="registBtn" value="예매">예매</button>
			</div>
		</div>
	</div>
	<div class="wrap-tab-list-on">
		<ul>
			<li style="border-bottom: 2px solid #6643B3;"><a
				href="movie_detail.jsp?movietitle=${movie_title }"
				style="color: #6643B3;">주요정보</a></li>
			<li><a href="movie_review.jsp?movietitle=${movie_title }">한줄평</a></li>
			<li><a href="movie_preview.jsp?movietitle=${movie_title }">예고편/스틸컷</a></li>
		</ul>
	</div>
	<div class="tab-wrap">
		<div class="tab-list">
			<div class="li"
				style="border: 2px solid #6643B3; border-bottom: 1px solid white;">
				<a href="movie_detail.jsp?movietitle=${movie_title }">주요정보</a>
			</div>
			<div class="li">
				<a href="movie_review.jsp?movietitle=${movie_title }">한줄평</a>
			</div>
			<div class="li">
				<a href="movie_preview.jsp?movietitle=${movie_title }">예고편/스틸컷</a>
			</div>
		</div>
	</div>
	<section class="content">
		<div class="summary" style="width: 1100px">
			<div class="summary-wrapper">
				<div id="txt">
					<p>${movie_summary }</p>
				</div>
				<div id="etc" class="etc"></div>
			</div>
			<button class="more-btn" type="button">더보기</button>
		</div>
		<div class="review">
			<p style="font-size: 26px;">${movie_title }에대한3,715개의이야기가있어요!</p>
			
			<ul class="review-util 1">
				<li>전체 |</li>
				<li><a href="#">기대평 999건 |</a></li>
				<li><a href="#">관람평 999건</a></li>
			</ul>
			<ul class="review-util two"
				style="position: absolute; top: 188px; right: 0;">
				<li><a href="#">최신순 |</a></li>
				<li><a href="#">공감순</a></li>
			</ul>

			<ul>
				<li class="write-review">
					<div class="storyArea">
						<div class="user-wrapper">
							<div class="user"></div>
							<p>
								<c:out value="${loginid }" />
							</p>
						</div>
						<div class="storyBox">
							<div class="wrap-WriteReview">
								<span class="default" style="font-size: 15px;">${movie_title }의
									어떤 점이 기대되세요? 기대되는 점을 한줄평으로 남겨주세요!</span> <a href="#"
									user-id="${loginid }" check_wrote="${wrote_review.rowCount }"
									class="writeBtn" style="font-size: 15px;"><img
									src="image/review@2x.png" width="18px"
									style="padding-right: 10px;">한줄평쓰기</a>
							</div>
						</div>
						<!-- action="ReviewDAO" -->
						<form name="review" method="post" accept-charset="utf-8"
							id="review_form">
							<input type="hidden" name="review_title" value="${movie_title }" />
							<input type="hidden" name="review_id" value="${loginid }" />
							<div class="write_popup_wrapper">
								<header class="layer-header">
									<p style="color: white; font-size: 22px;">관람평 작성하기</p>
									<button type="button" class="close"
										style="font-size: 22px; color: white; position: absolute; right: 24px; top: 13px; background-color: rgba(0, 0, 0, 0); border: none;">✕</button>
								</header>
								<div class="layer-content">

									<p
										style="padding: 0 20px; margin: 0; color: #353535; padding: 25px 0;">
										"
										<c:out value="${movie_title }" />
										"<br>관람평을 남겨보세요!
									</p>
								</div>

								<div class="popup_score-box">
									<div class="box-star" style="margin: 0 150px;">
										<span class="star star_left"><img src="image/odd.png"><span
											hidden id="score">1</span></span> <span class="star star_right"><img
											src="image/even.png"><span hidden id="score">2</span></span> <span
											class="star star_left"><img src="image/odd.png"><span
											hidden id="score">3</span></span> <span class="star star_right"><img
											src="image/even.png"><span hidden id="score">4</span></span> <span
											class="star star_left"><img src="image/odd.png"><span
											hidden id="score">5</span></span> <span class="star star_right"><img
											src="image/even.png"><span hidden id="score">6</span></span> <span
											class="star star_left"><img src="image/odd.png"><span
											hidden id="score">7</span></span> <span class="star star_right"><img
											src="image/even.png"><span hidden id="score">8</span></span> <span
											class="star star_left"><img src="image/odd.png"><span
											hidden id="score">9</span></span> <span class="star star_right"><img
											src="image/even.png"><span hidden id="score">10</span></span>
										<input type="hidden" class="review_score" name="review_score"
											style="border: none;" value="0"> <span
											id="score-count">0</span>점
									</div>

									<div class="text-area">
										<textarea id="text-area" name="review_text"
											style="color: #353535; border: solid 1px #AFAFB0; resize: none; font-size: 18px; border-bottom: none; outline: none;"
											placeholder="영화에 대한 후기를 남겨주세요" rows="5" cols="50"
											class="input-textarea"></textarea>
										<div class="count-util"
											style="font-size: 18px; margin-top: -5px;">
											<span id="text_count">0</span>/100
										</div>

									</div>

								</div>
								<div style="padding: 0 208px;" class="btn-wrapper">
									<button type="button" class="wcancel wbtn">취소</button>
									<button type="button" class="wregist wbtn">등록</button>
								</div>
							</div>
						</form>
				</li>
				<c:forEach var="review" items="${reviewRs.rows }" varStatus="status">
					<c:set var="review_id" value="${review.review_id }" />
					<c:set var="review_text" value="${review.review_text }" />
					<c:set var="review_score" value="${review.review_score }" />
					<c:set var="review_date" value="${review.review_date }" />
					<li class="ContentTag">
						<div class="storyArea">
							<div class="user-wrapper">
								<div class="user"></div>
								<p>
									<c:out value="${review_id}" />
								</p>
							</div>
							<div class="storyBox">
								<div class="tit">관람평</div>
								<div class="story-point">${review_score}</div>
								<div class="reviewBox">${review_text }</div>
								<div class="story-like">
									<button type="button" class="LikeBtn">
										<img src="image/good@2x.png"> <span>
											<p>0</p>
										</span>
									</button>
								</div>
								<div class="story-util">
									<div class="circle-wrap">
										<div class="circle"></div>
										<div class="circle"></div>
										<div class="circle"></div>
									</div>
										<!-- 수적, 삭제  -->
									<div class="story-util-wrapper" title="수정,삭제">
										<div class="writer">
											<a href="#" title="수정" class="btn-modal-open updateOne"
											w-data="500" h-data="680" data-score="${review_score }"
											data-id="${review_id }" data-title="${movie_title }"
											data-text="${review_text }">수정 <i
											class="iconset ico-arr-right-green"></i>
											</a>
											<button type="button" class="deleteOne"
											data-id="${review_id }" data-title="${movie_title }"
											data-cd="PREV">
											삭제 <i class="iconset ico-arr-right-green"></i>
											</button>
										</div>
										<div class="btn-close">
											<a href="#" title="닫기"><img
											src="/static/pc/images/common/btn/btn-balloon-close.png"
											alt="닫기"></a>
										</div>
									</div>
									<!-- 신고 -->
									<div class="story-report-wrapper" title="수정,삭제">
										<div class="btn-close">
											<a href="#" title="닫기"><img
											src="/static/pc/images/common/btn/btn-balloon-close.png"
											alt="닫기"></a>
										</div>
										<p>신고하시겠습니까?</p>
									</div>
								</div>
								<script>
									/*아이디 일치함에 따라 관람평 수정,삭제 또는 신고*/
									$(function(){
										$(".story-util").click(function(){
											var loginid="<%=session.getAttribute("loginid")%>";
											var review_id=$(this).children(".story-util-wrapper").children(".writer").children("button").attr("data-id");
											if(loginid==="null"){
												console.log("loginid?: "+loginid);
												alert("로그인을 해주세요");
												return false;
											}
											if(loginid===review_id){
												 $(this).children(".story-util-wrapper").show();
											}else{
												$(this).children(".story-report-wrapper").show();
												return false;
											}
											/* 닫기 */
											$(this).children(".story-util-wrapper").children(".btn-close").click(function(){
												console.log("닫기");
												 $(this).children(".story-util-wrapper").hide();
											})
										});
									})
								</script>
								
									
							</div>
						</div>
						<div class="wrote-date">${review_date }</div>
					</li>
				</c:forEach>
			</ul>
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
										김진선</span> 개인정보보호 조상연<br> <span>사업자등록번호 211-86-59478</span>
									통신판매업신고번호 제 833호
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
