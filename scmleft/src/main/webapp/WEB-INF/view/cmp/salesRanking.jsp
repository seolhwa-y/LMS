<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 매출 순위</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>

<style>
//
click-able rows
	.clickable-rows {tbody tr td { cursor:pointer;
	
}

.el-table__expanded-cell {
	cursor: default;
}
}

#divSalesRanking {
	width: 20rem;
}
</style>
<script type="text/javascript">
	function init() {
		makeTableBody(${salesRankList});
		makeChart(${salesRankList});
	}

	// 날짜인풋 :: 수주리스트 조회기간 설정
	function getRankList() {
		let stDate = document.getElementById("inpStartDate").value.replaceAll("-", "");
		let edDate = document.getElementById("inpEndDate").value.replaceAll("-", "");
	
		if(stDate != "" & edDate != "") {
			if((edDate - stDate) < 0) return alert("날짜를 다시 선택하세요.");

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
		
		if(list[0] == null) return alert("조회하신 기간의 매출내역이 없습니다.");
		
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

</script>

</head>
<body onload = "init()">
	<form id="myForm" action="" method="">

		<input type="hidden" id="currentPage" value="1"> <input
			type="hidden" id="selectedInfNo" value="">
		<!-- 모달 배경 -->
		<div id="mask"></div>
		<div id="wrap_area">
			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 --> <jsp:include
							page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
					</li>
					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3> <!-- content --> 
						
						<!-- 타이틀 영영 -->
						<div class="content" style="margin-bottom: 20px;">
							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">메인</span> <a
									href="../dashboard/dashboard.do" class="btn_set refresh">새로고침</a>
							</p>
							<div>
								<p class="conTitle" style="margin-bottom: 1%;">
									<span>매출 상위</span> <span class="fr"> 관련 자료 </span>
								</p>
							</div>
							
							<div id = "divSearchBar" style="padding: 2% 2%; width: 23rem; display: flex; justify-content: space-between;">
								<span>기간검색</span>
								<input type = "date" id = "inpStartDate" onchange = "getRankList()" />
								<span> ~ </span>
								<input type = "date" id = "inpEndDate" onchange = "getRankList()" />
							</div>
							
							<div style="display: flex; justify-content: space-between;">
							<!-- 매출 TOP 10 -->
							<div id="divSalesRanking">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
											<col width="10%">
											<col width="30%">
											<col width="30%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">순위</th>
											<th scope="col">기업명</th>
											<th scope="col">매출금액</th>
										</tr>
									</thead>
									<tbody id = "salesRankingTBody">

									</tbody>
								</table>
								<br>
							</div>
							
							<div id = "chart"></div>
							</div>
						</div>

					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>