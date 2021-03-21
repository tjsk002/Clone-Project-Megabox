<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=yes" />
<link rel="shortcut icon" />
<title>빠른예매 &lt; 예매 | 라이프씨어터, 메가박스</title>


<link rel="stylesheet" href="css/quick-reserve.css">
<link rel="stylesheet" href="css/other_style.css">
<link href="https://fonts.googleapis.com/css?family=Roboto&display=swap"
	rel="stylesheet">
<script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/quick-reserve.js?ver=22"></script>
    <!-- <script src="js/quick-reserve_.js"></script> -->
</head>
<sql:setDataSource var="db" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://127.0.0.1:3306/project" user="root"
	password="1234" />
<sql:query dataSource="${db}" var="rs">  
	SELECT time_title, time_start, time_finish, time_theater, time_sinema, time_category FROM movie_time where time_idx = ?;
	<sql:param value="${param.ck}"/>
</sql:query>
<c:forEach var="movie" items="${rs.rows}" varStatus="status">
			<c:set var="title" value="${movie.time_title}" />
			<c:set var="start" value="${movie.time_start}" />
			<c:set var="finish" value="${movie.time_finish} " />
			<c:set var="theater" value="${movie.time_theater}" />
			<c:set var="cinema" value="${movie.time_sinema}" />
			<c:set var="category" value="${movie.time_category} " />
</c:forEach>
<sql:query dataSource="${db}" var="rs2">  
	SELECT movie_img, movie_age, movie_release FROM mega_movie where movie_title=?;
	<sql:param value="${title}"/>
</sql:query>
<c:forEach var="movie" items="${rs2.rows}" varStatus="status">
			<c:set var="movieIMG" value="${fn:split(movie.movie_img, ',')[0]}" />
			<c:set var="age" value="${movie.movie_age}" />
			<c:set var="release" value="${movie.movie_release} " />
</c:forEach>
<%-- <sql:query dataSource="${db}" var="rs3">  
	SELECT ticket_seat FROM mega_ticket where ticket_movieTime=?;
	<sql:param value="${param.ck}"/>
</sql:query> --%>

<body>
<div style="display : none;" id="nextParam">${param.ck}</div>
<div style="display : none;" id="userid"><%=session.getAttribute("loginid") %></div>
    <header id="header">
		<div class="container" style="position: relative; width: 1100px; margin: 0 auto;">
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
									alt="메뉴" class="menuBtn"><img
									src="image/btn-header-layer-close.png" class="menuClose"
									style="display: none; position: absolute; float: left; top: 43px; left: 47px; z-index: 1;"></a></li>
							<li><a href="#"><img src="image/ico-search_b.png"
									alt="검색" class="searchBtn"><img
									src="image/btn-header-layer-close.png" class="searchClose"
									style="display: none; position: absolute; float: left; top: 43px; left: 150px; z-index: 1;"></a></li>
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

	<div class="page-util" style="">
		<div class="cont">
			<div class="inner-wrap">
				<div class="location">
					<span>Home</span> <a href="/booking" title="예매 페이지로 이동">예매</a> <a
						href="/booking" title="빠른예매 페이지로 이동">빠른예매</a>
				</div>

			</div>
		</div>
	</div>

	<div class="body-iframe">
		<div class="container">
			<input type="hidden" id="playSchdlNo" name="playSchdlNo"
				value="2003301372070"> <input type="hidden" id="brchNo"
				name="brchNo" value="1372">
			<section id="layer_age_alert" class="modal-layer"
				style="z-index: 900">
				<a href="" class="focus">레이어로 포커스 이동 됨</a>


				<!-- 팝업-->

				<div class="wrap"
					style="width: 500px; height: 350px; margin-left: -250px; margin-top: 0px; top: 140px;">
					<header class="layer-header">
						<h3 class="tit">알림</h3>
					</header>
					<div class="layer-con">
						<div class="alert-age-layer age12">
							<div class="age-box age-12">
								<div class="left">
									<p class="circle">12</p>
								</div>


								<div class="right">
									<p class="tit">12세이상관람가</p>
									<p class="txt">
									<p>
										[12세 이상 관람가]<br> <br>만 12 세 미만의 고객님은(영,유아 포함) 반드시
										부모님 또는<br> 성인 보호자의 동반하에 관람이 가능합니다.<br>연령 확인 불가 시 입장이
										제한될 수 있습니다.
									</p>
									</p>
								</div>


							</div>
						</div>
					</div>
					<div class="btn-group-fixed">
						<button type="button" class="button purple close-layer">확인</button>
					</div>
					<button type="button" class="btn-modal-close">레이어 닫기</button>
				</div>
				<!-- 팝업-->



				<!--팝업-->
				<div class="wrap">
					<header class="layer-header">
						<h3 class="tit">알림</h3>
					</header>
					<div class="layer-con" style="height: 200px;">
						<p class="txt-common">관람하실 인원을 먼저 선택해주세요.</p>
						<div class="btn-group">
							<button type="button" class="button lyclose"
								style="display: none;"></button>
							<button type="button" class="button purple confirm">확인</button>
						</div>
					</div>
					<button type="button" class="btn-layer-close">레이어 닫기</button>
				</div>
				<!--팝업-->
			</section>


			<div class="inner-wrap"
				style="padding-top: 40px; padding-bottom: 100px;">
				<div class="quick-reserve">
					<h2 class="tit">빠른예매</h2>
					<!-- cti 일때만 출력 -->

					<!-- cti 일때만 출력 -->
					<div class="cti-area" style="display: none">
						<p>이름</p>
						<input maxlength="20" name="riaName" type="text" title="이름 출력"
							class="input-text a-c w120px" placeholder="이름" value="">

						<p>생년월일</p>
						<input maxlength="8" name="riaBirthday" type="text"
							title="생년월일 출력" class="input-text a-c w150px"
							placeholder="6자리 또는 8자리" value="">

            <div class="inner-wrap" style="padding-top:40px; padding-bottom:100px;">
                <div class="quick-reserve">
                    <h2 class="tit">빠른예매</h2>
                    <!-- cti 일때만 출력 -->

                    <!-- cti 일때만 출력 -->
                    <div class="cti-area" style="display:none">
                        <p>이름</p>
                        <input maxlength="20" name="riaName" type="text" title="이름 출력" class="input-text a-c w120px"
                            placeholder="이름" value="">

                        <p>생년월일</p>
                        <input maxlength="8" name="riaBirthday" type="text" title="생년월일 출력"
                            class="input-text a-c w150px" placeholder="6자리 또는 8자리" value="">

                        <p>휴대폰번호</p>
                        <input maxlength="11" name="riaMobileNo" type="text" title="휴대폰번호 출력"
                            class="input-text a-c w150px" placeholder="- 없이 입력" value="">

                        <p>회원</p>
                        <input name="riaMemberYn" type="text" title="회원여부 출력" class="input-text a-c w100px" value=""
                            readyonly="readyonly">


                        <button type="button" class="button gray ml10" login-at="N"></button>

                    </div>
                    <div class="seat-select-section">
                        <div class="seat-section">
                            <div class="tit-util">
                                <h3 class="tit small"> 관람인원선택<span class="sub">(최대 8매 선택가능)</span>
                                </h3>
                                <div class="right">
                                    <!-- input button type="reset" -->
                                    <button type="button" class="button gray-line small" id="seatMemberCntInit">
                                        <i class="iconset ico-reset-small"></i>초기화</button>
                                </div>
                            </div>
                            <div class="seat-area">
                                <div class="seat-count" style="min-height: 52px">







                                    <div class="cell">
                                        <p class="txt">성인</p>
                                        <div class="count">
                                            <button type="button" id="adult" class="down" title="성인 좌석 선택 감소">-</button>
                                            <div class="number">
                                                <button class="now adult" title="성인 현재 좌석 선택 수"
                                                    ticketgrpcd="TKA">0</button>
                                            </div>
                                            <button type="button" id="adult" class="up" title="성인 좌석 선택 증가">+</button>
                                        </div>
                                    </div>



                                    <div class="cell">
                                        <p class="txt">청소년</p>
                                        <div class="count">
                                            <button type="button" id="children" class="down"
                                                title="청소년 좌석 선택 감소">-</button>
                                            <div class="number">
                                                <button type="button" class="now children" title="청소년 현재 좌석 선택 수"
                                                    ticketgrpcd="TKY">0</button>
                                            </div>
                                            <button type="button" id="children" class="up"
                                                title="청소년 좌석 선택 증가">+</button>
                                        </div>
                                    </div>



                                    <div class="cell">
                                        <p class="txt">우대</p>
                                        <div class="count"><button type="button" id="disabled" class="down"
                                                title="우대 좌석 선택 감소">-</button>
                                            <div class="number"><button type="button" class="now disabled"
                                                    title="우대 현재 좌석 선택 수" ticketgrpcd="TKS">0</button>

                                            </div><button type="button" id="disabled" class="up"
                                                title="우대 좌석 선택 증가">+</button>
                                        </div>
                                    </div>







                                </div>

                                <div class="seat-layout">
                                    <div class="alert" style="display: none;"></div>
                                    <div class="seat-count-before" style="top: 0px">관람인원을 선택하십시요</div>
                    
                                    <div class="scroll m-scroll mCustomScrollbar _mCS_1 mCS_no_scrollbar">
                                        <div id="mCSB_1" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
                                            style="max-height: none;" tabindex="0">
                                            <div id="mCSB_1_container" class="mCSB_container mCS_no_scrollbar_y"
                                                style="position: relative; top: 0px; left: 0px; height: 350px;"
                                                dir="ltr">
                                                <div id="seatLayout" style="width: 100%; height: 350px;">

                                                    <!--                                            스크린 이미지-->
                                                    <img src="image/img-theater-screen.png" alt="screen"
                                                        style="position: absolute; left: 62px; top: 10px;"
                                                        class="mCS_img_loaded">
                                                    <%--     
													<c:forEach var="seatNum" items="${rs3.rows}" varStatus="status">
													<c:set var="seatCK" value="${seatNum.ticket_seat}" />
													</c:forEach> --%>
                                                    <div class'row'="">
                                                        <button type="button" class="btn-seat-row" title="A 행"
                                                            style="position:absolute; left:106px; top:52px;">A</button>
                                                        <button type="button" title="A2 (스탠다드/장애인석)"
                                                            class="jq-tooltip seat-condition standard disabled"
                                                            style="position:absolute; left:171px; top:50px; width:20px;"
                                                            rownm="A" seatno="2" seatchoidircval="1" seatchoigrpno="1"
                                                            seatchoigrpnm="A1" seatchoirowcnt="3" seatchoigrpseq="1"
                                                            seattocnt="1"
                                                            seatnotimsg="해당좌석은 장애인 전용 좌석으로 일반고객은 다른 좌석을 선택하여  주시기 바랍니다.">
                                                            <span class="num">2</span>
                                                            <span class="kind">스탠다드</span>
                                                            <span class="condition">판매가능</span>
                                                            <span class="rank">장애인석</span></button>

                                                        <button type="button" title="A3 (스탠다드/장애인석)"
                                                            class="jq-tooltip seat-condition standard disabled"
                                                            style="position:absolute; left:191px; top:50px; width:20px;"
                                                            rownm="A" seatno="3" seatchoidircval="1" seatchoigrpno="1"
                                                            seatchoigrpnm="A1" seatchoirowcnt="3" seatchoigrpseq="2"
                                                            seattocnt="1"
                                                            seatnotimsg="해당좌석은 장애인 전용 좌석으로 일반고객은 다른 좌석을 선택하여  주시기 바랍니다.">
                                                            <span class="num">3</span><span
                                                                class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span>
                                                            <span class="rank">장애인석</span></button>

                                                        <button type="button" title="A4 (스탠다드/장애인석)"
                                                            class="jq-tooltip seat-condition standard disabled"
                                                            style="position:absolute; left:211px; top:50px; width:20px;"
                                                            seatclasscd="DISABLED_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00100401" rownm="A" seatno="4"
                                                            seatchoidircval="1" seatchoigrpno="1" seatchoigrpnm="A1"
                                                            seatchoirowcnt="3" seatchoigrpseq="3" seattocnt="1"
                                                            seatnotimsg="해당좌석은 장애인 전용 좌석으로 일반고객은 다른 좌석을 선택하여  주시기 바랍니다."><span
                                                                class="num">4</span>
                                                            <span class="kind">스탠다드</span>
                                                            <span class="condition">판매가능</span>
                                                            <span class="rank">장애인석</span>
                                                        </button><button type="button" title="A5 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:231px; top:50px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00100501" rownm="A" seatno="5"
                                                            seatchoidircval="1" seatchoigrpno="2" seatchoigrpnm="A2"
                                                            seatchoirowcnt="2" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">5</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="A6 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:251px; top:50px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00100601" rownm="A" seatno="6"
                                                            seatchoidircval="1" seatchoigrpno="2" seatchoigrpnm="A2"
                                                            seatchoirowcnt="2" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">6</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="A9 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:331px; top:50px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00101001" rownm="A" seatno="9"
                                                            seatchoidircval="0" seatchoigrpno="3" seatchoigrpnm="A3"
                                                            seatchoirowcnt="8" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">9</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="A10 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:351px; top:50px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00101101" rownm="A" seatno="10"
                                                            seatchoidircval="0" seatchoigrpno="3" seatchoigrpnm="A3"
                                                            seatchoirowcnt="8" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">10</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="A11 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:371px; top:50px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00101201" rownm="A" seatno="11"
                                                            seatchoidircval="0" seatchoigrpno="3" seatchoigrpnm="A3"
                                                            seatchoirowcnt="8" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">11</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="A12 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:391px; top:50px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00101301" rownm="A" seatno="12"
                                                            seatchoidircval="0" seatchoigrpno="3" seatchoigrpnm="A3"
                                                            seatchoirowcnt="8" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">12</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="A13 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:411px; top:50px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00101401" rownm="A" seatno="13"
                                                            seatchoidircval="0" seatchoigrpno="3" seatchoigrpnm="A3"
                                                            seatchoirowcnt="8" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">13</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="A14 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:431px; top:50px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00101501" rownm="A" seatno="14"
                                                            seatchoidircval="0" seatchoigrpno="3" seatchoigrpnm="A3"
                                                            seatchoirowcnt="8" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">14</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="A15 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:451px; top:50px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00101601" rownm="A" seatno="15"
                                                            seatchoidircval="0" seatchoigrpno="3" seatchoigrpnm="A3"
                                                            seatchoirowcnt="8" seatchoigrpseq="7" seattocnt="1"><span
                                                                class="num">15</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="A16 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:471px; top:50px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00101701" rownm="A" seatno="16"
                                                            seatchoidircval="0" seatchoigrpno="3" seatchoigrpnm="A3"
                                                            seatchoirowcnt="8" seatchoigrpseq="8" seattocnt="1"><span
                                                                class="num">16</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button>



                                                        <button type="button" title="A17 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:511px; top:50px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00101901" rownm="A" seatno="17"
                                                            seatchoidircval="0" seatchoigrpno="4" seatchoigrpnm="A4"
                                                            seatchoirowcnt="5" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">17</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span>
                                                        </button>


                                                        <button type="button" title="A18 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:531px; top:50px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00102001" rownm="A" seatno="18"
                                                            seatchoidircval="0" seatchoigrpno="4" seatchoigrpnm="A4"
                                                            seatchoirowcnt="5" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">18</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="A19 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:551px; top:50px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00102101" rownm="A" seatno="19"
                                                            seatchoidircval="0" seatchoigrpno="4" seatchoigrpnm="A4"
                                                            seatchoirowcnt="5" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">19</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="A20 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:571px; top:50px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00102201" rownm="A" seatno="20"
                                                            seatchoidircval="0" seatchoigrpno="4" seatchoigrpnm="A4"
                                                            seatchoirowcnt="5" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">20</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="A21 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:591px; top:50px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00102301" rownm="A" seatno="21"
                                                            seatchoidircval="0" seatchoigrpno="4" seatchoigrpnm="A4"
                                                            seatchoirowcnt="5" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">21</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button> <button type="button"
                                                            class="btn-seat-row" title="B 행"
                                                            style="position:absolute; left:106px; top:72px;">B</button><button
                                                            type="button" title="B1 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:151px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00200101" rownm="B" seatno="1"
                                                            seatchoidircval="1" seatchoigrpno="5" seatchoigrpnm="B5"
                                                            seatchoirowcnt="6" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">1</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B2 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:171px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00200201" rownm="B" seatno="2"
                                                            seatchoidircval="1" seatchoigrpno="5" seatchoigrpnm="B5"
                                                            seatchoirowcnt="6" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">2</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B3 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:191px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00200301" rownm="B" seatno="3"
                                                            seatchoidircval="1" seatchoigrpno="5" seatchoigrpnm="B5"
                                                            seatchoirowcnt="6" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">3</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B4 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:211px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00200401" rownm="B" seatno="4"
                                                            seatchoidircval="1" seatchoigrpno="5" seatchoigrpnm="B5"
                                                            seatchoirowcnt="6" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">4</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B5 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:231px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00200501" rownm="B" seatno="5"
                                                            seatchoidircval="1" seatchoigrpno="5" seatchoigrpnm="B5"
                                                            seatchoirowcnt="6" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">5</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B6 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:251px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00200601" rownm="B" seatno="6"
                                                            seatchoidircval="1" seatchoigrpno="5" seatchoigrpnm="B5"
                                                            seatchoirowcnt="6" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">6</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B9 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:331px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00201001" rownm="B" seatno="9"
                                                            seatchoidircval="0" seatchoigrpno="6" seatchoigrpnm="B6"
                                                            seatchoirowcnt="8" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">9</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B10(스탠다드/선택됨)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:351px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00201101" rownm="B" seatno="10"
                                                            seatchoidircval="0" seatchoigrpno="6" seatchoigrpnm="B6"
                                                            seatchoirowcnt="8" seatchoigrpseq="2" seattocnt="1"
                                                           ><span class="num">10</span><span
                                                                class="kind">스탠다드</span><span
                                                                class="condition">선택됨</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B11(스탠다드/선택됨)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:371px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00201201" rownm="B" seatno="11"
                                                            seatchoidircval="0" seatchoigrpno="6" seatchoigrpnm="B6"
                                                            seatchoirowcnt="8" seatchoigrpseq="3" seattocnt="1"
                                                            seatnextuniqno="00201301"><span
                                                                class="num">11</span><span class="kind">스탠다드</span><span
                                                                class="condition">선택됨</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B12(스탠다드/선택됨)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:391px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00201301" rownm="B" seatno="12"
                                                            seatchoidircval="0" seatchoigrpno="6" seatchoigrpnm="B6"
                                                            seatchoirowcnt="8" seatchoigrpseq="4" seattocnt="1"
                                                            seatnextuniqno="00201201"><span
                                                                class="num">12</span><span class="kind">스탠다드</span><span
                                                                class="condition">선택됨</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B13(스탠다드/선택됨)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:411px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00201401" rownm="B" seatno="13"
                                                            seatchoidircval="0" seatchoigrpno="6" seatchoigrpnm="B6"
                                                            seatchoirowcnt="8" seatchoigrpseq="5" seattocnt="1"
                                                            seatnextuniqno="00201501"><span
                                                                class="num">13</span><span class="kind">스탠다드</span><span
                                                                class="condition">선택됨</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B14(스탠다드/선택됨)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:431px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00201501" rownm="B" seatno="14"
                                                            seatchoidircval="0" seatchoigrpno="6" seatchoigrpnm="B6"
                                                            seatchoirowcnt="8" seatchoigrpseq="6" seattocnt="1"
                                                            seatnextuniqno="00201401"><span
                                                                class="num">14</span><span class="kind">스탠다드</span><span
                                                                class="condition">선택됨</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B15 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:451px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00201601" rownm="B" seatno="15"
                                                            seatchoidircval="0" seatchoigrpno="6" seatchoigrpnm="B6"
                                                            seatchoirowcnt="8" seatchoigrpseq="7" seattocnt="1"><span
                                                                class="num">15</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B16 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:471px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00201701" rownm="B" seatno="16"
                                                            seatchoidircval="0" seatchoigrpno="6" seatchoigrpnm="B6"
                                                            seatchoirowcnt="8" seatchoigrpseq="8" seattocnt="1"><span
                                                                class="num">16</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B17 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:511px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00201901" rownm="B" seatno="17"
                                                            seatchoidircval="0" seatchoigrpno="7" seatchoigrpnm="B7"
                                                            seatchoirowcnt="6" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">17</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B18 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:531px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00202001" rownm="B" seatno="18"
                                                            seatchoidircval="0" seatchoigrpno="7" seatchoigrpnm="B7"
                                                            seatchoirowcnt="6" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">18</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B19 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:551px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00202101" rownm="B" seatno="19"
                                                            seatchoidircval="0" seatchoigrpno="7" seatchoigrpnm="B7"
                                                            seatchoirowcnt="6" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">19</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B20 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:571px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00202201" rownm="B" seatno="20"
                                                            seatchoidircval="0" seatchoigrpno="7" seatchoigrpnm="B7"
                                                            seatchoirowcnt="6" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">20</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B21 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:591px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00202301" rownm="B" seatno="21"
                                                            seatchoidircval="0" seatchoigrpno="7" seatchoigrpnm="B7"
                                                            seatchoirowcnt="6" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">21</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="B22 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:611px; top:70px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00202401" rownm="B" seatno="22"
                                                            seatchoidircval="0" seatchoigrpno="7" seatchoigrpnm="B7"
                                                            seatchoirowcnt="6" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">22</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button> <button type="button"
                                                            class="btn-seat-row" title="C 행"
                                                            style="position:absolute; left:106px; top:92px;">C</button><button
                                                            type="button" title="C1 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:151px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00300101" rownm="C" seatno="1"
                                                            seatchoidircval="1" seatchoigrpno="8" seatchoigrpnm="C8"
                                                            seatchoirowcnt="6" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">1</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C2 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:171px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00300201" rownm="C" seatno="2"
                                                            seatchoidircval="1" seatchoigrpno="8" seatchoigrpnm="C8"
                                                            seatchoirowcnt="6" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">2</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C3 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:191px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00300301" rownm="C" seatno="3"
                                                            seatchoidircval="1" seatchoigrpno="8" seatchoigrpnm="C8"
                                                            seatchoirowcnt="6" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">3</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C4 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:211px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00300401" rownm="C" seatno="4"
                                                            seatchoidircval="1" seatchoigrpno="8" seatchoigrpnm="C8"
                                                            seatchoirowcnt="6" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">4</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C5 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:231px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00300501" rownm="C" seatno="5"
                                                            seatchoidircval="1" seatchoigrpno="8" seatchoigrpnm="C8"
                                                            seatchoirowcnt="6" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">5</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C6 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:251px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00300601" rownm="C" seatno="6"
                                                            seatchoidircval="1" seatchoigrpno="8" seatchoigrpnm="C8"
                                                            seatchoirowcnt="6" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">6</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C9 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:331px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00301001" rownm="C" seatno="9"
                                                            seatchoidircval="0" seatchoigrpno="9" seatchoigrpnm="C9"
                                                            seatchoirowcnt="8" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">9</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C10 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:351px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00301101" rownm="C" seatno="10"
                                                            seatchoidircval="0" seatchoigrpno="9" seatchoigrpnm="C9"
                                                            seatchoirowcnt="8" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">10</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C11 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:371px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00301201" rownm="C" seatno="11"
                                                            seatchoidircval="0" seatchoigrpno="9" seatchoigrpnm="C9"
                                                            seatchoirowcnt="8" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">11</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C12 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:391px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00301301" rownm="C" seatno="12"
                                                            seatchoidircval="0" seatchoigrpno="9" seatchoigrpnm="C9"
                                                            seatchoirowcnt="8" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">12</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C13 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:411px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00301401" rownm="C" seatno="13"
                                                            seatchoidircval="0" seatchoigrpno="9" seatchoigrpnm="C9"
                                                            seatchoirowcnt="8" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">13</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C14 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:431px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00301501" rownm="C" seatno="14"
                                                            seatchoidircval="0" seatchoigrpno="9" seatchoigrpnm="C9"
                                                            seatchoirowcnt="8" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">14</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C15 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:451px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00301601" rownm="C" seatno="15"
                                                            seatchoidircval="0" seatchoigrpno="9" seatchoigrpnm="C9"
                                                            seatchoirowcnt="8" seatchoigrpseq="7" seattocnt="1"><span
                                                                class="num">15</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C16 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:471px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00301701" rownm="C" seatno="16"
                                                            seatchoidircval="0" seatchoigrpno="9" seatchoigrpnm="C9"
                                                            seatchoirowcnt="8" seatchoigrpseq="8" seattocnt="1"><span
                                                                class="num">16</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C17 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:511px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00301901" rownm="C" seatno="17"
                                                            seatchoidircval="0" seatchoigrpno="10" seatchoigrpnm="C10"
                                                            seatchoirowcnt="6" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">17</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C18 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:531px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00302001" rownm="C" seatno="18"
                                                            seatchoidircval="0" seatchoigrpno="10" seatchoigrpnm="C10"
                                                            seatchoirowcnt="6" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">18</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C19 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:551px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00302101" rownm="C" seatno="19"
                                                            seatchoidircval="0" seatchoigrpno="10" seatchoigrpnm="C10"
                                                            seatchoirowcnt="6" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">19</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C20 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:571px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00302201" rownm="C" seatno="20"
                                                            seatchoidircval="0" seatchoigrpno="10" seatchoigrpnm="C10"
                                                            seatchoirowcnt="6" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">20</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C21 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:591px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00302301" rownm="C" seatno="21"
                                                            seatchoidircval="0" seatchoigrpno="10" seatchoigrpnm="C10"
                                                            seatchoirowcnt="6" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">21</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="C22 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:611px; top:90px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00302401" rownm="C" seatno="22"
                                                            seatchoidircval="0" seatchoigrpno="10" seatchoigrpnm="C10"
                                                            seatchoirowcnt="6" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">22</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button> <button type="button"
                                                            class="btn-seat-row" title="D 행"
                                                            style="position:absolute; left:106px; top:112px;">D</button><button
                                                            type="button" title="D1 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:151px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00400101" rownm="D" seatno="1"
                                                            seatchoidircval="1" seatchoigrpno="11" seatchoigrpnm="D11"
                                                            seatchoirowcnt="6" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">1</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D2 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:171px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00400201" rownm="D" seatno="2"
                                                            seatchoidircval="1" seatchoigrpno="11" seatchoigrpnm="D11"
                                                            seatchoirowcnt="6" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">2</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D3 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:191px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00400301" rownm="D" seatno="3"
                                                            seatchoidircval="1" seatchoigrpno="11" seatchoigrpnm="D11"
                                                            seatchoirowcnt="6" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">3</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D4 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:211px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00400401" rownm="D" seatno="4"
                                                            seatchoidircval="1" seatchoigrpno="11" seatchoigrpnm="D11"
                                                            seatchoirowcnt="6" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">4</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D5 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:231px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00400501" rownm="D" seatno="5"
                                                            seatchoidircval="1" seatchoigrpno="11" seatchoigrpnm="D11"
                                                            seatchoirowcnt="6" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">5</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D6 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:251px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00400601" rownm="D" seatno="6"
                                                            seatchoidircval="1" seatchoigrpno="11" seatchoigrpnm="D11"
                                                            seatchoirowcnt="6" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">6</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D9 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:331px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00401001" rownm="D" seatno="9"
                                                            seatchoidircval="0" seatchoigrpno="12" seatchoigrpnm="D12"
                                                            seatchoirowcnt="8" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">9</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D10 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:351px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00401101" rownm="D" seatno="10"
                                                            seatchoidircval="0" seatchoigrpno="12" seatchoigrpnm="D12"
                                                            seatchoirowcnt="8" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">10</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D11 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:371px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00401201" rownm="D" seatno="11"
                                                            seatchoidircval="0" seatchoigrpno="12" seatchoigrpnm="D12"
                                                            seatchoirowcnt="8" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">11</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D12 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:391px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00401301" rownm="D" seatno="12"
                                                            seatchoidircval="0" seatchoigrpno="12" seatchoigrpnm="D12"
                                                            seatchoirowcnt="8" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">12</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D13 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:411px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00401401" rownm="D" seatno="13"
                                                            seatchoidircval="0" seatchoigrpno="12" seatchoigrpnm="D12"
                                                            seatchoirowcnt="8" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">13</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D14 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:431px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00401501" rownm="D" seatno="14"
                                                            seatchoidircval="0" seatchoigrpno="12" seatchoigrpnm="D12"
                                                            seatchoirowcnt="8" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">14</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D15 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:451px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00401601" rownm="D" seatno="15"
                                                            seatchoidircval="0" seatchoigrpno="12" seatchoigrpnm="D12"
                                                            seatchoirowcnt="8" seatchoigrpseq="7" seattocnt="1"><span
                                                                class="num">15</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D16 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:471px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00401701" rownm="D" seatno="16"
                                                            seatchoidircval="0" seatchoigrpno="12" seatchoigrpnm="D12"
                                                            seatchoirowcnt="8" seatchoigrpseq="8" seattocnt="1"><span
                                                                class="num">16</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D17 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:511px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00401901" rownm="D" seatno="17"
                                                            seatchoidircval="0" seatchoigrpno="13" seatchoigrpnm="D13"
                                                            seatchoirowcnt="6" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">17</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D18 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:531px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00402001" rownm="D" seatno="18"
                                                            seatchoidircval="0" seatchoigrpno="13" seatchoigrpnm="D13"
                                                            seatchoirowcnt="6" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">18</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D19 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:551px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00402101" rownm="D" seatno="19"
                                                            seatchoidircval="0" seatchoigrpno="13" seatchoigrpnm="D13"
                                                            seatchoirowcnt="6" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">19</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D20 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:571px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00402201" rownm="D" seatno="20"
                                                            seatchoidircval="0" seatchoigrpno="13" seatchoigrpnm="D13"
                                                            seatchoirowcnt="6" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">20</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D21 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:591px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00402301" rownm="D" seatno="21"
                                                            seatchoidircval="0" seatchoigrpno="13" seatchoigrpnm="D13"
                                                            seatchoirowcnt="6" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">21</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="D22 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:611px; top:110px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00402401" rownm="D" seatno="22"
                                                            seatchoidircval="0" seatchoigrpno="13" seatchoigrpnm="D13"
                                                            seatchoirowcnt="6" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">22</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button> <button type="button"
                                                            class="btn-seat-row" title="E 행"
                                                            style="position:absolute; left:106px; top:132px;">E</button><button
                                                            type="button" title="E1 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:151px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00500101" rownm="E" seatno="1"
                                                            seatchoidircval="1" seatchoigrpno="14" seatchoigrpnm="E14"
                                                            seatchoirowcnt="6" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">1</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E2 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:171px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00500201" rownm="E" seatno="2"
                                                            seatchoidircval="1" seatchoigrpno="14" seatchoigrpnm="E14"
                                                            seatchoirowcnt="6" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">2</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E3 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:191px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00500301" rownm="E" seatno="3"
                                                            seatchoidircval="1" seatchoigrpno="14" seatchoigrpnm="E14"
                                                            seatchoirowcnt="6" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">3</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E4 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:211px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00500401" rownm="E" seatno="4"
                                                            seatchoidircval="1" seatchoigrpno="14" seatchoigrpnm="E14"
                                                            seatchoirowcnt="6" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">4</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E5 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:231px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00500501" rownm="E" seatno="5"
                                                            seatchoidircval="1" seatchoigrpno="14" seatchoigrpnm="E14"
                                                            seatchoirowcnt="6" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">5</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E6 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:251px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00500601" rownm="E" seatno="6"
                                                            seatchoidircval="1" seatchoigrpno="14" seatchoigrpnm="E14"
                                                            seatchoirowcnt="6" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">6</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E9 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:331px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00501001" rownm="E" seatno="9"
                                                            seatchoidircval="0" seatchoigrpno="15" seatchoigrpnm="E15"
                                                            seatchoirowcnt="8" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">9</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E10 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:351px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00501101" rownm="E" seatno="10"
                                                            seatchoidircval="0" seatchoigrpno="15" seatchoigrpnm="E15"
                                                            seatchoirowcnt="8" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">10</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E11 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:371px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00501201" rownm="E" seatno="11"
                                                            seatchoidircval="0" seatchoigrpno="15" seatchoigrpnm="E15"
                                                            seatchoirowcnt="8" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">11</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E12 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:391px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00501301" rownm="E" seatno="12"
                                                            seatchoidircval="0" seatchoigrpno="15" seatchoigrpnm="E15"
                                                            seatchoirowcnt="8" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">12</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E13 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:411px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00501401" rownm="E" seatno="13"
                                                            seatchoidircval="0" seatchoigrpno="15" seatchoigrpnm="E15"
                                                            seatchoirowcnt="8" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">13</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E14 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:431px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00501501" rownm="E" seatno="14"
                                                            seatchoidircval="0" seatchoigrpno="15" seatchoigrpnm="E15"
                                                            seatchoirowcnt="8" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">14</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E15 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:451px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00501601" rownm="E" seatno="15"
                                                            seatchoidircval="0" seatchoigrpno="15" seatchoigrpnm="E15"
                                                            seatchoirowcnt="8" seatchoigrpseq="7" seattocnt="1"><span
                                                                class="num">15</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E16 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:471px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00501701" rownm="E" seatno="16"
                                                            seatchoidircval="0" seatchoigrpno="15" seatchoigrpnm="E15"
                                                            seatchoirowcnt="8" seatchoigrpseq="8" seattocnt="1"><span
                                                                class="num">16</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E17 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:511px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00501901" rownm="E" seatno="17"
                                                            seatchoidircval="0" seatchoigrpno="16" seatchoigrpnm="E16"
                                                            seatchoirowcnt="6" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">17</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E18 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:531px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00502001" rownm="E" seatno="18"
                                                            seatchoidircval="0" seatchoigrpno="16" seatchoigrpnm="E16"
                                                            seatchoirowcnt="6" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">18</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E19 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:551px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00502101" rownm="E" seatno="19"
                                                            seatchoidircval="0" seatchoigrpno="16" seatchoigrpnm="E16"
                                                            seatchoirowcnt="6" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">19</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E20 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:571px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00502201" rownm="E" seatno="20"
                                                            seatchoidircval="0" seatchoigrpno="16" seatchoigrpnm="E16"
                                                            seatchoirowcnt="6" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">20</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E21 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:591px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00502301" rownm="E" seatno="21"
                                                            seatchoidircval="0" seatchoigrpno="16" seatchoigrpnm="E16"
                                                            seatchoirowcnt="6" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">21</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="E22 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:611px; top:130px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00502401" rownm="E" seatno="22"
                                                            seatchoidircval="0" seatchoigrpno="16" seatchoigrpnm="E16"
                                                            seatchoirowcnt="6" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">22</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button> <button type="button"
                                                            class="btn-seat-row" title="F 행"
                                                            style="position:absolute; left:106px; top:152px;">F</button><button
                                                            type="button" title="F1 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:151px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00600101" rownm="F" seatno="1"
                                                            seatchoidircval="1" seatchoigrpno="17" seatchoigrpnm="F17"
                                                            seatchoirowcnt="6" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">1</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F2 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:171px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00600201" rownm="F" seatno="2"
                                                            seatchoidircval="1" seatchoigrpno="17" seatchoigrpnm="F17"
                                                            seatchoirowcnt="6" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">2</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F3 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:191px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00600301" rownm="F" seatno="3"
                                                            seatchoidircval="1" seatchoigrpno="17" seatchoigrpnm="F17"
                                                            seatchoirowcnt="6" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">3</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F4 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:211px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00600401" rownm="F" seatno="4"
                                                            seatchoidircval="1" seatchoigrpno="17" seatchoigrpnm="F17"
                                                            seatchoirowcnt="6" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">4</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F5 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:231px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00600501" rownm="F" seatno="5"
                                                            seatchoidircval="1" seatchoigrpno="17" seatchoigrpnm="F17"
                                                            seatchoirowcnt="6" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">5</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F6 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:251px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00600601" rownm="F" seatno="6"
                                                            seatchoidircval="1" seatchoigrpno="17" seatchoigrpnm="F17"
                                                            seatchoirowcnt="6" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">6</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F9 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:331px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00601001" rownm="F" seatno="9"
                                                            seatchoidircval="0" seatchoigrpno="18" seatchoigrpnm="F18"
                                                            seatchoirowcnt="8" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">9</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F10 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:351px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00601101" rownm="F" seatno="10"
                                                            seatchoidircval="0" seatchoigrpno="18" seatchoigrpnm="F18"
                                                            seatchoirowcnt="8" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">10</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F11 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:371px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00601201" rownm="F" seatno="11"
                                                            seatchoidircval="0" seatchoigrpno="18" seatchoigrpnm="F18"
                                                            seatchoirowcnt="8" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">11</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F12 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:391px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00601301" rownm="F" seatno="12"
                                                            seatchoidircval="0" seatchoigrpno="18" seatchoigrpnm="F18"
                                                            seatchoirowcnt="8" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">12</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F13 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:411px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00601401" rownm="F" seatno="13"
                                                            seatchoidircval="0" seatchoigrpno="18" seatchoigrpnm="F18"
                                                            seatchoirowcnt="8" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">13</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F14 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:431px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00601501" rownm="F" seatno="14"
                                                            seatchoidircval="0" seatchoigrpno="18" seatchoigrpnm="F18"
                                                            seatchoirowcnt="8" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">14</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F15 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:451px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00601601" rownm="F" seatno="15"
                                                            seatchoidircval="0" seatchoigrpno="18" seatchoigrpnm="F18"
                                                            seatchoirowcnt="8" seatchoigrpseq="7" seattocnt="1"><span
                                                                class="num">15</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F16 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:471px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00601701" rownm="F" seatno="16"
                                                            seatchoidircval="0" seatchoigrpno="18" seatchoigrpnm="F18"
                                                            seatchoirowcnt="8" seatchoigrpseq="8" seattocnt="1"><span
                                                                class="num">16</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F17 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:511px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00601901" rownm="F" seatno="17"
                                                            seatchoidircval="0" seatchoigrpno="19" seatchoigrpnm="F19"
                                                            seatchoirowcnt="6" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">17</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F18 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:531px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00602001" rownm="F" seatno="18"
                                                            seatchoidircval="0" seatchoigrpno="19" seatchoigrpnm="F19"
                                                            seatchoirowcnt="6" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">18</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F19 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:551px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00602101" rownm="F" seatno="19"
                                                            seatchoidircval="0" seatchoigrpno="19" seatchoigrpnm="F19"
                                                            seatchoirowcnt="6" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">19</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F20 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:571px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00602201" rownm="F" seatno="20"
                                                            seatchoidircval="0" seatchoigrpno="19" seatchoigrpnm="F19"
                                                            seatchoirowcnt="6" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">20</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F21 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:591px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00602301" rownm="F" seatno="21"
                                                            seatchoidircval="0" seatchoigrpno="19" seatchoigrpnm="F19"
                                                            seatchoirowcnt="6" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">21</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="F22 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:611px; top:150px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00602401" rownm="F" seatno="22"
                                                            seatchoidircval="0" seatchoigrpno="19" seatchoigrpnm="F19"
                                                            seatchoirowcnt="6" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">22</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button> <button type="button"
                                                            class="btn-seat-row" title="G 행"
                                                            style="position:absolute; left:106px; top:172px;">G</button><button
                                                            type="button" title="G1 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:151px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00700101" rownm="G" seatno="1"
                                                            seatchoidircval="1" seatchoigrpno="20" seatchoigrpnm="G20"
                                                            seatchoirowcnt="6" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">1</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G2 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:171px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00700201" rownm="G" seatno="2"
                                                            seatchoidircval="1" seatchoigrpno="20" seatchoigrpnm="G20"
                                                            seatchoirowcnt="6" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">2</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G3 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:191px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00700301" rownm="G" seatno="3"
                                                            seatchoidircval="1" seatchoigrpno="20" seatchoigrpnm="G20"
                                                            seatchoirowcnt="6" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">3</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G4 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:211px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00700401" rownm="G" seatno="4"
                                                            seatchoidircval="1" seatchoigrpno="20" seatchoigrpnm="G20"
                                                            seatchoirowcnt="6" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">4</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G5 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:231px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00700501" rownm="G" seatno="5"
                                                            seatchoidircval="1" seatchoigrpno="20" seatchoigrpnm="G20"
                                                            seatchoirowcnt="6" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">5</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G6 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:251px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00700601" rownm="G" seatno="6"
                                                            seatchoidircval="1" seatchoigrpno="20" seatchoigrpnm="G20"
                                                            seatchoirowcnt="6" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">6</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G9 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:331px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00701001" rownm="G" seatno="9"
                                                            seatchoidircval="0" seatchoigrpno="21" seatchoigrpnm="G21"
                                                            seatchoirowcnt="8" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">9</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G10 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:351px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00701101" rownm="G" seatno="10"
                                                            seatchoidircval="0" seatchoigrpno="21" seatchoigrpnm="G21"
                                                            seatchoirowcnt="8" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">10</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G11 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:371px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00701201" rownm="G" seatno="11"
                                                            seatchoidircval="0" seatchoigrpno="21" seatchoigrpnm="G21"
                                                            seatchoirowcnt="8" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">11</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G12 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:391px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00701301" rownm="G" seatno="12"
                                                            seatchoidircval="0" seatchoigrpno="21" seatchoigrpnm="G21"
                                                            seatchoirowcnt="8" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">12</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G13 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:411px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00701401" rownm="G" seatno="13"
                                                            seatchoidircval="0" seatchoigrpno="21" seatchoigrpnm="G21"
                                                            seatchoirowcnt="8" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">13</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G14 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:431px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00701501" rownm="G" seatno="14"
                                                            seatchoidircval="0" seatchoigrpno="21" seatchoigrpnm="G21"
                                                            seatchoirowcnt="8" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">14</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G15 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:451px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00701601" rownm="G" seatno="15"
                                                            seatchoidircval="0" seatchoigrpno="21" seatchoigrpnm="G21"
                                                            seatchoirowcnt="8" seatchoigrpseq="7" seattocnt="1"><span
                                                                class="num">15</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G16 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:471px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00701701" rownm="G" seatno="16"
                                                            seatchoidircval="0" seatchoigrpno="21" seatchoigrpnm="G21"
                                                            seatchoirowcnt="8" seatchoigrpseq="8" seattocnt="1"><span
                                                                class="num">16</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G17 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:511px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00701901" rownm="G" seatno="17"
                                                            seatchoidircval="0" seatchoigrpno="22" seatchoigrpnm="G22"
                                                            seatchoirowcnt="6" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">17</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G18 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:531px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00702001" rownm="G" seatno="18"
                                                            seatchoidircval="0" seatchoigrpno="22" seatchoigrpnm="G22"
                                                            seatchoirowcnt="6" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">18</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G19 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:551px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00702101" rownm="G" seatno="19"
                                                            seatchoidircval="0" seatchoigrpno="22" seatchoigrpnm="G22"
                                                            seatchoirowcnt="6" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">19</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G20 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:571px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00702201" rownm="G" seatno="20"
                                                            seatchoidircval="0" seatchoigrpno="22" seatchoigrpnm="G22"
                                                            seatchoirowcnt="6" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">20</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G21 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:591px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00702301" rownm="G" seatno="21"
                                                            seatchoidircval="0" seatchoigrpno="22" seatchoigrpnm="G22"
                                                            seatchoirowcnt="6" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">21</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="G22 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:611px; top:170px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00702401" rownm="G" seatno="22"
                                                            seatchoidircval="0" seatchoigrpno="22" seatchoigrpnm="G22"
                                                            seatchoirowcnt="6" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">22</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button> <button type="button"
                                                            class="btn-seat-row" title="H 행"
                                                            style="position:absolute; left:106px; top:192px;">H</button><button
                                                            type="button" title="H1 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:151px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00800101" rownm="H" seatno="1"
                                                            seatchoidircval="1" seatchoigrpno="23" seatchoigrpnm="H23"
                                                            seatchoirowcnt="6" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">1</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H2 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:171px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00800201" rownm="H" seatno="2"
                                                            seatchoidircval="1" seatchoigrpno="23" seatchoigrpnm="H23"
                                                            seatchoirowcnt="6" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">2</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H3 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:191px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00800301" rownm="H" seatno="3"
                                                            seatchoidircval="1" seatchoigrpno="23" seatchoigrpnm="H23"
                                                            seatchoirowcnt="6" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">3</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H4 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:211px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00800401" rownm="H" seatno="4"
                                                            seatchoidircval="1" seatchoigrpno="23" seatchoigrpnm="H23"
                                                            seatchoirowcnt="6" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">4</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H5 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:231px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00800501" rownm="H" seatno="5"
                                                            seatchoidircval="1" seatchoigrpno="23" seatchoigrpnm="H23"
                                                            seatchoirowcnt="6" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">5</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H6 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:251px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00800601" rownm="H" seatno="6"
                                                            seatchoidircval="1" seatchoigrpno="23" seatchoigrpnm="H23"
                                                            seatchoirowcnt="6" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">6</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H9 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:331px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00801001" rownm="H" seatno="9"
                                                            seatchoidircval="0" seatchoigrpno="24" seatchoigrpnm="H24"
                                                            seatchoirowcnt="8" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">9</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H10 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:351px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00801101" rownm="H" seatno="10"
                                                            seatchoidircval="0" seatchoigrpno="24" seatchoigrpnm="H24"
                                                            seatchoirowcnt="8" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">10</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H11 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:371px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00801201" rownm="H" seatno="11"
                                                            seatchoidircval="0" seatchoigrpno="24" seatchoigrpnm="H24"
                                                            seatchoirowcnt="8" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">11</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H12 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:391px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00801301" rownm="H" seatno="12"
                                                            seatchoidircval="0" seatchoigrpno="24" seatchoigrpnm="H24"
                                                            seatchoirowcnt="8" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">12</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H13 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:411px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00801401" rownm="H" seatno="13"
                                                            seatchoidircval="0" seatchoigrpno="24" seatchoigrpnm="H24"
                                                            seatchoirowcnt="8" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">13</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H14 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:431px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00801501" rownm="H" seatno="14"
                                                            seatchoidircval="0" seatchoigrpno="24" seatchoigrpnm="H24"
                                                            seatchoirowcnt="8" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">14</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H15 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:451px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00801601" rownm="H" seatno="15"
                                                            seatchoidircval="0" seatchoigrpno="24" seatchoigrpnm="H24"
                                                            seatchoirowcnt="8" seatchoigrpseq="7" seattocnt="1"><span
                                                                class="num">15</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H16 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:471px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00801701" rownm="H" seatno="16"
                                                            seatchoidircval="0" seatchoigrpno="24" seatchoigrpnm="H24"
                                                            seatchoirowcnt="8" seatchoigrpseq="8" seattocnt="1"><span
                                                                class="num">16</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H17 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:511px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00801901" rownm="H" seatno="17"
                                                            seatchoidircval="0" seatchoigrpno="25" seatchoigrpnm="H25"
                                                            seatchoirowcnt="5" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">17</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H18 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:531px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00802001" rownm="H" seatno="18"
                                                            seatchoidircval="0" seatchoigrpno="25" seatchoigrpnm="H25"
                                                            seatchoirowcnt="5" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">18</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H19 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:551px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00802101" rownm="H" seatno="19"
                                                            seatchoidircval="0" seatchoigrpno="25" seatchoigrpnm="H25"
                                                            seatchoirowcnt="5" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">19</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H20 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:571px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00802201" rownm="H" seatno="20"
                                                            seatchoidircval="0" seatchoigrpno="25" seatchoigrpnm="H25"
                                                            seatchoirowcnt="5" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">20</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="H21 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:591px; top:190px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00802301" rownm="H" seatno="21"
                                                            seatchoidircval="0" seatchoigrpno="25" seatchoigrpnm="H25"
                                                            seatchoirowcnt="5" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">21</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button> <button type="button"
                                                            class="btn-seat-row" title="I 행"
                                                            style="position:absolute; left:106px; top:212px;">I</button><button
                                                            type="button" title="I17 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:511px; top:210px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00901901" rownm="I" seatno="17"
                                                            seatchoidircval="1" seatchoigrpno="26" seatchoigrpnm="I26"
                                                            seatchoirowcnt="5" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">17</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="I18 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:531px; top:210px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00902001" rownm="I" seatno="18"
                                                            seatchoidircval="1" seatchoigrpno="26" seatchoigrpnm="I26"
                                                            seatchoirowcnt="5" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">18</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="I19 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:551px; top:210px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00902101" rownm="I" seatno="19"
                                                            seatchoidircval="1" seatchoigrpno="26" seatchoigrpnm="I26"
                                                            seatchoirowcnt="5" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">19</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="I20 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:571px; top:210px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00902201" rownm="I" seatno="20"
                                                            seatchoidircval="1" seatchoigrpno="26" seatchoigrpnm="I26"
                                                            seatchoirowcnt="5" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">20</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="I21 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:591px; top:210px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="00902301" rownm="I" seatno="21"
                                                            seatchoidircval="1" seatchoigrpno="26" seatchoigrpnm="I26"
                                                            seatchoirowcnt="5" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">21</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button> <button type="button"
                                                            class="btn-seat-row" title="J 행"
                                                            style="position:absolute; left:106px; top:232px;">J</button><button
                                                            type="button" title="J7 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:291px; top:230px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01000801" rownm="J" seatno="7"
                                                            seatchoidircval="1" seatchoigrpno="27" seatchoigrpnm="J27"
                                                            seatchoirowcnt="10" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">7</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="J8 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:311px; top:230px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01000901" rownm="J" seatno="8"
                                                            seatchoidircval="1" seatchoigrpno="27" seatchoigrpnm="J27"
                                                            seatchoirowcnt="10" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">8</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="J9 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:331px; top:230px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01001001" rownm="J" seatno="9"
                                                            seatchoidircval="1" seatchoigrpno="27" seatchoigrpnm="J27"
                                                            seatchoirowcnt="10" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">9</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="J10 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:351px; top:230px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01001101" rownm="J" seatno="10"
                                                            seatchoidircval="1" seatchoigrpno="27" seatchoigrpnm="J27"
                                                            seatchoirowcnt="10" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">10</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="J11 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:371px; top:230px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01001201" rownm="J" seatno="11"
                                                            seatchoidircval="1" seatchoigrpno="27" seatchoigrpnm="J27"
                                                            seatchoirowcnt="10" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">11</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="J12 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:391px; top:230px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01001301" rownm="J" seatno="12"
                                                            seatchoidircval="1" seatchoigrpno="27" seatchoigrpnm="J27"
                                                            seatchoirowcnt="10" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">12</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="J13 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:411px; top:230px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01001401" rownm="J" seatno="13"
                                                            seatchoidircval="1" seatchoigrpno="27" seatchoigrpnm="J27"
                                                            seatchoirowcnt="10" seatchoigrpseq="7" seattocnt="1"><span
                                                                class="num">13</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="J14 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:431px; top:230px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01001501" rownm="J" seatno="14"
                                                            seatchoidircval="1" seatchoigrpno="27" seatchoigrpnm="J27"
                                                            seatchoirowcnt="10" seatchoigrpseq="8" seattocnt="1"><span
                                                                class="num">14</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="J15 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:451px; top:230px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01001601" rownm="J" seatno="15"
                                                            seatchoidircval="1" seatchoigrpno="27" seatchoigrpnm="J27"
                                                            seatchoirowcnt="10" seatchoigrpseq="9" seattocnt="1"><span
                                                                class="num">15</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="J16 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:471px; top:230px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01001701" rownm="J" seatno="16"
                                                            seatchoidircval="1" seatchoigrpno="27" seatchoigrpnm="J27"
                                                            seatchoirowcnt="10" seatchoigrpseq="10" seattocnt="1"><span
                                                                class="num">16</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="J17 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:511px; top:230px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01001901" rownm="J" seatno="17"
                                                            seatchoidircval="0" seatchoigrpno="28" seatchoigrpnm="J28"
                                                            seatchoirowcnt="5" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">17</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="J18 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:531px; top:230px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01002001" rownm="J" seatno="18"
                                                            seatchoidircval="0" seatchoigrpno="28" seatchoigrpnm="J28"
                                                            seatchoirowcnt="5" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">18</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="J19 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:551px; top:230px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01002101" rownm="J" seatno="19"
                                                            seatchoidircval="0" seatchoigrpno="28" seatchoigrpnm="J28"
                                                            seatchoirowcnt="5" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">19</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="J20 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:571px; top:230px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01002201" rownm="J" seatno="20"
                                                            seatchoidircval="0" seatchoigrpno="28" seatchoigrpnm="J28"
                                                            seatchoirowcnt="5" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">20</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="J21 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:591px; top:230px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01002301" rownm="J" seatno="21"
                                                            seatchoidircval="0" seatchoigrpno="28" seatchoigrpnm="J28"
                                                            seatchoirowcnt="5" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">21</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button> <button type="button"
                                                            class="btn-seat-row" title="K 행"
                                                            style="position:absolute; left:106px; top:252px;">K</button><button
                                                            type="button" title="K7 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:291px; top:250px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01100801" rownm="K" seatno="7"
                                                            seatchoidircval="1" seatchoigrpno="29" seatchoigrpnm="K29"
                                                            seatchoirowcnt="10" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">7</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="K8 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:311px; top:250px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01100901" rownm="K" seatno="8"
                                                            seatchoidircval="1" seatchoigrpno="29" seatchoigrpnm="K29"
                                                            seatchoirowcnt="10" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">8</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="K9 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:331px; top:250px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01101001" rownm="K" seatno="9"
                                                            seatchoidircval="1" seatchoigrpno="29" seatchoigrpnm="K29"
                                                            seatchoirowcnt="10" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">9</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="K10 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:351px; top:250px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01101101" rownm="K" seatno="10"
                                                            seatchoidircval="1" seatchoigrpno="29" seatchoigrpnm="K29"
                                                            seatchoirowcnt="10" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">10</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="K11 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:371px; top:250px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01101201" rownm="K" seatno="11"
                                                            seatchoidircval="1" seatchoigrpno="29" seatchoigrpnm="K29"
                                                            seatchoirowcnt="10" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">11</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="K12 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:391px; top:250px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01101301" rownm="K" seatno="12"
                                                            seatchoidircval="1" seatchoigrpno="29" seatchoigrpnm="K29"
                                                            seatchoirowcnt="10" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">12</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="K13 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:411px; top:250px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01101401" rownm="K" seatno="13"
                                                            seatchoidircval="1" seatchoigrpno="29" seatchoigrpnm="K29"
                                                            seatchoirowcnt="10" seatchoigrpseq="7" seattocnt="1"><span
                                                                class="num">13</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="K14 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:431px; top:250px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01101501" rownm="K" seatno="14"
                                                            seatchoidircval="1" seatchoigrpno="29" seatchoigrpnm="K29"
                                                            seatchoirowcnt="10" seatchoigrpseq="8" seattocnt="1"><span
                                                                class="num">14</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="K15 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:451px; top:250px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01101601" rownm="K" seatno="15"
                                                            seatchoidircval="1" seatchoigrpno="29" seatchoigrpnm="K29"
                                                            seatchoirowcnt="10" seatchoigrpseq="9" seattocnt="1"><span
                                                                class="num">15</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="K16 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:471px; top:250px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01101701" rownm="K" seatno="16"
                                                            seatchoidircval="1" seatchoigrpno="29" seatchoigrpnm="K29"
                                                            seatchoirowcnt="10" seatchoigrpseq="10" seattocnt="1"><span
                                                                class="num">16</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="K17 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:511px; top:250px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01101901" rownm="K" seatno="17"
                                                            seatchoidircval="0" seatchoigrpno="30" seatchoigrpnm="K30"
                                                            seatchoirowcnt="5" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">17</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="K18 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:531px; top:250px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01102001" rownm="K" seatno="18"
                                                            seatchoidircval="0" seatchoigrpno="30" seatchoigrpnm="K30"
                                                            seatchoirowcnt="5" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">18</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="K19 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:551px; top:250px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01102101" rownm="K" seatno="19"
                                                            seatchoidircval="0" seatchoigrpno="30" seatchoigrpnm="K30"
                                                            seatchoirowcnt="5" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">19</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="K20 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:571px; top:250px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01102201" rownm="K" seatno="20"
                                                            seatchoidircval="0" seatchoigrpno="30" seatchoigrpnm="K30"
                                                            seatchoirowcnt="5" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">20</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="K21 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:591px; top:250px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01102301" rownm="K" seatno="21"
                                                            seatchoidircval="0" seatchoigrpno="30" seatchoigrpnm="K30"
                                                            seatchoirowcnt="5" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">21</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button> <button type="button"
                                                            class="btn-seat-row" title="L 행"
                                                            style="position:absolute; left:106px; top:272px;">L</button><button
                                                            type="button" title="L7 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:291px; top:270px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01200801" rownm="L" seatno="7"
                                                            seatchoidircval="1" seatchoigrpno="31" seatchoigrpnm="L31"
                                                            seatchoirowcnt="10" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">7</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="L8 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:311px; top:270px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01200901" rownm="L" seatno="8"
                                                            seatchoidircval="1" seatchoigrpno="31" seatchoigrpnm="L31"
                                                            seatchoirowcnt="10" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">8</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="L9 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:331px; top:270px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01201001" rownm="L" seatno="9"
                                                            seatchoidircval="1" seatchoigrpno="31" seatchoigrpnm="L31"
                                                            seatchoirowcnt="10" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">9</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="L10 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:351px; top:270px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01201101" rownm="L" seatno="10"
                                                            seatchoidircval="1" seatchoigrpno="31" seatchoigrpnm="L31"
                                                            seatchoirowcnt="10" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">10</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="L11 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:371px; top:270px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01201201" rownm="L" seatno="11"
                                                            seatchoidircval="1" seatchoigrpno="31" seatchoigrpnm="L31"
                                                            seatchoirowcnt="10" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">11</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="L12 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:391px; top:270px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01201301" rownm="L" seatno="12"
                                                            seatchoidircval="1" seatchoigrpno="31" seatchoigrpnm="L31"
                                                            seatchoirowcnt="10" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">12</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="L13 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:411px; top:270px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01201401" rownm="L" seatno="13"
                                                            seatchoidircval="1" seatchoigrpno="31" seatchoigrpnm="L31"
                                                            seatchoirowcnt="10" seatchoigrpseq="7" seattocnt="1"><span
                                                                class="num">13</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="L14 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:431px; top:270px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01201501" rownm="L" seatno="14"
                                                            seatchoidircval="1" seatchoigrpno="31" seatchoigrpnm="L31"
                                                            seatchoirowcnt="10" seatchoigrpseq="8" seattocnt="1"><span
                                                                class="num">14</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="L15 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:451px; top:270px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01201601" rownm="L" seatno="15"
                                                            seatchoidircval="1" seatchoigrpno="31" seatchoigrpnm="L31"
                                                            seatchoirowcnt="10" seatchoigrpseq="9" seattocnt="1"><span
                                                                class="num">15</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="L16 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:471px; top:270px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01201701" rownm="L" seatno="16"
                                                            seatchoidircval="1" seatchoigrpno="31" seatchoigrpnm="L31"
                                                            seatchoirowcnt="10" seatchoigrpseq="10" seattocnt="1"><span
                                                                class="num">16</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="L17 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:511px; top:270px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01201901" rownm="L" seatno="17"
                                                            seatchoidircval="0" seatchoigrpno="32" seatchoigrpnm="L32"
                                                            seatchoirowcnt="5" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">17</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="L18 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:531px; top:270px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01202001" rownm="L" seatno="18"
                                                            seatchoidircval="0" seatchoigrpno="32" seatchoigrpnm="L32"
                                                            seatchoirowcnt="5" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">18</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="L19 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:551px; top:270px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01202101" rownm="L" seatno="19"
                                                            seatchoidircval="0" seatchoigrpno="32" seatchoigrpnm="L32"
                                                            seatchoirowcnt="5" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">19</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="L20 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:571px; top:270px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01202201" rownm="L" seatno="20"
                                                            seatchoidircval="0" seatchoigrpno="32" seatchoigrpnm="L32"
                                                            seatchoirowcnt="5" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">20</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="L21 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:591px; top:270px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01202301" rownm="L" seatno="21"
                                                            seatchoidircval="0" seatchoigrpno="32" seatchoigrpnm="L32"
                                                            seatchoirowcnt="5" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">21</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button> <button type="button"
                                                            class="btn-seat-row" title="M 행"
                                                            style="position:absolute; left:106px; top:292px;">M</button><button
                                                            type="button" title="M7 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:291px; top:290px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01300801" rownm="M" seatno="7"
                                                            seatchoidircval="1" seatchoigrpno="33" seatchoigrpnm="M33"
                                                            seatchoirowcnt="10" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">7</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="M8 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:311px; top:290px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01300901" rownm="M" seatno="8"
                                                            seatchoidircval="1" seatchoigrpno="33" seatchoigrpnm="M33"
                                                            seatchoirowcnt="10" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">8</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="M9 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:331px; top:290px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01301001" rownm="M" seatno="9"
                                                            seatchoidircval="1" seatchoigrpno="33" seatchoigrpnm="M33"
                                                            seatchoirowcnt="10" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">9</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="M10 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:351px; top:290px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01301101" rownm="M" seatno="10"
                                                            seatchoidircval="1" seatchoigrpno="33" seatchoigrpnm="M33"
                                                            seatchoirowcnt="10" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">10</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="M11 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:371px; top:290px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01301201" rownm="M" seatno="11"
                                                            seatchoidircval="1" seatchoigrpno="33" seatchoigrpnm="M33"
                                                            seatchoirowcnt="10" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">11</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="M12 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:391px; top:290px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01301301" rownm="M" seatno="12"
                                                            seatchoidircval="1" seatchoigrpno="33" seatchoigrpnm="M33"
                                                            seatchoirowcnt="10" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">12</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="M13 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:411px; top:290px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01301401" rownm="M" seatno="13"
                                                            seatchoidircval="1" seatchoigrpno="33" seatchoigrpnm="M33"
                                                            seatchoirowcnt="10" seatchoigrpseq="7" seattocnt="1"><span
                                                                class="num">13</span>
                                                            <span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="M14 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:431px; top:290px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01301501" rownm="M" seatno="14"
                                                            seatchoidircval="1" seatchoigrpno="33" seatchoigrpnm="M33"
                                                            seatchoirowcnt="10" seatchoigrpseq="8" seattocnt="1"><span
                                                                class="num">14</span>
                                                            <span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="M15 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:451px; top:290px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01301601" rownm="M" seatno="15"
                                                            seatchoidircval="1" seatchoigrpno="33" seatchoigrpnm="M33"
                                                            seatchoirowcnt="10" seatchoigrpseq="9" seattocnt="1"><span
                                                                class="num">15</span>
                                                            <span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="M16 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:471px; top:290px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01301701" rownm="M" seatno="16"
                                                            seatchoidircval="1" seatchoigrpno="33" seatchoigrpnm="M33"
                                                            seatchoirowcnt="10" seatchoigrpseq="10" seattocnt="1"><span
                                                                class="num">16</span>
                                                            <span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="M17 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:511px; top:290px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01301901" rownm="M" seatno="17"
                                                            seatchoidircval="0" seatchoigrpno="34" seatchoigrpnm="M34"
                                                            seatchoirowcnt="5" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">17</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="M18 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:531px; top:290px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01302001" rownm="M" seatno="18"
                                                            seatchoidircval="0" seatchoigrpno="34" seatchoigrpnm="M34"
                                                            seatchoirowcnt="5" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">18</span>
                                                            <span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="M19 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:551px; top:290px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01302101" rownm="M" seatno="19"
                                                            seatchoidircval="0" seatchoigrpno="34" seatchoigrpnm="M34"
                                                            seatchoirowcnt="5" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">19</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span>
                                                            <span class="rank">일반</span></button><button type="button"
                                                            title="M20 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:571px; top:290px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01302201" rownm="M" seatno="20"
                                                            seatchoidircval="0" seatchoigrpno="34" seatchoigrpnm="M34"
                                                            seatchoirowcnt="5" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">20</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="M21 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:591px; top:290px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01302301" rownm="M" seatno="21"
                                                            seatchoidircval="0" seatchoigrpno="34" seatchoigrpnm="M34"
                                                            seatchoirowcnt="5" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">21</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span>
                                                            <span class="rank">일반</span></button> <button type="button"
                                                            class="btn-seat-row" title="N 행"
                                                            style="position:absolute; left:106px; top:312px;">N</button><button
                                                            type="button" title="N7 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:291px; top:310px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01400801" rownm="N" seatno="7"
                                                            seatchoidircval="1" seatchoigrpno="35" seatchoigrpnm="N35"
                                                            seatchoirowcnt="6" seatchoigrpseq="1" seattocnt="1"><span
                                                                class="num">7</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span>
                                                            <span class="rank">일반</span></button><button type="button"
                                                            title="N8 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:311px; top:310px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01400901" rownm="N" seatno="8"
                                                            seatchoidircval="1" seatchoigrpno="35" seatchoigrpnm="N35"
                                                            seatchoirowcnt="6" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">8</span>
                                                            <span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="N9 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:331px; top:310px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01401001" rownm="N" seatno="9"
                                                            seatchoidircval="1" seatchoigrpno="35" seatchoigrpnm="N35"
                                                            seatchoirowcnt="6" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">9</span>
                                                            <span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="N10 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:351px; top:310px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01401101" rownm="N" seatno="10"
                                                            seatchoidircval="1" seatchoigrpno="35" seatchoigrpnm="N35"
                                                            seatchoirowcnt="6" seatchoigrpseq="4" seattocnt="1"><span
                                                                class="num">10</span>
                                                            <span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="N15 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:451px; top:310px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01401601" rownm="N" seatno="15"
                                                            seatchoidircval="1" seatchoigrpno="35" seatchoigrpnm="N35"
                                                            seatchoirowcnt="6" seatchoigrpseq="5" seattocnt="1"><span
                                                                class="num">15</span>
                                                            <span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="N16 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:471px; top:310px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01401701" rownm="N" seatno="16"
                                                            seatchoidircval="1" seatchoigrpno="35" seatchoigrpnm="N35"
                                                            seatchoirowcnt="6" seatchoigrpseq="6" seattocnt="1"><span
                                                                class="num">16</span>
                                                            <span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="N17 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:511px; top:310px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01401901" rownm="N" seatno="17"
                                                            seatchoidircval="0" seatchoigrpno="36" seatchoigrpnm="N36"
                                                            seatchoirowcnt="4" seatchoigrpseq="1" seattocnt="1">
                                                            <span class="num">17</span><span
                                                                class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button><button type="button"
                                                            title="N18 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:531px; top:310px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01402001" rownm="N" seatno="18"
                                                            seatchoidircval="0" seatchoigrpno="36" seatchoigrpnm="N36"
                                                            seatchoirowcnt="4" seatchoigrpseq="2" seattocnt="1"><span
                                                                class="num">18</span>
                                                            <span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span>
                                                            <span class="rank">일반</span></button><button type="button"
                                                            title="N19 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common view"
                                                            style="position:absolute; left:551px; top:310px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01402101" rownm="N" seatno="19"
                                                            seatchoidircval="0" seatchoigrpno="36" seatchoigrpnm="N36"
                                                            seatchoirowcnt="4" seatchoigrpseq="3" seattocnt="1"><span
                                                                class="num">19</span><span class="kind">스탠다드</span><span
                                                                class="condition">판매가능</span><span
                                                                class="rank">일반</span></button>
                                                        <button type="button" title="N20 (스탠다드/일반)"
                                                            class="jq-tooltip seat-condition standard common"
                                                            style="position:absolute; left:571px; top:310px; width:20px;"
                                                            seatclasscd="GERN_CLS" seatzonecd="GERN_ZONE"
                                                            seatuniqno="01402201" rownm="N" seatno="20"
                                                            seatchoidircval="0" seatchoigrpno="36" seatchoigrpnm="N36"
                                                            seatchoirowcnt="4" seatchoigrpseq="4" seattocnt="1">
                                                            <span class="num">20</span><span class="kind">스탠다드</span>
                                                            <span class="condition">판매가능</span><span
                                                                class="rank">일반</span></button></div>

                                                    <!--                                                whkcmr cnfdlqrn dlalwl-->
                                                    <!--                                                <img src="image/img-door-left.png" alt="좌측 출입구" style="position:absolute; left:131px; top:30px; width:16px; height: 16px;" class="mCS_img_loaded">
                                           
                                            
                                              <img src="image/img-door-top.png" alt="상단측좌측 출입구" style="position:absolute; left:191px; top:330px; width:16px; height: 16px;" class="mCS_img_loaded">-->
                                                </div>
                                            </div>
                                            
                                            
                                            <div id="mCSB_1_scrollbar_vertical"
                                                class="mCSB_scrollTools mCSB_1_scrollbar mCS-light mCSB_scrollTools_vertical">
                                                <div class="mCSB_draggerContainer">
                                                    <div id="mCSB_1_dragger_vertical" class="mCSB_dragger"
                                                        style="position: absolute; min-height: 30px; display: none; height: 439px; top: 0px; max-height: 382px;">
                                                        <div class="mCSB_dragger_bar" style="line-height: 30px;"></div>
                                                    </div>
                                                    <div class="mCSB_draggerRail"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="zone-legend" style="display: none"></div>
                            </div>
                        </div>
                        <div class="seat-result">
                     <div class="wrap">
                        <div class="tit-area">
                           <span class="movie-graseat-resultde small age-all age-12">${age } 관람가</span>
                           <p class="tit">${title }</p>
                           <p class="cate">${category }</p>
                        </div>
                        <div class="info-area">
                           <p class="theater">${cinema }</p>
                           <p class="special">${theater }</p>
                           <p class="date">
                              <span>${release }</span><em></em>
                           </p>
                           <div class="other-time">
                              <button type="button" class="now">
                                 ${start }~${finish }<i class="arr"></i>
                              </button>
                           </div>
                           <p class="poster">
                              <img src="${movieIMG }" onerror="noImg(this);" alt="라라랜드">
                           </p>
                        </div>
                        <div class="choice-seat-area">
                           <div class="legend">
                              <ul class="list">
                                 <li>
                                    <div class="seat-condition choice" title="선택한 좌석"></div> <em>선택</em>
                                 </li>
                                 <li>
                                    <div class="seat-condition common" title="예매 완료"></div> <em>예매완료</em>
                                 </li>
                                 <li>
                                    <div class="seat-condition impossible" title="선택 불가"></div>
                                    <em>선택불가</em>
                                 </li>
                                 <li>
                                    <div class="seat-condition common" title="일반"></div> <em>
                                       일반</em>
                                 </li>
                                 <li>
                                    <div class="seat-condition disabled" title="장애인석"></div> <em>
                                       장애인석</em>
                                 </li>
                              </ul>
                           </div>
                           <div class="seat-num">
                              <p class="tit">선택좌석</p>
                              <div class="my-seat">
                                 <div class="seat choice" title="선택한 좌석">-</div>
                                 <div class="seat all" title="구매가능 좌석">-</div>
                                 <div class="seat all" title="구매가능 좌석">-</div>
                                 <div class="seat all" title="구매가능 좌석">-</div>
                                 <div class="seat all" title="구매가능 좌석">-</div>
                                 <div class="seat all" title="구매가능 좌석">-</div>
                                 <div class="seat all" title="구매가능 좌석">-</div>
                                 <div class="seat all" title="구매가능 좌석">-</div>
                              </div>
                           </div>
                        </div>
                        <div class="pay-area">
                           <p class="count">
                              <span> <em></em>
                              </span>
                           </p>
                           <div class="pay">
                              <p class="tit">최종결제금액</p>
                              <div class="money">
                                 <em>0</em> <span>원</span>
                              </div>
                           </div>
                        </div>
                        <div class="btn-group">
                           <a href="javaScript:void(0)" class="button" id="pagePrevious"
                              title="이전">이전</a> <a href="javaScript:void(0)"
                              class="button active" id="pageNext" title="다음">다음</a>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>

         <!-- 초기화 알람창 팝업-->
         <section class="alert-popup"
            style="display: none; position: fixed; padding-top: 45px; background: rgb(255, 255, 255); z-index: 5006; top: 289px; left: 405px; width: 400px; opacity: 1;"
            id="layerId_030983947233653875">
            <div class="wrap">
               <header class="layer-header">
                  <h3 class="tit">알림</h3>
               </header>
               <div class="layer-con" style="height: 200px;">
                  <p class="txt-common">선택하신 좌석을 모두 취소하고 다시 선택하시겠습니까?</p>
                  <div class="btn-group">
                     <button type="button" class="button lyclose">취소</button>
                     <button type="button" class="button purple confirm">확인</button>
                  </div>
               </div>
               <button type="button" class="btn-layer-close">레이어 닫기</button>
            </div>
         </section>


         <!--인원초과 알람창 팝업-->
         <section class="alert-popup"
            style="display: none; position: fixed; padding-top: 45px; background: rgb(255, 255, 255); z-index: 5006; top: 289px; left: 400px; width: 300px; opacity: 1;"
            id="layerId_08010659137218192">
            <div class="wrap">
               <header class="layer-header">
                  <h3 class="tit">알림</h3>
               </header>
               <div class="layer-con" style="height: 200px;">
                  <p class="txt-common">좌석 선택이 완료되었습니다.</p>
                  <div class="btn-group">
                     <button type="button" class="button lyclose"
                        style="display: none;"></button>
                     <button type="button" class="button purple confirm">확인</button>
                  </div>
               </div>
               <button type="button" class="btn-layer-close">레이어 닫기</button>
            </div>

         </section>
         <div class="normalStyle"
            style="display: none; position: fixed; top: 0; left: 0; background: #000; opacity: 0.7; text-indent: -9999px; width: 100%; height: 100%; z-index: 100;">
            닫기</div>
         <div class="alertStyle"
            style="display: none; position: fixed; top: 0px; left: 0px; background: #000; opacity: 0.7; width: 100%; height: 100%; z-index: 5005;">
         </div>
      </div>
   </div>
</body>



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



</html>