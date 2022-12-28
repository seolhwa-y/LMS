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
		let scList = ${shoppingCartList};

		makeBasketList(scList);
	}
	
	// 버튼 :: 주문하기
	function confOrder() {
		confirm("입금도 같이 진행하시겠습니까?") == true ? insOrderInfo('1') : insOrderInfo('0');
	}
	
	function insOrderInfo(isCheck) {
		let checkBox = document.querySelectorAll("input[name='delProduct']:checked");
		let param = new Object;
        let value = [], type = '0', model = "", amt = "", wish = "", jin = "";

        checkBox.forEach((checkBox, index) => { value.push(checkBox.value.split("&")); })
    
        value.forEach((value, index) => { value.push(isCheck); })

        value.forEach((value, index) => { 
								        	model += (index == 0 ? "" : "&" ) + value[0];
								            amt += (index == 0 ? "" : "&" ) + value[1];
								            wish += (index == 0 ? "" : "&" ) + value[2];
								            jin += (index == 0 ? "" : "&" ) + value[3];
								        })
		
        param['modelCode'] = model, param['jordAmt'] = amt, param['jordWishdate'] = wish, param['jordIn'] = jin;
        
        console.log(param);
        
        if(param != null) {
			// Ajax = 호출
			var callafterback = function(returndata) {
				calInsJorder(returndata);
			}
			
 			 callAjax("/cor/insJorder", "post", "json", true, param, callafterback);	  
		} else return;  
	}
	
	function calInsJorder(ajax) {
		makeBasketList(ajax.insBaList);
		alert(ajax.message);
	}
	
	// 제품 삭제
	function delBaProduct() {
		let checkBox = document.getElementsByName("delProduct");
		let val = "", code = "", length = checkBox.length-1;
		
		checkBox.forEach(function(checkBox, index){
			if(checkBox.checked) {
				code = checkBox.value;
				val += code.substring(0, code.indexOf("&"));
				if(length != index) val += "&";
				else val += "";
			}
		})

		if(val != null) {			
			// Ajax = 파라미터
			let param = { modelCode : val }

			// Ajax = 호출
			var callafterback = function(returndata) {
				callDelProduct(returndata);
			}
			
			callAjax("/cor/delBasketProduct", "post", "json", true, param, callafterback);	
		} else return;
	}
	
	function callDelProduct(ajax) {
		let baList = ajax.delBaList;
		console.log(baList);
		makeBasketList(baList);
		alert(ajax.message);
	}
	
	// 테이블 그리기
	function makeBasketList(list) {
		console.log(list);
		
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
		console.log(content);
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
							<div id="divCartList">
								<table class="col">
									<caption>caption</caption>
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
							<input type = 'button' value = '제품삭제' onClick = "delBaProduct()" />
							<div id = "divOrderTotal">
									<p style="font-size: 1.3rem;">장바구니 총액</p>
									<p style="font-size: 1rem;">합계금액</p>
									<p style="font-size: 1rem;">${basketTotal}</p>
									<input type = "button" id = "btnOrderMoney" value = "주문하기" onclick="confOrder()" />
							</div>
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