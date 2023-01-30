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

<script type="text/javascript" >

	var DivSalesRanking;
	var DivSearchBar;

	function init() {
		
		DivSearchBar = new Vue ({
			el : '#divSearchBar',
			data : {
				startDate : 0,
				endDate : 0,
			},
			methods : {
				/* 랭킹 다시 조회 */
				getList : function() {
					if(DivSearchBar.startDate != 0 && DivSearchBar.endDate != 0) {
						if((DivSearchBar.endDate.replaceAll("-", "") - DivSearchBar.startDate.replaceAll("-", "")) < 0) return swal("날짜를 다시 선택하세요.");

						var param = { 
								startDate : DivSearchBar.startDate.replaceAll("-", ""), 
								endDate : DivSearchBar.endDate.replaceAll("-", ""), 
						}
						
						var callafterback = function(ajax) {
							DivSalesRanking.salesRankList = ajax.searchRankList;
							makeChart(ajax.searchRankList);
						}
						
						callAjax("/cmp/searchRank", "post", "json", true, param, callafterback);	
					}
				}
			}
		});
		
		//조회
		DivSalesRanking = new Vue({
			el : '#divSalesRanking',
			data : {
					salesRankList : ${salesRankList},
			}
		});
		
		// 테이블 그리기
		makeChart(${salesRankList});
	
		
	}
	
	
	
	 function makeChart (list) {
		 console.log(list);
			document.querySelector("#chart").innerHTML = "";
			let name = [], price = [];
			
			for(i = 0; i < list.length; i++){
				name.push(list[i].companyName);
				price.push(list[i].total);
			}
	    	
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
								<input type = "date"  v-model = "startDate"  />
								<span> ~ </span>
								<input type = "date"  v-model = "endDate"  />
								<a class="btnType blue" v-on:click="getList()"> 
									<span>검 색</span>
								</a>
							</div>
							
							<div style="height: 38rem; display: flex; justify-content: space-between;">
								<!-- 매출 TOP 10 -->
								<div id="divSalesRanking"  style="width: 30rem;">
									<table class="col">
										<thead>
											<tr>
												<th scope="col">순위</th>
												<th scope="col">기업명</th>
												<th scope="col">매출금액</th>
											</tr>
										</thead>
										<tbody id = "salesRankingTBody">
											<tr v-for= "(item, index) in salesRankList" v-if = "salesRankList.length > 0">
												<td>{{ index + 1 }}</td>
												<td>{{ item.companyName }}</td>
												<td>{{ item.total }}</td>
											</tr>
											<tr v-if="salesRankList.length == 0">
												<td colspan="3">검색된 데이터가 없어요</td>
											</tr>
										</tbody>
									</table>
									<br>
								</div>
								
								<div id = "chart" style="width: 30rem;"></div>
							</div>
						</div>

					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>