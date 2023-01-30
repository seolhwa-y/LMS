<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: SCM</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<script>

/* 상세 조회*/
function fdetailDeliModal(model_code) {
	var param = {
			model_code : model_code
	};
	var resultCallback2 = function(data) {
		fDelidetailResult(data);
	};

	callAjax("/scm/detail.do", "post", "json", true, param,
			resultCallback2);
}

</script>

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
/* 페이징 css */
.pagination-div {
	position: absolute;
	left: 42%!important;
	top: 114%!important;
}

.pagination {
	list-style: none;
	padding: 0;
	margin-top: 10px;
}

.pagination li {
	display: inline-block;
	text-align: center;
}

.pagination a {
	float: left;
	display: block;
	font-size: 14px;
	text-decoration: none;
	padding: 6.3px 12px !important;
	margin-left: -1px;
	border: 1px solid transparent;
	line-height: 1.5;
}

.pagination a.active {
	cursor: default;
}

.pagination a:active {
	outline: none;
}
</style>
</head>
<body>
<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
							<a href="#" class="btn_nav">시스템 관리</a> 
								<span class="btn_nav bold">사용자 관리</span> 
								<a href="top.location='javascript:location.reload()'" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>창고별 재고 현황 </span> 
							<!--검색창   -->
							<form method="get" action="${pageContext.request.contextPath}/scm/whInventoryForm.do">
							<span class="fr">
							<select id="searchKey" name="search_field" style="width: 80px;">
									<option value="0" selected>제품명</option>
	 								<option value="1">창고명</option>
							</select> 
								
							<input type="text" style="width: 160px; height: 30px;" id="sname" name="search_word">  
							<input type="submit" class="btnType blue" id="searchBtn" name="btn" value="검 색">
							</span>
							</form>
							</p>
		
						
						<div class="divUserList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="30%">
								</colgroup>
								<thead>
									<tr>
									      <th scope="col">창고 코드</th>
									      <th scope="col">제품 번호</th>
							              <th scope="col">창고명</th>
							              <th scope="col">제품 명</th>
							              <th scope="col">재고 수량</th>
							              <th scope="col">창고 위치</th>
									</tr>
								</thead>
								<tbody id="userList">
								<c:forEach var="b" items="${list}">
									<tr onclick="javascript:fdetailDeliModal(${b.model_code})">
									<td>${b.wh_code}</td> 
									<td>${b.model_code}</td>
									<td>${b.wh_name}</td>
									<td>${b.pd_name}</td>
									<td>${b.wh_stock}</td>
									<td>${b.wh_addr}</td>
									</tr>
								</c:forEach>
								
								</tbody>
							</table>
							
						</div>
					</div> <!--// content -->
					
					<!-- 페이징 처리 -->
	<div style="position:absolute;left:45%;margin-top:60px">
	<ul class="pagination modal-2 text-center">
	  
	 <c:if test="${page <= 1 }">
	  <li><a href="#" class="prev"><i class="fas fa-angle-double-left"></i></a></li>
	 </c:if> 
	 <c:if test="${page > 1 }">
	  <li>
		<a class="next" href="${pageContext.request.contextPath}/scm/whInventoryForm.do?page=${page-1}&search_field=${search_field}&search_word=${search_word}"><i class="fas fa-angle-double-left"></i></a>
	  </li>
	 </c:if> 
	 
	 <c:forEach var="a" begin="${startpage}" end="${endpage}">
	 	<c:if test="${a == page}">
		 <li>
			<a class="pnum active">${a}</a>
		 </li>
	   </c:if>
	   <c:if test="${a != page }"> 
	 	 <li>
			<a class="pnum" href="${pageContext.request.contextPath}/scm/whInventoryForm.do?page=${a}&search_field=${search_field}&search_word=${search_word}">${a}</a>
		 </li>
	   </c:if>
	 </c:forEach>
	  
	<c:if test="${page >= maxpage }">
		<li class="page-item">
		  <li><a href="#" class="next"><i class="fas fa-angle-double-right"></i></a></li>
	</c:if>
	<c:if test="${page < maxpage }"> 
	     <li>
			<a class="next" href="${pageContext.request.contextPath}/scm/whInventoryForm.do?page=${page+1}&search_field=${search_field}&search_word=${search_word}"><i class="fas fa-angle-double-right"></i></a>
		 </li>
	</c:if>
	</ul>
	</div>
					
					
		<!-- 디테일 모달 -->
		<div id="deli" class="layerPop layerType2" style="width: 500px; height: 400px;">
           <dl>
			<dd class="content">
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="25%">
						<col width="25%">
						<col width="25%">
						<col width="25%">
					</colgroup>
					<tbody>
						<th>제품 번호</th>
						<th>제품 명</th>
						<th>입고 량</th>
						<th>출고 량</th>
					</tbody>	
				</table>
		    </dd>
          </dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
     </div>
	
					
					

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>