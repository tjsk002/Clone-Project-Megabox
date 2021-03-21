	$(function () {
		
		/*메뉴 바*/
	    $('.menuBtn').click(function(){
	        $('.menuBtn_sitemap').show();
	        $('.menuClose').show();
	    });
	    $('.menuClose').click(function(){
	        $('.menuBtn_sitemap').hide();
	        $('.menuClose').hide();
	        
	    });
	    
	    /*영화 줄거리*/
        
        $('ol').hover(function () {
            var idx = $(this).index() + 1;
            console.log
            $('ol.movie-group.' + idx + ' .movie-post>.movie-summ').show();
        }, function () {
            var idx = $(this).index() + 1;
            $('ol.movie-group.' + idx + ' .movie-post>.movie-summ').hide();
        });
        
        $('.searchBtn').click(function(){
	        $('.searchBtn_sitemap').show();
	        $('.searchClose').show();
	    });
	    $('.searchClose').click(function(){
	        $('.searchBtn_sitemap').hide();
	        $('.searchClose').hide();
	    });
	    
	    $('.mymegaBtn').click(function(){
	        $('.mymegaBtn_sitemap1').show();
	        $('.mymegaClose').show();
	    });
	    $('.mymegaClose').click(function(){
	        $('.mymegaBtn_sitemap1').hide();
	        $('.mymegaClose').hide();
	    });
	    
	    $('.movieBtn').hover(function(){
	        $('.movieBtn_menu').show();}
	        , function(){$('.movieBtn_menu').hide();
	    }); 
	    
	    $('.reserveBtn').hover(function(){
	        $('.reserveBtn_menu').show();}
	        , function(){$('.reserveBtn_menu').hide();
	    }); 
	});


	
	
	//로그인 팝업
	$(function(){
	    $("#loginbringPopup").click(function(){
	        $("#loginpopup").show();
	    });
	    
	    $("img").click(function(){
	        $("#loginpopup").hide();
	    })
	    $(".confirm").click(function(){
	        $("#loginpopup").hide();
	    })

	    //main_page.jsp 240줄 수정 필요
//	    $(".buttonLogin").click(function(){
//	    	console.log("ㅁㅁㅇㅁㄴ");
//			$("#loginpopup").show();
//		});
	
	   
	})
	 
	
	
	$(function(){
		$("#ibxLoginPwd").on("keyup", function(){
			if($("#ibxLoginPwd").val().length >= 1 && ($("#ibxLoginId").val().length >= 1)){
				$(".button").css("background-color", "#503396").css("color", "#fff");
			}
		});
	    
	    $("button.heart").click(function(){
	    	if($(this).hasClass("click")){
	    		if($(this).children().attr("src")=='image/heart_1.png'){
	    			var title = $(this).prev().text().split(",")[0];
	    			var userid = $(this).prev().text().split(",")[1];
	    			var parameters = {"userid" : userid, "title" : title};
	    		
	    			$.ajax({
	    				url:'/Megabox/MinusLikeDAO',
	    				type : 'POST',
	    				dataType:'text',//받아올 데이터 타입
	    				data:{"userid" : userid, "title" : title},
	    				context : this,
	    				success:function(data){
	    					var num = data.split('x')[1];
	    					$(this).children().attr("src",'image/heart_.png');
	    					$(this).children().next().text(num);
	    				},
	    				error:function(request,status,error){
	    					console.log("유감");
	    					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    				}
	    			});
	    		}else if($(this).children().attr("src")=='image/heart_.png'){
	    			var title = $(this).prev().text().split(",")[0];
	    			var userid = $(this).prev().text().split(",")[1];
	    			var parameters = {"userid" : userid, "title" : title};
	    		
	    			//console.log(JSON.stringify(parameters));
	    			$.ajax({
	    				url:'/Megabox/AddLikeDAO',
	    				type : 'POST',
	    				dataType:'text',//받아올 데이터 타입
	    				data:{"userid" : userid, "title" : title},
	    				context : this,
	    				success:function(data){
	    					var num = data.split('x')[1];
	    					$(this).children().attr("src",'image/heart_1.png');
	    					//총 하트 수도 변경해 줘야함.
	    					$(this).children().next().text(num);
	    					
	    				},
	    				error:function(request,status,error){
	    					console.log("유감");
	    					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    				}
	    			});
	    		}
	    	}else{
	    		return false;
	    	}
	    });
	    
	});
