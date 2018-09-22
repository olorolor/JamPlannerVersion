/**
 * 
 */
$(document).ready(function() {
	/*function planTableGo() {*/
		
		$.ajax({
			url : '/jamplan/planTable.plan',
			type : 'POST',
			dataType: "json",
			/*async: false,*/
	        contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			success:function(data){
				$('#planput').empty();
				$('#saveput').empty();
				var put = '';
				var saveput = '';
					saveput += '<br><br>';
					saveput += '<a href="javascript:savePlanTable();"><button class="btn btn-primary pull-right" >저장</button></a>';
					$('#saveput').append(saveput);
					
				$.each(data, function(index, item){
					
					var planput = '';
					planput += '<table class="table">';
					planput += '<thead>';
					planput += '<th>날짜 </th>';
					planput += '<th>장소</th>';
					planput += '<th>일정</th>';
					planput += '</thead>';
					planput += '<tbody>';
					planput += '<tr>';
					planput += '<td>' + item.selectDate + '</td>';
					planput += '<td>' + item.placeName + '</td>';
					planput += '<td><textarea class="form-control" name="memo" id="memo' + index + '" placeholder="여행계획을 작성해보세요!" rows="5" cols="30" >'+ item.memo +'</textarea></td>';
					planput += '<td><input type="text" hidden="hidden" id="planSeq'+index+'" value="'+item.planSeq+'"></td>'
					planput += '</tr>';
					planput += '</tbody>';
					planput += '</table>';
					
//						memoList[index] = item.map;
					console.log("planput" + planput);
					$('#planput').append(planput);
				});
			},
			error:function() {
				alert('ajax통신실패!!!');
			}
		});
	/*}*/




});

// savePlanTable : 저장
function savePlanTable(){
	var memoCnt = $('[name="memo"]');
	var params = {};
	for(var i=0; i<memoCnt.length; i++){
		params = {"memo" : $('#memo'+ i).val(), "planSeq" : $('#planSeq'+ i).val()};
		console.log(params);
		
		$.ajax({
			url : '/jamplan/savePlanTable.plan',
			type : 'POST',
			/*async: false,*/
			dataType: "json",
			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			data : params,
			success:function(data) {
				
				 /*$.each(data, function(index, item){
						$('#planput').empty();
						$('#updateput').empty();
						var updateput = '';
						updateput += '<table class="table">';
						updateput += '<thead>';
						updateput += '<th>날짜 </th>';
						updateput += '<th>장소</th>';
						updateput += '<th>일정</th>';
						updateput += '</thead>';
						updateput += '<tbody>';
						updateput += '<tr>';
						updateput += '<td>' + item.selectDate + '</td>';
						updateput += '<td>' + item.placeName + '</td>';
						updateput += '<td><textarea class="form-control" id="memo" placeholder="여행계획을 작성해보세요!" rows="5" cols="30" >'+ item.memo +'</textarea></td>';
						updateput += '</tr>';
						updateput += '</tbody>';
						updateput += '</table>';
						
							
						console.log("updateput" + updateput);
						$('#updateput').append(updateput);
						
					}); */
			},
			error:function() {
				alert('ajax통신실패!!!');
			}
		});
	}
	alert('저장성공!');
	
}

