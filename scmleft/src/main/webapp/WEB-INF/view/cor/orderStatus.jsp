<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 주문현황 및 반품신청</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<!-- D3 -->
<style>
//
click-able rows
	.clickable-rows {tbody tr td { cursor:pointer;
	
}

.el-table__expanded-cell {
	cursor: default;
}
}
</style>
<script type="text/javascript">
	let listCount = 5;
	let pageCount = 10;
    
	// 페이지 로드
	function init() {
		let pageLine = document.querySelector("#orderStatusPaging");
		
		fRegisterButtonClickEvent();
		makeOrderList(${orderStatusList});
		pageLine.innerHTML = getPaginationHtml(1, ${orderCount}, listCount, pageCount, 'getOrderStatusList');
       	pageLine.appendChild( createInput("orderCount", ${orderCount}));
	}
	
	// 주문현황 조회
	function getOrderStatusList(pageNum) {
		let currentPage = pageNum || 1;
		let pageLine = document.querySelector("#orderStatusPaging");
		let stDate = document.getElementById("inpStartDate").value.replaceAll("-", "");
		let edDate = document.getElementById("inpEndDate").value.replaceAll("-", "");
	
		if((edDate - stDate) < 0) return alert("날짜를 다시 선택하세요.");

		let param = { pageNum : currentPage, listCount : listCount, startDate : stDate, endDate : edDate }
		console.log(param);
		let callafterback = (ajax) => { 
			console.log(ajax);
			
			makeOrderList(ajax.newOrder); 
			
			pageLine.innerHTML = "";
			pageLine.innerHTML = getPaginationHtml(currentPage, ajax.orderCount, listCount, pageCount, 'getOrderStatusList');
	        pageLine.appendChild(createInput("orderCount", ajax.orderCount));
		}
		
		callAjax("/cor/searchOrderList", "post", "json", true, param, callafterback);	
	}
	
	// 주문내역에서 상세 제품정보 불러오기
	function getDetailList(no, sh, jIn, pageNum) {
		let currentPage = pageNum || 1;
		let pageLine = document.querySelector("#detailStatusPaging");
		
		if(jIn == "0") return ;
		if(sh == null) return alert("아직 배송이 진행되지 않았습니다.");

		let param = { pageNum : currentPage, listCount : listCount, jordNo : no }
		let callafterback = (ajax) => { 
			makeOrderDetailList(ajax.osdList);

			pageLine.innerHTML = "";
			pageLine.innerHTML = getPaginationHtml(1, ${orderCount}, listCount, pageCount, 'getOrderStatusList');
	       	pageLine.appendChild( createInput("orderCount", ${orderCount}));
		}
		
		callAjax("/cor/refundHistory", "post", "json", true, param, callafterback);
	}
	
	// 입금하기 상세 목록 가져오기
	function updJordIn(no) {
		let param = { jordNo : no, jordIn : "1" }
		let callafterback = (ajax) => { 
			makeOrderList(ajax.newOsList);
			alert(ajax.message);
		}
			
		callAjax("/cor/updJorderStatus", "post", "json", true, param, callafterback);	
	}
	
	// 반품하기
	function insReturnInfo() {		
		let checkBox = document.querySelectorAll("input[name='cheReturn']:checked");
		let b = [], jCode = "", mCode = "", wCode = "", bCode = "", rAmt = "";
		
		checkBox.forEach((checkBox) => {
			b.push(checkBox.value.split("&"));
		})
		
		b.forEach((b, index) => {
			jCode += (index != 0 ? "&" : "") + b[0];
			mCode += (index != 0 ? "&" : "") + b[1];
			wCode += (index != 0 ? "&" : "") + b[2];
			bCode += (index != 0 ? "&" : "") + b[3];
			rAmt += (index != 0 ? "&" : "") + b[4];
		})
		
		if(jCode != null && mCode != null) {			
			let param = { jordCode : jCode, modelCode : mCode, whCode : wCode, bordCode : bCode, reAmt : rAmt}
			let callafterback = (ajax) => { 
				makeOrderDetailList(ajax.osdList);
				alert(ajax.message);
			}
			
			callAjax("/cor/insReturnProduct", "post", "json", true, param, callafterback);	
		} else return;
	}

	
	// 주문내역 테이블 그리기 + 페이징
	function makeOrderList(list){
		let tbody = document.getElementById("orderStatusTBody");
		let content = "";
		
		tbody.innerHTML = "";
		list.forEach((list, index) => {
			content += "<tr onClick ='getDetailList(" + list.jordNo + "," + list.shDate + "," + list.jordIn + ")'><td>" + (index + 1) + "</td>"
					+ "<td>" + list.jordNo + "</td>"
					+ "<td>" + list.pdName + (list.count != "1" ? (" 외 " + (list.count - 1) + "개") : "") + "</td>"
					+ "<td>" + cngNumberType(list.total) + "</td>"
					+ "<td>" + cngDateType(list.jordDate) + "</td>"
					+ "<td>" + (list.shDate != null ? cngDateType(list.shDate) : "") + "</td>";
			if(list.jordIn == "0") {
				content += "<td>" + "<a class='btnType blue' id='btnIn' name='btn' onClick = 'updJordIn(" + list.jordNo + ")'><span>입금하기</span></a>"  + "</td>";
			} else content += "<td></td></tr>";
		})
		tbody.innerHTML = content;
	}
	
	/**
	 *	paging(maxNum, pageNum, pageName)
	 */
	 function paging(maxNum, pageNum, pageName) {
        // 전체 글의 숫자, 현재 페이지 번호, 페이지당 나타낼 글의 갯수, 페이지 그룹당 페이지 갯수, 페이지 종류
        let totalPage = (maxNum % listCount > 0) ? maxNum / listCount + 1 : maxNum / listCount;
        let totalGroup = (totalPage % pageCount > 0) ? totalPage / pageCount + 1 : totalPage / pageCount;
        let currentGroup = (pageNum % pageCount > 0) ? pageNum / pageCount + 1 : pageNum / pageCount;

       	let html =  makeHtml(currentGroup, totalPage, pageName, pageNum);
		
       	return html;
    }  
	
	function makeHtml(currentGroup, totalPage, pageName, pageNum) {
		let sb = "";
        let start = (currentGroup * pageCount) - (pageCount) > 0 ? (currentGroup * pageCount) - (pageCount) : ((currentGroup * pageCount) - (pageCount)) - 1;
        let end = (currentGroup > 1) ? ((1 * pageCount >= totalPage) ? totalPage : currentGroup * pageCount) : ((currentGroup * pageCount >= totalPage) ? totalPage : currentGroup * pageCount) ;

        for (i = start; i <= end; i++) {
            if (pageNum != i) sb += "<a href= " + pageName + " ?pageNum= " + i + ">[" + i + "]</a>";
            else sb += "<font style='color:red;' >[" + i + "]</font>";
	    }
    
        if (end != totalPage) sb += "<a href=" + pageName + "?pageNum=" + (end + 1) + ">[다음]</a>";
        
        return sb;
	}
	
	// 주문 상세 내역 테이블 그리기
	function makeOrderDetailList(list) {
		let tbody = document.getElementById("detailOrderStatusTBody");
		let content = "";
		
		tbody.innerHTML = "";
		if(list != null) {
			list.forEach((list, index) => {
				content += "<tr><td><input type = 'checkBox' name = 'cheReturn' value = '" + list.jordCode + "&" + list.modelCode + "&" 
						+ list.whCode + "&" + list.bordCode + "&" + list.jordAmt + "' " 
						+ ((list.shType == "1" ? "" : "disabled") || (list.reCode == "0" ? "" : "disabled")) + "/ ></td>"
						+ "<td>" + list.jordNo + "</td>"
						+ "<td>" + list.pdName + "</td>"
						+ "<td>" + list.pdCode + "</td>"
						+ "<td>" + list.pdCorp + "</td>"
						+ "<td>" + cngNumberType(list.pdPrice)  + "</td>"
						+ "<td>" + cngNumberType(list.jordAmt) + "</td>"
						+ "<td>" + cngNumberType(list.total) + "</td></tr>";
			})
			tbody.innerHTML = content;
		}
	}
	
	// 타입 변환 :: 스트링 -> 날짜
	function cngDateType(strDate) {
		return strDate.substr(0, 4) + "-" + strDate.substr(4, 2) + "-" + strDate.substr(6, 2);
	}
	
	// 금액 콤마
	function cngNumberType(num) {
		return num.toLocaleString('ko-KR');
	}
	
	// 버튼 이벤트 등록
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			switch (btnId) {
				case 'btnClose' : gfCloseModal(); break;
				case 'btnReturn' : insReturnInfo(); break;
			}
		});
	}
	
	// <input type = 'hidden' /> 
	function createInput(id, value) {
		let input = document.createElement("input");
		
		input.setAttribute("type", "hidden");
		input.setAttribute("id", id);
		input.setAttribute("value", value);	
		
		return input;
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
									<span>주문현황 및 반품신청</span> <span class="fr"> 관련 자료 </span>
								</p>
							</div>

							<div id = "divSearchBar" style="width: 23rem; padding: 2% 2%; display: flex; justify-content: space-between;">
								<span>구매일자</span>
								<input type = "date" id = "inpStartDate" onchange="getOrderStatusList()" />
								<span> ~ </span>
								<input type = "date" id = "inpEndDate" onchange="getOrderStatusList()" />
							</div>
							
							<!-- 주문상태 -->
							<div id="divOrderStatus">
								<table class="col">
									<thead>
										<tr>
											<th scope="col">일련번호</th>
											<th scope="col">주문번호</th>
											<th scope="col">제품명</th>
											<th scope="col">금액</th>
											<th scope="col">구매일</th>
											<th scope="col">배송일</th>
											<th scope="col">입금상태</th>
										</tr>
									</thead>
									<tbody id = "orderStatusTBody">
									</tbody>
								</table>
								<!-- 페이징라인 -->
								<div class="paging_area" id="orderStatusPaging" ></div>
							</div>
							<br>
							
							<div id="divOrderDetailList">
								<table class="col">
									<thead>
										<tr>
											<th scope="col">선택</th>
											<th scope="col">주문번호</th>
											<th scope="col">제품명</th>
											<th scope="col">제품번호</th>
											<th scope="col">제조사</th>
											<th scope="col">단가</th>
											<th scope="col">수량</th>
											<th scope="col">합계금액</th>
										</tr>
									</thead>
									<tbody id = "detailOrderStatusTBody">

									</tbody>
								</table>
								<!-- 페이징라인 -->
								<div class="paging_area" id="orderDetailPaging" ></div>
								<br/>
								<a class="btnType gray" id="btnReturn" name="btn"><span>반품하기</span></a>
							</div>
						</div>

					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>