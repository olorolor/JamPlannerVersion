/**
 * 
 */
var teamName = "";
var planName = "";
					

$(document).ready(function() {
	// 페이지가 로드되면 바로 받은 메시지를 보여준다.
/* sendMessage(); */

// 로드 되면 업데이트 사항 바로 보여준다.

// 로드 되면 출력한다.
	ajaxGetTeamList();
	noticeMessage();
	$(".move").on("click",function(){
		var planNo = $(this).attr("value");
		//console.log(planNo);
		//alert("planNo : " + planNo);
		planClickEvent(planNo);
		
	})
	
	/*.css('visibility', 'hidden');*/
	
	$(".btn.btn-outline-light.text-dark.border-0.teamList").on("click", function(){
		$(".collapse.planlist").css('visibility', 'hidden');
	})
	
	//팀장이 해당 팀에 신청을 한 유저의 요청을 수락 할 때
/*	alert("?");
		var header = new Array();
		
		$("#messageTable tr td").each(function(i, v){
	        header[i] = $(this).text();
	        alert($(this).text());
		})*/
		
	$(document).on("click","button.acceptTeamBut",function(){
		//alert("팀원초대 이벤트");
		//console.log($(this));
		console.log($(this).data("teamName"));
		console.log($(this).data("sender"));
		var index1 = $(this).data("trIndex");
		$.ajax({
			url : '/jamplan/acceptToMember.do',
			type : 'POST',dataType : 'json',
			contentType : 'application/x-www-form-urlencoded;charset=utf-8',
			data :{'sender':$(this).data("sender"),
				   'teamName':$(this).data("teamName")},
			success : function(data) {
				//alert("팀원초대 성공");
				console.log(index1);
				$('#tr'+index1).remove();
			},
			erorr : function(data){
				alert("팀원초대 실패");
			}
		})
		
		//$()
	})
	
	$(document).on("click", "button.rejectTeamBut", function(){
		var teamName = $(this).attr("value");
		var sender = $(this).data("sender");
		var index1 = $(this).data("trIndex");
		deleteMessageTR(teamName,sender,index1)
			});
	$(document).on("click", "button.applyButCan", function(){
		alert("팀 신청 취소");
		var teamName = $(this).attr("value");
		//var sender = $(this).data("sender");
		deleteMessage(teamName)
			});
	$(document).on("click", "button.deleteMessageBut", function(){
		var teamName = $(this).attr("value");
		//var sender = $(this).data("sender");
		deleteMessage(teamName)
			});
			
	//메세지 클릭 이벤트
	$("#messageBut").click(function(){
		//alert("메세지 클릭 이벤트");
		//server에서 id값으로 메세지 테이블 값 가져오기
		$("#messageContent").empty();
		$("#countLabel").empty();
		$.ajax({
			url : '/jamplan/getMessageById.do',
			type : 'POST',dataType : 'json',
			contentType : 'application/x-www-form-urlencoded;charset=utf-8',
			async: false,
			success : function(data) {
				//alert("메세지 리스트 가져오기 성공");
				
				var notReadMessageCount = "";
				var messageHtml = "<table id = 'messageTable'></table>";
				$("#messageContent").append(messageHtml);
			
				$.each(data,function(index,item) {
					//console.log(index);
					//console.log(item.sender);
					//console.log(item.teamName);
					//메세지 분류하기
					if(item.isRead == 0){ //팀장이 안 읽은 "신청" 메세지
						messageHtml='';
						messageHtml += '<tr id = tr'+ index+'><td>'+item.sender + '님이 ' + item.teamName + '에 신청을 하셨습니다.' 
									+ '<span class="label label-primary messageNew"></span>'
									+ "<button id = acceptTeam"+index+" class = 'btn btn-primary acceptTeamBut'>수락</button>" 	
									+ "<button id = rejectTeamBut"+index+" class = 'btn btn-primary rejectTeamBut' value = "+item.teamName+">거절</button></td></tr>";
						
						$("#messageTable").append(messageHtml);
						$("#acceptTeam"+index).data("sender",item.sender);
						$("#acceptTeam"+index).data("teamName",item.teamName);
						$("#acceptTeam"+index).data("trIndex" ,index);
						$("#rejectTeamBut"+index).data("sender",item.sender)
						$("#rejectTeamBut"+index).data("trIndex",index);
						//console.log($("#acceptTeam"+index).data("trIndex"));
						//$(".table"+item.teamName).data("teamName")

					}else if(item.isRead == 1){//팀장이 이미 읽은 "신청" 메세지
						messageHtml='';
						messageHtml += '<tr id = tr'+ index+'><td>'+item.sender + '님이 ' + item.teamName + '에 신청을 하셨습니다.'
									+"<button id = acceptTeam"+index+" class = 'btn btn-primary acceptTeamBut'>수락</button>" 
									+"<button id = rejectTeamBut"+index+" class = 'btn btn-primary rejectTeamBut' value = "+item.teamName+">거절</button></td></tr>";
						$("#messageTable").append(messageHtml);
						$("#acceptTeam"+index).data("sender",item.sender);
						$("#acceptTeam"+index).data("teamName",item.teamName);
						$("#acceptTeam"+index).data("trIndex" ,index);
						$("#rejectTeamBut"+index).data("sender",item.sender)
						$("#rejectTeamBut"+index).data("trIndex",index);
						//console.log($("#acceptTeam"+index).data("trIndex"));  rejectTeamBut i    canTeam i

					}else if(item.isRead == 2){//팀원에 신청을 한 유저가  "팀에 초대 수락 알림"을 받고 안 읽음
						messageHtml='';
						messageHtml += '<tr id = tr'+ index+'><td>'+item.receiver + '님 축하 드립니다. ' + item.teamName + '에 초대 되셨습니다.'
									+ '<span class="label label-primary messageNew"></span>'
									+"<button id = canTeam "+index+ " class = 'btn btn-primary deleteMessageBut'  value = "+item.teamName+">삭제</button></td></tr>";
						$("#messageTable").append(messageHtml);
						$("#canTeam"+index).data("sender",item.receiver);
						$("#canTeam"+index).data("teamName",item.teamName);
						$("#acceptTeam"+index).data("trIndex" ,index);
						$("#rejectTeamBut"+index).data("trIndex",index);
					}else if(item.isRead == 3){//팀원에 신청을 한 유저가  "팀에 초대 수락 알림"을 받고 읽음
						messageHtml='';
						messageHtml += '<tr id = tr'+ index+'><td>'+item.receiver + '님 축하 드립니다. ' + item.teamName + '에 초대 되셨습니다.'
									+"<button id = canTeam "+index+ " class = 'btn btn-primary deleteMessageBut'  value = "+item.teamName+">삭제</button></td></tr>";
						$("#messageTable").append(messageHtml);
						$("#canTeam"+index).data("sender",item.receiver);
						$("#canTeam"+index).data("teamName",item.teamName);
						$("#acceptTeam"+index).data("trIndex" ,index);
						$("#rejectTeamBut"+index).data("trIndex",index);
					}else if(item.isRead == 4){//팀원에 신청을 한 유저가  "팀에 초대 거절 알림" 을 받고  안 읽음
						messageHtml='';
						messageHtml += '<tr id = tr'+ index+'><td>'+item.receiver + '님 죄송하지만 ' + item.teamName + '팀에서 거절했습니다.'
									+ '<span class="label label-primary messageNew"></span>'
									+"<button id = canTeam "+index+ " class = 'btn btn-primary deleteMessageBut'  value = "+item.teamName+">삭제</button></td></tr>";
						$("#messageTable").append(messageHtml);
						$("#canTeam"+index).data("sender",item.receiver);
						$("#canTeam"+index).data("teamName",item.teamName);
						$("#acceptTeam"+index).data("trIndex" ,index);
						$("#rejectTeamBut"+index).data("trIndex",index);
					}else if(item.isRead == 5){//팀원에 신청을 한 유저가  "팀에 초대 거절 알림" 을 받고 읽음
						messageHtml='';
						messageHtml +='<tr id = tr'+ index+'><td>'+ item.receiver + '님 죄송하지만 ' + item.teamName + '팀에서 거절했습니다.'
									+"<button id = canTeam "+index+ " class = 'btn btn-primary deleteMessageBut'  value = "+item.teamName+">삭제</button></td></tr>";
						$("#messageTable").append(messageHtml);
						$("#canTeam"+index).data("sender",item.receiver);
						$("#canTeam"+index).data("teamName",item.teamName);
						$("#acceptTeam"+index).data("trIndex" ,index);
						$("#rejectTeamBut"+index).data("trIndex",index);
					}
			})

			$("#countLabel").append(notReadMessageCount);
			$(".messageNew").append("new");
			},
			error : function() {
				alert("메세지 리스트 가져오기 실패");
			}
		})
		
		$.ajax({
			url : '/jamplan/updateMessage.do',
			async: false,
			type : 'POST',dataType : 'json',
			contentType : 'application/x-www-form-urlencoded;charset=utf-8',
			success : function(data) {
				//alert("메세지 읾음 처리 완료")
			},
			erorr : function(data){
				alert("메세지 읾음 처리 실패")
			}
		})
		//
	})
	
	//요기
	
	$(document).on("click", "button.applyBut", function(){
		//alert("신청 버튼 이벤트 ")
		var teamName = $(this).attr("value");
		alert(teamName+"에 지원했습니다.");
		$.ajax({
			url : '/jamplan/applyToTeam.do',
			type : 'POST',
			data : {
					'teamName' : teamName,
					'isRead' : 0
					},
			dataType : 'json',
			contentType : 'application/x-www-form-urlencoded;charset=utf-8',
			success : function(data) {
				alert(data.res);
			},
			error: function(data){
				alert(data.res);
			}
		});
	})
	
	//$(".applyBut").on("click", function(){
	//	alert("applyBut 버튼 클릭 이벤트");
	//	
	//	});
	//})
	
	
	//applyBut,applyButCan
	// 팀명 클릭했을 경우 팀명을 보내고 해당 팀의 멤버들을 불러와야한다.
	
	/*
	* $('.teamList').click(function () { var params = $(this);
	* alert(params);
	* 
	* jQuery.ajax({ url : '/jamplan/ajaxPrintPlanList.do', type :
	* 'GET', data : { id: <%=id %>, teamName: params },
	* dataType : 'json', contentType :
	* 'application/x-www-form-urlencoded;charset=utf-8', //
	* check가 responsebody에서 오는 데이터를 받는다. success :
	* function(data) { alert(data); if(data == null) { var
	* nullPlan = ''; nullPlan += '<h4>일정을 만들어볼까요?</h4>';
	* $(this).append(nullPlan); }else {
	* $.each(data,function(index, item) { var planList = '';
	* planList += '<button class="btn btn-outline-light
	* text-dark border-0" id="myTeam' + index + '"' + '
	* data-toggle="collapse" data-target="#myPlan' + index +
	* '">' + item.teamName + '</button>' + '<div
	* class="collapse" id="myPlan' + index + '">' + 'hello' + '</div>';
	* $(this).append(planList);
	* 
	* });
	*  } }, error : function() { alert("일정 목록을 불러올 수 없습니다."); }
	* }); // 기본 이벤트 제거 event.preventDefault(); })
	*/
	
	$('#inputForm').click(function(event) {
			/*var params = $('#makeTeamForm').serialize();*/
			var teamName = $("#teamName").val();
			
			//alert("teamNmae: " + teamName);
			$.ajax({
					url : '/jamplan/makeTeam.do',
					type : 'POST',
					data : {"teamName" : teamName},
					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
					dataType : 'json',
					// check이 responsebody에서 오는
					// 데이터를 받는다.
					success : function(check) {
						if (check == "SUCCESS") {
							ajaxGetTeamList();
							// 초기화
							$('#teamName').val('');
						} else {
							alert("Insert Fail!!");
						}
					},
					error : function() {
						alert("에러 발생!!");
					}
				});
			// 기본 이벤트 제거
			//event.preventDefault();
		});
	
	// 팀 이름에 대해 유효성 체크하는 부분
	$('#validationCheck').click(function() {
		validationCheck();
	})
	
	// Add plan 버튼에 대한 클릭 이벤트 부분
	$('#addPlan').click(function() {
		$('#planSpace').empty();
		//일정 추가 버튼 클릭 시 추가 버튼 비활성화 > 팀을 선택한 이후 일정을 추가할 수 있도록
		$("#planAddModal").attr('disabled', 'true');
		//console.log('테이블 생성하는 부분까지는 들어옴');
		var html = '<table id="teamNameTable" class="table table-hover text-center">'
				+ '<thead><tr><th>No.</th><th>가입된 팀</th>'
				+ '</tr></thead><tbody>';
		//console.log('테이블 생성하기 직전');
		for (var index = 0; index < teamNameArray.length; index++) {
			html += '<tr><td>' + (index + 1)
					+ '</td><td class = "teamNameBox">' + teamNameArray[index] + '</td></tr>';
		}
	
		html += '</tbody></table>';
		//console.log('테이블 생성 태그는 모두 완성');
		$('#planSpace').append(html);
		//console.log('append했지만 과연??!!');
		
		planAddbut();
		addPlanToDB();

	});
	
	// Add plan 모달 창에서 테이블 내의 각 팀명 클릭 시, 팀명 값을 가져온다.
	$('#teamNameTable tr').click(function() {
	
		var teamNameTable = $('#teamNameTable').val();
		var str = '';
		var tr = $(this);
		var td = tr.children();
		
		// 값을 잘 받아왔는지 확인
		//console.log('td: ' + td);
		str = '' + td + '';
		
		$('#teamNameByTable').val(str);
		//alert($('#teamNameByTable').val());
	})
	
	// 업데이트된 사항이 있는지 5초마다 체크한다.
	var interval = setInterval(
	function() {
	var id = '<%=id %>';
	$('#updateSpace').empty();
	
	$.ajax({
			url : '/jamplan/updateCheck.do',
			type : 'POST',
			data : {
				id : id
			},
			dataType : 'json',
			contentType : 'application/x-www-form-urlencoded;charset=utf-8',
			success : function(data) {
				$.each(data, function(index,item) {
					var update = '';
							update += '<div class="media border p-3">' + '<img src="/jamplan/image/${user.image}"'
									+ 'alt="John Doe" class="mr-3 mt-3 rounded-circle" style="width:60px;">'
									+ '<div class="media-body">'
									+ '<h4>'+ item.planName+ '</h4>'
									+ '<p>일정에 변화가 있어요. 확인해 보세요.</p>'
									+ '</div>'+ '</div>'+ '</br></br>';
							$('#updateSpace').append(update);
						});
			},
			error : function() {
				alert("Error");
			}
		});
	
	}, 30000000)
	//요기
	// 팀검색을 시도할 경우 업데이트 사항 보여주기를 멈추고 비슷한 이름들의 팀을 나열해서 보여준다.
	$('#searchButton').click(function() {
			// updateSpace에 나오던 업데이트 작업을 중단한다.
			clearInterval(interval);
	
			var teamName = $('#searchTeamName').val();
	
			// 테이블 형태로 바꿔주기 위해 기존에 있던 업데이트 사항들을
			// 지워준다.
			$('.media.p-3').empty();
	
			var tableHead = '<table class="table table-hover">'+'<thead><tr>'+'<th scope="col">팀 이름 검색결과</th>'+'</thead></tr><tbody>';
	
			var tableTail = '</tbody></table>';
			var update = '';
			console.log('ajax전까지 ');
			$.ajax({
					url : '/jamplan/searchTeam.do',
					type : 'GET',
					data : {'teamName' : teamName},
					dataType : 'json',
					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
					success : function(data) {
						$.each(data, function(index, item) {			
								update += '<tr><td>'+ item.teamName+ '</td>'
								+ '<td class="tdOdd"><button class = "btn btn-primary applyBut" value = '+item.teamName+'>신청</button></td>'
								+ '<td class="tdOdd"><button class = "btn btn-danger applyButCan" value = '+item.teamName+'>취소</button></td></tr>';
								console.log("팀 검색 결과 : " + item.teamName);
							})
							//console.log("update 글 : " + update);
							tableHead += update;
							tableHead += tableTail;
							//$('tableTail').append(tableHead);
							$('#teamListSearch').append(tableHead);
						},
						error : function() {
							alert("searchTeam ERROR");
						}
				});
		});

})


//onready end===========================================================================
function deleteMessageTR(teamName, sender,index1){
	//alert("취소 버튼 이벤트 ")
	var teamNAME = teamName;
	var Sender = sender;
	var index2 = index1;
	alert("팀이름 : " + teamName);
	$.ajax({
		url : "/jamplan/deleteMessageToTeam.do",
		type : 'POST',
		data : {
				'teamName' : teamNAME,
				'sender' : Sender
				},
		dataType : 'json',
		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		success : function(data) {
			alert(data.res);
			$('#tr'+index2).remove();
		},
		error: function(data){ 
			alert(data.res);
		}
	});
}

function deleteMessage(teamName){
	//alert("취소 버튼 이벤트 ")
	var teamNAME = teamName;
	//alert("팀이름 : " + teamName);
	$.ajax({
		url : "/jamplan/deleteMessageToTeam.do",
		type : 'POST',
		data : {
				'teamName' : teamNAME
				},
		dataType : 'json',
		//contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		success : function(data) {
			alert(data.res);
		},
		error: function(data){ 
			alert(data.res);
		}
	});
}
//message 창 안읽은 메세지 표시
function noticeMessage(){
	//alert("메세지 안읽은것 표시하기 이벤트");
	var notReadMessageCount = 0;
	$.ajax({
		url : '/jamplan/getMessageById.do',
		type : 'POST',dataType : 'json',
		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		success : function(data) {
			//alert("메세지 리스트 가져오기 성공");
			
			var messageHtml = "";
			$.each(data,function(index,item) {
				//안읽은 메세지 수 세기
				if(item.isRead == 0 || item.isRead ==2 || item.isRead==4){
					notReadMessageCount++;
				}	
			})
		if(notReadMessageCount!=0){
			$("#countLabel").append(notReadMessageCount);
		}
		
		},
		error : function() {
			alert("메세지 리스트 가져오기 실패");
		}
	});
}


//팀 모달창 나온 이후 팀을 선택해야만 선택 창을 클릭 할 수 있도록 설정 
function planAddbut(){
	$(".teamNameBox").click(function(){
		teamName = $(this).html();
		//console.log("팀네임 이벤트 : " +teamName );
		$("#planAddModal").removeAttr("disabled");
	})
}

//팀을 선택한 이후 추가 버튼을 클릭 했을 때 이벤트
function addPlanToDB() {
	$("#planAddModal").click(function(){
		
		planName = $("#planName").val();
		//console.log("plan add teamname"+teamName);
		//console.log("plan add planname"+planName);
		$.ajax({
			url : '/jamplan/insertPlan.do',
			type : 'POST',
			dataType : 'json', 
			contentType : 'application/x-www-form-urlencoded;charset=utf-8',
			data : { 'teamName' : teamName,
					 'planName' : planName},
			success : function(str){
				//console.log(str.res);
				alert("플랜 추가 : 데이터 전송 성공");
				teamName ="";
				planName="";
				ajaxGetTeamList();
			},
			error:function(str){
				//console.log(str.res);
				alert("플랜 추가 : 데이터 전송 실패");
				teamName ="";
				planName="";
			}
		});
	});
}


	
/*
// 메시지를 실시간으로 처리하기 위한 웹소켓 개통 부분
var domain = "ws://localhost:8800/jamplan/jamplanWebSocket";
function sendMessage() {
	webSocket = new WebSocket(domain);
	// 서버와 연결이 성공하면 자동으로 호출되는 메서드
	webSocket.onopen = function(event) {
		onOpen(event);
	};
	webSocket.onmessage = function(event) {
		onMessage(event);
	};
	webSocket.onerror = function(event) {
		onError(event);
	};
}
function onOpen(event) {
	webSocket.send('<%=id%>');
}
function onMessage(event) {
	$('#countLabel').append(event.data);
}
function onError(event) {
}*/


// 메시지를 실시간으로 처리하기 위한 웹소켓 개통 부분 끝 --%>

// 배열을 생성하고 팀 이름들을 저장한다.
//btn btn-primary, btn btn-danger  

var teamNameArray = [];

function ajaxGetTeamList() {

		
	$('#teamList').empty();	
	$.ajax({

			url : '/jamplan/ajaxPrintTeamList.do',
			type : 'POST',
			contentType : 'application/x-www-form-urlencoded;charset=utf-8',
			async: false,
			dataType : 'json',
			//async: false,
			success : function(data){ $.each(data,function(index, item) {
					var teamList = '';
					teamList += '<button class="btn btn-outline-light text-dark border-0 teamList" id="myTeam'
							+ index+ '"' + ' data-toggle="collapse" data-target="#myPlan'+ index+ '">'+ item.teamName+ '</button>';
							
					var RetrunList = teamList;
					var teamN =  item.teamName;
					var i = index;
					$.ajax({	
						url : '/jamplan/getPlanListById.do',
						type : 'POST',
						contentType : 'application/x-www-form-urlencoded;charset=utf-8',
						async: false,
						dataType : 'json',
						success : function(data) {
							//console.log("ajax get teamName"+teamName);
							$.each(data,function(index,item){
								//console.log(item.teamName);
								if(teamN == item.teamName && item.planNo != 0){
									teamList += '<div id="myPlan' + item.planNo + ' class ="collapse planlist" ><p class = "move" value = '+item.planNo+'>'+ item.planName +'</p></div>';
								}
							})
						}
					})
		
					$('#teamList').append(teamList);
	
					// 팀명을 배열에 담고 Add plan 버튼에서의 테이블 생성에
					// 이용한다.
					teamNameArray[index] = item.teamName;
				});
			}, error : function(e) {}
	});
} 

//플랜 클릭시 페이지 이동 이벤트  form으로 데이터 전달 및 페이지 이동
function planClickEvent(planNo){

	var planNO = planNo;
	//console.log("플랜 이벤트 플랜 번호  : " + planNO)
	
	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","movePlanMainPage.do");
	document.body.appendChild(form);
	
	var input = document.createElement("input");
	input.setAttribute("type","hidden");
	input.setAttribute("name","planNo");
	input.setAttribute("value",planNo);
	form.appendChild(input);
	
	form.submit();
	
}

function planListAdd(teamName, indexI){
	var RetrunList ="";
	var teamN = teamName;
	var i = indexI;
	$.ajax({	
		url : '/jamplan/getPlanListById.do',
		type : 'POST',
		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		async: false,
		dataType : 'json',
		success : function(data) {
			//console.log("ajax get teamName"+teamName);
			$.each(data,function(index,item){
				//console.log(item.teamName);
				if(teamN == item.teamName && item.planNo != 0){
					
					//console.log("if문 플랜 정보 "+item.planNo);
					//console.log("플랜이름"+item.planName);

					RetrunList = '<div id="planSelectList' + item.planNo + ' class ="movePlan" value = "'+item.planNo+'">' + item.planName + '</div>';
					$('#myTeam'+i).append(RetrunList);	

				}
			})
		}
	})
}

function validationCheck() {
	var params = $('#teamName').val();
	//alert(params);
	jQuery.ajax({
		url : '/jamplan/validationCheck.do',
		type : 'GET',
		data : {
			teamName : params
		},
		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		dataType : 'text',
		// check가 responsebody에서 오는 데이터를 받는다.
		success : function(check) {
			alert(check);
			if (check == 'SUCCESS') {
				$('#validationCheck').val('check');
				$('#validationCheck').css('color', 'powderblue');
				// wookim edit
				$('#inputForm').attr('enable', 'true');

			} else {
				$('#teamName').val('');
				$('#inputForm').attr('disabled', 'true');

				if ($('#teamName').focus()) {
					alert("focus in");
					$('#validationCheck').able();
				} else {
					alert("focus out");
				}
			}
		},
		error : function() {
			alert("error!!");
		}
	});

}

/* 메세지 팝업창을 위한 스크립트 */
$(document).on('click', '.panel-heading span.icon_minim', function(e) {
	var $this = $(this);
	if (!$this.hasClass('panel-collapse')) {
		$this.parents('.panel').find('.panel-body').slideUp();
		$this.addClass('panel-collapse');
		$this.removeClass('glyphicon-minus').addClass('glyphicon-plus');
	} else {
		$this.parents('.panel').find('.panel-body').slideDown();
		$this.removeClass('panel-collapse');
		$this.removeClass('glyphicon-plus').addClass('glyphicon-minus');
	}
});
/* 메세지 팝업창을 위한 스크립트 끝 */
