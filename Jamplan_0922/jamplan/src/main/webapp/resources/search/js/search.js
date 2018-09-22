/**
 * 
 */
$(document).ready(function(){ /* (document).ready는 html문서가 로딩이완료되면 자동으로 실행 */
	//목록
	function selectData(){ 
		//table내부 내용을 제거(초기화), 동적으로 제거
		
		
		
		
		
		
		/*
 		$('#scdIdCheck').click(function) {
			schedulePage 뿌려줄 function기능 넣기
		} 
		*/
		
		
		/*
		//로그인한 유저인지 체크..
		 //id session check
  		$('#scdIdCheck').click(function(){
		var checkID = null;
		if(session.getAttribute("checkID") != null) {
			alert("로그인 성공!");
		}
		else {
			
		}
		}); */

		
		
		$.ajax({ //jquery에서 ajax호출할때 사용하는 방식 / jQuery.ajax=$.ajax : jquery 표현하는방식 2가지 
			url:'/jamplan/getPlanList.search',
			type:'POST',
			dataType:"json",
			contentType:'application/x-www-form-urlencoded; charset=utf-8',
			success:function(data){ // 응답(getPeopleJSON.do)이 존재하면 함수 실행된다. ,  getPeopleJSON.do에서 실행한 값이 data에 저장된다
				$.each(data, function(index, item){ // data 는 PeopleVO의 list들이 저장되어 item에 값(항목들)이 주어진다. / each는 data가 가지고있는 값만큼 반복수행하게해준다.(각각의데이터접근시)
					var output = '';
					output += '<div class="col-sm-4">';
					output += '<div class="card cardMargin" style="width : 80%">';
					output += '<div><a href = "schedule.search?planNo='+ item.planNo +'"><img src="/jamplan/image/' + item.image + '" style="width:100%; height:60vh;"  />' + '</a></div>';
					output += '<div class="card-body">';
					output += '<span>' + item.selectDate + '</span>' + '&nbsp' + '&nbsp';
					output += '<span>' + item.planName + '</span>' + '&nbsp' + '&nbsp';
					output += '<button class="btn">' + item.readCount + '</button>' + '&nbsp';
					output += '<span class="goodCount"><h5><i class="fas fa-heart " style= "color : #E75450;"  >'+'&nbsp' + item.goodCount + '</i><h5></span>' + '&nbsp' + '&nbsp';
					output += '</div>';
					output += '</div>';
					output += '</div>';
					console.log("output:" + output);
					$('#output').append(output);
				});
			},
			error:function(){
				alert("ajax통신 실패!!!");
			}
		});
	}
	
	
	
	
	
	
	//이미지클릭시 스케쥬럴로click 시 planName 정보를 받아서 전달할수있게, 이미지를눌렀을때 보내는것, 나중에 코딩해보기.
	$('#이미지_클릭').click(function(event){
		var params = $("#이미지_폼").serialize(); // serialize - 직렬화(문자열) 시켜주는것 ex) id=O&name=O&.... 식으로 (키&밸류) 5가지던 100가지던 문자열형태로로..
		jQuery.ajax({
			url : '/jamplan/이미지컨트롤러',
			type : 'POST',
			data : params,
			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			dataType : "json",
			success : function (retVal) { // retVal 에 PeopleController-/insertPerson.do의 return retVal값이 담긴다
				if (retVal.res == "OK") {
					//데이터 성공일때 이벤트 작성
					selectData();
					//스케쥴러뿌려줄양식
					//코딩
				}
				else
					{
						alert("Insert Fail!!!");
					}
			},
			error:function(){
				alert("ajax통신 실패!!!");
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});

	
	 $('.li1').click(function(){
			
			var name = $(this).html();
			console.log(name);
			$('.dropdown-toggle').html(name);
			
			if (name == '날짜') {
				$('#dateCheck').css('display', 'block');
			}
			else {
				$('#dateCheck').css('display', 'none');
			}
		});
	 
	
	
	
	 var tagEvent = '';
	 $('.tag').click(function (){ 
         
    	var params = {};
    	//var name = $(this).html();
    	var tagEvent = $('.dropdown-toggle').html();
    	alert(tagEvent);
    	switch(tagEvent) {
    		case '날짜' :
    			params = {'selectDate' : $('.form-control').val()};
    			console.log("날짜");
    			break;
    		case '제목' :
    			params = {'planName' : $('.form-control').val()};
    			console.log("제목");
    			alert(params);
    			break;
           //날짜값 자르는 변수하나 만들어줘서 넘기자.   
     
      
      
	    
    			
    	}
    	  alert("3");
         $.ajax({
        	 url:'/jamplan/planSearch.search',
            type:'POST',
            dataType: "json",
            contentType : 'application/x-www-form-urlencoded; charset=utf-8',
            data : params,
            	/* {
            	'planDate' : $('.form-control').val()
            	//위의 코딩은 예제로 일정네임으로 검색할수있게해준것, 조회수,추천순,최신순,날짜순 출력하수있게 하기
            }, */
            
         	success:function(data) {
         

           $('#output').empty();
            /* alert(data); */
        	 $.each(data, function(index, item){ 
        		 /* alert(item.image); */
					var output = '';
					output += '<div class="col-sm-4">';
					output += '<div class="card cardMargin" style="width : 80%">';
					output += '<div><a href = "schedule.search?planNo='+ item.planNo +'"><img src="/jamplan/image/' + item.image + '" style="width:100%; height:60vh;"  />' + '</a></div>';
					output += '<div class="card-body">';
					output += '<span>' + item.selectDate + '</span>' + '&nbsp' + '&nbsp';
					output += '<span>' + item.planName + '</span>' + '&nbsp' + '&nbsp';
					output += '<button class="btn">' + item.readCount + '</button>' + '&nbsp';
					output += '<span class="goodCount"><h5><i class="fas fa-heart " style= "color : #E75450;"  >'+'&nbsp' + item.goodCount + '</i><h5></span>' + '&nbsp' + '&nbsp';
					output += '</div>';
					output += '</div>';
					output += '</div>';
					console.log("output:" + output);
					$('#output').append(output);
				});
			},
			error:function(){
				alert("ajax통신 실패!!!");
			}
		});         
      

	 }); 
	
      
      
      var clickevent = '';
      $('.clk').click(function(event){
    	  
         var params = {};
          var clickevent = $(this).attr('id');
          alert(clickevent);
            switch(clickevent) {
              case 'newDateClick':
            	  params = {'selectDate' : 'a'};
            	  alert(params);
                  break;
              case 'readCountClick':
            	   params = {'readCount' : 1};
                  break;
              case 'goodCountClick':
            	   params = {'goodCount' : 2};
                  break;
              case 'dateClick':
            	   params = {'planName' : 'b'};
            	   alert(params);
                  break;
            }
  		
  		jQuery.ajax({
  			url : '/jamplan/clickSearch.search',
  			type : 'POST',
  			data : params,
  			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
  			dataType : "json",
  			success : function (data) { // retVal 에 PeopleController-/insertPerson.do의 return retVal값이 담긴다
  				
  				$('#output').empty();
  	            //alert(data);
  	        	 $.each(data, function(index, item){ 
  	        		 //alert(item.planName);
  						var output = '';
  						output += '<div class="col-sm-4">';
  						output += '<div class="card cardMargin" style="width : 80%">';
  						output += '<div><a href = "schedule.search?planNo='+ item.planNo +'"><img src="/jamplan/image/' + item.image + '" style="width:100%; height:60vh;"  />' + '</a></div>';
  						output += '<div class="card-body">';
  						output += '<span>' + item.selectDate + '</span>' + '&nbsp' + '&nbsp';
  						output += '<span>' + item.planName + '</span>' + '&nbsp' + '&nbsp';
  						output += '<button class="btn">' + item.readCount + '</button>' + '&nbsp';
  						output += '<span class="goodCount"><h5><i class="fas fa-heart " style= "color : #E75450;"  >'+'&nbsp' + item.goodCount + '</i><h5></span>' + '&nbsp' + '&nbsp';
  						output += '</div>';
  						output += '</div>';
  						output += '</div>';
  						console.log("output:" + output);
  						$('#output').append(output);
  					});
  				},
  				error:function(){
  					alert("ajax통신 실패!!!");
  				}
  			}); 
  	});
      
      
  	

      
      
  	
  	selectData();
  }); 