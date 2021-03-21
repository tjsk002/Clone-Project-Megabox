/*
    리셋 confirm과 인원초과 confirm
    - 인원을 줄여 reset실행시 인원초과 confirm 작동X
    
    알람창 css수정 필요
*/

//관람 인원을 선택해주세요. 아무곳이나 클릭시 창 닫힘
$(function () {
    $(document).click(function () {
        $(".seat-count-before").addClass('off');
    });
    
    $(window).ready(function(){
    	//console.log($("span.movie-graseat-resultde").text().split(" ")[0]);
    	if ($("span.movie-graseat-resultde").text().split(" ")[0] == '12') {
    	$("span.movie-graseat-resultde").empty().append("12세 이상 관람가");
	} else if ($("span.movie-graseat-resultde").text().split(" ")[0] == '15') {
		$("span.movie-graseat-resultde").empty().append("15세 이상 관람가");
	} else if ($("span.movie-grade").text().split(" ")[0] == '청소') {
		$("span.movie-graseat-resultde").empty().append("청소년 관람 불가");
	}
    	var ticket_movieTime = $('#nextParam').text();
    	var listInfo1 = {"ticket_movieTime": ticket_movieTime};
    	$.ajax({
			url:'/Megabox/SeatCheckDAO',
			type : 'POST',
			dataType:'text',
			data:listInfo1,
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
			success:function(seatCK){
				seatCK = seatCK.split("x")[1];
				var seatlist = seatCK.split(" ");
				//console.log(seatCK);
				//console.log($("button.seat-condition").eq(5).attr("title"));
				for(var i =0; i<seatlist.length; i++){
					for(var a = 0; a<$("button.seat-condition").length;a++){
						if(seatlist[i] == $("button.seat-condition").eq(a).attr("title").split(" ")[0]){
							$("button.seat-condition").eq(a).addClass("seat-condition finish");
						}
					}
				}
				
			},
			error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
    	
    });
    
    $(document).on("click","a#pageNext", function(){
    	var ticket_movieTime1 = $('#nextParam').text();
    	var userid = $('#userid').text();
    	var seat1 = $('.my-seat').children().eq(0).text();
    	var seat2 = $('.my-seat').children().eq(1).text();
    	var seat3 = $('.my-seat').children().eq(2).text();
    	var seat4 = $('.my-seat').children().eq(3).text();
    	var seat5 = $('.my-seat').children().eq(4).text();
    	var seat6 = $('.my-seat').children().eq(5).text();
    	var seat7 = $('.my-seat').children().eq(6).text();
    	var seat8 = $('.my-seat').children().eq(7).text();
    	
    	
    	var listInfo = {"ticket_movieTime": ticket_movieTime1,"userid": userid, "seat1": seat1, "seat2":seat2, "seat3":seat3, "seat4":seat4, "seat5":seat5, "seat6":seat6, "seat7":seat7, "seat8":seat8};
    	$.ajax({
			url:'/Megabox/SeatDAO',
			type : 'POST',
			data:listInfo,
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
			success:function(){
				alert("예매가 완료되었습니다.");
				$(location).attr('href', 'mainpage.jsp');
			},
			error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
    	
	});
});



var adult = Number(0);
var children = Number(0);
var disabled = Number(0);
var total = Number(0); //총 인원 카운트 
var price = Number(0);
var seatCnt = Number(0); //선택된 좌석 수 카운트

//초기화
function reset() {
	
    console.log("리셋댐?");
    /*변수 초기화 */
    adult = 0;
    children = 0;
    disabled = 0;
    total = 0;
    price = 0;
    seatCnt = 0;

    /*버튼 값 초기화*/
    $(".adult").text(adult);
    $(".children").text(children);
    $(".disabled").text(disabled);

    /*selected 좌석 해제*/
    $("button[selected]").removeClass("seat-condition on choice").addClass("seat-condition common").removeAttr("selected");

    /* 가격과 인원정보 */
    price = Number(adult * 11000 + children * 9000 + disabled * 5000);
    $(".money").children().eq(0).text(price);
    if($(".pay-area>.count").children.length!=0){
        $(".pay-area>.count").empty();
    }

    /* 좌석 */
    $('.my-seat').children().css("background-color", "#333333").text("-");

    
}

$(function () {

    //초기화 버튼 
    $("#seatMemberCntInit").click(function () {
        $("#layerId_030983947233653875").show();
        $(".alertStyle").show();

        $(".lyclose").click(function(){
            $("#layerId_030983947233653875").hide();
            $(".alertStyle").hide();
        });$(".btn-layer-close").click(function(){
            $("#layerId_030983947233653875").hide();
            $(".alertStyle").hide();
        });
        //확인시 reset 
        $("#layerId_030983947233653875 .confirm").click(function(){
            console.log("리셋 확인");
            $("#layerId_030983947233653875").hide();
            $(".alertStyle").hide();
            reset();
        });
       
    });

    //인원 증가 
    $("button.up").click(function () {
        //최대인원 8명
        if (total === 8) {
            alert("인원은 8명까지 선택 가능합니다.");
            return false;
        }
        //성인,청소년,우대 판별 
        var kind = $(this).attr("id");
        if (kind == 'adult') {
            adult++;
            $(".adult").text(adult);
        } else if (kind === 'children') {
            children++;
            $(".children").text(children);
        } else if (kind === 'disabled') {
            disabled++;
            $(".disabled").text(disabled);
        }
        total = Number(adult + children + disabled);
        price = Number(adult * 11000 + children * 9000 + disabled * 5000);

        //선택좌석 안내 
        $('.my-seat').children().eq((total - 1)).css("background-color", "#54565B").text("-");

        //짝수 홀수 좌석 라인 변경
        if (total == 1) {

            for (var i = 0; i < 20; i++) {
                $("button[seatno=" + (2 * i + 1) + "]").addClass("seat-condition finish");
            }
        } else {

            for (var i = 0; i < 20; i++) {
                $("button[seatno=" + (2 * i + 1) + "]").removeClass("seat-condition finish");
                $("button[seatno=" + (2 * i + 1) + "]").addClass("seat-condition common");
            }
        }
    });
    //인원 감소
    $("button.down").click(function () {
    	//각각 성인, 청소년, 우대일 떄
        var kind = $(this).attr("id");
        if (kind === 'adult') {
            //0명 이하는 지정할 수 없음
            if (adult === 0) return false;
            //선택된 좌석이 있을때 인원 수 감소시 초기화 됨
            if (seatCnt > 0) { 
	            $("#layerId_030983947233653875").show();
	            $(".alertStyle").show();
	    
	            $(".lyclose").click(function(){
	                $("#layerId_030983947233653875").hide();
	                $(".alertStyle").hide();
	                return false;
	            });$(".btn-layer-close").click(function(){
	                $("#layerId_030983947233653875").hide();
	                $(".alertStyle").hide();
	                return false;
	            });
	            $(".confirm").click(function(){
	                reset();
	                $("#layerId_030983947233653875").hide();
	                $(".alertStyle").hide();
	            });
            }
            else{
                adult--;
                $(".adult").text(adult);
            }
        } else if (kind === 'children') {
            //0명 이하는 지정할 수 없음
            if (children == 0) return false;
              //선택된 좌석이 있을때 인원 수 감소시 초기화 됨
            if (seatCnt > 0) { 
                $("#layerId_030983947233653875").show();
                $(".alertStyle").show();
        
                $(".lyclose").click(function(){
                    $("#layerId_030983947233653875").hide();
                    $(".alertStyle").hide();
                    return false;
                });$(".btn-layer-close").click(function(){
                    $("#layerId_030983947233653875").hide();
                    $(".alertStyle").hide();
                    return false;
                });
                $("#layerId_030983947233653875 .confirm").click(function(){
                    reset();
                    $("#layerId_030983947233653875").hide();
                    $(".alertStyle").hide();
                });
            }
            else{
            children--;
            $(".children").text(children);
            }
        } else if (kind === 'disabled') {
            //0명 이하는 지정할 수 없음
            if (disabled == 0) return false;
            //선택된 좌석이 있을때 인원 수 감소시 초기화 됨
            if (seatCnt > 0) { 
                $("#layerId_030983947233653875").show();
                $(".alertStyle").show();
        
                $(".lyclose").click(function(){
                    $("#layerId_030983947233653875").hide();
                    $(".alertStyle").hide();
                    return false;
                });$(".btn-layer-close").click(function(){
                    $("#layerId_030983947233653875").hide();
                    $(".alertStyle").hide();
                    return false;
                });
                $("#layerId_030983947233653875 .confirm").click(function(){
                    reset();
                    $("#layerId_030983947233653875").hide();
                    $(".alertStyle").hide();
                });
            }else{
            disabled--;
            $(".disabled").text(disabled);
            }
        }
          
        /* 좌석 */
        total = Number(adult + children + disabled);
        $('.my-seat').children().eq((total)).css("background-color", "#333").text("-");
            

        //짝수 홀수 좌석 라인 변경 
        if (total % 2 == 0) {
            for (var i = 0; i < 20; i++) {
                $("button[seatno=" + (2 * i + 1) + "]").removeClass("seat-condition finish");
                $("button[seatno=" + (2 * i + 1) + "]").addClass("seat-condition common");
            }
        } else if (total == 1) {

            for (var i = 0; i < 20; i++) {
                $("button[seatno=" + (2 * i + 1) + "]").addClass("seat-condition finish");
            }
        }
    });

    /*좌석 선택 */
    var seatnum = null; //A17의 '17'
    var row = null; //A17의 'A'

    $("button.jq-tooltip").on({
        //좌석 mouseover시 보라색으로 영역 보여줌 
        mouseover: function () {
            seatCnt = $("button[selected='selected']").length;
            console.log("현재 선택된 좌석 수 " + $("button[selected='selected']").length);
            //선택인원이 1명일 떄 (선택인원이 없을 때 mouseover 작동 안함)
            if (total === 1) {
                $(this).addClass("seat-condition choice");
            }
            //선택인원이 2명 이상일 때 
            if (total >= 2) {
                console.log("total : " + total + " seatCnt : " + seatCnt);
                //홀수명 선택시 나머지 1명일 때 
                if ((total - seatCnt) === 1) {
                    $(this).addClass("seat-condition choice");
                }
                //짝수명 선택 
                else {
                    $(this).addClass("seat-condition choice");
                    seatnum = Number($(this).attr("seatno"));
                    //선택한 좌석이 2k+2(짝수)번호일때 2k+1,2k+2 선택 (k=0) 
                    //선택한 좌석이 2k+1(홀수)번호일때 2k+1,2k+2 선택 (k=0)
                    row = $(this).attr("rownm");
                    if (seatnum % 2 == 1) {
                        $("button[rownm=" + row + "][seatno=" + seatnum + "]").addClass("seat-condition choice");
                        $("button[rownm=" + row + "][seatno=" + (seatnum + 1) + "]").addClass("seat-condition choice");
                    }
                    else {
                        $("button[rownm=" + row + "][seatno=" + seatnum + "]").addClass("seat-condition choice");
                        $("button[rownm=" + row + "][seatno=" + (seatnum - 1) + "]").addClass("seat-condition choice");
                    }
                }
            }
        },
        //좌석을 클릭해서 선택함 
        click: function () {
            //선택된 좌석을 다시 클릭시 해제됨
            if ($(this).is('[selected]')) {
                /*selected 좌석 해제*/
                seatnum = Number($(this).attr("seatno"));
                row = $(this).attr("rownm");
                if (seatnum % 2 == 1) {
                    $("button[rownm=" + row + "][seatno=" + seatnum + "]").removeClass("on choice").removeAttr("selected");
                    $("button[rownm=" + row + "][seatno=" + (seatnum + 1) + "]").removeClass("on choice").removeAttr("selected");
                }
                else {
                    $("button[rownm=" + row + "][seatno=" + seatnum + "]").removeClass("on choice").removeAttr("selected");
                    $("button[rownm=" + row + "][seatno=" + (seatnum - 1) + "]").removeClass("on choice").removeAttr("selected");
                }
                /*좌석 정보 */
                //좌석 우선 초기화 
                for(var j=0;j<seatCnt;j++){
                $('.my-seat').children().eq(j).css("background-color", "#54565B").text("-");  }
                //우측 좌석 정보 표 
                 $('button[selected="selected"]').each(function(index,item) {
                    item=$(this).attr("rownm")+$(this).attr("seatno");
                    $('.my-seat').children().eq(index).css("background-color", "#503396").text(item);  
                });
            }
            //좌석 선택 
            else {
                seatCnt = $("button[selected='selected']").length;
                //인원이 0명일때 클릭이 안 됨
                if (total === 0) { alert("인원을 먼저 선택해 주세요!"); return false; }
                //인원 1명일 때 
                if (total === 1 || ((total - seatCnt) === 1)) {
                    //초과된 인원을 선택
                    if (total <= seatCnt) {
                        $('.alertStyle').show();
                        $("#layerId_08010659137218192").show();

                        $(".btn-layer-close").click(function () {
                            $(".alert-popup").hide();
                            $(".alertStyle").hide();
                        });
                        $("#layerId_08010659137218192 > .wrap > .layer-con >.btn-group > .confirm").click(function () {
                            console.log("초과된 인원 확인");
                            $(".alert-popup").hide();
                            $(".alertStyle").hide();
                        });
                        return false;
                    }
                    //finish된 좌석을 선택시 
                    if( $(this).hasClass('finish')===true){return false;}
                    //선택된 좌석 selected 속성 추가
                    $(this).attr("selected", "selected");
                    //selected된 좌석에 on choice 추가 
                    $('button[selected="selected"]').addClass("seat-condition on choice");
                    //선택된 좌석 수
                    seatCnt = $("button[selected='selected']").length;
                    

                    //좌석 선택
                    seatnum = Number($(this).attr("seatno"));
                    row = $(this).attr("rownm");
                    $('.my-seat').children().eq(seatCnt - 1).text(row + seatnum).css("background-color", "#503396");

                }
                //인원 2명이상일 때 
                else {
                    //초과된 인원을 선택
                    if (total <= seatCnt) {
                        $('.alertStyle').show();
                        $("#layerId_08010659137218192").show();

                        $(".btn-layer-close").click(function () {
                            $(".alert-popup").hide();
                            $(".alertStyle").hide();
                        });
                        $("#layerId_08010659137218192 .confirm").click(function () {
                            console.log("초과된 인원 확인");
                            $(".alert-popup").hide();
                            $(".alertStyle").hide();
                        });
                        return false;
                    }
                    //finish된 좌석을 선택시 retrun false 
                    if( $(this).hasClass('finish')===true){return false;}

                    seatnum = Number($(this).attr("seatno"));
                    row = $(this).attr("rownm");

                    //total이 홀수일 때 : 4명선택 후 1명이 남았을 때 
                    if (seatnum % 2 == 1) {
                        //선택된 좌석 selected 속성 추가
                        $("button[rownm=" + row + "][seatno=" + seatnum + "]").attr("selected", "selected");
                        $("button[rownm=" + row + "][seatno=" + (seatnum + 1) + "]").attr("selected", "selected");
                        seatCnt = $("button[selected='selected']").length;
                    }
                    //total이 짝수일 때 
                    else {
                        $("button[rownm=" + row + "][seatno=" + seatnum + "]").attr("selected", "selected");
                        $("button[rownm=" + row + "][seatno=" + (seatnum - 1) + "]").attr("selected", "selected");
                        seatCnt = $("button[selected='selected']").length;
                    }

                    //selected한 좌석 표시
                    $('button[selected="selected"]').addClass("seat-condition on choice");

                    //선택된 좌석 표시 
                    $('.my-seat').children().eq(seatCnt - 2).text(row + seatnum).css("background-color", "#503396");
                    $('.my-seat').children().eq(seatCnt - 1).text(row + (seatnum + 1)).css("background-color", "#503396");
                }
            }

            
            /* 가격과 인원정보 */
            $(".money").children().eq(0).text(price);
            if($(".pay-area>.count").children.length!=0){
                $(".pay-area>.count").empty();
            }
            if(adult>0){
                $(".pay-area>.count").append("<span>"+ "성인"  +"<em>"+ adult  +"</em></sapn>");                     
            }if(children>0){
                $(".pay-area>.count").append("<span>"+ "청소년"  +"<em>"+ children  +"</em></sapn>");    
            }if(disabled>0){
                $(".pay-area>.count").append("<span>"+ "우대"  +"<em>"+ disabled  +"</em></sapn>");    
            }
            
        },
        //좌석 mouseleave시 common 상태
        mouseleave: function () {
            //선택한 좌석이 2k+2(짝수)번호일때 2k+1,2k+2 선택 (k=0) 
            //선택한 좌석이 2k+1(홀수)번호일때 2k+1,2k+2 선택 (k=0)
            $(this).addClass("seat-condition choice");
            seatnum = Number($(this).attr("seatno"));
            row = $(this).attr("rownm");

            if (seatnum % 2 == 1) {
                $("button[rownm=" + row + "][seatno=" + seatnum + "]").removeClass("seat-condition choice");
                $("button[rownm=" + row + "][seatno=" + seatnum + "]").addClass("seat-condition common");
                $("button[rownm=" + row + "][seatno=" + (seatnum + 1) + "]").removeClass("seat-condition choice");
                $("button[rownm=" + row + "][seatno=" + (seatnum + 1) + "]").addClass("seat-condition common");
            }
            else {
                $("button[rownm=" + row + "][seatno=" + seatnum + "]").removeClass("seat-condition choice");
                $("button[rownm=" + row + "][seatno=" + (seatnum - 1) + "]").removeClass("seat-condition choice");
                $("button[rownm=" + row + "][seatno=" + seatnum + "]").addClass("seat-condition common");
                $("button[rownm=" + row + "][seatno=" + (seatnum - 1) + "]").addClass("seat-condition common");
            }

        }
    });
});