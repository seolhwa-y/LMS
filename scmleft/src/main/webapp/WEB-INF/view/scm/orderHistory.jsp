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
.blue{
    display: inline-block;
    padding-right: 10px;
    min-width: 80px;
    height: 31px;
    line-height: 31px;
    font-family: '나눔바른고딕',NanumBarunGothic;
    font-size: 15px;
    color: #fff;
    text-align: center;
    font-weight: 400;
    background: url(/images/admin/comm/set_btnBg.png) 100% 0px no-repeat;}
</style>
<script type="text/javascript">
	var pageSizeinf = 3;
	var pageBlockSizeinquiry = 10;

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			switch (btnId) {
			case 'btnClose':
				gfCloseModal();
				break;
			case 'btnCloseGrpCod':
				gfCloseModal();
				break;
			case 'btnSaveGrpCod':
				fSaveGrpCod();
				break;

			}
		});
	}

	/** 공지사항 조회 */
	function fListInf(currentPage) {

		currentPage = currentPage || 1;

		//console.log("currentPage : " + currentPage);

		var param = {
			currentPage : currentPage,
			pageSize : pageSizeinf
		}

		var resultCallback = function(data) {
			fListInfResult(data, currentPage);
		};

		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		//html로 받을거라 text
		callAjax("/inf/listinfvue.do", "post", "json", true, param,
				resultCallback);
	}

	/** 공지사항 조회 콜백 함수 */
	function fListInfResult(data, currentPage) {

		//console.log(data);		
		noticeareavar.listitem = data.notice;

		// 총 개수 추출
		var totalCntlistInf = data.noticeCnt;
		var list = $("#selectedInfNo").val();
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntlistInf,
				pageSizeinf, pageBlockSizeinquiry, 'fListInf', [ list ]);
		//console.log("paginationHtml : " + paginationHtml);

		$("#listInfPagination").empty().append(paginationHtml);

	}

	/*공지사항 상세 조회*/
	function fNoticeModal(noticeNo) {

		var param = {
			noticeNo : noticeNo
		};
		var resultCallback2 = function(data) {
			fdetailResult(data);
		};

		callAjax("/system/detailNotice.do", "post", "json", true, param,
				resultCallback2);
	}

	/*  공지사항 상세 조회 -> 콜백함수   */
	function fdetailResult(data) {

		if (data.resultMsg == "SUCCESS") {
			//모달 띄우기 
			gfModalPop("#notice");

			// 모달에 정보 넣기 
			frealPopModal(data.result);

		} else {
			alert(data.resultMsg);
		}
	}

	function init() {
		let ohList = ${orderHistoryList};

		makeOHTable(ohList);
	}

	// 날짜인풋 :: 수주리스트 조회기간 설정
	function getOrderList() {
		let stDate = document.getElementById("inpStartDate").value.replaceAll("-", ""); // 조회 시작
		let edDate = document.getElementById("inpEndDate").value.replaceAll("-", ""); // 조회 끝
		const dateType = document.getElementById("selClass").value; // 조회 타입
		let reInput = document.getElementsByName("returnType"), reType = "";

		reInput.forEach(function(reInput) {
			if (reInput.checked) reType = reInput.value;
		});

		if (dateType != "" && stDate != "" && edDate != "") {
			// Ajax = 파라미터
			const param = {
				type : dateType,
				startDate : stDate,
				endDate : edDate,
				reType : reType
			}

			// Ajax = 호출
			var callafterback = function(returndata) {
				callSearchList(returndata);
			}
			callAjax("/scm/searchOrderHistoryList", "post", "json", true,
					param, callafterback);
		} else return;
	}

	function callSearchList(ajax) {
		let newList = ajax.newOrderSearchList;
		
		makeOHTable(newList);
	}
	
	// 지시서 작성하기
	function showDirection(t, jCode, mCode) {
		console.log("code = " + t + ":" + jCode + ":" + mCode);
		type = "";
		
		t == "b" ? type = "발주" : type = "배송";
		console.log(type);
		
		
		if (t != null && jCode != null && mCode != null) {
			// Ajax = 파라미터
			const param = {
				type : t,
				jordCode : jCode,
				modelCode : mCode
			}

			// Ajax = 호출
			var callafterback = function(returndata) {
				callDirectionList(returndata);
			}
			callAjax("/scm/showDirection", "post", "json", true, param, callafterback);
		} else return;
		
	}

	function callDirectionList(ajax) {
		const type = ajax.type;
		let whInfo = "", bordInfo = "", shipInfo = "", deliInfo = "";
		let bdTBody = document.getElementById("borderDrectionTBody");
		let sdTBody = document.getElementById("shipDrectionTBody");
		
		switch(type) {
		case "b" :
			whInfo = makeWhSelect(ajax.whInfo);
			bordInfo = makeBorderInfo(ajax.bordInfo, ajax.loginId);
			
			fillDirectionModal(whInfo, bordInfo);
			gfModalPop("#bDirection");
			break;
		case "s" :
			// 배송정보 + 창고 + 배송자
			whInfo = makeWhSelect(ajax.whInfo);
			deliInfo = makeDeliSelect(ajax.deliInfo);
			shipInfo = makeShipInfo(ajax.shipInfo);
			
			fillDirectionModal(whInfo, shipInfo, deliInfo);
			gfModalPop("#sDirection");
			break;
		}
	}
	
	// 모달 내용 채우기
	function fillDirectionModal (wh, main, deli) {
		let bdTBody = document.getElementById("borderDrectionTBody");
		let sdTBody = document.getElementById("shipDrectionTBody");
		let selBW = document.getElementById("selBWInfo");
		let selSW = document.getElementById("selSWInfo");

		bdTBody.innerHTML = "";
		sdTBody.innerHTML = "";
		
		if(deli != null) {
			sdTBody.innerHTML = main;
			selSW.innerHTML = wh;
		} else {
			bdTBody.innerHTML = main;
			selBW.innerHTML = wh;
		}
	}
	
	// 창고정보 셀렉트
	function makeWhSelect (list) {
		let selectBox = "<option selected disabled>창고선택</option>";

		if(list.length != 0){
			for(i = 0; i < list.length; i++) {
				selectBox += "<option value = '" + list[i].whCode + "&" + list[i].whStock + "&" + list[i].whName + "'>" + list[i].whName + "</option>";
			}
		} else selectBox += "<option disabled>선택할 수 있는 창고가 없습니다.</option>";

		return selectBox;
	}
	
	// 배송담당자 정보 셀렉트
	function makeDeliSelect (list) {
		let selectBox = "<select id = 'selDeliInfo'>"
		  	  + "<option disabled>배송담당자 선택<option>";

		if(list.length != 0){
			for(i = 0; i < list.length; i++) {
				selectBox += "<option value = '" + list[i].loginId + "&" + list[i].deliName + "'>" + list[i].deliName + "<option>";
			}
		} else selectBox += "<option disabled>선택할 수 있는 배송담당자가 없습니다.<option>";
		
		selectBox += "</select>";
		
		return selectBox;
	}
	
	// 발주지시서 정보
	function makeBorderInfo (list, direc) {
		console.log(list);
		let content = "<tr><td id = 'modelCode'>" + list.modelCode + "</td>"
					+ "<td id = 'pdName'>" + list.pdName + "</td>"
					+ "<td id = 'pdCode'>" + list.pdCode + "</td>"
					+ "<td id = 'bCorp'>" + list.companyName + "</td>"
					+ "<td id = 'bDirec'>" + direc + "</td></tr>";
					
		return content;
	}
	
	// 배송지시서 정보
	function makeShipInfo (list) {
		console.log(list);
		let content = "<tr><td id = 'modelCode'>" + list[0].jordCode + "</td>"
					+ "<td id = 'pdName'>" + list[0].jordDate + "</td>"
					+ "<td id = 'pdCode'>" + list[0].companyName + "</td>"
					+ "<td id = 'bCorp'>" + list[0].pdName + "</td>"
					+ "<td id = 'bDirec'>" + list[0].jordAmt + "</td></tr>";
					
		return content;
	}
	
	function insBordDirec() {
		console.log("hi");
	}

	function makeOHTable(list) {
		let tbody = document.getElementById("orderHistoryTBody");
		let content = "";

		console.log(list);

		for (i = 0; i < list.length; i++) {
			content += "<tr>" + "<td>" + list[i].jordCode + "</td>" 
					+ "<td>" + cngDateType(list[i].jordDate) + "</td>" 
					+ "<td>" + list[i].companyName + "</td>" 
					+ "<td>" + list[i].pdName + "</td>" 
					+ "<td>" + list[i].whStock.toLocaleString('ko-KR') + "</td>"
					+ "<td>" + list[i].pdPrice.toLocaleString('ko-KR') + "</td>" 
					+ "<td>" + list[i].jordAmt.toLocaleString('ko-KR') + "</td>"
					+ "<td>" + list[i].totalAmt.toLocaleString('ko-KR') + "</td>";

			list[i].reDate != null ? content += "<td>Y</td><td>" + list[i].reDate + "</td>"
									: content += "<td>N</td><td></td>";
			list[i].jordIn == "0" ? content += "<td>미입금</td>"
									: content += "<td>입금</td>";
			list[i].bordCode != null ? content += "<td>작성완료</td>"
									: content += "<td><input type = 'button' id = 'btnBordDirec' value = '작성' onClick = 'showDirection(\"b\", " + list[i].jordCode + "," + list[i].modelCode + ")' /></td>";
			list[i].shCode != null ? content += "<td>작성완료</td>"
									: content += "<td><input type = 'button' id = 'btnShipDirec' value = '작성' onClick = 'showDirection(\"s\", " + list[i].jordCode + "," + list[i].modelCode + ")' /></td>";
		}
		tbody.innerHTML = "";
		tbody.innerHTML = content;
	}

	// 타입 변환 :: 스트링 -> 날짜
	function cngDateType(strDate) {
		return strDate.substr(0, 4) + "-" + strDate.substr(4, 2) + "-" + strDate.substr(6, 2);
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
							
								<div id = "divSearchBar">
									<select id = "selClass">
										<option value = 'jorder'>주문일자</option>
										<option value = 'return'>반품처리일</option>
									</select>
									<input type = "date" id = "inpStartDate" onchange = "getOrderList(this)"/>
									<span> ~ </span>
									<input type = "date" id = "inpEndDate" onchange = "getOrderList(this)"/>
									<input type = "radio" name = "returnType" value = "all" onchange = "getOrderList(this)" /> <span>전체</span>
									<input type = "radio" name = "returnType" value = "true" onchange = "getOrderList(this)" /> <span>반품요청</span>
									<input type = "radio" name = "returnType" value = "false" onchange = "getOrderList(this)" /> <span>반품미요청</span>
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
								<br>
								<!-- 페이징라인 -->
								<div class="paging_area" id="comnGrpCodPagination" ></div>
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
							</tbody>
						</table>
					</div>
					<!-- 창고정보 -->
					<div id = "whInfo">
						<span>창고선택</span>
						<select id = "selBWInfo" onchange="totalStock(this)"></select>
						<span>재고수량</span><input type="text" id = "totalBStock" readonly="readonly" />
						<span>수량</span><input type="text" maxlength="2" />
						<input type = "button" value = "추가" onClick = "" /> 
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
							<tbody>
							</tbody>
						</table>
					</div>
					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<input type = "button" class = "btnType blue" value = "완료" onClick = "insBordDirec()">
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
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
							</tbody>
						</table>
					</div>
					<!-- 창고정보 -->
					<div id = "whInfo">
						<span>창고선택</span>
						<select id = "selSWInfo" onchange="totalStock(this)"></select>
						<span>재고수량</span><input type="text" id = "totalSStock" readonly="readonly" />
						<span>수량</span><input type="text" maxlength="2">
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
							<tbody>
							</tbody>
						</table>
					</div>
					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<input type = "button" class = "btnType blue" value = "완료" onClick = "insBordDirec()">
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>

			</dl>
		</div>
	</form>
</body>
</html>