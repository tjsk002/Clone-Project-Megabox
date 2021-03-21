
	


$(function () {
	    $('.menuBtn').click(function(){
	        $('.menuBtn_sitemap').show();
	        $('.menuClose').show();
	    });
	    $('.menuClose').click(function(){
	        $('.menuBtn_sitemap').hide();
	        $('.menuClose').hide();
	    })   
	});




$(function () {
	    $('.searchBtn').click(function(){
	        $('.searchBtn_sitemap').show();
	        $('.searchClose').show();
	    });
	    $('.searchClose').click(function(){
	        $('.searchBtn_sitemap').hide();
	        $('.searchClose').hide();
	    })   
	});



$(function () {
	    $('.searchBtn').click(function(){
	        $('.searchBtn_sitemap').show();
	        $('.searchClose').show();
	    });
	    $('.searchClose').click(function(){
	        $('.searchBtn_sitemap').hide();
	        $('.searchClose').hide();
	    })   
	});

$(function () {

        
            /*영화 줄거리, 정보 오버레이*/
            
            $('li').hover(function () {
                var idx = $(this).index() + 1;
                $('li.movie-group.' + idx + '>.movie-post>.movie-summ').show();
            }, function () {
                var idx = $(this).index() + 1;
                $('li.movie-group.' + idx + '>.movie-post>.movie-summ').hide();
            })

            /*하트버튼*/
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
    	    					console.log(data);
    	    					var num = data.split('x')[1];
    	    					console.log(num);
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
    	    					console.log(num);
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
            
            
//            
//             var click = true;
//            $('.heart').click(function () {
//                if (click == true) {
//                    
//                    console.log(click);
//                    $(this).children().eq(0).attr("src", "image/heart_1.png")
//                 
//                    var likeNum=$(this).children().eq(1).text();
//                    console.log(likeNum);
//                    likeNum++;
//                    $(this).children().eq(1).text(likeNum);
//                    click = false;
//
//                } else {
//                    $(this).children().eq(0).attr("src", "image/heart_.png")
//
//                    // var likeNum=$('.heart').index();
//                     var likeNum=$(this).children().eq(1).text();
//                     console.log(likeNum);
//                    likeNum--;
//                    $(this).children().eq(1).text(likeNum);
//                    click = true;
//                }
//               
//            });
          
    
            
           
            
            
//            /*더보기 수정필요!!!*/
//            var total = 15; /*상영중인 영화*/
//            var rest = total % 4;
//
//
//            $('.show-more').click(function () {
//                var num = $('ol li').length;
//                console.log(num);
//                var $Element = $('#test');
//
//                function addDiv() {
//                    $('ol').append($Element.clone());
//                }
//
//
//                if (total - num < 4) {
//                    for (var i = 0; i < rest; i++) {
//                        $Element.attr('class', 'movie-group ' + (i + num + 1));
//                        addDiv();
//                        rankingMovie();
//                    }
//                }
//                else {
//
//                    for (var i = 0; i < 4; i++) {
//                        $Element.attr('class', 'movie-group ' + (i + num + 1));
//                        addDiv();
//                        rankingMovie();
//                    }
//
//                }
//
//            });


        })
        
 
