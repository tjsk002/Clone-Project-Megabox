

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!DOCTYPE html>
<html lang="ko">
<!-- mega_movie 쿼리문  -->
<sql:setDataSource var="db" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://127.0.0.1:3306/project" user="root" password="1234" />
<sql:query dataSource="${db}" var="rs">  
	SELECT * from mega_movie;
</sql:query>
<!-- mega_member 쿼리문  -->

<sql:query dataSource="${db}" var="memberDb_rs">  
	SELECT mem_name FROM mega_member WHERE mem_id=?;  
	<sql:param value="${sessionScope.loginid}" />
</sql:query>


<!--  c tag로 수정했습니다. -->
<!-- 243줄 loginpopup 수정필요 -->

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>라이프시어터, 메가박스</title>
<link rel="stylesheet" href="css/main_style.css">
<link rel="stylesheet" href="css/main_js.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="js/mainpage.js"></script>
</head>
<body>
	<!-- //header -->
	<!-- 메인 페이지 -->
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
							<li><a href="#"><img src="image/menu_white.svg" alt="메뉴"
									class="menuBtn"><img
									src="image/btn-header-layer-close.png" class="menuClose"></a></li>
							<li><a href="#"><img src="image/search_white.svg"
									alt="검색" class="searchBtn"><img
									src="image/btn-header-layer-close.png" class="searchClose"></a></li>
							<li><a href="boxoffice.jsp"><img
									src="image/gnb-txt-movie-white.png" alt="영화" class="movieBtn"></a></li>
							<li><a href="booking.jsp"><img
									src="image/gnb-txt-reserve-white.png" alt="예매"
									class="reserveBtn"></a></li>
						</ul>
						<ul class="nav_middle">
							<li><a href="mainpage.jsp"><img
									src="image/logo_white.png" alt="메인로고"transparent 0% 0% no-repeatpadding-box;></a></li>
						</ul>
						<ul class="nav_right">
							<li><a href="#"><img src="image/ico-mymega.png"
									alt="마이메가박스" class="mymegaBtn"><img
									src="image/btn-header-layer-close.png" class="mymegaClose"></a></li>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</header>
	<!-- //header -->
	<section id="loginpopup">
		<div class="login_popup">
			<div class="layer-header">
				<h3 class="tit">로그인</h3>
				<img src="image/btn-layer-close.png" alt="닫기">
			</div>
			<div class="layer-con">

				<div class="login-con">
					<form method="post" action="login_ok.jsp">
						<input name="userid" id="ibxLogi
						nId" maxlength="20"
							type="text" placeholder="아이디" title="아이디를 입력하세요"
							class="input-text strTrim"> <input name="userpw"
							id="ibxLoginPwd" maxlength="20" type="password"
							placeholder="비밀번호" title="비밀번호를 입력하세요" class="input-text mt15">
						<div class="chk-util">
							<input id="chkIdSave" type="checkbox"> <label
								for="chkIdSave">아이디 저장</label>
						</div>
						<input type="submit" value="로그인" class="button purple confirm">
					</form>
					<div class="link">
						<a href="idfind.jsp" title="ID/PW 찾기 선택">ID/PW 찾기</a> <span>
							| </span> <a href="megaSign.jsp" title="회원가입 선택">회원가입</a>
					</div>
				</div>

				<div class="login-add">
					<a href="lastweek.jsp" alt="광고" target="_blank"> <img
						id="pageBannerRnbImage" src="image/next-end.jpg"></a>
				</div>
			</div>
		</div>
	</section>

	<!-- menu js-->
	<div class="menuBtn_sitemap">
		<div class="container">
			<h2 class="tit">SITEMAP</h2>
			<div class="sitemapMenuList">
				<div class="list position-1">
					<p class="tit-depth">영화</p>
					<ul class="list-depth">
						<li>
						<a href="boxoffice.jsp" title="전체영화">전체영화</a></li>
					</ul>
				</div>
				<div class="list position-2">
					<p class="tit-depth">예매</p>
					<ul class="list-depth">
						<li><a href="booking.jsp" title="빠른예매">빠른예매</a></li>
					</ul>
				</div>
				<div class="list position-3">
					<p class="tit-depth">나의 메가박스</p>
					<ul class="list-depth mymage">
						<li><a href="mypagemain.jsp" title="나의 메가박스 홈">나의 메가박스 홈</a></li>
						<li><a href="bookinglist.jsp" title="예매내역">예매/구매내역</a></li>
						<li><a href="userinfo.jsp" title="회원정보">회원정보</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<div class="searchBtn_sitemap" style="display: none;">
		<div class="container" style= "width:1000px; margin-left: 200px; align: center;">
			<div class="searchTitle"  style= "width:1000px; display: block; float: left;">
				<h2 class="tit">예매율 순</h2>
				<h2 class="tit">누적관객순</h2>
				<h2 class="tit">메가스코어순</h2>
			
			</div>
			<div class="sitemapsearchList">
				<div class="list position-1">
					<c:forEach var="movie" items="${rs.rows}" varStatus="status" begin="0" end="0">
						<c:set var="images" value="${movie.movie_img}" />
						<c:set var="poster" value="${fn:split(images,',')[0]} " />
						<img src="${fn:split(images,',')[0]}" alt="검색창포스터" style="width: 150px; height: 210px; display: block; float: left;">
					</c:forEach>
				</div>
				<div class="list position-2">
					<c:forEach var="movie" items="${rs.rows}" begin="0" end="4">
						<ul class="list-depth mymage" style="display: inline-block; width:200px">
							<c:set var="title" value="${movie.movie_title}" />
							<li><em> ${movie.movie_rank } </em> <a href="movie_detail.jsp?movietitle=${title }" style="color: #ffffff; padding-left:10px;"> ${movie.movie_title} </a></li>
						</ul></br>
					</c:forEach>
				</div>
				<div class="searchMovie" style="display: block; width: 360px; line-height: 50px; border-bottom: solid 1px #ffffff; margin-left: 150px; margin-top: 100px; padding-left: 0px; padding-top: 0px;">
					<input type="text" placeholder="영화를 검색하세요" title="영화 검색" class="input-text" style="display: block; float: left; width: 260px; height: 60px; font-size: 17px; color: #ffffff; background-color: transparent; border: 0; padding: 0px 20px">
					<input type="image" src="image/ico-search-white.png" class="input-img" style="display: block; float: right; line-height: 60px; margin: 0 auto; background-color: transparent; border: 0; padding: 20px;">
				</div>
			</div>
		</div>
	</div>
	

	<div class="mymegaBtn_sitemap1">
		<div class="container">
			<c:choose>
				<c:when test="${not empty sessionScope.loginid}">
					<div class="login-after">
						<c:forEach var="mega_member" items="${memberDb_rs.rows }">
							<p class="txt">
								안녕하세요!
								<c:out value="${mega_member.mem_name}" />
							회원님 <br> 마지막 접속일 : 0000년 00월 00일 00:00:00
							</p>
						</c:forEach>
						<div class="moveMymega">
							<a href="mypagemain.jsp">나의 메가박스</a>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="login-before">
						<p class="txt">
							로그인 하시면 나의 메가박스를 만날 수 있어요.<br> 영화를 사랑하는 당신을 위한 꼭 맞는 혜택까지 확인해
							보세요!
						</p>
						<div class="moveLogin">
							<a href="#" id="moveLogin" title="로그인" class="buttonLogin">로그인</a>
						</div>
						<div class="nonmember">
							<a href="megaSign.jsp" class="link" title="혹시 아직 회원이 아니신가요?">혹시
								아직 회원이 아니신가요?</a>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<!--// menu js-->

	<!--movie-->
	<section id="movie">
		<div class="container">
			<div class="row">
				<div class="movie">
					<div class="movie_title" id="movie_title">
						<ul>
							<li><a href="boxoffice.jsp">박스오피스순</a></li>
							<li><a href="#">누적관객순</a></li>
							<li><a href="#">메가스코어순</a></li>
						</ul>
					</div>

					<div class="movie_chart">
						<div class="container">
							<c:forEach var="movie" items="${rs.rows}" begin="0" end="3">
								<c:set var="images" value="${movie.movie_img}" />
								<c:set var="poster" value="${fn:split(images,',')[0]} " />
								<c:set var="title" value="${movie.movie_title}" />
								<!-- 영화 제목 -->
								<ol class="movie-group ${movie.movie_rank }" id="test">
									<a href="movie_detail.jsp?movietitle=${title }"></a>

									<div class="movieWapper" style="width:245px; height:410px; float:left; padding: 0 15px 10px 15px;">	
										<div class="movie-post" style="background-image: url('${poster}'); background-size:cover; border-radius: 10px; border:1px solid #474747; ">

									<p class="rank" style="font: Light Oblique s35px/42px Helvetica; font-size: 35px; color: white; position: absolute; padding: 20px; font-style: italic;"> ${movie.movie_rank }</p>

											<div class="movie-summ" style="line-height: 25px;">
												<div style="height: 300px; overflow: hidden;">${movie.movie_summary }</div>
											</div>
										</div>

										<div>
											<div class="this-title" style="display: none">${title },<%=session.getAttribute("loginid")%></div>
											<%
												//로그인 중
													if (session.getAttribute("loginid") != null) {
											%>
											<%-- <sql:query dataSource="${db}" var="like">  
												SELECT like_boolean from movie_like where like_title = '${movie.movie_title}' and like_member = '<%=session.getAttribute("loginid") %>';  
											</sql:query> --%>
											<button type="button" class="heart btn click"
												style="float: left; width: 37%;">
												<%-- 
												//<c:forEach var="idCheck" items="${like }">
												//<%if(session.getAttribute("loginid") == ${idCheck ) %> --%>
												<%
													//LikeDAO likeDAO = new LikeDAO();
															//boolean ck = likeDAO.selectMovieLike((String) pageContext.getAttribute("title"),
															//		(String) session.getAttribute("loginid"));
															//if (ck) {
												%>
												<%
												//<img id="heart" src="image/heart_1.png"
												//	style="float: left; margin: 10px 10px 0;"> <span class="like-number"
													//style="font-size: 18px; color: #838383; margin-right: 15px;">${movie.movie_like}</span>
												
													%>
													<%
													//} else {
												%>
												<%
												//<img id="heart" src="image/heart_.png"
												//style="float: left; margin: 10px 10px 0;"> <span class="like-number"
												//style="font-size: 18px; color: #838383; margin-right: 15px;">${movie.movie_like}</span>
												%>
												
												<%
													//}
												%>
												<%-- </c:forEach> --%>
											</button>
											<%
												//} else {//로그아웃
											%>
											
											<button type="button" class="heart btn"
												style="float: left; width: 37%;">
												<img id="heart" src="image/heart_.png"
													style="float: left; margin: 10px 10px 0;"> <span
													class="like-number"
													style="font-size: 18px; color: #838383; margin-right: 15px;">${movie.movie_like}</span>
											</button>
											<%
												}
											%>
											<button type="button" class="regist btn"
												style="float: right; width: 60%; line-height: 40px; background-color: #503396; color: #fff;">예매</button>
										</div>
									</div>
								</ol>
							</c:forEach>
						</div>
					</div>
					<div class="shortcut_search">
						<div class="searchMovie">
							<input type="text" placeholder="영화명을 입력해 주세요" title="영화 검색"
								class="input-text" id="movieName"> <input type="image"
								src="image/ico-search-white.png">
						</div>
						<div class="shortcut">
							<a href="boxoffice.jsp" title="박스오피스"><img
								src="image/ico-boxoffice-main.png"> 박스오피스</a>
						</div>
						<div class="shortcut">
							<a href="booking.jsp" title="빠른예매"><img
								src="image/ico-quick-reserve-main.png"> 빠른예매</a>
						</div>
					</div>

				</div>
			</div>
		</div>
	</section>
	<!-- //movie-->


	<!--footer -->
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
	<!-- //footer -->
</body>
</html>