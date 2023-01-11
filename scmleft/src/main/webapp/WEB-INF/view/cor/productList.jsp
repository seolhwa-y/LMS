<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 제품 목록</title>

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
									<span>제품 목록</span> <span class="fr"> 관련 자료 </span>
								</p>
							</div>
							
							<!-- 서치바 -->
							<div id = "divSearchBar" style="padding: 2% 2%; display: flex; justify-content: space-between;">
									<div style="width: 28rem; display: flex; justify-content: space-evenly; align-items: baseline;">
									<!-- 장비구분 선택  -->
										<select id = "selModel" style="width: 5rem; height: 100%; margin-right: 1rem;"></select>
									<!-- 제조사 선택 -->	
										<select id = "selModel" style="width: 5rem; height: 100%; margin-right: 1rem;"></select>
									</div>
									
									<div>
										<input type = "text" id = "inpSerName"/>
										<a class="btnType blue" id="btnSearch" name="btn" onClick = "productSearch()"><span>검색</span></a>
									</div>
								</div>
							
							<!-- 제품 목록 -->
							<div id="divProductList" style="height: 34.81rem; overflow: auto;">
								<table class="col">
									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">구분</th>
											<th scope="col">제품명</th>
											<th scope="col">제품CODE</th>
											<th scope="col">제조사</th>
											<th scope="col">판매가격</th>
										</tr>
									</thead>
									<tbody id = "productTBody"></tbody>
								</table>
								<!-- 페이징라인 -->
								<div class="paging_area" id="productPaging" ></div>
							</div>
							<br>
						</div>
						
						<!-- 모달 :: 제품상세보기 -->					
						<div id="productInfo" class="layerPop layerType2" style="width:60rem; height: 25rem;">
							<dl>
								<dt><strong>제품 상세보기</strong></dt>
								<dd class="content">
									<div style="margin-bottom: 1rem;">
									</div>
									
									<div style="height: 6rem;">
										<table class='col'>
											<thead>
												<tr>
													<th scope='col'>제품명</th>
													<th scope='col'>구분</th>
													<th scope='col'>제품CODE</th>
													<th scope='col'>제조사</th>
													<th scope='col'>상세정보</th>
													<th scope='col'>수량</th>
													<th scope='col'>판매가격</th>
													<th scope='col'>납품희망일</th>
												</tr>
											</thead>
											<tbody id = "detailProduct"></tbody>
										</table>
									</div>
									
									<!-- e : 여기에 내용입력 -->
									<div class="btn_areaC mt30">
										<a class="btnType blue" id="btnBorderDirec" name="btn"><span>장바구니 담기</span></a>	
										<a class="btnType blue" id="btnBorderDirec" name="btn"><span>주문하기</span></a>
										<a class="btnType gray" id="btnBModalClose" name="btn"><span>취소</span></a>
									</div>
								</dd>
							</dl>
						</div>
						
					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>