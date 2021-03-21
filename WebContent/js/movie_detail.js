$(function() {
	$(".more-btn").click(function() {
		$(".etc").toggleClass("show-more");
		if ($(".more-btn").text() === "닫기") {
			$(".more-btn").text("더보기");
		} else {
			$(".more-btn").text("닫기");
		}

	})
	$(".more-btn").hover(function() {
		$(this).css('border-bottom', 'black');
	}, function() {
		$(this).css('border-bottom', '#AAAAAA');
	})

	// 하트버튼
	$('#likebtn1').on({
		mouseenter : function() {
			$(this).addClass('on');
		},
		mouseleave : function() {
			$(this).removeClass('on');
		},
		click : function() {
			if ($(this).hasClass('like')) {
				var i = $(this).text();
				i--;
				$(this).text(i);
				$(this).removeClass('like');
			} else {

				var i = $(this).text();
				++i;
				$(this).text(i);
				$(this).addClass('like');
			}
		}

	});

	$('#likebtn2').on({
		mouseenter : function() {
			$(this).addClass('on');
		},
		mouseleave : function() {
			$(this).removeClass('on');
		},
		click : function() {
			if ($(this).hasClass('like')) {
				var i = $(this).text();
				i--;
				$(this).text(i);
				$(this).removeClass('like');
			} else {

				var i = $(this).text();
				++i;
				$(this).text(i);
				$(this).addClass('like');

			}
		}

	});

});
// /* movie 섹션의 좋아요 버튼 */
// $('.likebtn1').mouseenter(function(){
// $(this).addClass('on');
// }).mouseleave(function(){
// $(this).removeClass('on');
// });

/* 하트버튼 */
// $('.likebtn1').click(function () {
// if ($(this).hasClass('like')) {
// var i = $(this).text();
// i--;
// $(this).text(i);
// $(this).removeClass('like');
// } else {
//
// var i = $(this).text();
// ++i;
// $(this).text(i);
// $(this).addClass('like');
//
// }
// })

/*hidden tab */
$(window).scroll(function() {
	var scrollTop = $(this).scrollTop();
	if (scrollTop >= 580) {
		$(".wrap-hidden").css("display", "block");
	} else {
		$(".wrap-hidden").css("display", "none");
	}
	if (scrollTop >= 604) {
		$(".wrap-tab-list-on").show();
	} else {
		$(".wrap-tab-list-on").hide();
	}
});


/*리뷰 작성 시간 계산 */
$(function(){
	var dateArr= $(".wrote-date").text().split(" ");//dateArr[0]:날짜 저장 dateArr[1]:시간 저장 
	var wdate=dateArr[0].split("-");/*년,월,일 */ var wtime=dateArr[1].split(":");//시,분,초 
	var d= new Date();
	//리뷰 작성된 날짜, 시간 
	var wyear=wdate[0]; var wmonth=wdate[1]; var wday=wdate[2]; var whour=wtime[0]; var wminute=wtime[1];
	//현재 시간 
	var cyear=d.getFullYear(); var cmonth=(d.getMonth()+1)>9 ? ''+(d.getMonth()+1) : '0'+(d.getMonth()+1); var cday=d.getDate()>9 ? ''+d.getDate() : '0'+d.getDate(); var chour=d.getHours(); var cminute=d.getMinutes();
	console.log("sadwed");
	console.log("작성된 시간:"+wday+""+whour+""+wminute);
	console.log("GUSW현재시간:"+cday+""+chour+""+cminute);
	/* $(".wrote-date").text(hour); */
	
	if(wyear==cyear&&wmonth==cmonth&&wday==cday){
		//작성시간 분 이내  
		console.log("시 비교"+whour+" "+chour);
		if(whour==chour){
			var minute=Math.abs(wminute-cminute);
			console.log(minute);
			$(".wrote-date").text(minute+" 분 전");
		}
		else{
			//작성시간 시 이내 
			var hour=Math.abs(whour-chour);
			$(".wrote-date").text(hour+" 시간 전");
			console.log(Math.abs(whour-chour));
			console.log("오늘 작성됨");
		}
	}
		//작성날짜 일주일 이내 
	else if(wyear==cyear&&wmonth==cmonth&&(Math.abs(wday-cday)<=7)){
		var day=Math.abs(wday-cday);
		$(".wrote-date").text(day+" 일 전");
	}
		//작성날짜 그 이외 
	else{
		$(".wrote-date").text(wyear+"."+wmonth+"."+wday);
	}
})


$(function() {
	//닫기 버튼 
	$('.wcancel').click(function(){
	$('.write_popup_wrapper').hide();
	});$('.close').click(function() {
	$('.write_popup_wrapper').hide();});
	
	/* 리뷰팝업 */
	$('.writeBtn').click(function() {
		/*로그인 여부 확인 */
		var check=$(this).attr('user-id');
		if(!check){
			console.log("로그인 안되어있음");
			console.log(check);
			alert("로그인을 해주세요.");
			return false;
		}
		/*리뷰작성 여부 확인*/
		var check_wrote=$(this).attr('check_wrote');
		if(check_wrote>=1){
			alert("리뷰이미 작성함");
			return false;
		}
		$('.write_popup_wrapper').show();
		var offset = $(document).scrollTop();
		$('html, body').animate({
			scrollTop : offset
		});
	});
		
	/*리뷰 작성*/
	$('.wregist').click(function(){
		$('.write-review').hide();
		$.ajax({
			url:'ReviewDAO',
			type:'POST',
			dataType:'text',
			data:{
				"review_title" : $('input[name=review_title]').val(),
				"review_score" : $('input[name=review_score]').val(),
				"review_id"	   : $('input[name=review_id]').val(),
				"review_text"  : $('.input-textarea').val()
			},
		 	success: function(data) {
		 		//console.log(data);		
	         	console.log("리뷰 작성");
	        },
            error:function(request,status,error,data){
                console.log("유감");
                console.log(data);
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
		});
		location.reload();
	});
	
	/* 리뷰 수정 */
	$(".updateOne").click(function(){
		$('.write_popup_wrapper').show();
		/*스크롤 고정*/
		var offset = $(document).scrollTop();
		$('html, body').animate({
			scrollTop : offset });
		var review_title=$(this).attr('data-title');
		var review_id=$(this).attr('data-id');
		var review_text=$(this).attr('data-text');
		var ex_score=$(this).attr('data-score'); //수정 전 점수
		var review_score=$(this).attr('data-score');
		$('#score-count').text(parseInt(review_score));
		$('#text-area').val(review_text);
		
		/*수정버튼으로 변경*/
		$('.wregist').remove();
        var wedit =$('<button type="button" class="wedit wbtn">수정</button>')
        $(".btn-wrapper").append(wedit);
		
		/*별점*/
		for (var i = 0; i <= review_score; i++) {
			if ((i % 2) == 1) { $('.star:nth-child(' + i + ')').children().first().attr("src", "image/odd_color.png");} 
			else { $('.star:nth-child(' + i + ')').children().first().attr("src", "image/even_color.png");}
		}
		/* 리뷰 글자 수 */
		var content = $('.input-textarea').val();
		$('#text_count').text(content.length);
		//100자로 제한 
		if (content.length > 100) {
			$(this).val(content.substring(0, 100));
			$('#text_count').text(100);
		}
		$('.wedit').click(function(){
			$('.write_popup_wrapper').hide();
			review_score=$('#score-count').text();
			review_text=$('#text-area').val();
			$.ajax({
					url:'ReviewEditDAO',
					type:'POST',
					dataType:'text',
					data:{
						'review_text':review_text,
						'ex_score':ex_score,
						'review_score':review_score,
						'review_id':review_id,
						'review_title':review_title
						
					},success: function(data) {
			         	console.log(data);		
			         	console.log("리뷰 수정");
			         	location.reload();
			        },
		           error:function(request,status,error,data){
		               console.log("유감");
		               console.log(data);
		               alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		           }
			});
		});
	})
	
	/*리뷰 삭제*/
	$('.deleteOne').click(function(){
		var review_id=$(this).attr('data-id');
		var review_title=$(this).attr('data-title');
           $.ajax({
			url:'ReviewDeleteDAO',
			type:'POST',
			dataType:'text',
			data:{
				"review_id" : review_id,
				"review_title" : review_title
			},
			success: function(data) {
	         	console.log(data);		
	         	console.log("리뷰 삭제");
	        },
           error:function(request,status,error,data){
               console.log("유감");
               console.log(data);
               alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
           }
		   });   
           location.reload();
	});
});

//review star
$(function () {
	$(".star").on({
		//보라색
		mouseenter: function () {
			//별점을 체크함 
			var num = $(this).text();
			$('#score-count').text(num);
			for (var i = 0; i <= num; i++) {
				if ((i % 2) == 1) {
					$('.star:nth-child(' + i + ')').children().first().attr("src", "image/odd_color.png");
				} else {
					$('.star:nth-child(' + i + ')').children().first().attr("src", "image/even_color.png");
				}
			}
		},
		//보라색 해제 
		mouseout: function () {
			console.log("mouseout");
			var num = $(this).text();
			$('#score-count').text(num);
			//별점을 회색으로 초기화 
			for (var i = 0; i <= 10; i++) {
				if ((i % 2) == 1) {
					$('.star:nth-child(' + i + ')').children().first().attr("src", "image/odd.png");
				} else {
					$('.star:nth-child(' + i + ')').children().first().attr("src", "image/even.png");
				}
			}
			if ($(this).is(".star_left") === true) {
				console.log("왼쪽");
				$(this).children().first().attr("src", "image/odd.png");
			}
			else {
				console.log("오른쪽");
				$(this).children().first().attr("src", "image/even.png");
			}
		}
	})
	//사용자가 남길 별점 
	$(".box-star").mouseleave(function () {
		var num = $(this).children("#score-count").text();
		//input hidden에 값 설정
		$(".review_score").val(num);
		for (var i = 0; i <= num; i++) {
			if ((i % 2) == 1) {
				$('.star:nth-child(' + i + ')').children().first().attr("src", "image/odd_color.png");
			} else {
				$('.star:nth-child(' + i + ')').children().first().attr("src", "image/even_color.png");
			}
		}
	});
	/* 리뷰 글자 수 */
	$('.input-textarea').keyup(function () {
		var content = $(this).val();
		$('#text_count').text(content.length);
		//100자로 제한 
		if (content.length > 100) {
			$(this).val(content.substring(0, 100));
			$('#text_count').text(100);
		}
	})

});
