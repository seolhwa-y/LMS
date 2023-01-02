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
<script src="${CTX_PATH}/js/view/scm/orderHistory/orderHistory.js"></script>

<script type="text/javascript">
	// 페이지 로드시
	function init() {
		let pageLine = document.querySelector("#orderHistoryPaging");

		fRegisterButtonClickEvent();
		makeOHTable(${orderHistoryList});
		pageLine.innerHTML = getPaginationHtml(1, ${historyCount}, listCount, pageCount, 'getOrderList');
       	pageLine.appendChild( createInput("historyCount", ${historyCount}));
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
										<input type = "date" id = "inpStartDate" onchange = "getOrderList()"/>
										<span> ~ </span>
										<input type = "date" id = "inpEndDate" onchange = "getOrderList()"/>
									</div>
									<div style="width: 16rem; display: flex; justify-content: space-evenly; align-items: baseline;">
										<input type = "radio" name = "returnType" value = "all" onchange = "getOrderList()" /> <span>전체</span>
										<input type = "radio" name = "returnType" value = "true" onchange = "getOrderList()" /> <span>반품요청</span>
										<input type = "radio" name = "returnType" value = "false" onchange = "getOrderList()" /> <span>반품미요청</span>
									</div>
								</div>

							<!-- 일별 수주 내역 -->
							<div id="divDailyOrderList" style="height: 36.9rem;">
								<table class="col">
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
					<div style="margin-bottom: 1rem;">
						<table class='col'>
							<thead>
								<tr>
									<th scope='col'>주문번호</th>
									<th scope='col'>제품번호</th>
									<th scope='col'>제품명</th>
									<th scope='col'>제품CODE</th>
									<th scope='col'>납품기업</th>
								</tr>
							</thead>
							<tbody id = 'borderDrectionTBody'>
								<tr>
									<td id = 'jordCode_B'></td>
									<td id = 'modelCode_B'></td>
									<td id = 'pdName_B'></td>
									<td id = 'pdCode_B'></td>
									<td id = 'bCorp_B'></td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<!-- 창고정보 -->
					<div id = "whInfo" style="margin-bottom: 1rem; display: flex; justify-content: space-around; align-items: baseline;">
						<span>창고선택</span>
						<select id = "selBWInfo" onchange="inTotalStock(this.value)"></select>
						<span>재고수량</span><input type="text" class = "totalStock" readonly="readonly" style="width: 180px; height: 30px;" />
						<span>수량</span><input type="number" class = 'countAmt' id = "bAmt" style="width: 180px; height: 30px;" />
						<a class="btnType blue" id="btnBDirec" name="btn" onClick = "appendDetail('b')"><span>추가</span></a>
					</div>
					
					<div style="height: 6rem;">
						<table class='col'>
							<thead>
								<tr>
									<th scope='col'>주문번호</th>
									<th scope='col'>제품번호</th>
									<th scope='col'>제품명</th>
									<th scope='col'>제품CODE</th>
									<th scope='col'>납품기업</th>
									<th scope='col'>창고번호</th>
									<th scope='col'>창고명</th>
									<th scope='col'>발주수량</th>
									<th scope='col'>삭제</th>
								</tr>
							</thead>
							<tbody id = "detailBorder"></tbody>
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
					<div style="margin-bottom: 1rem;">
						<table class='col'>
							<thead>
								<tr>
									<th scope='col'>주문번호</th>
									<th scope='col'>주문일자</th>
									<th scope='col'>기업명</th>
									<th scope='col'>제품번호</th>
									<th scope='col'>제품명</th>
									<th scope='col'>제품CODE</th>
									<th scope='col'>주문수량</th>
								</tr>
							</thead>
							<tbody id = 'shipDrectionTBody'>
								<tr>
									<td id = 'jordCode_S'></td>
									<td id = 'jordDate_S'></td>
									<td id = 'modelCode_S'></td>
									<td id = 'companyName_S'></td>
									<td id = 'pdName_S'></td>
									<td id = 'pdCode_S'></td>
									<td id = 'jordAmt_S'></td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<!-- 창고정보 -->
					<div id = "whInfo" style="margin-bottom: 1rem; display: flex; justify-content: space-around; align-items: baseline;">
						<span>창고선택</span>
						<select id = "selSWInfo" onchange="inTotalStock(this.value)"></select>
						<span>재고수량</span><input type="text" class = "totalStock" readonly="readonly" style="width: 180px; height: 30px;" />
						<span>수량</span><input type="number" class = "countAmt" id = "sAmt" style="width: 180px; height: 30px;" />
						<a class="btnType blue" id="btnSDirec" name="btn" onClick = "appendDetail('s')"><span>추가</span></a>
					</div>
					<div id="deli" style="display: none;"></div>
					<div style="height: 6rem;">
						<table class='col'>
							<thead>
								<tr>
									<th scope='col'>주문번호</th>
									<th scope='col'>기업명</th>
									<th scope='col'>제품번호</th>
									<th scope='col'>제품명</th>
									<th scope='col'>제품CODE</th>
									<th scope='col'>창고번호</th>
									<th scope='col'>창고명</th>
									<th scope='col'>배송수량</th>
									<th scope='col'>배송담당자</th>
									<th scope='col'>삭제</th>
								</tr>
							</thead>
							<tbody id = "detailShip"></tbody>
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