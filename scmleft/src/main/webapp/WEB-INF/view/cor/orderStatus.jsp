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
	function init() {
		let osList =${orderStatusList};
	
		makeOrderList(osList);
	}
	
	// 주문내역에서 상세 제품정보 불러오기
	function getDetailList(no) {
		// Ajax = 파라미터
		const param = { jordNo : no }
		
		// Ajax = 호출
		var callafterback = function(returndata) {
			callDatail(returndata);
		}
		
		callAjax("/cor/refundHistory", "post", "json", true, param, callafterback);
	}
	
	// 상세 제품정보 CALLBACK
	function callDatail(ajax){
		let osdList = ajax.osdList;
		let tbody = document.getElementById("detailOrderStatusTBody");
		let content = "";
		
		console.log(osdList);
		for(i = 0; i < osdList.length; i++) {
			// 체크박스 주문번호 제품명 제품번호 제조사 단가 수량 합계금액
			content += "<tr><td><input type = 'checkBox' class = 'cheReturn'/></td>"
					+ "<td>" + osdList[i].jordNo + "</tb>"
					+ "<td>" + osdList[i].pdName + "</tb>"
					+ "<td>" + osdList[i].pdCode + "</tb>"
					+ "<td>" + osdList[i].pdCorp + "</tb>"
					+ "<td>" + osdList[i].pdPrice.toLocaleString('ko-KR') + "</tb>"
					+ "<td>" + osdList[i].jordAmt.toLocaleString('ko-KR') + "</tb>"
					+ "<td>" + osdList[i].total.toLocaleString('ko-KR') + "</tb>";
		}
		console.log(content);
		tbody.innerHTML = content;
	}

	// 날짜인풋 :: 수주리스트 조회기간 설정
	function getOrderStatusList() {
		let stDate = document.getElementById("inpStartDate").value.replaceAll("-", ""); // 조회 시작
		let edDate = document.getElementById("inpEndDate").value.replaceAll("-", ""); // 조회 끝*/
	
		if(stDate != "" & edDate != "") {
			console.log(stDate + "~" + edDate + "기간 확인 ok");
			
			// Ajax = 파라미터
			const param = { startDate : stDate, 
							endDate : edDate }
			
			// Ajax = 호출
			var callafterback = function(returndata) {
				callNewOrderList(returndata);
			}
			
			callAjax("/cor/searchOrderList", "post", "json", true, param, callafterback);	
		} else return;
	}
	
	function callNewOrderList(ajax) {
		let newList = ajax.newOrder;
		console.log(newList);
		makeOrderList(newList);
	}
	
	// 주문내역 테이블 그리기
	function makeOrderList(list){
		let tbody = document.getElementById("orderStatusTBody");
		let content = "", num = 0;

		for(i = 0; i < list.length; i++) {
			num = i + 1;
			content += "<tr><td>" + num + "</td>"
					+ "<td>" + list[i].cnt.toLocaleString('ko-KR') + "</td>"
					+ "<td>" + list[i].total.toLocaleString('ko-KR') + "</td>"
					+ "<td>" + cngDateType(list[i].jordDate) + "</td>"
					+ "<td>" + cngDateType(list[i].jordWishdate) + "</td>";
			content += "<td>" + (list[i].shType == "0" ? "미배송" : "배송완료") + "</td>"
					+ "<td><input type = 'button' class = 'btnReturn' value = '반품' onClick = 'getDetailList(" + list[i].jordNo + ")' /></td></tr>";
		}
		tbody.innerHTML = content;
		console.log(content);
	}
	
	// 타입 변환 :: 스트링 -> 날짜
	function cngDateType(strDate) {
		return strDate.substr(0, 4) + "-" + strDate.substr(4, 2) + "-" + strDate.substr(6, 2);
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

							<div id = "divSearchBar">
								<span>구매일자</span>
								<input type = "date" id = "inpStartDate" />
								<span> ~ </span>
								<input type = "date" id = "inpEndDate" onchange="getOrderStatusList()" />
							</div>
							
							<!-- 주문상태 -->
							<div id="divOrderStatus">
								<table class="col">
									<caption>caption</caption>
									<thead>
										<tr>
											<th scope="col">일련번호</th>
											<th scope="col">주문수량</th>
											<th scope="col">결제금액</th>
											<th scope="col">구매일자</th>
											<th scope="col">배송희망일자</th>
											<th scope="col">배송상태</th>
											<th scope="col">반품선택</th>
										</tr>
									</thead>
									<tbody id = "orderStatusTBody">

									</tbody>
								</table>
							</div>
							<br>
							
							<div id="divOrderDetailList">
								<table class="col">
									<caption>caption</caption>
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
								<input type = "button"  id = "btnReturn" value = "반품하기" onClick = "insReturnInfo()" />
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