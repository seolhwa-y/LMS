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
	function init() {
		fRegisterButtonClickEvent();
		makeBasketList(${shoppingCartList});
	}
	
	// 버튼 :: 주문하기
	function confOrder() {
		confirm("입금도 같이 진행하시겠습니까?") == true ? insOrderInfo('1') : insOrderInfo('0');
	}
	
	function insOrderInfo(isCheck) {
		let checkBox = document.querySelectorAll("input[name='delProduct']:checked");
        let value = [], type = '0', model = "", amt = "", wish = "", jin = "";

        checkBox.forEach((checkBox, index) => { value.push(checkBox.value.split("&")); })
        value.forEach((value, index) => { 
        	value.push(isCheck); 
			model += (index == 0 ? "" : "&" ) + value[0];
			amt += (index == 0 ? "" : "&" ) + value[1];
			wish += (index == 0 ? "" : "&" ) + value[2];
			jin += (index == 0 ? "" : "&" ) + value[3];
		})
		
        if(model != null && amt != null && wish != null && jin != null) {
			let param = { modelCode : model, jordAmt : amt, jordWishdate : wish, jordIn : jin }
			let callafterback = (ajax) => { 
				makeBasketList(ajax.insBaList);
				document.querySelector("#basketTotal").innerText = ajax.basketTotal;
				alert(ajax.message);
			}
			
 			callAjax("/cor/insJorder", "post", "json", true, param, callafterback);	  
		} else return;  
	}
	
	// 제품 삭제
	function delBaProduct() {
		let checkBox = document.querySelectorAll("input[name='delProduct']:checked");
		let val = "";
		
		checkBox.forEach((checkBox, index) => {
			val += (index != 0 ? "&" : "") + checkBox.value.substring(0, checkBox.value.indexOf("&"));
		})

		if(val != null) {			
			let param = { modelCode : val }
			let callafterback = (ajax) => { 
				makeBasketList(ajax.delBaList);
				document.querySelector("#basketTotal").innerText = ajax.basketTotal;
				alert(ajax.message);
			}
			
			callAjax("/cor/delBasketProduct", "post", "json", true, param, callafterback);	
		} else return;
	}
	
	// 테이블 그리기
	function makeBasketList(list) {
		let tbody = document.getElementById("shoppingCartTBody");
		let content = "";
		tbody.innerHTML = "";
		
		for(i = 0; i < list.length; i++) {
			content += "<tr><td><input type = 'checkBox' name = 'delProduct' value = '" + list[i].modelCode + "&" + list[i].baAmt + "&" + list[i].baWishdate + "' /></td>"
					+ "<td>"+ list[i].pdName +"</td>"
					+ "<td>"+ cngNumberType(list[i].pdPrice) +"</td>"
					+ "<td>"+ list[i].baAmt +"</td>"
					+ "<td>"+ cngNumberType(list[i].total) +"</td>"
					+ "<td>"+ cngDateType(list[i].baWishdate) +"</td>";
		}
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
	
	// 버튼 이벤트 등록
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			switch (btnId) {
				case 'btnClose' : gfCloseModal(); break;
				case 'btnDelProduct' : insReturnInfo(); break;
				case 'btnDelBasket' : delBaProduct(); break;
				case 'btnOrderMoney' : confOrder(); break;
			}
		});
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
							<div id="divCartList" style="height: 23.81rem; overflow: auto;">
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