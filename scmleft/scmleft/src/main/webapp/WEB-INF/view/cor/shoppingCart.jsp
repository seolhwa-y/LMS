<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 장바구니 목록</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<script src="${CTX_PATH}/js/view/cor/shoppingCart/shoppingCart.js"></script>
<style>
img {
width: 50px; height: 50px; margin : 10px;
}
</style>

<script type="text/javascript">
	// 페이지 로드시
	function init() {
		fRegisterButtonClickEvent();
		makeBasketList(${shoppingCartList});
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
									<span>장바구니 목록</span> <span class="fr"> 관련 자료 </span>
								</p>
							</div>
							
							<!-- 장바구니 목록 -->
							<div id="divCartList" style="height: 34.81rem; overflow: auto;">
								<table class="col">
									<thead>
										<tr>
											<th scope="col">선택</th>
											<th scope="col">제품명</th>
											<th scope="col">단가</th>
											<th scope="col">수량</th>
											<th scope="col">합계</th>
											<th scope="col">납품희망일자</th>
										</tr>
									</thead>
									<tbody id = "shoppingCartTBody">
									</tbody>
								</table>
							</div>
							<br>
							
							<div id = "divOrderTotal" style=" float: right; bottom: 20rem; margin-left: 51rem;" >
								<a class="btnType gray" id="btnDelBasket" name="btn"><span>제품삭제</span></a>
								<a class="btnType blue" id="btnOrderMoney" name="btn"><span>주문하기</span></a>
								<div style="height: 5rem; display: flex; flex-direction: column; justify-content: space-evenly; align-items: flex-end;">
									<p style="font-size: 1.3rem;">장바구니 총액</p>
									<p id = "basketTotal" style="font-size: 1rem;">${basketTotal}원</p>
								</div>
							</div>
						</div>

					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>