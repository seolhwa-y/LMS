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
		let srList = ${salesRankList};

		makeTableBody(srList);
		makeChart(srList);
	}

	// 날짜인풋 :: 수주리스트 조회기간 설정
	function getRankList() {
		let stDate = document.getElementById("inpStartDate").value.replaceAll("-", ""); // 조회 시작
		let edDate = document.getElementById("inpEndDate").value.replaceAll("-", ""); // 조회 끝*/
	
		if(stDate != "" & edDate != "") {
			console.log(stDate + "~" + edDate + "기간 확인 ok");
			
			// Ajax = 파라미터
			const param = { startDate : stDate, 
							endDate : edDate }
			
			// Ajax = 호출
			var callafterback = function(returndata) {
				callNewRank(returndata);
			}
			
			callAjax("/cmp/searchRank", "post", "json", true, param, callafterback);	
		} else return;
	}
	
	function callNewRank(ajax) {
		let rankList = ajax.searchRankList;
		
		console.log(rankList);
		
		makeTableBody(rankList);
		makeChart(rankList);
	}
	
	// 테이블 그리기
	function makeTableBody (list) {
		let tbody = document.getElementById("salesRankingTBody");
		let content = "", num = 0;
		
		for(i = 0; i < list.length; i++) {
			num = i + 1;
			content += "<tr><td>" + num + "</td>"
					+ "<td>" + list[i].companyName + "</td>"
					+ "<td>" + list[i].total.toLocaleString('ko-KR') + "</td>";
		}
		tbody.innerHTML = "";
		tbody.innerHTML = content;
	}
	
	// 차트 그리기
    function makeChart (list) {
		let name = [], price = [];
		
		list.forEach(function(srList) {
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
	    
	    console.log(options);
    
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
							
							<div id = "divSearchBar">
									<input type = "date" id = "inpStartDate" onchange = "getRankList()"/>
									<span> ~ </span>
									<input type = "date" id = "inpEndDate" onchange = "getRankList()" />
							</div>

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
							<br>
							
							<div id = "chart"></div>
						</div>

					</li>
				</ul>
			</div>
		</div>
		
		
		<!-- 모달팝업 -->
		<div id="notice" class="layerPop layerType2" style="width: 600px;">
			<input type="hidden" id="noticeNo" name="noticeNo" value="${noticeNo}">
			<!-- 수정시 필요한 num 값을 넘김  -->

			<dl>
				<dt>
					<strong><!-- 제목 --></strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>

						<tbody>
							<tr>
								<th scope="row">작성자 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="loginId"
									id="loginId" v-model="loginId" v-bind:readonly="loginIdread" /></td>
								<!-- <th scope="row">작성일<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="write_date" id="write_date" /></td> -->
							</tr>
							<tr>
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="noticeTitle" id="noticeTitle" v-model="noticeTitle"
									v-bind:readonly="noticeTitleread" /></td>
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="3"><textarea class="inputTxt p100"
										name="noticeContent" id="noticeContent"
										v-model="noticeContent" v-bind:readonly="noticeContentread">
								</textarea></td>
							</tr>

						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>

			</dl>
		</div>


		<div id="layer2" class="layerPop layerType2" style="width: 600px;">
			<input type="hidden" id="action" name="action" value="U">
			<dl>
				<dt>
					<strong>그룹코드 관리</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>

						<tbody>
							<tr>
								<th scope="row">그룹 코드 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="grp_cod"
									id="grp_cod" v-model="grp_cod" /></td>
								<th scope="row">그룹 코드 명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									name="grp_cod_nm" id="grp_cod_nm" v-model="grp_cod_nm" /></td>
							</tr>
							<tr>
								<th scope="row">코드 설명 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="grp_cod_eplti" id="grp_cod_eplti" v-model="grp_cod_eplti" /></td>
							</tr>

							<tr>
								<th scope="row">사용 유무 <span class="font_red">*</span></th>
								<td colspan="3"><input type="radio" id="radio1-1"
									name="grp_use_poa" id="grp_use_poa_1" value='Y'
									v-model="use_poa" /> <label for="radio1-1">사용</label>
									&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="radio1-2"
									name="grp_use_poa" id="grp_use_poa_2" value="N"
									v-model="use_poa" /> <label for="radio1-2">미사용</label></td>
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveGrpCod" name="btn"><span>저장</span></a>
						<a href="" class="btnType blue" id="btnDeleteGrpCod" name="btn"
							v-show="delshow"><span>삭제</span></a> <a href=""
							class="btnType gray" id="btnCloseGrpCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

	</form>
</body>
</html>