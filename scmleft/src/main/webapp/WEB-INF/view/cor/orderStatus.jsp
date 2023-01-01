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
<script src="${CTX_PATH}/js/view/cor/orderStatus/orderStatus.js"></script>

<script type="text/javascript">
	// 페이지 로드
	function init() {
		let pageLine = document.querySelector("#orderStatusPaging");
		
		fRegisterButtonClickEvent();
		makeOrderList(${orderStatusList});
		pageLine.innerHTML = getPaginationHtml(1, ${orderCount}, listCount, pageCount, 'getOrderStatusList');
       	pageLine.appendChild( createInput("orderCount", ${orderCount}));
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
							<div id="divOrderStatus" style="height: 15rem; margin-bottom: 3rem;">
								<table class="col">
									<thead>
										<tr>
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
							
							<div id="divOrderDetailList" style="height: 15rem; margin-bottom: 3rem;">
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
							</div>
							<div>
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