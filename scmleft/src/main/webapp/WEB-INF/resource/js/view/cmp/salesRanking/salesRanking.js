	// 날짜인풋 :: 수주리스트 조회기간 설정
	function getRankList() {
		let stDate = document.getElementById("inpStartDate").value.replaceAll("-", "");
		let edDate = document.getElementById("inpEndDate").value.replaceAll("-", "");
	
		if(stDate != "" & edDate != "") {
			if((edDate - stDate) < 0) return swal("날짜를 다시 선택하세요.");

			let param = { startDate : stDate, endDate : edDate }
			
			let callafterback = (ajax) => {
				makeTableBody(ajax.searchRankList);
				makeChart(ajax.searchRankList);
			}
			
			callAjax("/cmp/searchRank", "post", "json", true, param, callafterback);	
		} else return;
	}
	
	// 테이블 그리기
	function makeTableBody (list) {
		let tbody = document.getElementById("salesRankingTBody"), content = "", num = 0;
		
		tbody.innerHTML = "";
		if(list[0] == null) return swal("조회하신 기간의 매출내역이 없습니다.");
		
		list.forEach((list, index) => {
			content += "<tr><td>" + (index + 1) + "</td>"
			+ "<td>" + list.companyName + "</td>"
			+ "<td>" + list.total.toLocaleString('ko-KR') + "</td>";
		}) 

		tbody.innerHTML = content;
	}
	
	// 차트 그리기
    function makeChart (list) {
		if(list[0] == null) return document.querySelector("#chart").innerHTML = "";;
		let name = [], price = [];
		
		list.forEach((srList) => {
			name.push(srList.companyName);
			price.push(srList.total);
		});
    	
	    var options = {
		    series: price,
		    chart: {
		    width: 380,
		    type: 'pie',
	    },
		    labels: name,
		    responsive: [{
		      breakpoint: 480,
		      options: {
		        chart: {
		          width: 200
		        },
		        legend: {
		          position: 'bottom'
		        }
		      }
		    }]
	    };
    
	    var chart = new ApexCharts(document.querySelector("#chart"), options);
	    chart.render();
    }  