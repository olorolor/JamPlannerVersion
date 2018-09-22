/**@author wookim
 * 
 */

//문서 전체 출력 후
$(document).ready(function() {
	//var myFolder = new Folder(window.location.pathname);
	//console.log(folder.exits);
	//console.log(window.location.pathname);
	$("#calendarContent").load("./calendarPage.jsp");
	$("#mapContent").load("mapPage.jsp");
	$("#planTableContent").load("./planTablePage.jsp");
	$("#viewAllContent").load("./viewAllPage.jsp");

	$('.drawer').on("drawer",function(){
		$('.drawer').drawer({
			  class: {
			    nav: 'drawer-nav',
			    toggle: 'drawer-toggle',
			    overlay: 'drawer-overlay',
			    open: 'drawer-open',
			    close: 'drawer-close',
			    dropdown: 'drawer-dropdown'
			  },
			  iscroll: {
			    preventDefault: false
			  },
			  showOverlay: true
			});
	});
	
	
	document.getElementById("sendButton").onclick = function() {
		var input = document.getElementById('inputText').value;
		w.send(id + "/" + input);
	}

	/*var link = $(".tab-pane container active").attr("value");
	console.log(link);
	$.ajax({
		url : "calendarajax.mp",
		type : "post",
		contentType : 'application/x-www-form-urlencoded; charsert=utf-8',
		dataType : "json",
		success:function(str){
			$(".content").load(str.link);
			console.log('로드 후11')
		},	
		error:function(){
			alert("페이지 이동 ajax실패")
		}
	})
	*/

	/*$(document).ready(function() {
		$('.drawer').drawer();
		
		 var trigEnter = document.getElementById('inputText')
		trigEnter.addEventListener('keyup', function(event) {
			event.preventDefault();
			if(event.keyCode === 13) {
				document.getElementById('sendButton').click();
				var input = document.getElementById('inputText').value;
				w.send(id + "/" + input);
			}
<<<<<<< HEAD
		}); 
		
		document.getElementById("sendButton").onclick = function() {
			var input = document.getElementById('inputText').value;
			w.send(id + "/" + input);
		}
		
});*/

/*// websocket 부분에 대한 스크립트
var log = function (s) {
	// 이 부분에 메시지 형식 넣어야함.
	document.getElementById("exampleFormControlTextarea3").textContent += (s + "\n");
}

var id = '<%=id%>';
var teamNo = '<%=teamNo%>';

w = new WebSocket("ws://localhost:8800/jamplan/planMainChat?id="+id + "&teamNo=" + teamNo);
// 서버에서 handshaking이 성공적으로 끝나면 자동으로 호출되는 메서드
w.onopen = function () {
	alert("WebSocket Connected!");
}
w.onmessage = function(e) {
	log(e.data.toString());
}
w.onclose = function(e) {
	log("WebSocket closed!!");
}
w.onerror = function(e) {
	log("WebSocket error!!");
}
// websocket 부분에 대한 스크립트 끝
=======
		})
	})
});
>>>>>>> 711bb3fadbdfe9685e60acfa43d696a0b62fd460

//chat창에 대한 스크립트
function openForm() {
    document.getElementById("myForm").style.display = "block";
}

function closeForm() {
    document.getElementById("myForm").style.display = "none";
}
<<<<<<< HEAD
*/

// chat창에 대한 스크립트 끝




//planTable : 불러오기

});

	
