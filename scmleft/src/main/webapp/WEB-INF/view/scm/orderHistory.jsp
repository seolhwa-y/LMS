<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 일별 수주 내역</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<!-- D3 -->
<style>
//
click-able rows
	.clickable-rows {tbody tr td { 
	cursor:pointer;
}

.el-table__expanded-cell {
	cursor: default;
}
}
</style>
<script type="text/javascript">
	let listCount = 5;
	let pageCount = 10;

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			switch (btnId) {
			case 'btnBModalClose' : 
			case 'btnSModalClose' : gfCloseModal(); break;
			case 'btnBorderDirec' : insBordDirec(); break;
			case 'btnShipDirec' : insShipDirec(); break;

			}
		});
	}

	function init() {
		fRegisterButtonClickEvent();
		makeOHTable(${orderHistoryList});
	}

	// 날짜인풋 :: 수주리스트 조회기간 설정
	function getOrderList() {
		let stDate = document.getElementById("inpStartDate").value.replaceAll("-", "");
		let edDate = document.getElementById("inpEndDate").value.replaceAll("-", "");
		const dateType = document.getElementById("selClass").value; 
		let reInput = document.getElementsByName("returnType"), reType = "";

		reInput.forEach((reInput) => { if (reInput.checked) reType = reInput.value; });

		if (dateType != "" && stDate != "" && edDate != "") {
			let param = { type : dateType, startDate : stDate, endDate : edDate, reType : reType }

			let callafterback = (ajax) => { makeOHTable(ajax.newOrderSearchList); }
			callAjax("/scm/searchOrderHistoryList", "post", "json", true,
					param, callafterback);
		} else return;
	}
	
	// 지시서 작성하기
	function showDirection(ty, jCode, mCode, jIn) {
		if(ty == "s" && jIn != 1) return alert("미입금 상태라 배송지시서 작성이 불가능 합니다."); 
		
		if (ty != null && jCode != null && mCode != null) {
			let param = { type : ty, jordCode : jCode, modelCode : mCode }
			console.log(param);
			let callafterback = function(returndata) {
				callDirectionList(returndata);
			}
			callAjax("/scm/showDirection", "post", "json", true, param, callafterback);
		} else return;
		
	}
	
	// 지시서 내용 리스트 정리
	function callDirectionList(ajax) {
		const type = ajax.type;
		let whInfo = makeWhSelect(ajax.whInfo), bordInfo = "", shipInfo = "", deliInfo = "";
		let bdTBody = document.getElementById("borderDrectionTBody");
		let sdTBody = document.getElementById("shipDrectionTBody");
		
		switch(type) {
		case "b" :
			makeBorderInfo(ajax.bordInfo, ajax.loginId);
			fillDirectionModal(whInfo);
			gfModalPop("#bDirection");
			break;
			
		case "s" :
			deliInfo = makeDeliSelect(ajax.deliInfo);
			makeShipInfo(ajax.shipInfo);
			fillDirectionModal(whInfo, deliInfo);
			gfModalPop("#sDirection");
			break;
		}
	}
	
	// 창고선택
	function inTotalStock(val){
		let data = val.split("&");
		let stock = document.querySelectorAll(".totalStock"), amt = document.querySelectorAll(".countAmt");
	
		stock.forEach((stock, index) => { stock.value = data[1]; })
	}
	
	// 항목 추가
	function appendDetail(type) {
		let bName = ["modelCode", "pdName_B", "pdCode", "bCorp", "bDirec"], sName = ["jordCode", "jordDate", "companyName", "pdName_S", "sAmt"];
		let borderWhCode = document.querySelector("#selBWInfo").value, shipWhCode = document.querySelector("#selSWInfo").value;
		let bBoby = document.getElementById("detailBorder"), sBody = document.getElementById("detailReturn");
		let bAmt = document.querySelector("#bAmt").value, sAmt = document.querySelector("#sAmt").value;
		let data = [];
		
		switch (type) {
		case 'b' : 
			if(borderWhCode == "창고선택") return alert("창고를 선택하세요.");
			if(bAmt == "") return alert("수량을 입력하세요.");
			
		 	bName.forEach((bName, index) => {
				data.push(document.getElementById(bName).innerText);
			})
			
			data.push(borderWhCode.substring(0, borderWhCode.indexOf("&")));
		 	data.push(bAmt);
		 	
			makeDetailDirect(type, data); 
			break;
			
		case 's' :
			if(shipWhCode == "창고선택") return alert("창고를 선택하세요.");
			if(sAmt == "") return alert("수량을 입력하세요.");
			
			sName.forEach((sName, index) => {
				data.push(document.getElementById(sName).innerText);
			})
			
			data.push(shipWhCode.substring(0, shipWhCode.indexOf("&")));
		 	data.push(sAmt);
		 	
			makeDetailDirect(type, data, sAmt);
			break;
			
		default:
			break;
		}
	}
	
	// 디테일 테이블  :: 배열데이터, 창고정보, 수량
	function makeDetailDirect(type, data, amt) {
		console.log(type);
		console.log(data);
		console.log(amt);
	}
	
	// 항목 삭제 
	function removeDetail(type) {
		console.log(type);
		//document.querySelector("#detailBorder").removeChild(document.querySelector("#detailBorder").childNodes[0]);
		//document.querySelector("#detailReturn").removeChild(document.querySelector("#detailReturn").childNodes[0]);
	}
	
	// 발주지시서 작성완료
	function insBordDirec() {
		console.log("bd");
	}
	
	// 배송지시서 작성완료
	function insShipDirec() {
		console.log("sd");
	}

	// 모달 내용 채우기
	function fillDirectionModal (wh, deli) {
		let selBW = document.getElementById("selBWInfo"), selSW = document.getElementById("selSWInfo");
		let stock = document.querySelectorAll(".totalStock"), amt = document.querySelectorAll(".countAmt");
		
		stock.forEach((stock, index) => {
			stock.value = "", amt[index].value = "";
		})
		deli != null ? selSW.innerHTML = wh : selBW.innerHTML = wh;
	}
	
	// 배송담당자 정보 셀렉트
	function makeDeliSelect (list) {
		let selectBox = "<select id = 'selDeliInfo'><option disabled>배송담당자 선택<option>";

		if(list.length != 0){
			list.forEach((list, index) => { selectBox += "<option value = '" + list.loginId + "&" + list.deliName + "'>" + list.deliName + "<option>"; })
		} else selectBox += "<option disabled>선택할 수 있는 배송담당자가 없습니다.<option>";
		
		selectBox += "</select>";
		
		return selectBox;
	}
	
	// 발주지시서 정보
	function makeBorderInfo (list, direc) {
		let name = ['#modelCode', '#pdName_B', '#pdCode', '#bCorp', '#bDirec'];
		let value = [list.modelCode, list.pdName, list.pdCode, list.companyName, direc];
		
		name.forEach((name, index) => {
			document.querySelector(name).innerText = value[index];
		})
	}
	
	// 배송지시서 정보
	function makeShipInfo (list) {
		console.log(list.pdName);
		let name = ['#jordCode', '#jordDate', '#companyName', '#pdName_S', '#sAmt'];
		let value = [list.jordCode, cngDateType(list.jordDate), list.companyName, list.pdName, list.jordAmt];
		
		name.forEach((name, index) => {
			document.querySelector(name).innerText = value[index];
		})
	}
	
	// 창고정보 셀렉트
	function makeWhSelect (list) {
		let selectBox = "<option selected disabled>창고선택</option>";

		if(list.length != 0){
			list.forEach((list, index) => { selectBox += "<option value = '" + list.whCode + "&" + list.whStock + "&" + list.whName + "'>" + list.whName + "</option>"; })
		} else selectBox += "<option disabled>선택할 수 있는 창고가 없습니다.</option>";

		return selectBox;
	}
	
	// 일별수주내역 테이블 그리기
	function makeOHTable(list) {
		let tbody = document.getElementById("orderHistoryTBody");
		let content = "";

		console.log(list);

		list.forEach((list, index) => {
			content += "<tr>" + "<td>" + list.jordCode + "</td>" 
			+ "<td>" + cngDateType(list.jordDate) + "</td>" 
			+ "<td>" + list.companyName + "</td>" 
			+ "<td>" + list.pdName + "</td>" 
			+ "<td>" + cngNumberType(list.whStock) + "</td>"
			+ "<td>" + cngNumberType(list.pdPrice) + "</td>" 
			+ "<td>" + cngNumberType(list.jordAmt) + "</td>"
			+ "<td>" + cngNumberType(list.totalAmt) + "</td>";

		list.reDate != null? content += "<td>Y</td><td>" + cngDateType(list.reDate) + "</td>" : content += "<td>N</td><td></td>";
		list.jordIn == "0" ? content += "<td>미입금</td>" : content += "<td>입금</td>";
		list.bordCode != "0" ? content += "<td>작성완료</td>"
							 : content += "<td><a id = 'btnBordDirec' class = 'btnType blue' onClick = 'showDirection(\"b\", " 
									   + list.jordCode + "," + list.modelCode + ")'><span>작성</span></a></td>";
		list.shCode != "0" ? content += "<td>작성완료</td>"
						   : content += "<td><a id = 'btnShipDirec' class = 'btnType blue' onClick = 'showDirection(\"s\", " 
								     + list.jordCode + "," + list.modelCode + "," + list.jordIn + ")'><span>작성</span></a></td>";
		})

		tbody.innerHTML = "";
		tbody.innerHTML = content;
	}

	// 타입 변환 :: 스트링 -> 날짜
	function cngDateType(strDate) {
		return strDate.substr(0, 4) + "-" + strDate.substr(4, 2) + "-" + strDate.substr(6, 2);
	}
	
	// 금액 콤마
	function cngNumberType(num) {
		return num.toLocaleString('ko-KR');
	}
</script>

</head>
<body onload="init()">
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
								<span class="btn_nav bold">메인</span> <a href="../dashboard/dashboard.do" class="btn_set refresh">새로고침</a>
							</p>
							<div>
								<p class="conTitle" style="margin-bottom: 1%;">
									<span>일별 수주 내역</span> <span class="fr"> 관련 자료 </span>
								</p>
							</div>
							
								<div id = "divSearchBar" style="padding: 2% 2%; display: flex; justify-content: space-between;">
									<div style="width: 28rem; display: flex; justify-content: space-evenly; align-items: baseline;">
										<select id = "selClass" style="width: 5rem; height: 100%; margin-right: 1rem;">
											<option value = 'jorder'>주문일자</option>
											<option value = 'return'>반품처리일</option>
										</select>
										<input type = "date" id = "inpStartDate" onchange = "getOrderList(this)"/>
										<span> ~ </span>
										<input type = "date" id = "inpEndDate" onchange = "getOrderList(this)"/>
									</div>
									<div style="width: 16rem; display: flex; justify-content: space-evenly; align-items: baseline;">
										<input type = "radio" name = "returnType" value = "all" onchange = "getOrderList(this)" /> <span>전체</span>
										<input type = "radio" name = "returnType" value = "true" onchange = "getOrderList(this)" /> <span>반품요청</span>
										<input type = "radio" name = "returnType" value = "false" onchange = "getOrderList(this)" /> <span>반품미요청</span>
									</div>
								</div>

							<!-- 일별 수주 내역 -->
							<div id="divDailyOrderList">
								<table class="col">
									<caption>caption</caption>
									<thead>
										<tr>
											<th scope="col">주문번호</th>
											<th scope="col">주문일자</th>
											<th scope="col">고객기업명</th>
											<th scope="col">주문제품명</th>
											<th scope="col">총재고갯수</th>
											<th scope="col">단가</th>
											<th scope="col">주문갯수</th>
											<th scope="col">금액합계</th>
											<th scope="col">반품요청여부</th>
											<th scope="col">반품처리일자</th>
											<th scope="col">입금여부</th>
											<th scope="col">발주지시서</th>
											<th scope="col">배송지시서</th>
										</tr>
									</thead>
									<tbody id = "orderHistoryTBody">

									</tbody>
								</table>
								<!-- 페이징라인 -->
								<div class="paging_area" id="orderHistoryPaging" ></div>
							</div>
							<br>
						</div>
					</li>
				</ul>
			</div>
		</div>
		
		<!-- 발주 모달팝업 -->
		<div id="bDirection" class="layerPop layerType2" style="width:60rem; height: 25rem;">
			<dl>
				<dt><strong>발주지시서 작성</strong></dt>
				<dd class="content">
					<div>
						<table class='col'>
							<thead>
								<tr>
									<th scope='col'>제품번호</th>
									<th scope='col'>제품명</th>
									<th scope='col'>제품CODE</th>
									<th scope='col'>납품기업</th>
									<th scope='col'>발주자</th>
								</tr>
							</thead>
							<tbody id = 'borderDrectionTBody'>
								<tr>
									<td id = 'modelCode'></td>
									<td id = 'pdName_B'></td>
									<td id = 'pdCode'></td>
									<td id = 'bCorp'></td>
									<td id = 'bDirec'></td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- 창고정보 -->
					<div id = "whInfo" style="display: flex; justify-content: space-around;">
						<span>창고선택</span>
						<select id = "selBWInfo" onchange="inTotalStock(this.value)"></select>
						<span>재고수량</span><input type="text" class = "totalStock" readonly="readonly" />
						<span>수량</span><input type="number" class = 'countAmt' id = "bAmt"/>
						<input type = "button" value = "추가" onClick = "appendDetail('b')" /> 
					</div>
					
					<div id = realInfo>
						<table class='col'>
							<thead>
								<tr>
									<th scope='col'>제품번호</th>
									<th scope='col'>제품명</th>
									<th scope='col'>제품CODE</th>
									<th scope='col'>납품기업</th>
									<th scope='col'>창고번호</th>
									<th scope='col'>창고명</th>
									<th scope='col'>개수</th>
									<th scope='col'>발주자</th>
									<th scope='col'>삭제</th>
								</tr>
							</thead>
							<tbody id = "detailBorder">

							</tbody>
						</table>
					</div>
					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">				
						<a class="btnType blue" id="btnBorderDirec" name="btn"><span>완료</span></a>
						<a class="btnType gray" id="btnBModalClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>

			</dl>
		</div>
		
		<!-- 배송 모달팝업 -->
		<div id="sDirection" class="layerPop layerType2" style="width:60rem; height: 25rem;">
			<dl>
				<dt><strong>배송지시서 작성</strong></dt>
				<dd class="content">
					<div>
						<table class='col'>
							<thead>
								<tr>
									<th scope='col'>주문번호</th>
									<th scope='col'>주문일자</th>
									<th scope='col'>기업명</th>
									<th scope='col'>제품명</th>
									<th scope='col'>수량</th>
								</tr>
							</thead>
							<tbody id = 'shipDrectionTBody'>
								<tr>
									<td id = 'jordCode'></td>
									<td id = 'jordDate'></td>
									<td id = 'companyName'></td>
									<td id = 'pdName_S'></td>
									<td id = 'sAmt'></td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- 창고정보 -->
					<div id = "whInfo" style="display: flex; justify-content: space-around;">
						<span>창고선택</span>
						<select id = "selSWInfo" onchange="inTotalStock(this.value)"></select>
						<span>재고수량</span><input type="text" class = "totalStock" readonly="readonly" />
						<span>수량</span><input type="number" class = "countAmt" id = "sAmt"/>
						<input type = "button" value = "추가" onClick = "appendDetail('s')" /> 
					</div>
					
					<div id = realInfo>
						<table class='col'>
							<thead>
								<tr>
									<th scope='col'>제품번호</th>
									<th scope='col'>제품명</th>
									<th scope='col'>제품CODE</th>
									<th scope='col'>납품기업</th>
									<th scope='col'>창고번호</th>
									<th scope='col'>창고명</th>
									<th scope='col'>개수</th>
									<th scope='col'>발주자</th>
									<th scope='col'>삭제</th>
								</tr>
							</thead>
							<tbody id = "detailReturn">
							</tbody>
						</table>
					</div>
					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a class="btnType blue" id="btnShipDirec" name="btn"><span>완료</span></a>
						<a class="btnType gray" id="btnSModalClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>

			</dl>
		</div>
	</form>
</body>
</html>